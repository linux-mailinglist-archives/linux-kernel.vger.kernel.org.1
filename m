Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282E02964AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369690AbgJVSaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900451AbgJVSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:30:13 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C452C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:30:12 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id l23so610476vkm.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4v8Ha3TFg3az8pkly9JegXyIbM/38NHzQoTOXoHd1s=;
        b=kamEeDWGiGohye4hVyQkHXfrHJ1Qlhzfl+yTzHud9CLtjTSZWPEWwDFGcgBTacvwG9
         JBfO45kUWR2PCx2iUnJO8cmdWKRj4Rx/2PpEaPuDIiD+X0Jd3NxFJ2qlhOsNLRgPyhHz
         HW9+bLwYBaGRPkJdOfrI6+etMM00XXy0bx9esuWGjkfnqSQs6DAeIIjjRQyNpu6enX5Y
         R2QrD9c0DKvN34mmT48AcdlcVE9E2rf1nXkRax/unyd1+PQ5+/OFZXKOuP50Nuc2Qwri
         MoXBH3Y82S87DtmJ7rvFGdb2x5s2ajgXr+WbmQsUr+/RKYb+fr4W/B0o6ayeIYJvFUBY
         N59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4v8Ha3TFg3az8pkly9JegXyIbM/38NHzQoTOXoHd1s=;
        b=pV7PL3HaRl4xdmecBkn/p3XPQj8YfO0lvK3m0Xw/bj7vtHOfTUhi8km24Orjeqjd8L
         HyAB7SyspPcqm5TU4vBOYf7SB4zLpI5jD2cL1W+P2Nt5I7nSAB1W2Q54OtAvqUVQ1EEM
         1qGiQyopH/3DphwZFz1BEmDocXDZLzJdJrGtLKx8+weQH+eDRVDCiD+TQuV44kuR276L
         MCMTJldoA2we+M050qygSj2j8SxMLbkPJZ5a7erxJvKHza4eErkft7L11icK7gluHRVa
         Jgs6tYDIgLdJLMkCWLEnwgP10Q2OVHhm+IRZclFDeiSUl9HLndyk8cLNMrDaedKcE8Km
         9JWA==
X-Gm-Message-State: AOAM530hEr1qx+zJzlo+/3/J9rwCaksw0jPB924eUGNuYS2xjxJDUbCr
        qIkhQgGuKZQhfrvON95SiUoHB3DVatHlbBQqnaS4fw==
X-Google-Smtp-Source: ABdhPJy7k+0rbbSdtO8+zmoLrd3YrImQRkklZjrSyRmKKTf7xtna/FjcshCOI4/nRreoS1C7vfg7IOY0619BhlFSQ4Y=
X-Received: by 2002:a1f:d844:: with SMTP id p65mr2842445vkg.23.1603391410889;
 Thu, 22 Oct 2020 11:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <CACT4Y+bVCADgzweb_gmC9f7m_uc5r73scLPy+D3=Tbf2DFqb6g@mail.gmail.com>
 <CAAeHK+xEQ2krRDrPPFmOvp-pR+jR179VDg1iwd+mB0hVZ9rsgg@mail.gmail.com>
In-Reply-To: <CAAeHK+xEQ2krRDrPPFmOvp-pR+jR179VDg1iwd+mB0hVZ9rsgg@mail.gmail.com>
From:   Kostya Serebryany <kcc@google.com>
Date:   Thu, 22 Oct 2020 11:29:59 -0700
Message-ID: <CAN=P9piWK0Wk7LzLv3j1SQrR4=ifOv+e2KawCLLNftErZQzLww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/21] kasan: hardware tag-based mode for
 production use on arm64
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot parameters look great!

Do we use redzones in kasan.mode=prod?
(I think we should not)

Please separate the work on improving the stack trace collection form the work
on enabling kasan.mode=prod, the latter is more important IMHO.

Still some notes on stack traces:

> kasan.mode=full has 40% performance and 30% memory impact over
> kasan.mode=prod. Both come from alloc/free stack collection.

This is a lot. Right?
Please provide a more detailed breakdown:
* CPU overhead of collecting stack traces vs overhead of putting them
in a container/depot
* RAM overhead depending on the number of frames stored
* RAM overhead of the storage container (or redones?)
* How much is 30% in absolute numbers?

Do we perform any stack trace compressions?

Can we collect stack traces from the shadow call stack, when it's
available (default on Android)?

As we discussed offline, I think we have a way to compress reasonably
long stack traces into 8 bytes,
but it will take some effort and time to implement:
* collect the stack trace as usual (with shadow stack, when available)
* compute a hash of the top N frames
* store the hash, discard the stack trace. On trap, report the hashes
for allocation/deallocation
* Offline, analyze the binary to reconstruct the call graph, including
the indirect calls
* Perform DFS search from kmalloc/kfree up the call graph to depth N,
compute hashes for all paths,
report paths with the hash that matches the hash in the report.
My preliminary investigation shows that we can do it easily for N <= 10.
The trickiest bit here is to build the call graph for indirect calls,
but we should be able to do it.



