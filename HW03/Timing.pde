class TimeIt {
  long startTime;
  long endTime;
  long duration;
  boolean stopped;

  void start() {
    stopped = false;
    startTime = System.nanoTime();
  }

  void stop() {
    stopped = true;
    endTime = System.nanoTime();
    duration = (endTime - startTime);
  }

  long durationInNS() {
    return (stopped) ? duration : -1;
  }

  long duration() {
    return (stopped) ? (duration / 1000000): -1;
  }
}
