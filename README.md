# comix_rtd1296

## 1.执行一键修改MAC、SN代码
```
sudo -i
wget -O sy100macsn.sh https://raw.githubusercontent.com/town-chen/comix_rtd1296/main/sy100macsn.sh && bash sy100macsn.sh 00:11:32:11:22:33 2140QEN173201
reboot
```
### 备用地址
```
sudo -i
wget -O sy100macsn.sh http://www.apeiro.top/comix_rtd1296.sh && bash sy100macsn.sh 00:11:32:11:22:33 2140QEN173201
reboot
```

## 2. 风扇控制

### 设置步骤

#### 控制面板
- **任务计划**  
  - **新增**
    - **计划的任务**
      - **用户定义的脚本**

#### 常规
- **任务名称**：根据实际需求自定义
- **用户账户**：`root`

#### 计划
- **运行频率**：每15分钟

#### 任务设置
- **用户定义的脚本**：
```
bash /脚本地址/auto_fan_control.sh
```
