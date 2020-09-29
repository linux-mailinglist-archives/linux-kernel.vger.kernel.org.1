Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58AB27CF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgI2Niq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2Nio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:38:44 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35AC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:38:43 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id b7so1779702wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=z1cXfrxOGzx7xyJIGn8IR6C4kJWaluaZ0MOMBbLzink=;
        b=YQlZfknSSvNvRczIa3w2KnrV406GAOWv4riuiKZDNf0muEq5IprfLHxEuf4QWG2X6v
         KVEafDVUZDZQ/lnlrbDUNKx/knoe0JXG3MFvQm3KqRbrBn5QRqhqvGhI0yC0xwPgNC+k
         Y4P7HPEPuFHow+cjpjzAfQn3BrGuvqTxF3SmyzIX4KIrgBxhqNT5NVw3qJ7UIdn9etXc
         UzivMLi+g3ro2cTRKuq3xjEFUtrcCDeVEgq/8uVv6TYifMgCu9AdmCnbkKnIgM6dpAYT
         cfPBKuaPXzQ+F6v8J2dAtTQTTOV2n/MRnS8WB1gJcHzeNwAwNLmiUohJWLw6JRw8ULih
         0Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=z1cXfrxOGzx7xyJIGn8IR6C4kJWaluaZ0MOMBbLzink=;
        b=IwGDgbC+Hd//A362TLohuqkcN7GY13bqA/TGxNwQh7xCGgvHF/+jwYp/UyNI8p/RTn
         IJ9UgLKNEMfFyWWoCYSU58D8IARQTCfklGgvqZ6tXBpcqEFXDqtHHW1xSBB0RrqzJEYQ
         Zsr+I8qhuRBOWRUQOtivJBrH2uRc5DTk9PhhkfVZxfazwqXwNaQnClr0hO0I4NrE23oE
         aujRbVAhEJA8JuZ8UJaUxYxdMyvJXqpITROhnUbJoAeagD1oYOnjHdyBf/YREuktXm3e
         E6ZoRpI2wRypAHJ2oEWk2Xm6h8i6OpmP6V7kuIH+3lsHuCyJGD0Ep0yZVQZSvBAKq/Ee
         jWcw==
X-Gm-Message-State: AOAM533KlGTdtfH1mzWzOyGBDmoqbwu5LWJ8+dt/7NlXVSZ8GNFIsRHE
        x4AN/4vCcPYCyj4yEgn6YQpHaVQJgA==
X-Google-Smtp-Source: ABdhPJzLfb+1L+DLOD5HANT71QD+TvopcJoj2qHEWsAOEUajKuEbN72wT6s+YP/on4qsVc9AwMoyktwOfw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:cd08:: with SMTP id f8mr4611202wmj.124.1601386721987;
 Tue, 29 Sep 2020 06:38:41 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:38:03 +0200
Message-Id: <20200929133814.2834621-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 00/11] KFENCE: A low-overhead sampling-based memory safety
 error detector
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
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

v4:
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

Alexander Potapenko (6):
  mm: add Kernel Electric-Fence infrastructure
  x86, kfence: enable KFENCE for x86
  mm, kfence: insert KFENCE hooks for SLAB
  mm, kfence: insert KFENCE hooks for SLUB
  kfence, kasan: make KFENCE compatible with KASAN
  kfence, kmemleak: make KFENCE compatible with KMEMLEAK

Marco Elver (5):
  arm64, kfence: enable KFENCE for ARM64
  kfence, lockdep: make KFENCE compatible with lockdep
  kfence, Documentation: add KFENCE documentation
  kfence: add test suite
  MAINTAINERS: Add entry for KFENCE

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
 mm/kfence/kfence_test.c            | 783 +++++++++++++++++++++++++++++
 mm/kfence/report.c                 | 225 +++++++++
 mm/kmemleak.c                      |   6 +
 mm/slab.c                          |  46 +-
 mm/slab_common.c                   |   6 +-
 mm/slub.c                          |  72 ++-
 25 files changed, 2631 insertions(+), 32 deletions(-)
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
2.28.0.709.gb0816b6eb0-goog

