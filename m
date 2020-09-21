Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8A2725BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgIUNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:38:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:38:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so7281735qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERlr98dYkkda4zLxk53JkLPO7AhscnKPFqUfoBopbaA=;
        b=HNVQxdIvyjxV02C0SmKSgBOK3X7gmaAI+1wd7Y1v/D2826xQAIFx2yNTQVVIQCTkGk
         DJIiamwhdLzg1aiKo8B+4LNJMb4aahXCaj6Tnxrec6RRLNHYMCi6KSMa7W0RazgRWKWl
         bibpbbIsj5H/7ZgjXUXqJQNV1rg4WsPmAo8I4psbOh37Nu7Z1O7nCfyiuwWKMEOyrnCW
         9nVjMyy+gJNxrh5Q+/2mcz0oSUjxm1+RI1npswmnkqm/5TuTKzoyRs5Z2BYZRqKYGzIv
         wWUtgg7NJyPApffKrC4m14CoV8blSCRSAoOgoGKYZXu7mDTBJ0i5DHI6ERGJjiFg2DZE
         AYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERlr98dYkkda4zLxk53JkLPO7AhscnKPFqUfoBopbaA=;
        b=SZFr9puZ8GOAF/x5hUPdpBS8/rP5vLfvHRmI1oug421Ik1JONWSlvEBrr7mMm8Z3DG
         gA6OMSQxrWyNRlKk5Yc5EfpelCDQRWT3SNCT+OQC7Rjm/VllTqRn0iCLsuEFl4AOhMuw
         gT/AMxeOu0Y3BapHg0idtIbWg3H5UbUlPoi1YadZ14SZMpDm1rLvdaMyUztxNST7KT2Y
         Ev3W6aH8K8LUAmmoIz4ifL9PPFzdkZDm7Ejtpyz4AGWfOuSL+YCr7+x7VAyAz5hi/P1N
         1DEm/PxqIKvkJHTSh4gh5Rd0Udnj+Sxji20jzv2SLqejCLxB5PnKfS5S3CY5sYcvrK6n
         PGjQ==
X-Gm-Message-State: AOAM533WB1dridZ0u/27GnckGV3vAir9qoLbhGvyUxuYYZnu/IleSyL5
        rD5/WuUACL5vVux7zbnJubxb1l+2YzcLJnd840Dfng==
X-Google-Smtp-Source: ABdhPJzu+vpcCJEiJAr7jQhKGwS1zn6cL7CDLvVaILUlHon5A+NGPQgau+h6tFlcRBb2p1DUcTCfbj90hS7dNHDxS9g=
X-Received: by 2002:a0c:a4c5:: with SMTP id x63mr36319qvx.58.1600695524500;
 Mon, 21 Sep 2020 06:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com>
In-Reply-To: <20200921132611.1700350-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Sep 2020 15:38:33 +0200
Message-ID: <CACT4Y+a1PH_Pms=AZg_QwAd8_MzZDKyxUTxo0-GthiJyE-e4vg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 3:26 PM Marco Elver <elver@google.com> wrote:
>
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.  This
> series enables KFENCE for the x86 and arm64 architectures, and adds
> KFENCE hooks to the SLAB and SLUB allocators.

Hi Andrew,

I wanted to ask what we can expect with respect to the timeline of
merging this into mm/upstream? The series got few reviews/positive
feedback.

Thank you



