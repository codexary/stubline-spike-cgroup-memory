package com.elsworne.stubline.spike.cgroup;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class MemoryMainTest {
  @Test
  void rejectsUnknownAllocationMode() {
    assertThrows(IllegalArgumentException.class, () -> MemoryMain.main(new String[] {"other"}));
  }
}
