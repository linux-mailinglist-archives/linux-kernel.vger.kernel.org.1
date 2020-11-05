Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA42A85BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgKESKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKESKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:10:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:10:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so1893951pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAoNSuBVW5u3fxEUjvf+bvrAfgyMkB897WinOBxVK3w=;
        b=F491/pGRojhINVVl3SszqGp2vZ+2u+JaPtTLKZpnytAPIGHN/++hTHce0DgSA66RxC
         aHMtp+v9EwdtmbCsNx5pZiltbcEs9KypJZ1rPA7LBmeRLf2rju7EczSN+t/Za0q01u05
         3GrwR4M6Dqd1fvAFcP+4amce+O8iOsacSW0S6s2eas3UiRxwmxsP66O22mOX2/boDOO7
         PRZMpe/qyzdiQp0PbQjs5sKBDMTnjO72t603qUbo5GKOT9VYrLY7b8RaHasOMdMzzEcy
         KQuThEPWKpm7wID3Kry+1Xigzj2UAY8DKFCokZ/bqXJT6hbyBV15tcYApupqAYsrgZAs
         5vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAoNSuBVW5u3fxEUjvf+bvrAfgyMkB897WinOBxVK3w=;
        b=pldIgAOCdwtwp1bC1uIbQhd/FqDgdVaYuL4hTM/ei6mGuG/3dAG5PwsRySg9kR9dHL
         2MKiyK0EwplUyDJ/og7oCryp5EhXadTqHN4Q7ofR1AOvhUdT3smFJVZ0SwhSGrz3lmv3
         6v4TGcnmVbM5lSJrRJRkS3NZBV5X5UQYvwH0FMk82kIrRwG+Y/SOjgHdSXuLL8c8lpom
         3WrQuOMRRwR8Pdkj67N09d2xe7tpJd/egJ3ERUYYtanEAobKX40VUPwC5F7C05pGf4nq
         3/fZv7EnyoU83/XIBd81Q91MW0HR/LIv1BOSlfgUxG1TsBg4RXEiEpvX68SHt3BLYAtu
         irzA==
X-Gm-Message-State: AOAM532U8ZLl1HJY5q9j7CQP84+F5oPl2tR+TYE0c32l+/A+XSONIEp/
        +t+sjxu+rT80pHCwyOH8Q8e5qCLCGvhUM/89o8l+ZA==
X-Google-Smtp-Source: ABdhPJyhqZ00u0pP8D204fPo/eIgdONzEkL+r5w1dxzrQid0f/YcXOppsgFmFTvjin+GdKBUrQmEfPzexsRxbDIR9hA=
X-Received: by 2002:a05:6a00:16c4:b029:162:bf9f:6458 with SMTP id
 l4-20020a056a0016c4b0290162bf9f6458mr3576815pfc.55.1604599809690; Thu, 05 Nov
 2020 10:10:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com> <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <20201105172549.GE30030@gaia> <CAAeHK+x0pQyQFG9e9HRxW5p8AYamPFmP-mKpHDWTwL_XUq7msA@mail.gmail.com>
 <20201105173901.GH30030@gaia>
In-Reply-To: <20201105173901.GH30030@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 19:09:58 +0100
Message-ID: <CAAeHK+wOyPYP=BkhratZwR=NKyzLWzwTTbyGtqQ75tJyM1D=rg@mail.gmail.com>
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 6:39 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 05, 2020 at 06:29:17PM +0100, Andrey Konovalov wrote:
> > On Thu, Nov 5, 2020 at 6:26 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Thu, Nov 05, 2020 at 12:18:45AM +0100, Andrey Konovalov wrote:
> > > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > > index 06ba6c923ab7..fcfbefcc3174 100644
> > > > --- a/arch/arm64/kernel/mte.c
> > > > +++ b/arch/arm64/kernel/mte.c
> > > > @@ -121,6 +121,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> > > >       return ptr;
> > > >  }
> > > >
> > > > +void __init mte_init_tags(u64 max_tag)
> > > > +{
> > > > +     /* Enable MTE Sync Mode for EL1. */
> > > > +     sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> > > > +     isb();
> > > > +}
> > >
> > > Is this going to be called on each CPU? I quickly went through the rest
> > > of the patches and couldn't see how.
> >
> > Yes, on each CPU. This is done via kasan_init_hw_tags() that is called
> > from cpu_enable_mte(). This change is added in the "kasan, arm64:
> > implement HW_TAGS runtime".
>
> Ah, I got there eventually in patch 38. Too many indirections ;) (I'm
> sure we could have trimmed them down a bit, hw_init_tags ==
> arch_init_tags == mte_init_tags).

The idea with these indirections was to make hw_tags.c to not directly
call MTE stuff and abstract away the underlying memory tagging
implementation. We won't know for sure how fitting these abstractions
are before we add another memory tagging implementation though :)

> > Would it make sense to put it into a separate patch?
>
> I think that's fine. I had the impression that kasan_init_hw_tags()
> should only be called once.

This was the case before, but not anymore. I've also added a comment
before the kasan_init_hw_tags() definition.
