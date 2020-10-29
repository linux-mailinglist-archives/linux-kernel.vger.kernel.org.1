Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538F29EC99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgJ2NRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgJ2NRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:17:01 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB60C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:16:59 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l47so1783762qve.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=gJ+NyZrwSjh9xv4IitL3tDIsRKqkaN8A5XofNgnAjw0=;
        b=bkpQw3q1vLKk8DHo5pHLHBVE1CIav1oE1voIWji1HnsQ08+YTjgHqmcXNPvpEvKeJX
         fqyg8UADfhL3YCWwAyuqU1senrwPc8QfPpEt5Lk0hmZL10YHWhVsO4gZ7ivQm8EhP9x0
         D/SXkdwqzsmoEdyysNzopPSuloZqi0uBgd59zF9Ik1Z3OS2aAO59SjyVg2z1dfhOlafL
         K9R8qDs+QEnNahOgYlbKRFVOgdBl+JRhs91xoEyWKV5tIksD26LJDse70QYAfLdS+RS3
         IKaXGR4ELKqHdBk0eVTImANA7yaRtoe2Gtp/13tf/72Si6arhIafA5VVPQMvj4cjk8Jc
         uLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=gJ+NyZrwSjh9xv4IitL3tDIsRKqkaN8A5XofNgnAjw0=;
        b=sIebrQUQJLHaz36lEfhMEWus01/lAGKxkVRNDb93gvLVwdSOoaJmw39s4PQzwVQ0jN
         s5Q4YL79R5gSBFVpZjuauYtj4fKM2A1t5rCwW3xUjJ0RokNayTJ1Z6CLllB4LhtQ89VC
         Ic1SPkV2g7g5W1UdpBs5dJW/vbUJgUfsX59RS7XJPJ5NSMk3JX5kD6lcDzi07Z8GyHGC
         chzk4vIp+sSguBrkK1j9swMxXv0flR6WYaN1ZOuFn/ea8Q1xldDHsWeSpkMf7955sKrD
         7eJM2Qc3rQXrfoE6N6i47061n87P9RXKkAyT1Kv7DWOcb04+QTj3jNGQ0sh67RM6UlPl
         FFAw==
X-Gm-Message-State: AOAM531mUlLcajPz1ZAuaVpo87YiAfTIszUu6pD9/WtZz2meF6vtTU14
        vq3BpMNoqjjJ0wcVmFjFs1lXk1d3KQ==
X-Google-Smtp-Source: ABdhPJyiBEUA7qxqCN7bgZyMqRXcQURQ1iojG+u5gBlNOJrvBwDovJB4Z2UVeJEY7owHFDQXsGpnumDHpA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:45ca:: with SMTP id v10mr4429043qvt.48.1603977418489;
 Thu, 29 Oct 2020 06:16:58 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:16:40 +0100
Message-Id: <20201029131649.182037-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 0/9] KFENCE: A low-overhead sampling-based memory safety
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

v6:
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
 mm/kfence/core.c                   | 821 ++++++++++++++++++++++++++++
 mm/kfence/kfence.h                 | 107 ++++
 mm/kfence/kfence_test.c            | 822 +++++++++++++++++++++++++++++
 mm/kfence/report.c                 | 235 +++++++++
 mm/slab.c                          |  37 +-
 mm/slab_common.c                   |   5 +-
 mm/slub.c                          |  72 ++-
 27 files changed, 2771 insertions(+), 31 deletions(-)
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

