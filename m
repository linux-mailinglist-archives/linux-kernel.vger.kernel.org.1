Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5619A2F816D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbhAORB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbhAORB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:01:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ADAC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:00:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n10so6352312pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpClgSgoL5qlpfbaIDgx+JiK7CY1YGls1Kpu5D2pXJM=;
        b=uyCixVTzoIdCHTSe73V5pVNgDxg9Tc74jsDQCYZviBWeWUEbZMNEktX9LrepMGaYU7
         tnxspVujy3IKRPQOO6zcRWDPT26Mg7w+JuuiRmDz+K9loh/hhiVX7nRo+gZe933/541V
         c37METKgJmpTGM+GebawsbqaGafQRtZcEr+Il2S7j4V6DMMHdfh3ZxS1oLRtKbnSu7Lm
         eMkG33dh/bhPlWCEOqxjzIwcZ3bzkggOf6hbETA+P71OQTY1DAR6O9v9um/KU/oQph70
         fy3MvHLGCjJDRymq6Z8cGbTY+oUv889luwLB5aU5NJo4uiNb8Q8IRH94P8z51AfdTad4
         AR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpClgSgoL5qlpfbaIDgx+JiK7CY1YGls1Kpu5D2pXJM=;
        b=EJjQE8cR1bu4jJMTh+t8VtBRJaSQ900rCoReOP0DIV6gOv66o6WGkeHH52NfgrKkKM
         qCaNLS0I2qAfyzCi/9I3EJOZoKkeMjPlmq1cbDenK8ocYVplJZ7ZgSSYQxSqbmxBNH/0
         wLgvm2ItWHrsIwqZqkjArZ6PbKH6/LpuP+E1id9Fa+sPRwGRIA63SRs8odPDySP3nATq
         yMqiUa33sYxlwr19T/yANONPiYEGacab8Dh3mBkbOgpAfInYyKkRBR7r/8BzSwOG0Voc
         VKhEhw/pnAezqAi0I4cAZjXg7zn8PLql+Q+fkDlwuv/uymgm4pyPWn/Kyw7FdV7HYzOg
         tToQ==
X-Gm-Message-State: AOAM530frwbwuK3YhHeRBKdI0+Oyp9ICYcn7rmXqiXKlnBf+b25ebsz3
        TZEr03V6s65r2Bw21bStsjLvAZD8rw6bIgmeObJH/w==
X-Google-Smtp-Source: ABdhPJwhvahtE9d/id+FvyRynN9rz4lvtkignWGxUEkpYTA/x0WQhQ3wphGYDQ3Rgn2Cr058ucCafMD+GA+cb7whaMs=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr13254266pfh.24.1610730047501; Fri, 15
 Jan 2021 09:00:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com> <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
 <20210113165441.GC27045@gaia> <CAAeHK+y8VyBnAmx_c6N6-40RqKSUKpn-vzfeOEhzAnij93hnqw@mail.gmail.com>
 <20210115165558.GF16707@gaia>
In-Reply-To: <20210115165558.GF16707@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 18:00:36 +0100
Message-ID: <CAAeHK+wNOcA4Zgi5R8+ODMuDkLuMSYHoLinPhoeGstd78TsPjQ@mail.gmail.com>
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

On Fri, Jan 15, 2021 at 5:56 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jan 15, 2021 at 05:30:40PM +0100, Andrey Konovalov wrote:
> > On Wed, Jan 13, 2021 at 5:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Wed, Jan 13, 2021 at 05:03:30PM +0100, Andrey Konovalov wrote:
> > > > As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
> > > > that is passed to report_tag_fault has pointer tags in the format of 0x0X,
> > > > while KASAN uses 0xFX format (note the difference in the top 4 bits).
> > > >
> > > > Fix up the pointer tag before calling kasan_report.
> > > >
> > > > Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
> > > > Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
> > > > Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >  arch/arm64/mm/fault.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > index 3c40da479899..a218f6f2fdc8 100644
> > > > --- a/arch/arm64/mm/fault.c
> > > > +++ b/arch/arm64/mm/fault.c
> > > > @@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
> > > >  {
> > > >       bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> > > >
> > > > +     /* The format of KASAN tags is 0xF<x>. */
> > > > +     addr |= (0xF0UL << MTE_TAG_SHIFT);
> > >
> > > Ah, I see, that top 4 bits are zeroed by do_tag_check_fault(). When this
> > > was added, the only tag faults were generated for user addresses.
> > >
> > > Anyway, I'd rather fix it in there based on bit 55, something like (only
> > > compile-tested):
> > >
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 3c40da479899..2b71079d2d32 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -709,10 +709,11 @@ static int do_tag_check_fault(unsigned long far, unsigned int esr,
> > >                               struct pt_regs *regs)
> > >  {
> > >         /*
> > > -        * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
> > > -        * check faults. Mask them out now so that userspace doesn't see them.
> > > +        * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN
> > > +        * for tag check faults. Set them to the corresponding bits in the
> > > +        * untagged address.
> > >          */
> > > -       far &= (1UL << 60) - 1;
> > > +       far = (untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK) ;
> > >         do_bad_area(far, esr, regs);
> > >         return 0;
> > >  }
> >
> > BTW, we can do "untagged_addr(far) | (far & MTE_TAG_MASK)" here, as
> > untagged_addr() doesn't change kernel pointers.
>
> untagged_addr() does change tagged kernel pointers, it sign-extends from
> bit 55. So the top byte becomes 0xff and you can no longer or the tag
> bits in.

That's __untagged_addr(), untagged_addr() keeps the bits for kernel
pointers as of  597399d0cb91.