> KFENCE is designed to be enabled in production kernels, and has near
> zero performance overhead. Compared to KASAN, KFENCE trades performance
> for precision. The main motivation behind KFENCE's design, is that with
> enough total uptime KFENCE will detect bugs in code paths not typically
> exercised by non-production test workloads. One way to quickly achieve a
> large enough total uptime is when the tool is deployed across a large
> fleet of machines.
>
> KFENCE objects each reside on a dedicated page, at either the left or
> right page boundaries. The pages to the left and right of the object
> page are "guard pages", whose attributes are changed to a protected
> state, and cause page faults on any attempted access to them. Such page
> faults are then intercepted by KFENCE, which handles the fault
> gracefully by reporting a memory access error.
>
> Guarded allocations are set up based on a sample interval (can be set
> via kfence.sample_interval). After expiration of the sample interval,
> the next allocation through the main allocator (SLAB or SLUB) returns a
> guarded allocation from the KFENCE object pool. At this point, the timer
> is reset, and the next allocation is set up after the expiration of the
> interval.
>
> To enable/disable a KFENCE allocation through the main allocator's
> fast-path without overhead, KFENCE relies on static branches via the
> static keys infrastructure. The static branch is toggled to redirect the
> allocation to KFENCE.
>
> The KFENCE memory pool is of fixed size, and if the pool is exhausted no
> further KFENCE allocations occur. The default config is conservative
> with only 255 objects, resulting in a pool size of 2 MiB (with 4 KiB
> pages).
>
> We have verified by running synthetic benchmarks (sysbench I/O,
> hackbench) that a kernel with KFENCE is performance-neutral compared to
> a non-KFENCE baseline kernel.
>
> KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
> properties. The name "KFENCE" is a homage to the Electric Fence Malloc
> Debugger [2].
>
> For more details, see Documentation/dev-tools/kfence.rst added in the
> series -- also viewable here:
>
>         https://raw.githubusercontent.com/google/kasan/kfence/Documentation/dev-tools/kfence.rst
>
> [1] http://llvm.org/docs/GwpAsan.html
> [2] https://linux.die.net/man/3/efence
>
> v3:
> * Rewrite SLAB/SLUB patch descriptions to clarify need for 'orig_size'.
> * Various smaller fixes (see details in patches).
>
> v2: https://lkml.kernel.org/r/20200915132046.3332537-1-elver@google.com
> * Various comment/documentation changes (see details in patches).
> * Various smaller fixes (see details in patches).
> * Change all reports to reference the kfence object, "kfence-#nn".
> * Skip allocation/free internals stack trace.
> * Rework KMEMLEAK compatibility patch.
>
> RFC/v1: https://lkml.kernel.org/r/20200907134055.2878499-1-elver@google.com
>
> Alexander Potapenko (6):
>   mm: add Kernel Electric-Fence infrastructure
>   x86, kfence: enable KFENCE for x86
>   mm, kfence: insert KFENCE hooks for SLAB
>   mm, kfence: insert KFENCE hooks for SLUB
>   kfence, kasan: make KFENCE compatible with KASAN
>   kfence, kmemleak: make KFENCE compatible with KMEMLEAK
>
> Marco Elver (4):
>   arm64, kfence: enable KFENCE for ARM64
>   kfence, lockdep: make KFENCE compatible with lockdep
>   kfence, Documentation: add KFENCE documentation
>   kfence: add test suite
>
>  Documentation/dev-tools/index.rst  |   1 +
>  Documentation/dev-tools/kfence.rst | 291 +++++++++++
>  MAINTAINERS                        |  11 +
>  arch/arm64/Kconfig                 |   1 +
>  arch/arm64/include/asm/kfence.h    |  39 ++
>  arch/arm64/mm/fault.c              |   4 +
>  arch/x86/Kconfig                   |   2 +
>  arch/x86/include/asm/kfence.h      |  60 +++
>  arch/x86/mm/fault.c                |   4 +
>  include/linux/kfence.h             | 174 +++++++
>  init/main.c                        |   2 +
>  kernel/locking/lockdep.c           |   8 +
>  lib/Kconfig.debug                  |   1 +
>  lib/Kconfig.kfence                 |  78 +++
>  mm/Makefile                        |   1 +
>  mm/kasan/common.c                  |   7 +
>  mm/kfence/Makefile                 |   6 +
>  mm/kfence/core.c                   | 733 +++++++++++++++++++++++++++
>  mm/kfence/kfence.h                 | 102 ++++
>  mm/kfence/kfence_test.c            | 777 +++++++++++++++++++++++++++++
>  mm/kfence/report.c                 | 219 ++++++++
>  mm/kmemleak.c                      |   6 +
>  mm/slab.c                          |  46 +-
>  mm/slab_common.c                   |   6 +-
>  mm/slub.c                          |  72 ++-
>  25 files changed, 2619 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/dev-tools/kfence.rst
>  create mode 100644 arch/arm64/include/asm/kfence.h
>  create mode 100644 arch/x86/include/asm/kfence.h
>  create mode 100644 include/linux/kfence.h
>  create mode 100644 lib/Kconfig.kfence
>  create mode 100644 mm/kfence/Makefile
>  create mode 100644 mm/kfence/core.c
>  create mode 100644 mm/kfence/kfence.h
>  create mode 100644 mm/kfence/kfence_test.c
>  create mode 100644 mm/kfence/report.c
>
> --
> 2.28.0.681.g6f77f65b4e-goog
>
