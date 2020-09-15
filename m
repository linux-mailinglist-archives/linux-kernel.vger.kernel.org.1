Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A877926A699
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIONxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgIONuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:50:17 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD457C061352
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:49:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so3135382qtj.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtBJz+0p08+L8y6UxJF+d5EvYqNw22qJSy8aseGAB8M=;
        b=h/IVba/68t0qPIsX6EIwRoVuDLEC5J/mUrq1x5L0WBjdVnerhetEVq9R0g0s7eFCfj
         O9MZkHlzwMhYA4T5/sl5z4D4jUL3FVjs68bZqsoqKxsQ7N2fLqKbrrw1nNPetTbR3Mmb
         L7WffFVKpd7xlUau5b2L3sHnz7ZG1C66lcVf13tDfkSoxafm2zxUTjmKswvtH9I0yKcL
         o8gG3b03Y4tKDzA7bs4VqZ0I1uMs78NjVA88kpsuNzkY0AFsk0jQkPoeOvmrvw216ASn
         uoUSQgnG2Nai3N9rTqWHWWtvQJjLvI+h8Buc9/tBdzPP8z4yH0/7Rxq3DD4SqhPU/ILG
         OMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtBJz+0p08+L8y6UxJF+d5EvYqNw22qJSy8aseGAB8M=;
        b=lzizHp0tpVsfL2JXhnf4iYcAxiR/LMAk1p64lvecDg/Qr5djjw0gNSD2Z4LD30i8LB
         B4szzApe/uRaETyCEnLR3Ha67laRzC9/szITKXC8THSmX5KLYbLBwmu820iTJiyZ0GVb
         86BsJXvruSLnkcQHv7fr6CSTvwm0lm1Ib8hM/SQ9B/dYwCp/L+tDKXYA0Ra2aZZN4sbl
         8HjxMhB8dZqUdLJ/0hHLk26f+rJIT5wBKrNn/wdzZ5+LXqd1WeW4A8THQsjI39Z3NorB
         fy/I8cbQE9KbyfWBdZkie0A9zD7yfqViXSo0NFEWEYx7XW774R/Lxe0/Z6bDHJpid8FO
         uWag==
X-Gm-Message-State: AOAM530Al2xwyhZ+0UdN74lQ9ODfue+jjCw9KUPPMhpaDQT2a6q6YKJH
        bqxttAXJqx5Le6k+33KQieqQoTq8VLmm+UOGIjKtjw==
X-Google-Smtp-Source: ABdhPJzPdcIT8epev7ZwkqD39anHvjI83kLJhq+WY510/QuBLu74T6RLBAy4XlZRHUkFOEHg+aHps30lQ3JJUt2RMwk=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr18082864qto.158.1600177798597;
 Tue, 15 Sep 2020 06:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200915132046.3332537-1-elver@google.com>
In-Reply-To: <20200915132046.3332537-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Sep 2020 15:49:47 +0200
Message-ID: <CACT4Y+Ywx8G9W8izyiDAg1usHouSLds7E3XU0WJctCucDku_eQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
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
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 3:20 PM Marco Elver <elver@google.com> wrote:
>
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.  This
> series enables KFENCE for the x86 and arm64 architectures, and adds
> KFENCE hooks to the SLAB and SLUB allocators.
>
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

I see all of my comments from v1 are resolved. So this is:

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

for the series.

> v2:
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
> 2.28.0.618.gf4bc123cb7-goog
>
