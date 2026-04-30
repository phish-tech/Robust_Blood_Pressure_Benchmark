% =========================================================================
% 暴力透明版 run_data_selection.m (拒绝静音报错)
% =========================================================================
clc; clear; close all;

%% 1. 配置
IS_DEMO_MODE = true; 
data_folder = fullfile(pwd, 'demo_data');
file_prefix = 'demo_part_'; 
target_per_bin = 15; 
output_name = 'demo_sampled_balanced.mat';

fs = 200; 
bin_edges = [0, 110, 130, 150, 300]; 
bin_counts = zeros(1, 4);
sampled_data = {}; 

%% 2. 核心扫描
file_list = dir(fullfile(data_folder, sprintf('%s*.mat', file_prefix)));
if isempty(file_list), error('❌ 连文件都没找到，请检查路径！'); end

for i = 1:length(file_list)
    filename = fullfile(data_folder, file_list(i).name);
    fprintf('正在扫描: %s ...\n', file_list(i).name);
    
    tmp = load(filename);
    if isfield(tmp, 'p'), raw_cells = tmp.p; else, vars = fieldnames(tmp); raw_cells = tmp.(vars{1}); end
    
    % 🚨 暴力透视核心数据类型，绝不藏着掖着
    fprintf('>> 发现底层数据类型: %s, 维度: %s\n', class(raw_cells), mat2str(size(raw_cells)));
    
    num_segments = max(size(raw_cells)); 
    if num_segments == 0, continue; end
    
    for k = 1:num_segments
        
        % 🚨 卸下 try-catch 伪装，硬碰硬提取
        if iscell(raw_cells)
            seg = raw_cells{k};
        elseif isnumeric(raw_cells) && ndims(raw_cells) == 3
            seg = raw_cells(:, :, k); 
        elseif isstruct(raw_cells)
            vars_in_struct = fieldnames(raw_cells);
            seg = raw_cells(k).(vars_in_struct{1});
        else
            error('🚨 数据类型完全无法识别！请查看上面的底层数据类型输出。');
        end
        
        % 🛡️ 破解嵌套 Cell (MATLAB 切片时极易引发的格式变异，罪魁祸首往往是它)
        while iscell(seg) && numel(seg) >= 1
            seg = seg{1}; 
        end
        
        % --- 严格的质量控制 (QC) ---
        if isempty(seg) || size(seg, 2) < fs*5 || size(seg,1) < 2
            continue; 
        end
        
        % 维度修正：确保是 [传感器 x 时间] 的格式
        if size(seg,1) > 3 && size(seg,2) <= 3 
            seg = seg'; 
        end 
        
        bp_sig = seg(2, :); 
        
        % 快速估算 SBP 用于分箱
        sorted_bp = sort(bp_sig, 'descend');
        sbp_est = mean(sorted_bp(1:min(50, end))); 
        
        b = find(sbp_est < bin_edges, 1) - 1;
        if isempty(b) || b < 1, b = 4; end 
        
        if bin_counts(b) < target_per_bin
            sampled_data{end+1} = seg;
            bin_counts(b) = bin_counts(b) + 1;
        end
        
        if all(bin_counts >= target_per_bin), break; end
    end
    
    fprintf('进度 -> 低(<110):%d | 正常(110-130):%d | 偏高(130-150):%d | 高(>150):%d\n', ...
        bin_counts(1), bin_counts(2), bin_counts(3), bin_counts(4));
        
    if all(bin_counts >= target_per_bin), break; end
end

%% 3. 数据持久化
if isempty(sampled_data)
    fprintf('\n❌ 还是鸭蛋？！说明你的片段全都没挺过 QC (数据太短/缺失行数)。\n');
else
    save(output_name, 'sampled_data', 'fs');
    fprintf('\n======================================================\n');
    fprintf('✅ 采样成功！\n');
    fprintf('======================================================\n');
end


%% 4. 自动生成顶刊级数据分布图 (Publication-Grade Demographics)
% =========================================================================
fprintf('\n🎨 正在为 README 生成高颜值数据分布图...\n');

% 提取统计特征容器
stats_SBP = zeros(length(sampled_data), 1);
stats_DBP = zeros(length(sampled_data), 1);
stats_HR  = zeros(length(sampled_data), 1);

% 极速提取每个片段的特征用于绘图
for idx = 1:length(sampled_data)
    seg = sampled_data{idx};
    bp_sig = seg(2, :);
    
    % 快速提取 SBP, DBP 和 HR
    [sbp_peaks, locs] = findpeaks(bp_sig, 'MinPeakHeight', 50, 'MinPeakDistance', round(fs*0.4));
    if length(sbp_peaks) > 3
        stats_SBP(idx) = mean(sbp_peaks);
        % 反向寻找波谷近似 DBP
        [dbp_valleys, ~] = findpeaks(-bp_sig, 'MinPeakHeight', -200, 'MinPeakDistance', round(fs*0.4));
        if ~isempty(dbp_valleys), stats_DBP(idx) = mean(-dbp_valleys); else, stats_DBP(idx) = NaN; end
        % 通过峰值间隔估算 HR
        rr_intervals = diff(locs) / fs;
        stats_HR(idx) = 60 / mean(rr_intervals);
    else
        stats_SBP(idx) = NaN; stats_DBP(idx) = NaN; stats_HR(idx) = NaN;
    end
end


valid_idx = ~isnan(stats_SBP) & ~isnan(stats_DBP) & ~isnan(stats_HR);
stats_SBP = stats_SBP(valid_idx);
stats_DBP = stats_DBP(valid_idx);
stats_HR = stats_HR(valid_idx);


fig = figure('Name', 'Dataset Demographics', 'Color', 'w', 'Position', [100, 100, 1000, 350]);


subplot(1, 3, 1);
histogram(stats_SBP, 15, 'FaceColor', '#0072BD', 'EdgeColor', 'none', 'Normalization', 'probability');
hold on; xline(140, 'r--', 'HTN (140)', 'LineWidth', 1.5, 'LabelVerticalAlignment', 'middle');
xlabel('Systolic BP (mmHg)', 'FontWeight', 'bold'); ylabel('Probability Density', 'FontWeight', 'bold');
title('SBP Distribution', 'FontSize', 12); grid on;
set(gca, 'GridAlpha', 0.15, 'TickDir', 'out');


subplot(1, 3, 2);
histogram(stats_DBP, 15, 'FaceColor', '#D95319', 'EdgeColor', 'none', 'Normalization', 'probability');
xlabel('Diastolic BP (mmHg)', 'FontWeight', 'bold');
title('DBP Distribution', 'FontSize', 12); grid on;
set(gca, 'GridAlpha', 0.15, 'TickDir', 'out');

subplot(1, 3, 3);
scatter(stats_HR, stats_SBP, 25, 'k', 'filled', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeColor', 'w');
xlabel('Heart Rate (bpm)', 'FontWeight', 'bold'); ylabel('SBP (mmHg)', 'FontWeight', 'bold');
title('HR vs SBP Coverage', 'FontSize', 12); grid on;
set(gca, 'GridAlpha', 0.15, 'TickDir', 'out');


fprintf('======================================================\n');