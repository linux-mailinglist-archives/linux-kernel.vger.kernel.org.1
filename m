Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9742A4DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgKCR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:58:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0181DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:58:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h64so18839910ybc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GGWgvoZY910z090vjaD/trTDnHRiD2bK8G9Zkm0OdaQ=;
        b=MPs5H9K/GNYH88/cjofX/0pnvoh87i16NZDp+t/FBeBNmQr1f3sYSFhyoZvzUqnuCl
         7J5NmeGLORyPoEIIfoNQSRr9AxHL8WG7e6cSW99EgdR/JwhOAIoxuIRcKr5v6gx0ug0h
         HVnJR1uLWq9sD00ITzewjpDN3WrrG8VA6ejGUTN9sFd81d6P0VvyKIK3vCX+UaAjcVTg
         E4OhYeSMutCgHFoSiAk7bh2pqBCUCDGKyACK/vrfpYVcHDv1ITaQtKQIJEIvNqGGaWZl
         CaVHX3zDaPJZKCoDjchOdAFjj+4nj6VlcQQ+0bz1rnpdYLHf82iwSHMWiBPaurhED9xD
         FtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GGWgvoZY910z090vjaD/trTDnHRiD2bK8G9Zkm0OdaQ=;
        b=R3BTzHui5qCzEgTfDE63MqvGiZur6OmunHtLQCV/XMziHRG7Bw4A8Qi5PBZNVSn8GM
         1c5Kpot/Z3SR/2geCelIL8CyPpb22zMZM7wjGobz8aUg5rvPZ/+FriUV7TVHrghn75qn
         qQr/Sp/i3LE7tceSA8N2d3xOFXRAmnP6hDX8aUmjJAURi4lu+XOtZDRa5WdUk4F3TEr9
         EF/f72uswFLs/P6MPfxjBKG8ibPM81gsXf2MxLuFTRYoCDcPP6Xn4Hih9DSNLswBEItR
         wH6XznGMUf7NeOl6MHXWVcNfaEbCzclCrImq59NW6SSFsmCQZWj1gG00oSE4vEBgA5HS
         pOHA==
X-Gm-Message-State: AOAM530cscsj97P+MUDfN2kzOM0lOdmd7em3C1C7GPQJRPFJqTKXYMNO
        OYlxQen2MG8d60u+rcpzK/1rN2XnqA==
X-Google-Smtp-Source: ABdhPJyJ/KYtmxpdNOxTNZHyoQfNLx2vZEvV6qNcQFRvatq9jJu8NqZv0dG6QdWdqKG6OPr2EzdmCcH3BA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a25:d288:: with SMTP id j130mr30666909ybg.378.1604426335148;
 Tue, 03 Nov 2020 09:58:55 -0800 (PST)
Date:   Tue,  3 Nov 2020 18:58:32 +0100
Message-Id: <20201103175841.3495947-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 0/9] KFENCE: A low-overhead sampling-based memory safety
 error detector
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ From v7 we think this series is ready to be included in the mm tree.
  Where appropriate, we would welcome additional Acks / Reviews by MM,
  x86, and arm64 maintainers. Thank you! ]

This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
low-overhead sampling-based memory safety error detector of heap
use-after-free, invalid-free, and out-of-bounds access errors.  This
series enables KFENCE for the x86 and arm64 architectures, and adds
KFENCE hooks to the SLAB and SLUB allocators.

KFENCE is designed to be enabled in production kernels, and has near
zero performance overhead. Compared to KASAN, KFENCE trades performance
for precision. The main motivation behind KFENCE's design, is that with
enough total uptime KFENCE will detect bugs in code paths not typically
exercised by non-production test workloads. One way to quickly achieve a
large enough total uptime is when the tool is deployed across a large
fleet of machines.

KFENCE objects each reside on a dedicated page, at either the left or
right page boundaries. The pages to the left and right of the object
page are "guard pages", whose attributes are changed to a protected
state, and cause page faults on any attempted access to them. Such page
faults are then intercepted by KFENCE, which handles the fault
gracefully by reporting a memory access error.

Guarded allocations are set up based on a sample interval (can be set
via kfence.sample_interval). After expiration of the sample interval,
the next allocation through the main allocator (SLAB or SLUB) returns a
guarded allocation from the KFENCE object pool. At this point, the timer
is reset, and the next allocation is set up after the expiration of the
interval.

To enable/disable a KFENCE allocation through the main allocator's
fast-path without overhead, KFENCE relies on static branches via the
static keys infrastructure. The static branch is toggled to redirect the
allocation to KFENCE.

The KFENCE memory pool is of fixed size, and if the pool is exhausted no
further KFENCE allocations occur. The default config is conservative
with only 255 objects, resulting in a pool size of 2 MiB (with 4 KiB
pages).

We have verified by running synthetic benchmarks (sysbench I/O,
hackbench) and production server-workload benchmarks that a kernel with
KFENCE (using sample intervals 100-500ms) is performance-neutral
compared to a non-KFENCE baseline kernel.

KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
properties. The name "KFENCE" is a homage to the Electric Fence Malloc
Debugger [2].

For more details, see Documentation/dev-tools/kfence.rst added in the
series -- also viewable here:

	https://raw.githubusercontent.com/google/kasan/kfence/Documentation/dev-tools/kfence.rst