On Thu, Oct 22, 2020 at 10:00 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 5:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > This patchset is not complete (hence sending as RFC), but I would like to
> > > start the discussion now and hear people's opinions regarding the
> > > questions mentioned below.
> > >
> > > === Overview
> > >
> > > This patchset adopts the existing hardware tag-based KASAN mode [1] for
> > > use in production as a memory corruption mitigation. Hardware tag-based
> > > KASAN relies on arm64 Memory Tagging Extension (MTE) [2] to perform memory
> > > and pointer tagging. Please see [3] and [4] for detailed analysis of how
> > > MTE helps to fight memory safety problems.
> > >
> > > The current plan is reuse CONFIG_KASAN_HW_TAGS for production, but add a
> > > boot time switch, that allows to choose between a debugging mode, that
> > > includes all KASAN features as they are, and a production mode, that only
> > > includes the essentials like tag checking.
> > >
> > > It is essential that switching between these modes doesn't require
> > > rebuilding the kernel with different configs, as this is required by the
> > > Android GKI initiative [5].
> > >
> > > The patch titled "kasan: add and integrate kasan boot parameters" of this
> > > series adds a few new boot parameters:
> > >
> > > kasan.mode allows choosing one of main three modes:
> > >
> > > - kasan.mode=off - no checks at all
> > > - kasan.mode=prod - only essential production features
> > > - kasan.mode=full - all features
> > >
> > > Those mode configs provide default values for three more internal configs
> > > listed below. However it's also possible to override the default values
> > > by providing:
> > >
> > > - kasan.stack=off/on - enable stacks collection
> > >                        (default: on for mode=full, otherwise off)
> > > - kasan.trap=async/sync - use async or sync MTE mode
> > >                           (default: sync for mode=full, otherwise async)
> > > - kasan.fault=report/panic - only report MTE fault or also panic
> > >                              (default: report)
> > >
> > > === Benchmarks
> > >
> > > For now I've only performed a few simple benchmarks such as measuring
> > > kernel boot time and slab memory usage after boot. The benchmarks were
> > > performed in QEMU and the results below exclude the slowdown caused by
> > > QEMU memory tagging emulation (as it's different from the slowdown that
> > > will be introduced by hardware and therefore irrelevant).
> > >
> > > KASAN_HW_TAGS=y + kasan.mode=off introduces no performance or memory
> > > impact compared to KASAN_HW_TAGS=n.
> > >
> > > kasan.mode=prod (without executing the tagging instructions) introduces
> > > 7% of both performace and memory impact compared to kasan.mode=off.
> > > Note, that 4% of performance and all 7% of memory impact are caused by the
> > > fact that enabling KASAN essentially results in CONFIG_SLAB_MERGE_DEFAULT
> > > being disabled.
> > >
> > > Recommended Android config has CONFIG_SLAB_MERGE_DEFAULT disabled (I assume
> > > for security reasons), but Pixel 4 has it enabled. It's arguable, whether
> > > "disabling" CONFIG_SLAB_MERGE_DEFAULT introduces any security benefit on
> > > top of MTE. Without MTE it makes exploiting some heap corruption harder.
> > > With MTE it will only make it harder provided that the attacker is able to
> > > predict allocation tags.
> > >
> > > kasan.mode=full has 40% performance and 30% memory impact over
> > > kasan.mode=prod. Both come from alloc/free stack collection.
>
> FTR, this only accounts for slab memory overhead that comes from
> redzones that store stack ids. There's also page_alloc overhead from
> the stacks themselves, which I didn't measure yet.
>
> > >
> > > === Questions
> > >
> > > Any concerns about the boot parameters?
> >
> > For boot parameters I think we are now "safe" in the sense that we
> > provide maximum possible flexibility and can defer any actual
> > decisions.
>
> Perfect!
>
> I realized that I actually forgot to think about the default values
> when no boot params are specified, I'll fix this in the next version.
>
> > > Should we try to deal with CONFIG_SLAB_MERGE_DEFAULT-like behavor mentioned
> > > above?
> >
> > How hard it is to allow KASAN with CONFIG_SLAB_MERGE_DEFAULT? Are
> > there any principal conflicts?
>
> I'll explore this.
>
> > The numbers you provided look quite substantial (on a par of what MTE
> > itself may introduce). So I would assume if a vendor does not have
> > CONFIG_SLAB_MERGE_DEFAULT disabled, it may not want to disable it
> > because of MTE (effectively doubles overhead).
>
> Sounds reasonable.
>
> Thanks!
