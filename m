Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882B026A690
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIONvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIONsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:48:31 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0FC061352
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:10 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id t10so1155837wmi.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3v1WW0rh2eoeOYf+0D4JaYfcibqs7KNHQLEBt1uRbAw=;
        b=XpeZsX3ZL3cx8gGVk2Tbt+U9NXYj/ItbUog5GEEcb1+No+ZzD/4KVzi5GoiJJCB51V
         bJRNLWSxvPah1fy4Dc/n8t83LiNQ1KIx7CMeQeGEPUKyq+yFPc7/M4/b8aXVpv4SVrUt
         qrAwousVIXxiFN8JRYIqMaUdJn4bHhIy/i2fPuTRwGqeyG/NBQXymWXoE2IzCFDraXw+
         gwh57Oemz7lbxOD9hrLxrDjE+m1Mi/sYgwIJ45oIjXKGYWAIP0HbF/MmFuOCfuU21E8u
         IvN3YXhohU4OVeavLy81H0DLdYwDou/jdQav1l1PT+jy4PUJ+4a2njVXU7mQiBNkrdOz
         oRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3v1WW0rh2eoeOYf+0D4JaYfcibqs7KNHQLEBt1uRbAw=;
        b=ip+kDo5VCjysxaRzrlqx3ZcyCxBdE+RIsrGjCOsXQKbzrLB0L+hsGgQFlRU9kpGC+e
         qYZ4rD218SJZ8vnkxCk5eV30rJ0AKps572lyIXSsWynOt20FMYuWlrsom/3NMeSVE66X
         WqXQ3PwHr0cm2YAeXr1/z+YcvfKIG1rYAErVIJWmhRLxwJwM+PafAqHacwXUws9SGvTG
         jiHvhstDLigzQ2OCKBczzlMTYVsQ2e9aZKw6GUTghtpYjq2JW28XdyxrDkoaereyD015
         tIIIcbCxFTyDbMU4q5i/5ZcVQvahHKyaBo4UEjhlF029Cq9UeDW6c7XF3Cct9i10AcTI
         fYsw==
X-Gm-Message-State: AOAM5329FALByOt/V7aaji7YO8zIVZK0TNz0mjiFDCsb3XfAwgonnBDg
        jULzaGIQKu7IrDMhUw/FSvqEYhzysQ==
X-Google-Smtp-Source: ABdhPJz876+N2zJf4oc82/5JSXY1PLMnhaBDskG/2zUt6ueeQCkv0pCYT8As7W2kPVM/TWnB16xSldwfZg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a05:600c:2109:: with SMTP id
 u9mr4457620wml.147.1600176058180; Tue, 15 Sep 2020 06:20:58 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:20:36 +0200
Message-Id: <20200915132046.3332537-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 00/10] KFENCE: A low-overhead sampling-based memory safety
 error detector
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, jannh@google.com,
        Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        cai@lca.pw, tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
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

v2:
* Various comment/documentation changes (see details in patches).
* Various smaller fixes (see details in patches).
* Change all reports to reference the kfence object, "kfence-#nn".
* Skip allocation/free internals stack trace.
* Rework KMEMLEAK compatibility patch.

RFC/v1: https://lkml.kernel.org/r/20200907134055.2878499-1-elver@google.com

Alexander Potapenko (6):
  mm: add Kernel Electric-Fence infrastructure
  x86, kfence: enable KFENCE for x86
  mm, kfence: insert KFENCE hooks for SLAB
  mm, kfence: insert KFENCE hooks for SLUB
  kfence, kasan: make KFENCE compatible with KASAN
  kfence, kmemleak: make KFENCE compatible with KMEMLEAK

Marco Elver (4):
  arm64, kfence: enable KFENCE for ARM64
  kfence, lockdep: make KFENCE compatible with lockdep
  kfence, Documentation: add KFENCE documentation
  kfence: add test suite

 Documentation/dev-tools/index.rst  |   1 +
 Documentation/dev-tools/kfence.rst | 291 +++++++++++
 MAINTAINERS                        |  11 +
 arch/arm64/Kconfig                 |   1 +
 arch/arm64/include/asm/kfence.h    |  39 ++
 arch/arm64/mm/fault.c              |   4 +
 arch/x86/Kconfig                   |   2 +
 arch/x86/include/asm/kfence.h      |  60 +++
 arch/x86/mm/fault.c                |   4 +
 include/linux/kfence.h             | 174 +++++++
 init/main.c                        |   2 +
 kernel/locking/lockdep.c           |   8 +
 lib/Kconfig.debug                  |   1 +
 lib/Kconfig.kfence                 |  78 +++
 mm/Makefile                        |   1 +
 mm/kasan/common.c                  |   7 +
 mm/kfence/Makefile                 |   6 +
 mm/kfence/core.c                   | 733 +++++++++++++++++++++++++++
 mm/kfence/kfence.h                 | 102 ++++
 mm/kfence/kfence_test.c            | 777 +++++++++++++++++++++++++++++
 mm/kfence/report.c                 | 219 ++++++++
 mm/kmemleak.c                      |   6 +
 mm/slab.c                          |  46 +-
 mm/slab_common.c                   |   6 +-
 mm/slub.c                          |  72 ++-
 25 files changed, 2619 insertions(+), 32 deletions(-)
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
2.28.0.618.gf4bc123cb7-goog