[1] http://llvm.org/docs/GwpAsan.html
[2] https://linux.die.net/man/3/efence

v7:
* Clean up print_diff_canary() boundary calculation.
* Cleaner CONFIG_KFENCE_STRESS_TEST_FAULTS, using "if EXPERT".
* Make __kfence_free() part of the public API.
* Only not-present faults should be handled by KFENCE.
* Remove arm64 dependency on 4K page size.
* Move kmemleak_free_recursive() before kfence_free() in SLAB.
* Revert unused orig_size in SLUB.
* For KASAN compatibility, also skip kasan_poison_*().
* Various smaller fixes (see details in patches).

v6: https://lkml.kernel.org/r/20201029131649.182037-1-elver@google.com
* Record allocation and free task pids, and show them in reports. This
  information helps more easily identify e.g. racy use-after-frees.

v5: https://lkml.kernel.org/r/20201027141606.426816-1-elver@google.com
* Lots of smaller fixes (see details in patches).
* Optimize is_kfence_address() by using better in-range check.
* Removal of HAVE_ARCH_KFENCE_STATIC_POOL and static pool
  support in favor of memblock_alloc'd pool only, as it avoids all
  issues with virt_to translations. With the new optimizations to
  is_kfence_address(), we measure no noticeable performance impact.
* Taint with TAINT_BAD_PAGE, to distinguish memory errors from regular
  warnings (also used by SL*B/KASAN/etc. for memory errors).
* Rework sample_interval parameter dynamic setting semantics.
* Rework kfence_shutdown_cache().
* Fix obj_to_index+objs_per_slab_page, which among other things is
  required when using memcg accounted allocations.
* Rebase to 5.10-rc1.

v4: https://lkml.kernel.org/r/20200929133814.2834621-1-elver@google.com
* MAINTAINERS: Split out from first patch.
* Make static memory pool's attrs entirely arch-dependent.
* Fix report generation if __slab_free tail-called.
* Clarify RCU test comment [reported by Paul E. McKenney].

v3: https://lkml.kernel.org/r/20200921132611.1700350-1-elver@google.com
* Rewrite SLAB/SLUB patch descriptions to clarify need for 'orig_size'.
* Various smaller fixes (see details in patches).

v2: https://lkml.kernel.org/r/20200915132046.3332537-1-elver@google.com
* Various comment/documentation changes (see details in patches).
* Various smaller fixes (see details in patches).
* Change all reports to reference the kfence object, "kfence-#nn".
* Skip allocation/free internals stack trace.
* Rework KMEMLEAK compatibility patch.

RFC/v1: https://lkml.kernel.org/r/20200907134055.2878499-1-elver@google.com

Alexander Potapenko (5):
  mm: add Kernel Electric-Fence infrastructure
  x86, kfence: enable KFENCE for x86
  mm, kfence: insert KFENCE hooks for SLAB
  mm, kfence: insert KFENCE hooks for SLUB
  kfence, kasan: make KFENCE compatible with KASAN

Marco Elver (4):
  arm64, kfence: enable KFENCE for ARM64
  kfence, Documentation: add KFENCE documentation
  kfence: add test suite
  MAINTAINERS: add entry for KFENCE

 Documentation/dev-tools/index.rst  |   1 +
 Documentation/dev-tools/kfence.rst | 297 +++++++++++
 MAINTAINERS                        |  12 +
 arch/arm64/Kconfig                 |   1 +
 arch/arm64/include/asm/kfence.h    |  19 +
 arch/arm64/mm/fault.c              |   4 +
 arch/arm64/mm/mmu.c                |   7 +-
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/kfence.h      |  65 +++
 arch/x86/mm/fault.c                |   5 +
 include/linux/kfence.h             | 201 +++++++
 include/linux/slab_def.h           |   3 +
 include/linux/slub_def.h           |   3 +
 init/main.c                        |   3 +
 lib/Kconfig.debug                  |   1 +
 lib/Kconfig.kfence                 |  72 +++
 mm/Makefile                        |   1 +
 mm/kasan/common.c                  |  19 +
 mm/kasan/generic.c                 |   3 +-
 mm/kfence/Makefile                 |   6 +
 mm/kfence/core.c                   | 826 +++++++++++++++++++++++++++++
 mm/kfence/kfence.h                 | 107 ++++
 mm/kfence/kfence_test.c            | 823 ++++++++++++++++++++++++++++
 mm/kfence/report.c                 | 235 ++++++++
 mm/slab.c                          |  38 +-
 mm/slab_common.c                   |   5 +-
 mm/slub.c                          |  60 ++-
 27 files changed, 2792 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/dev-tools/kfence.rst
 create mode 100644 arch/arm64/include/asm/kfence.h
 create mode 100644 arch/x86/include/asm/kfence.h
 create mode 100644 include/linux/kfence.h
 create mode 100644 lib/Kconfig.kfence
 create mode 100644 mm/kfence/Makefile
 create mode 100644 mm/kfence/core.c
 create mode 100644 mm/kfence/kfence.h
 create mode 100644 mm/kfence/kfence_test.c
 create mode 100644 mm/kfence/report.c

-- 
2.29.1.341.ge80a0c044ae-goog

