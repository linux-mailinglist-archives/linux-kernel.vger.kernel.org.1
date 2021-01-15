Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE92F82A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbhAORkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAORkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:40:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6038AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:40:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q4so5056012plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGVXpiw8I6lb3z0yqBCK7I13Qcilt0rv1FBT0p51gDE=;
        b=gJTpyu5066Bb28EW+n/Gm/erJhxik98VbWcacxgJPLQ33b9VnWwppVDxrG3x4cUxGH
         8er0VxI76GqZoB4NgtHaHhNXdJ9W3G3gug9gAfu3Z9SXzbBSPZuI7Eu7H1KnVlaMG+ig
         FiNZFYuIU4laXOBoKPgFwYvagf1BMi0ycpU40XqomACvFlMVEjm6P8F7RjjXKvG9qLgX
         0N3k4RtA7lYw75+c0bdBvlnlOEeb0shWR0lcK0sTAGDaeDdOEs9l9UsNo4XOblpX9J9i
         u7b/x1Zp0TPeP4hg3Ve/oMy5Rc4AF8RMh6MrFr3IQViznMgHeB8IsuPu8rTs6fOeg++o
         XaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGVXpiw8I6lb3z0yqBCK7I13Qcilt0rv1FBT0p51gDE=;
        b=IYUFhnLpw7wHcvEcssf04O84AKy7vaWo8+Ult9TjxStBxrI1XVpeAQ60q7pD/lXTkw
         np2eHhGUub7FqCIbextBGaLPH1r+GLIxHbfKUEU0YHZWxTX3M6a2jSuluA4aAiHStVuK
         APR+iqVKtiw0L/FmTw1bYCIGvJ+3tJDn5mHpoCKScUWBeK1ho/Ibj+ic6XXwgAvSTuAM
         SbGvL5X1jyhCSslDRNeUXKg1SHtflgy5wQrvpuTaRjB1wjjBuk2nJuPK6p3SQwXsjlaH
         A803ioptue5WbXNaly0Rr0zNTCcAhU+dwi56DuVzqtju/BOM1k3nyJm9mvZhuLxT2n5/
         Jx4Q==
X-Gm-Message-State: AOAM533vW3Zij3+gozAATqlA9tBbJROJpO74siUJhPxqnfcs/2ecG6z8
        t1vHeJjNb8ob6LDZgSW0VM4iu5iN6rlxseeK22cl2w==
X-Google-Smtp-Source: ABdhPJzs84fYGjLNG+Y1Bggp57D0m5CAQQL0o/gyRKWrByY6ejJeTsdd/dt5zlJbx2fOYDXyDZasgoHIePXVeHgbtwU=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr11467727pjb.41.1610732404627;
 Fri, 15 Jan 2021 09:40:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com> <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
 <20210113165441.GC27045@gaia> <CAAeHK+y8VyBnAmx_c6N6-40RqKSUKpn-vzfeOEhzAnij93hnqw@mail.gmail.com>
 <20210115165558.GF16707@gaia> <CAAeHK+wNOcA4Zgi5R8+ODMuDkLuMSYHoLinPhoeGstd78TsPjQ@mail.gmail.com>
 <20210115170556.GG16707@gaia>
In-Reply-To: <20210115170556.GG16707@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 18:39:53 +0100
Message-ID: <CAAeHK+xxWVGd6K=hc-s_VT3iS3_wNg5=LohPLWQmW=MZ0PmKKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan, arm64: fix pointer tags in KASAN reports
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jan 15, 2021 at 06:00:36PM +0100, Andrey Konovalov wrote:
> > On Fri, Jan 15, 2021 at 5:56 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Fri, Jan 15, 2021 at 05:30:40PM +0100, Andrey Konovalov wrote:
> > > > On Wed, Jan 13, 2021 at 5:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > On Wed, Jan 13, 2021 at 05:03:30PM +0100, Andrey Konovalov wrote:
> > > > > > As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
> > > > > > that is passed to report_tag_fault has pointer tags in the format of 0x0X,
> > > > > > while KASAN uses 0xFX format (note the difference in the top 4 bits).
> > > > > >
> > > > > > Fix up the pointer tag before calling kasan_report.
> > > > > >
> > > > > > Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
> > > > > > Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
> > > > > > Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
> > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > ---
> > > > > >  arch/arm64/mm/fault.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > > > index 3c40da479899..a218f6f2fdc8 100644
> > > > > > --- a/arch/arm64/mm/fault.c
> > > > > > +++ b/arch/arm64/mm/fault.c
> > > > > > @@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
> > > > > >  {
> > > > > >       bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> > > > > >
> > > > > > +     /* The format of KASAN tags is 0xF<x>. */
> > > > > > +     addr |= (0xF0UL << MTE_TAG_SHIFT);
> > > > >
> > > > > Ah, I see, that top 4 bits are zeroed by do_tag_check_fault(). When this
> > > > > was added, the only tag faults were generated for user addresses.
> > > > >
> > > > > Anyway, I'd rather fix it in there based on bit 55, something like (only
> > > > > compile-tested):
> > > > >
> > > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > > index 3c40da479899..2b71079d2d32 100644
> > > > > --- a/arch/arm64/mm/fault.c
> > > > > +++ b/arch/arm64/mm/fault.c
> > > > > @@ -709,10 +709,11 @@ static int do_tag_check_fault(unsigned long far, unsigned int esr,
> > > > >                               struct pt_regs *regs)
> > > > >  {
> > > > >         /*
> > > > > -        * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
> > > > > -        * check faults. Mask them out now so that userspace doesn't see them.
> > > > > +        * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN
> > > > > +        * for tag check faults. Set them to the corresponding bits in the
> > > > > +        * untagged address.
> > > > >          */
> > > > > -       far &= (1UL << 60) - 1;
> > > > > +       far = (untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK) ;
> > > > >         do_bad_area(far, esr, regs);
> > > > >         return 0;
> > > > >  }
> > > >
> > > > BTW, we can do "untagged_addr(far) | (far & MTE_TAG_MASK)" here, as
> > > > untagged_addr() doesn't change kernel pointers.
> > >
> > > untagged_addr() does change tagged kernel pointers, it sign-extends from
> > > bit 55. So the top byte becomes 0xff and you can no longer or the tag
> > > bits in.
> >
> > That's __untagged_addr(), untagged_addr() keeps the bits for kernel
> > pointers as of  597399d0cb91.
>
> Ah, you are right. In this case I think we should use __untagged_addr()
> above. Even if the tag check fault happened on a kernel address, bits
> 63:60 are still unknown.

Yeah, I keep forgetting about [__]untagged_addr() too. Maybe we need
better names? Like untagged_addr() and untagged_addr_ttbr0()?

Anyway, I'll do the explicit calculation with __untagged_addr() in the
next version.

Thanks!
