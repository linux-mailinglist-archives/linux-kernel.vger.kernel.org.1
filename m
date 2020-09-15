Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CACB26B027
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgIOWCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIOVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:24 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:23 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p20so3107740qvl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mLPMK4MCVaMfW1ExHIuH+/iSqevGe2FtNCbwS1lUn8o=;
        b=VNWaSIVTN/hY29M+g6/mna6fCs6sSWl/V8UrBXz7qIpv2xqAsiPQD19JZ4fj/JijVg
         y7wUNQn2Ql1W1x3o+x7zX5fYmrPshnVGFIMDWQP4ZJ7vpvKQseuGbRUnmiEg+jLqfQfC
         9YkSHJPuwfo0lmO5PnjOInliFUiWhfcQklVv4QHZEf9q7NnRshSKFzBFXG0dqtZ682sz
         nDedvZ5dNaYQO7d2STY5rB5dUMdazXCZZmNou338XujSDiCCPSf65lWucf6vwhzGy46d
         YBcycyYubrMgcsG6rLuFtUXELOrxEl01SgZ0xnZUEllm3v+BbKkClip8JhLFDpIMBLry
         jIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mLPMK4MCVaMfW1ExHIuH+/iSqevGe2FtNCbwS1lUn8o=;
        b=qHjSLB8fiIGFZUQIwMBwkT/UD1JZucSpm8jfVV4MnspudNNC+PG5XJDOAaKm5EZZsU
         2BmR2xY1auxYiaYKE9T+eb+1mHad9e3Vfm6YnSUkTstokOV/wpTCWo9JycpbEzxpPMKA
         T75QKJKEVT3tHHZpW+KtARsCLG/XRlyfS5KfrW2/igJGNwkF6vm9mugaowXNrPXQtLS9
         VTjFwkZM3pfvcwhfhsvZt1uoIM+al6oUf4oZ3tjlQftHO+zjKlsT9yu9ITRwxwUnx+bO
         ePaiR0/npsCzYT7WEdaytQdOOMkWKNqlOj1aLw/qWi3M6b4I8iFI7doJjJojFLnaI9cO
         cNDQ==
X-Gm-Message-State: AOAM532oSiPEB8EWQWPiL5+ft9ex2BIECekIx62fgTRKO6g8uJLmVhRo
        YBGXR6YN2qyu8v+xfssNjF32tqtkvdTJBVts
X-Google-Smtp-Source: ABdhPJyO9xM7CLluykFhwuM9eiIGVOlzaxETMk0Z6eu0LBMdYfeUTKPUVtqZ7FrFrVljPK3QFg3cjE4ndWeAi5Me
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9cc6:: with SMTP id
 j6mr3771581qvf.60.1600204582782; Tue, 15 Sep 2020 14:16:22 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:42 +0200
Message-Id: <cover.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 00/37] kasan: add hardware tag-based mode for arm64
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a new hardware tag-based mode to KASAN [1]. The new mode
is similar to the existing software tag-based KASAN, but relies on arm64
Memory Tagging Extension (MTE) [2] to perform memory and pointer tagging
(instead of shadow memory and compiler instrumentation).

This patchset is co-developed by
Vincenzo Frascino <vincenzo.frascino@arm.com>.

This patchset is available here:

https://github.com/xairy/linux/tree/up-kasan-mte-v2

and has also been uploaded to the Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2700

This patchset is based on the v10 of the user MTE patchset [3].

This patchset essentially consists of four parts:

1. Rework KASAN code to allow easier integration of the hardware tag-based
   mode.
2. Introduce config option for the new mode.
3. Introduce core in-kernel MTE routines.
4. Combine the previous parts together to implement the new mode.

For testing in QEMU hardware tag-based KASAN requires:

1. QEMU built from master [4] (use "-machine virt,mte=on -cpu max" arguments
   to run).
2. GCC version 10.

[1] https://www.kernel.org/doc/html/latest/dev-tools/kasan.html
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte
[4] https://github.com/qemu/qemu

====== Overview

The underlying ideas of the approach used by hardware tag-based KASAN are:

1. By relying on the Top Byte Ignore (TBI) arm64 CPU feature, pointer tags
   are stored in the top byte of each kernel pointer.

2. With the Memory Tagging Extension (MTE) arm64 CPU feature, memory tags
   for kernel memory allocations are stored in a dedicated memory not
   accessible via normal instuctions.

3. On each memory allocation, a random tag is generated, embedded it into
   the returned pointer, and the corresponding memory is tagged with the
   same tag value.

4. With MTE the CPU performs a check on each memory access to make sure
   that the pointer tag matches the memory tag.

5. On a tag mismatch the CPU generates a tag fault, and a KASAN report is
   printed.

Same as other KASAN modes, hardware tag-based KASAN is intended as a
debugging feature at this point.

====== Rationale

There are two main reasons for this new hardware tag-based mode:

