Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F422526FBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIRL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIRL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:59:28 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC68C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 04:59:27 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so6647572oih.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0D5X7Y+m7ttT/u5XV6+XFjpJPYZ+5nXOo1ENk9Sr6U=;
        b=DFPRb7Y9Hq4pascynXFSCCYpr/a4bl7ggPfVH9GJKFUO/ayct1amaR3wsxiMtCJvQ/
         uU9aqLvE4+HXrlO+1KmjR1ZdHm6nGOfYqOI56XcYbAoZM0igN3mx+nI9ZJpSYU8yrxJZ
         u+AZWJMVJIFe/bRMVGVi0Hi19qqYnmeQhZrR086TXXE4MzJZ6mBTzqOZdkbZePSwHv+b
         NlzY544p6SNnIG7ZfXxC5dhxyENzUj8syiofKsaVyI8Ug7qrh9/+qUTSkKFX7uk83X41
         cbPJFBW/Aoc0uFVMTF8ywh5ITaTxh+WCeIudQ5uchSvzeztt8D1HgMc80XgPqZ1p6LoH
         P58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0D5X7Y+m7ttT/u5XV6+XFjpJPYZ+5nXOo1ENk9Sr6U=;
        b=Cj/oG50P/LDa+F5D43bB7cNzmHmP4S3AJ1o/9FwoguwNIbHGHyvDGrZLkwnlwbFYVs
         DRVoYtBg0Crdn7l1Gkws1eKeofAzteOomP0lnwEGwxkzUoPghUYEHFcaxZrVoHRw16l3
         GpKt/bOJZw3JvVTYEHLyQRTZIA2/isdwNUm7MJWuIx0LyKsXCtS3CcO0CNLfZDqbh0lg
         X+haG67rLpGEBJz2J2x4tCTQBQRacWb1IcKowI/Qi1Gvd6YSXtjrUiVTMWbpK3S6IFo7
         tCZsKnkg3+UK74WPpP2rcZatSg3ISxYAbAVoa/YmbLl2EOoDVwEfSWVuWbTMvKnH9XMH
         qCfA==
X-Gm-Message-State: AOAM531UNThDUa2F//sfNcMz5ur2GtEeDeVS3mCejfVGMToOhMtIa3X6
        06yQabosM/ci/VLGVH1aAySaQu/XmEDiiHArGECFUA==
X-Google-Smtp-Source: ABdhPJx1YWIbj0a3kj+XHGq4l0nWGyQu8DX2tequbx+9ACWXzIIk8edPn+mRXVtmJXtgCrXRQzALviAeMqM1jJ7KNJc=
X-Received: by 2002:aca:5158:: with SMTP id f85mr9503239oib.121.1600430367017;
 Fri, 18 Sep 2020 04:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200915132046.3332537-1-elver@google.com> <115e74b249417340b5c411f286768dbdb916fd12.camel@redhat.com>
In-Reply-To: <115e74b249417340b5c411f286768dbdb916fd12.camel@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 18 Sep 2020 13:59:15 +0200
Message-ID: <CANpmjNMkjuW_qU+G77UUzgqGx+e2RswfhYuWTFMq2da2NwqSdA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Qian Cai <cai@redhat.com>
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
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 at 13:17, Qian Cai <cai@redhat.com> wrote:
>
> On Tue, 2020-09-15 at 15:20 +0200, Marco Elver wrote:
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.  This
> > series enables KFENCE for the x86 and arm64 architectures, and adds
> > KFENCE hooks to the SLAB and SLUB allocators.
> >
> > KFENCE is designed to be enabled in production kernels, and has near
> > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > for precision. The main motivation behind KFENCE's design, is that with
> > enough total uptime KFENCE will detect bugs in code paths not typically
> > exercised by non-production test workloads. One way to quickly achieve a
> > large enough total uptime is when the tool is deployed across a large
> > fleet of machines.
> >
> > KFENCE objects each reside on a dedicated page, at either the left or
> > right page boundaries. The pages to the left and right of the object
> > page are "guard pages", whose attributes are changed to a protected
> > state, and cause page faults on any attempted access to them. Such page
> > faults are then intercepted by KFENCE, which handles the fault
> > gracefully by reporting a memory access error.
> >
> > Guarded allocations are set up based on a sample interval (can be set
> > via kfence.sample_interval). After expiration of the sample interval,
> > the next allocation through the main allocator (SLAB or SLUB) returns a
> > guarded allocation from the KFENCE object pool. At this point, the timer
> > is reset, and the next allocation is set up after the expiration of the
> > interval.
> >
> > To enable/disable a KFENCE allocation through the main allocator's
> > fast-path without overhead, KFENCE relies on static branches via the
> > static keys infrastructure. The static branch is toggled to redirect the
> > allocation to KFENCE.
> >
> > The KFENCE memory pool is of fixed size, and if the pool is exhausted no
> > further KFENCE allocations occur. The default config is conservative
> > with only 255 objects, resulting in a pool size of 2 MiB (with 4 KiB
> > pages).
> >
> > We have verified by running synthetic benchmarks (sysbench I/O,
> > hackbench) that a kernel with KFENCE is performance-neutral compared to
> > a non-KFENCE baseline kernel.
> >
> > KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
> > properties. The name "KFENCE" is a homage to the Electric Fence Malloc
> > Debugger [2].
> >
> > For more details, see Documentation/dev-tools/kfence.rst added in the
> > series -- also viewable here:
>
> Does anybody else grow tried of all those different *imperfect* versions of in-
> kernel memory safety error detectors? KASAN-generic, KFENCE, KASAN-tag-based
> etc. Then, we have old things like page_poison, SLUB debugging, debug_pagealloc
> etc which are pretty much inefficient to detect bugs those days compared to
> KASAN. Can't we work towards having a single implementation and clean up all
> those mess?

If you have suggestions on how to get a zero-overhead, precise
("perfect") memory safety error detector without new hardware
extensions, we're open to suggestions -- many people over many years
have researched this problems, and while we're making progress for C
(and C++), the fact remains that what you're asking is likely
impossible. This might be useful background:
https://arxiv.org/pdf/1802.09517.pdf

The fact remains that requirements and environments vary across
applications and usecases. Maybe for one usecase (debugging, test env)
normal KASAN is just fine. But that doesn't work for production, where
we want to have max performance.

MTE will get us closer (no silicon yet, and ARM64 only for now), but
depending on implementation might come with small overheads, although
quite acceptable for most environments with increasing processing
power modern CPUs deliver.

Yet for other environments, where even a small performance regression
is unacceptable, and where it's infeasible to capture in tests what
the workloads execute, KFENCE is a very attractive option.

There have also been discussions on using Rust in the kernel [1], but
this is just not feasible for core kernel code in the near future
(even then, you'll still need dynamic error detection tools for all
the unsafe bits, of which there are many in an OS kernel).
[1] https://lwn.net/Articles/829858/

Thanks,
-- Marco
