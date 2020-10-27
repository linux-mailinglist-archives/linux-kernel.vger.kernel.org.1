Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59129C49D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901150AbgJ0OTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:19:24 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42469 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757180AbgJ0OQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:16:38 -0400
Received: by mail-qk1-f202.google.com with SMTP id e7so839926qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OIhtJmQn8cPhTYAMUsg4K5Bpc/At3M+CZmjJH0wJYj0=;
        b=swqC9CC50SvTwnu1p+NAEDUkfC9DTlBcJNPL6hdrqHkHXUlyAUE5Vht1e0smkxqH4D
         /0HZD6e4s1ZRQYVNH7Tx08omITR3CywUlxhYtKryxWjlHTxZ3N11mcSfiuLpn+co7mMh
         PKADunsWulz/DMZ685eoabCdusjZjOsaUkV1te8xrH5clsKVDy2M1SJqM/JUT5YQPnjy
         GB3G/Gfh3jgc0zezL0jZZ68W2hjiFmAU0jvZwM4VdvD60Yr8LMU9XnyjtCAIduXJysWD
         RHkhzeAPh4CR76dqhU5m502SyrspBlNwaLXH6EqCV1RJTAyAcqXJYhwQG5A05DLFfpWj
         wciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OIhtJmQn8cPhTYAMUsg4K5Bpc/At3M+CZmjJH0wJYj0=;
        b=V+4DCzbA1vSXZenLCA8rCAugTgOI35RCvj2UvCGX0W0wn+HW0Luv2EWsqx13/SUHKe
         P5jxwVqe++HXi75QpCAhEzHrUuLMrDHPRCNCLdYZRRC7yp2iS4FoEm0hGxc7YcG8gyV/
         epwkqMNb9Zgjkg9odWM9Q3BEFO5knnlE3JS2s4eOcJw7ocS5iYbDvzu/EB+2+0V6tyIS
         Gp4afmmF1JSUSTchMfMxD/bBrMk3UTBNvr2PLVsI+mt04nP6wgg0ZBXMV9l3zu9tP6MY
         xSfMjfF11laApJh0EWWPV2JxTmdPdoaQVCLGBiqsM0ATD/LAsDBopE8nQsNJX2kZ1iOD
         y3rw==
X-Gm-Message-State: AOAM531NHXxhveDEe5v09gdXrn46XsynXoqFIZ8UQwTu0LlbCIvpgxBT
        k71tlRZJ8xUVjyNneBFFMRewXigrcg==
X-Google-Smtp-Source: ABdhPJxPqYmqxq3HpEgVPCM1Ayd8D9b+wgHFlJYApQIK5Kr+4fRK+eo3YA4xPHQzdYQGSVlyWYBlOyoJTA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:fa91:: with SMTP id o17mr2582669qvn.49.1603808196014;
 Tue, 27 Oct 2020 07:16:36 -0700 (PDT)
Date:   Tue, 27 Oct 2020 15:15:57 +0100
Message-Id: <20201027141606.426816-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v5 0/9] KFENCE: A low-overhead sampling-based memory safety
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
hackbench) that a kernel with KFENCE is performance-neutral compared to
a non-KFENCE baseline kernel.

KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
properties. The name "KFENCE" is a homage to the Electric Fence Malloc
Debugger [2].

For more details, see Documentation/dev-tools/kfence.rst added in the
series -- also viewable here:

	https://raw.githubusercontent.com/google/kasan/kfence/Documentation/dev-tools/kfence.rst

[1] http://llvm.org/docs/GwpAsan.html
[2] https://linux.die.net/man/3/efence

v5:
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
  MAINTAINERS: Add entry for KFENCE

 Documentation/dev-tools/index.rst  |   1 +
 Documentation/dev-tools/kfence.rst | 291 ++++++++++
 MAINTAINERS                        |  11 +
 arch/arm64/Kconfig                 |   1 +
 arch/arm64/include/asm/kfence.h    |  19 +
 arch/arm64/mm/fault.c              |   4 +
 arch/arm64/mm/mmu.c                |   7 +-
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/kfence.h      |  65 +++
 arch/x86/mm/fault.c                |   4 +
 include/linux/kfence.h             | 191 +++++++
 include/linux/slab_def.h           |   3 +
 include/linux/slub_def.h           |   3 +
 init/main.c                        |   3 +
 lib/Kconfig.debug                  |   1 +
 lib/Kconfig.kfence                 |  73 +++
 mm/Makefile                        |   1 +
 mm/kasan/common.c                  |  15 +
 mm/kasan/generic.c                 |   3 +-
 mm/kfence/Makefile                 |   6 +
 mm/kfence/core.c                   | 823 +++++++++++++++++++++++++++++
 mm/kfence/kfence.h                 | 102 ++++
 mm/kfence/kfence_test.c            | 822 ++++++++++++++++++++++++++++
 mm/kfence/report.c                 | 236 +++++++++
 mm/slab.c                          |  37 +-
 mm/slab_common.c                   |   5 +-
 mm/slub.c                          |  72 ++-
 27 files changed, 2769 insertions(+), 31 deletions(-)
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
2.29.0.rc2.309.g374f81d7ae-goog

