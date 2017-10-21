// 擬似的なユーティリティークラス、実際はProcessing特有の処理があるため、別クラスにはできない

private float getRatio(float elapsion, int duration) {
    float ratio = elapsion / (float)duration;
    ratio = constrain(ratio, 0.0f, 1.0f);
    return ratio;
}

private float getRatio(float elapsion, int duration, Easing easing) {
    float ratio = getRatio(elapsion, duration);
    ratio = easing.get(ratio);
    return ratio;
}

private float getAntiRatio(float elapsion, int duration) {
    float ratio = getRatio(elapsion, duration);
    ratio = 1.0f - ratio;
    return ratio;
}

private float getAntiRatio(float elapsion, int duration, Easing easing) {
    float ratio = getAntiRatio(elapsion, duration);
    ratio = easing.get(ratio);
    return ratio;
}

/*
private class FrameCounter {
    private int elapsedFrame;

    private float calcElapsedTime() {
        elapsedFrame++;
        // 注意！！！ 1sec = 1.0fのfloat値として算出している
        float elapsedTime = (float)elapsedFrame * 1.0f / (float)BASE_FRAME_RATE;
        return elapsedTime;
    }
}
*/

// 時間（1000ms = 1.0f）をフレーム数（60fps換算）に変換する
private int toFrame(int time) {
    int frame = (int)((float)time * (float)BASE_FRAME_RATE / 1000.0f);
    return frame;
}
// フレーム（1frame = 1000/60ms）を時間（ms）に変換する
// ！！！注意：3frame = 50ms以下の精度で綺麗な数字は出せない
private int toTime(int frame) {
    int time = (int)((float)frame / (float)BASE_FRAME_RATE * 1000.0f);
    return time;
}

// フレーム単位でアニメーションをするプログラムで処理落ち対策用のタイマークラス
private class FrameTimer {
    private int lastElapsedFrame;                            // 割り込みカウント数
    private long timerStartTime = System.nanoTime();    // 開始時間

    private int getDiffFrame() {
        int nowElapsedFrame = (int)((double)(System.nanoTime() - timerStartTime) / 1000000000.0d * (double)BASE_FRAME_RATE);
        int diffFrame = nowElapsedFrame - lastElapsedFrame;
        lastElapsedFrame = nowElapsedFrame;
        return diffFrame;
    }
}

private class FrameRate{
    private int frameRate_;
    private float fps, sumFPS;
    private int cntFPS;
    FrameRate(int frameRate_){
        this.frameRate_ = frameRate_;
        fps = frameRate_;
    }
    private void Update(){
        if(cntFPS < frameRate_){
            sumFPS += frameRate;
            cntFPS++;
        }else{
            fps = round(sumFPS / frameRate_ * 10) / 10.0;
            sumFPS = cntFPS = 0;
        }
    }
}
