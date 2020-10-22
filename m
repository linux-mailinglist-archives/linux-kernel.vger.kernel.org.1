Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97D329633A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902204AbgJVRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898340AbgJVRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:00:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:00:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so1304313pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9Aq1WFRNzdLR8UtlVTni3Xh5pWCzbV3aMmYTzeHRyk=;
        b=YnO2A44cuaSmChU0uMnRd6pi32Jy01cimU6nmFhGtx2wsyKIKUvEFoeSl59skxdqKe
         OcmG+crA2W2V08HAm6naoonqEw2GZYJsNzd2AF2sxKnn++uh7j4O0LQXYaY+QTfXWcxp
         a8yZIJCso4Ik9njZLIbA+z+iRR7noHu7GOQa8sp2FXhekPD8cQguitj4Rd8KoA6ft7VA
         xE1M7hS2hPF3gaPAuCl7VbHFvPzpE1xKk7KVp1RDiB36vdAb31rRT3JgFYOxomoITtI2
         fAj79M9kHP7QGQsQw2Sm0gF2zR34RxrzUccA4RbRIXm7XioKUwnys3d2R6PPVa9wfolX
         liVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9Aq1WFRNzdLR8UtlVTni3Xh5pWCzbV3aMmYTzeHRyk=;
        b=rXdhvdSXSubDqS6NQ7AUgBYT2LPFcUymf+or/txzBJdMoj06UblVNrZS9iBDqDI3Fe
         xjrbd4629G1PI16+4cig+9AMtqi6FIycLe5QnmzNprbccWCLqeM9zByZh79Rxzk6iv7v
         tK78tYFpmXJVOeSBSR1U1DxMNFJNzZM0T9GCY3U9n/Aa886ui7PuGJcrX5lJ5M5tNCAW
         8aONRArTeaq8jUA4y3lfC+smHEVInpTQuXkD65pxVhzQ6ubJEpBgnKdwqyqMyC1x0o/w
         UMOV3SkpW/tyOFJYpTey69WzmkeOK50inMIKJQpjnV4PWM/n7cxxcxVFq7qWo7caMKK0
         rzYA==
X-Gm-Message-State: AOAM531gZ1Ge/dn7sGeaVI7kDAMLcQZ3UTjacufyKzyfm4vENOGVJTfl
        DGsi0OItV3HpW3cSzftyrZ7JZ+6nhPPMgrAwFRSjDQ==
X-Google-Smtp-Source: ABdhPJwIseJokmT+15DzDDxEnbPxtuHJDwDil7DuPbISBzf7KXMs0rivuA2lf05e1BwryEUEpoDbXlieMHevMhiZ9CA=
X-Received: by 2002:a63:d456:: with SMTP id i22mr3020892pgj.440.1603386054345;
 Thu, 22 Oct 2020 10:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <CACT4Y+bVCADgzweb_gmC9f7m_uc5r73scLPy+D3=Tbf2DFqb6g@mail.gmail.com>
In-Reply-To: <CACT4Y+bVCADgzweb_gmC9f7m_uc5r73scLPy+D3=Tbf2DFqb6g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 22 Oct 2020 19:00:43 +0200
Message-ID: <CAAeHK+xEQ2krRDrPPFmOvp-pR+jR179VDg1iwd+mB0hVZ9rsgg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/21] kasan: hardware tag-based mode for
 production use on arm64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
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

On Thu, Oct 22, 2020 at 5:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This patchset is not complete (hence sending as RFC), but I would like to
> > start the discussion now and hear people's opinions regarding the
> > questions mentioned below.
> >
> > === Overview
> >
> > This patchset adopts the existing hardware tag-based KASAN mode [1] for
> > use in production as a memory corruption mitigation. Hardware tag-based
> > KASAN relies on arm64 Memory Tagging Extension (MTE) [2] to perform memory
> > and pointer tagging. Please see [3] and [4] for detailed analysis of how
> > MTE helps to fight memory safety problems.
> >
> > The current plan is reuse CONFIG_KASAN_HW_TAGS for production, but add a
> > boot time switch, that allows to choose between a debugging mode, that
> > includes all KASAN features as they are, and a production mode, that only
> > includes the essentials like tag checking.
> >
> > It is essential that switching between these modes doesn't require
> > rebuilding the kernel with different configs, as this is required by the
> > Android GKI initiative [5].
> >
> > The patch titled "kasan: add and integrate kasan boot parameters" of this
> > series adds a few new boot parameters:
> >
> > kasan.mode allows choosing one of main three modes:
> >
> > - kasan.mode=off - no checks at all
> > - kasan.mode=prod - only essential production features
> > - kasan.mode=full - all features
> >
> > Those mode configs provide default values for three more internal configs
> > listed below. However it's also possible to override the default values
> > by providing:
> >
> > - kasan.stack=off/on - enable stacks collection
> >                        (default: on for mode=full, otherwise off)
> > - kasan.trap=async/sync - use async or sync MTE mode
> >                           (default: sync for mode=full, otherwise async)
> > - kasan.fault=report/panic - only report MTE fault or also panic
> >                              (default: report)
> >
> > === Benchmarks
> >
> > For now I've only performed a few simple benchmarks such as measuring
> > kernel boot time and slab memory usage after boot. The benchmarks were
> > performed in QEMU and the results below exclude the slowdown caused by
> > QEMU memory tagging emulation (as it's different from the slowdown that
> > will be introduced by hardware and therefore irrelevant).
> >
> > KASAN_HW_TAGS=y + kasan.mode=off introduces no performance or memory
> > impact compared to KASAN_HW_TAGS=n.
> >
> > kasan.mode=prod (without executing the tagging instructions) introduces
> > 7% of both performace and memory impact compared to kasan.mode=off.
> > Note, that 4% of performance and all 7% of memory impact are caused by the
> > fact that enabling KASAN essentially results in CONFIG_SLAB_MERGE_DEFAULT
> > being disabled.
> >
> > Recommended Android config has CONFIG_SLAB_MERGE_DEFAULT disabled (I assume
> > for security reasons), but Pixel 4 has it enabled. It's arguable, whether
> > "disabling" CONFIG_SLAB_MERGE_DEFAULT introduces any security benefit on
> > top of MTE. Without MTE it makes exploiting some heap corruption harder.
> > With MTE it will only make it harder provided that the attacker is able to
> > predict allocation tags.
> >
> > kasan.mode=full has 40% performance and 30% memory impact over
> > kasan.mode=prod. Both come from alloc/free stack collection.

FTR, this only accounts for slab memory overhead that comes from
redzones that store stack ids. There's also page_alloc overhead from
the stacks themselves, which I didn't measure yet.

> >
> > === Questions
> >
> > Any concerns about the boot parameters?
>
> For boot parameters I think we are now "safe" in the sense that we
> provide maximum possible flexibility and can defer any actual
> decisions.

Perfect!

I realized that I actually forgot to think about the default values
when no boot params are specified, I'll fix this in the next version.

> > Should we try to deal with CONFIG_SLAB_MERGE_DEFAULT-like behavor mentioned
> > above?
>
> How hard it is to allow KASAN with CONFIG_SLAB_MERGE_DEFAULT? Are
> there any principal conflicts?

I'll explore this.

> The numbers you provided look quite substantial (on a par of what MTE
> itself may introduce). So I would assume if a vendor does not have
> CONFIG_SLAB_MERGE_DEFAULT disabled, it may not want to disable it
> because of MTE (effectively doubles overhead).

Sounds reasonable.

Thanks!
