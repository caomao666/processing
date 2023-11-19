int width = 1920;
int height = 1080;

// 定义中心竖线的位置
int centerX = width / 2;

// 定义点的最大数量
int maxPoints = 5000000;

// 定义点的最大半径
int maxRadius = 1;

// 定义点的密度系数，越大则点越密集
float densityFactor = 0.007;

// 定义一个数组，用来存储点的位置和半径
float[][] points = new float[maxPoints][3];

// 定义一个变量，用来记录已经出现的点的数量
int currentPoints = 0;

// 定义一个变量，用来记录每一帧需要出现的点的数量
int pointsPerFrame = maxPoints / (10 * 60); // 假设每秒60帧，十秒内出现所有点

void setup() {
  // 设置窗口大小和背景颜色
  size(1920,1080);
  background(0);
  
  // 生成点的位置和半径
  for (int i = 0; i < maxPoints; i++) {
    // 随机生成点的横坐标
    float x = random(width);
    
    // 根据横坐标和密度系数，计算点的出现概率
    float probability = exp(-densityFactor * abs(x - centerX));
    
    // 如果随机数小于概率，则生成点，否则跳过
    if (random(1) < probability) {
      // 随机生成点的纵坐标
      float y = random(height);
      
      // 随机生成点的半径
      float r = random(maxRadius);
      
      // 将点的位置和半径存入数组
      points[i][0] = x;
      points[i][1] = y;
      points[i][2] = r;
    }
  }
}

void draw() {
  // 如果还有点没有出现，则继续绘制
  if (currentPoints < maxPoints) {
    // 遍历数组，绘制每一帧需要出现的点
    for (int i = currentPoints; i < currentPoints + pointsPerFrame; i++) {
      // 获取点的位置和半径
      float x = points[i][0];
      float y = points[i][1];
      float r = points[i][2];
      
      // 如果点的半径大于零，则绘制
      if (r > 0) {
        // 设置点的颜色为白色
        fill(255);
        
        // 绘制点为一个圆形
        noStroke();
        ellipse(x, y, r * 2, r * 2);
      }
    }
    // 更新已经出现的点的数量
    currentPoints += pointsPerFrame;
  }
}