1. Previously implemented software tag-based KASAN is being successfully
   used on dogfood testing devices due to its low memory overhead (as
   initially planned). The new hardware mode keeps the same low memory
   overhead, and is expected to have significantly lower performance
   impact, due to the tag checks being performed by the hardware.
   Therefore the new mode can be used as a better alternative in dogfood
   testing for hardware that supports MTE.

2. The new mode lays the groundwork for the planned in-kernel MTE-based
   memory corruption mitigation to be used in production.

====== Technical details

From the implementation perspective, hardware tag-based KASAN is almost
identical to the software mode. The key difference is using MTE for
assigning and checking tags.

Compared to the software mode, the hardware mode uses 4 bits per tag, as
dictated by MTE. Pointer tags are stored in bits [56:60), the top 4 bits
have the normal value 0xF. Having less distict tags increases the
probablity of false negatives (from ~1/256 to ~1/16) in certain cases.

Only synchronous exceptions are set up and used by hardware tag-based KASAN.

====== Benchmarks

Note: all measurements have been performed with software emulation of Memory
Tagging Extension, performance numbers for hardware tag-based KASAN on the
actual hardware are expected to be better.

Boot time [1]:
* 2.8 sec for clean kernel
* 5.7 sec for hardware tag-based KASAN
* 11.8 sec for software tag-based KASAN
* 11.6 sec for generic KASAN

Slab memory usage after boot [2]:
* 7.0 kb for clean kernel
* 9.7 kb for hardware tag-based KASAN
* 9.7 kb for software tag-based KASAN
* 41.3 kb for generic KASAN

Measurements have been performed with:
* defconfig-based configs
* Manually built QEMU master
* QEMU arguments: -machine virt,mte=on -cpu max
* CONFIG_KASAN_STACK_ENABLE disabled
* CONFIG_KASAN_INLINE enabled
* clang-10 as the compiler and gcc-10 as the assembler
    
[1] Time before the ext4 driver is initialized.
[2] Measured as `cat /proc/meminfo | grep Slab`.

====== Notes

The cover letter for software tag-based KASAN patchset can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0116523cfffa62aeb5aa3b85ce7419f3dae0c1b8

====== History

Changes v1->v2:
- Rebase onto v10 of the user MTE patchset.
- Only enable in-kernel MTE when KASAN_HW_TAGS is enabled.
- Add a layer of arch-level indirection, so KASAN doesn't call MTE helpers
  directly (this will be useful in case more architectures will add support
  for HW_TAGS).
- Don't do arm64_skip_faulting_instruction() on MTE fault, disable MTE
  instead.
- Don't allow software tags with MTE via arch/arm64/Kconfig instead of
  lib/Kconfig.kasan.
- Rename mm/kasan/tags.c to tags_sw.c and mte.c to tags_hw.c, and do the
  same for report_*.c files.
- Reword HW_TAGS Kconfig help text to make it less MTE specific.
- Reword and clarify Documentation.
- Drop unnecessary is_el1_mte_sync_tag_check_fault().
- Change report_tag_fault() to only call kasan_report() once HW_TAGS is
  introduced.
- Rename arch/arm64/include/asm/mte_asm.h to mte-helpers.h and move all
  MTE-related defines and some helper functions there.
- Change mm/kasan/kasan.h to include mte-def.h instead of mte.h.
- Add WARN_ON() on unaligned size to mte_set_mem_tag_range().
- Implement ldg/irg MTE routines as inline assembly.
- Remove smp_wmb() from mte_set_mem_tag_range().
- Drop __must_check from mte_set_mem_tag_range() as KASAN has no use for
  the return value.
- Drop zero size check from mte_assign_mem_tag_range().
- Drop unnecessary include <asm/kasan.h> from low-level arm64 code.
- Move enabling TBI1 into __cpu_setup().
- Drop stale comment about callee-saved register from
  arch/arm64/kernel/entry.S.
- Mark gcr_kernel_excl as __ro_after_init.
- Use GENMASK() in mte_init_tags().

Andrey Konovalov (31):
  kasan: KASAN_VMALLOC depends on KASAN_GENERIC
  kasan: group vmalloc code
  kasan: shadow declarations only for software modes
  kasan: rename (un)poison_shadow to (un)poison_memory
  kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
  kasan: only build init.c for software modes
  kasan: split out shadow.c from common.c
  kasan: rename generic/tags_report.c files
  kasan: don't duplicate config dependencies
  kasan: hide invalid free check implementation
  kasan: decode stack frame only with KASAN_STACK_ENABLE
  kasan, arm64: only init shadow for software modes
  kasan, arm64: only use kasan_depth for software modes
  kasan: rename addr_has_shadow to addr_has_metadata
  kasan: rename print_shadow_for_address to print_memory_metadata
  kasan: kasan_non_canonical_hook only for software modes
  kasan: rename SHADOW layout macros to META
  kasan: separate metadata_fetch_row for each mode
  kasan: don't allow SW_TAGS with ARM64_MTE
  kasan: rename tags.c to tags_sw.c
  kasan: introduce CONFIG_KASAN_HW_TAGS
  arm64: kasan: Add arch layer for memory tagging helpers
  arm64: kasan: Align allocations for HW_TAGS
  kasan: define KASAN_GRANULE_SIZE for HW_TAGS
  kasan, x86, s390: update undef CONFIG_KASAN
  kasan, arm64: expand CONFIG_KASAN checks
  kasan, arm64: implement HW_TAGS runtime
  kasan, arm64: print report from tag fault handler
  kasan, slub: reset tags when accessing metadata
  kasan, arm64: enable CONFIG_KASAN_HW_TAGS
  kasan: add documentation for hardware tag-based mode

