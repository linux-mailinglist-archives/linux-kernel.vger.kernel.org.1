Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52B8292E31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgJSTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbgJSTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:08:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C60C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:08:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so253991pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=8tGLxiz79H94oyuXwt68AJpgGVw0fGCvyBhofOmupQY=;
        b=ECSpZCYeKug6rF3RXrjlnGVA17/KBmL8gWPJxVJ9iHFOAYNw0E/EXoN+K3V9N/gpG9
         XaDvH1UEbOPjzlAxxkgB9VhPHxNv4FLoR0clFwvIZ/zRpYVP6D502RlYbNVgRx5tsFFu
         svyMw7RCaSBDp/lwXB88AC7zfYdOA71a+qlYXtKgwjJJ24WvzDISsA2jm1kTm5Ftz2nG
         uD6S9SUSmQLHLlFpGzFX9ttzf7bnjjhdUnlnE1yqFdo5Hs6gEzoUUmXLv6D4EiC9Xa/q
         Z69yczxxEYWL40lvrC5v6x0YVDO4T01sNf3vrs2fNuCXkDTvPKRFImtghj/soH7eJerU
         IFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=8tGLxiz79H94oyuXwt68AJpgGVw0fGCvyBhofOmupQY=;
        b=SDlX9bJhK5AyHrQ8XfZz7M6RM9BUoL5new1R7PH35cEcJzkhpIL92NPMKcPoiHmBIi
         pHp6ujG3s1s4PY0TRSbzQwaOuJZ8Yea1OSb7yQPA6+nPsW/n6XeYUJkSCxSEzkEQ+5yh
         d+wmJMUqp4iWA7EMH0nLZgMAt/bBPIX9IIGxoo6IWy5yV3KQXAI8TyaU3utFH0iNytVi
         E7BaHtrzBZEAa9EuksokYx5Kj7FmPRBSY+ygdtzV03wpmbxaZ7Z/QI3geWdsZ1t5Syg5
         PcKB5k02bWwKmeLa8KsD/yRcYHGtdg28i0OIDuRID/kWOslJka4V5ik0IcgvvjNnX07Q
         f3jg==
X-Gm-Message-State: AOAM530MN2HriuHi4Yto2EDDmkxN3xy04kOTHiG8ZZSjhsw+f7B14OFR
        sXU/qN6Xs2NmSDrD9QvK9oLNfw==
X-Google-Smtp-Source: ABdhPJwcw1vhs9ZMVodQtYhPHO2Io1vOOEv/d1ESaDJgS22DeSiudXW//nypi1km8L1k7TFCJa8p+w==
X-Received: by 2002:a17:902:6bc4:b029:d5:ef85:1a63 with SMTP id m4-20020a1709026bc4b02900d5ef851a63mr434565plt.73.1603134491603;
        Mon, 19 Oct 2020 12:08:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p6sm261472pjd.1.2020.10.19.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:08:11 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:08:11 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Oct 2020 12:08:06 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw0

for you to fetch changes up to de22d2107ced3cc5355cc9dbbd85e44183546bd5:

  RISC-V: Add page table dump support for uefi (2020-10-02 14:31:33 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.10 Merge Window, Part 1

This contains a handful of cleanups and new features, including:

* A handful of cleanups for our page fault handling.
* Improvements to how we fill out cacheinfo.
* Support for EFI-based systems.

---

This contains a merge from the EFI tree that was necessary as some of the EFI
support landed over there.  It's my first time doing something like this,

I haven't included the set_fs stuff because the base branch it depends on
hasn't been merged yet.  I'll probably have another merge window PR, as
there's more in flight (most notably the fix for new binutils I just sent out),
but I figured there was no reason to delay this any longer.

There is one merge conflict, which is between my fixes and for-next branches:

    diff --cc arch/riscv/kernel/vmlinux.lds.S
    index 67db80e12d1f,9795359cb9da..ffaa3da375c2
    --- a/arch/riscv/kernel/vmlinux.lds.S
    +++ b/arch/riscv/kernel/vmlinux.lds.S
    @@@ -66,8 -71,11 +70,13 @@@ SECTION
                    _etext = .;
            }
      
     +      INIT_DATA_SECTION(16)
     +
    + #ifdef CONFIG_EFI
    +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
    +       __pecoff_text_end = .;
    + #endif
    + 
            /* Start of data section */
            _sdata = .;
            RO_DATA(SECTION_ALIGN)

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Move DT mapping outof fixmap

Ard Biesheuvel (3):
      efi/libstub: arm32: Base FDT and initrd placement on image address
      efi/libstub: Export efi_low_alloc_above() to other units
      efi/libstub: arm32: Use low allocation for the uncompressed kernel

