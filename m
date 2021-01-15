Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BA2F80B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbhAOQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbhAOQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:25:55 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA1C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:25:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n25so6330008pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfexXFziwrKRfOX4l3+6YvZjjwRLIjObzMGfUtSVyeM=;
        b=bDO0sh8ND/Kp9YBuVYuuYne0hvDlDbstuN8s+MMzemjh4mRJRt5XK2gC2j9ukiCxxI
         lDM6zel6pLnNAUIVwz51E8E1Ea4TQdhGxtWcNtV0zM5dPD10AczUVwafHNsQZnhVIlQa
         PFpbOYgvz57XNEAMYbHsthMN8styMud5Ic7nDAUrMyKvBeTVxv6R7EvEZTZ95zd122j8
         CYDe4Js8rstp1FQPHbs/61odEazJHq0yxax2ena3/waG0VWiZeoLX3gnjAXVs1TfpGmb
         As0UGfVlmj6IfBsHDl4aCP4hqm4esruvsw3jZAnRIoHEk2iaKCIUt6H33PA6i1WXblNd
         TuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfexXFziwrKRfOX4l3+6YvZjjwRLIjObzMGfUtSVyeM=;
        b=OAMFZAUUCGpAhoTtrmIhe75zrB8vTh//bzbRhkeMXm+dQchWBukINcKH4HWN49d0O2
         MdmKr7Emb6vjkIrpQmPuL5yyFKpKyYXgg7WVvCZox52hlEiDnQrYkwlHm+gN/q49zOss
         I6tSWCv+W3YqFdrZkMmgoy3lJmKbEHJuubNFWxNh5sCbm8+aAJ6nQ3F2paWKC9wCkCjM
         zyfkwxrccfK/i2738QhU0vp7nVOnIFAu1uXDM8yRMbkW6G/j9emMzVoYi/l8PSYOjqeD
         jss1pjllWoqQLEsxP22ffARd5Cg8F2BmSvLt4kXFgnjh+MQ8vMM2YLtaS5S+Syw9rtvz
         M8HA==
X-Gm-Message-State: AOAM531WRhr3dKopCqZya/wbcvsndV99y8mZ9Cycdgr3P3qzUcZzB9lQ
        nxPTU0rzRtTovEsqCruoiShHTtpG2SK72YfXBkcqfg==
X-Google-Smtp-Source: ABdhPJyGyGY/VC4XtYJ6TesT63WXidZSszERWskyJorhJM/53Ff1OyrQPrltJj1Oc5cnrjiMxQiaIsSyYZoBRUB3B/k=
X-Received: by 2002:a62:115:0:b029:1b4:c593:acd4 with SMTP id
 21-20020a6201150000b02901b4c593acd4mr1100547pfb.2.1610727914773; Fri, 15 Jan
 2021 08:25:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com> <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
 <20210113165441.GC27045@gaia> <CAAeHK+zThyq7ApsRTu-En7pL9yAAOrEpV45KOuJV3PCpdjVuiw@mail.gmail.com>
 <20210115150658.GE16707@gaia>
In-Reply-To: <20210115150658.GE16707@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 17:25:03 +0100
Message-ID: <CAAeHK+yZdP7d5nrZDKnk_Drezs7pr07_XH10wtjKe87BjEpiQA@mail.gmail.com>
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

On Fri, Jan 15, 2021 at 4:07 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jan 15, 2021 at 02:12:24PM +0100, Andrey Konovalov wrote:
> > On Wed, Jan 13, 2021 at 5:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
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
> > Sounds good, will do in v3, thanks!
>
> I wonder if this one gives the same result (so please check):
>
>         far = u64_replace_bits(untagged_addr(far), far, MTE_TAG_MASK);
>
> (defined in linux/bitfield.h)

No, it zeroes out the tag. Not sure why. I took a brief look at the
implementation and didn't get how it's supposed to work - too much bit
trickery.