Vincenzo Frascino (6):
  arm64: mte: Add in-kernel MTE helpers
  arm64: mte: Add in-kernel tag fault handler
  arm64: kasan: Enable in-kernel MTE
  arm64: mte: Convert gcr_user into an exclude mask
  arm64: mte: Switch GCR_EL1 in kernel entry and exit
  arm64: kasan: Enable TBI EL1

 Documentation/dev-tools/kasan.rst            |  80 ++-
 arch/arm64/Kconfig                           |   5 +-
 arch/arm64/Makefile                          |   2 +-
 arch/arm64/include/asm/assembler.h           |   2 +-
 arch/arm64/include/asm/cache.h               |   3 +
 arch/arm64/include/asm/esr.h                 |   1 +
 arch/arm64/include/asm/kasan.h               |   8 +-
 arch/arm64/include/asm/memory.h              |  14 +-
 arch/arm64/include/asm/mte-helpers.h         |  54 ++
 arch/arm64/include/asm/mte.h                 |  19 +-
 arch/arm64/include/asm/processor.h           |   2 +-
 arch/arm64/include/asm/string.h              |   5 +-
 arch/arm64/kernel/asm-offsets.c              |   3 +
 arch/arm64/kernel/cpufeature.c               |  10 +
 arch/arm64/kernel/entry.S                    |  26 +
 arch/arm64/kernel/head.S                     |   2 +-
 arch/arm64/kernel/image-vars.h               |   2 +-
 arch/arm64/kernel/mte.c                      |  90 ++-
 arch/arm64/kernel/setup.c                    |   1 -
 arch/arm64/lib/mte.S                         |  17 +
 arch/arm64/mm/dump.c                         |   6 +-
 arch/arm64/mm/fault.c                        |  43 +-
 arch/arm64/mm/kasan_init.c                   |  22 +-
 arch/arm64/mm/proc.S                         |  26 +-
 arch/s390/boot/string.c                      |   1 +
 arch/x86/boot/compressed/misc.h              |   1 +
 include/linux/kasan-checks.h                 |   2 +-
 include/linux/kasan.h                        | 110 ++--
 include/linux/mm.h                           |   2 +-
 include/linux/moduleloader.h                 |   3 +-
 include/linux/page-flags-layout.h            |   2 +-
 include/linux/sched.h                        |   2 +-
 include/linux/string.h                       |   2 +-
 init/init_task.c                             |   2 +-
 kernel/fork.c                                |   4 +-
 lib/Kconfig.kasan                            |  69 ++-
 lib/test_kasan.c                             |   2 +-
 mm/kasan/Makefile                            |  25 +-
 mm/kasan/common.c                            | 554 +------------------
 mm/kasan/generic.c                           |  33 +-
 mm/kasan/generic_report.c                    | 165 ------
 mm/kasan/init.c                              |  10 +-
 mm/kasan/kasan.h                             |  64 ++-
 mm/kasan/report.c                            | 254 ++-------
 mm/kasan/report_generic.c                    | 331 +++++++++++
 mm/kasan/report_tags_hw.c                    |  47 ++
 mm/kasan/{tags_report.c => report_tags_sw.c} |   9 +-
 mm/kasan/shadow.c                            | 509 +++++++++++++++++
 mm/kasan/tags_hw.c                           |  78 +++
 mm/kasan/{tags.c => tags_sw.c}               |  16 +-
 mm/page_poison.c                             |   2 +-
 mm/ptdump.c                                  |  13 +-
 mm/slab_common.c                             |   2 +-
 mm/slub.c                                    |  25 +-
 scripts/Makefile.lib                         |   2 +
 55 files changed, 1689 insertions(+), 1095 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte-helpers.h
 delete mode 100644 mm/kasan/generic_report.c
 create mode 100644 mm/kasan/report_generic.c
 create mode 100644 mm/kasan/report_tags_hw.c
 rename mm/kasan/{tags_report.c => report_tags_sw.c} (91%)
 create mode 100644 mm/kasan/shadow.c
 create mode 100644 mm/kasan/tags_hw.c
 rename mm/kasan/{tags.c => tags_sw.c} (93%)

-- 
2.28.0.618.gf4bc123cb7-goog

