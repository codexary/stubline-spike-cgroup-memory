package com.elsworne.stubline.spike.cgroup;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

/** Allocates retained heap or direct memory in visible increments. */
public final class MemoryMain {
  private MemoryMain() {}

  public static void main(String[] args) throws Exception {
    if (args.length != 1 || (!args[0].equals("heap") && !args[0].equals("direct")))
      throw new IllegalArgumentException("heap or direct");
    List<Object> held = new ArrayList<>();
    int step = 0;
    System.out.printf(
        "mode=%s maxHeapBytes=%d availableProcessors=%d%n",
        args[0], Runtime.getRuntime().maxMemory(), Runtime.getRuntime().availableProcessors());
    while (true) {
      if (args[0].equals("heap")) held.add(new byte[8 * 1024 * 1024]);
      else held.add(ByteBuffer.allocateDirect(8 * 1024 * 1024));
      System.out.printf("step=%d allocatedMiB=%d%n", ++step, step * 8);
      Thread.sleep(100);
    }
  }
}