Atish Patra (8):
      include: pe.h: Add RISC-V related PE definition
      efi: Rename arm-init to efi-init common for all arch
      RISC-V: Add early ioremap support
      RISC-V: Implement late mapping page table allocation functions
      RISC-V: Add PE/COFF header for EFI stub
      RISC-V: Add EFI stub support.
      RISC-V: Add EFI runtime services
      RISC-V: Add page table dump support for uefi

Palmer Dabbelt (1):
      Merge tag 'efi-riscv-shared-for-v5.10' of ssh://gitolite.kernel.org/.../efi/efi into for-next

Pekka Enberg (11):
      riscv/mm: Simplify retry logic in do_page_fault()
      riscv/mm/fault: Move no context handling to no_context()
      riscv/mm/fault: Move bad area handling to bad_area()
      riscv/mm/fault: Move vmalloc fault handling to vmalloc_fault()
      riscv/mm/fault: Simplify fault error handling
      riscv/mm/fault: Move fault error handling to mm_fault_error()
      riscv/mm/fault: Simplify mm_fault_error()
      riscv/mm/fault: Move FAULT_FLAG_WRITE handling in do_page_fault()
      riscv/mm/fault: Move access error check to function
      riscv/mm/fault: Fix inline placement in vmalloc_fault() declaration
      riscv/mm/fault: Set FAULT_FLAG_INSTRUCTION flag in do_page_fault()

Tian Tao (1):
      RISC-V: Fix duplicate included thread_info.h

Zong Li (3):
      riscv: Set more data to cacheinfo
      riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
      riscv: Add cache information in AUX vector

 arch/arm/include/asm/efi.h                      |  23 +-
 arch/arm64/include/asm/efi.h                    |   5 +-
 arch/riscv/Kconfig                              |  25 ++
 arch/riscv/Makefile                             |   1 +
 arch/riscv/configs/defconfig                    |   1 +
 arch/riscv/include/asm/Kbuild                   |   1 +
 arch/riscv/include/asm/cacheinfo.h              |   5 +
 arch/riscv/include/asm/efi.h                    |  55 ++++
 arch/riscv/include/asm/elf.h                    |  13 +
 arch/riscv/include/asm/fixmap.h                 |  16 +-
 arch/riscv/include/asm/io.h                     |   1 +
 arch/riscv/include/asm/mmu.h                    |   2 +
 arch/riscv/include/asm/pgtable.h                |   5 +
 arch/riscv/include/asm/sections.h               |  13 +
 arch/riscv/include/uapi/asm/auxvec.h            |  24 ++
 arch/riscv/kernel/Makefile                      |   2 +
 arch/riscv/kernel/cacheinfo.c                   |  98 +++++--
 arch/riscv/kernel/efi-header.S                  | 111 ++++++++
 arch/riscv/kernel/efi.c                         |  96 +++++++
 arch/riscv/kernel/head.S                        |  18 +-
 arch/riscv/kernel/head.h                        |   2 -
 arch/riscv/kernel/image-vars.h                  |  51 ++++
 arch/riscv/kernel/setup.c                       |  18 +-
 arch/riscv/kernel/vmlinux.lds.S                 |  23 +-
 arch/riscv/mm/fault.c                           | 356 +++++++++++++-----------
 arch/riscv/mm/init.c                            | 191 ++++++++++---
 arch/riscv/mm/ptdump.c                          |  48 +++-
 drivers/firmware/efi/Kconfig                    |   3 +-
 drivers/firmware/efi/Makefile                   |   4 +-
 drivers/firmware/efi/{arm-init.c => efi-init.c} |   0
 drivers/firmware/efi/libstub/Makefile           |  10 +
 drivers/firmware/efi/libstub/arm32-stub.c       | 178 +++---------
 drivers/firmware/efi/libstub/arm64-stub.c       |   1 -
 drivers/firmware/efi/libstub/efi-stub.c         |  59 +---
 drivers/firmware/efi/libstub/efistub.h          |   7 +-
 drivers/firmware/efi/libstub/relocate.c         |   4 +-
 drivers/firmware/efi/libstub/riscv-stub.c       | 109 ++++++++
 drivers/firmware/efi/riscv-runtime.c            | 143 ++++++++++
 include/linux/pe.h                              |   3 +
 39 files changed, 1275 insertions(+), 450 deletions(-)
 create mode 100644 arch/riscv/include/asm/efi.h
 create mode 100644 arch/riscv/include/asm/sections.h
 create mode 100644 arch/riscv/kernel/efi-header.S
 create mode 100644 arch/riscv/kernel/efi.c
 create mode 100644 arch/riscv/kernel/image-vars.h
 rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
 create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
 create mode 100644 drivers/firmware/efi/riscv-runtime.c
