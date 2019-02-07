float QUANTIZATION = 1.0;

int [] rgb2YCbCr(float r, float g, float b) {
    int [] ycc = new int[3];
    
    ycc[0] = round(0.299 * r + 0.587 * g + 0.114 * b);
    ycc[1] = round((128 - 0.168736 * r - 0.331264 * g + 0.5 * b) / QUANTIZATION);
    ycc[2] = round((128 + 0.5 * r - 0.418688 * g - 0.081312 * b) / QUANTIZATION);
    
    return ycc;
}

int [] ycbcr2RGB(float y, float cb, float cr) {
    int [] rgb = new int[3];
    
    cb *= QUANTIZATION;
    cr *= QUANTIZATION;
    rgb[0] = round(y + 1.402 * (cr - 128));
    rgb[1] = round(y - 0.34414 * (cb - 128) - 0.71414 * (cr - 128));
    rgb[2] = round(y + 1.772 * (cb - 128));
    
    return rgb;
}