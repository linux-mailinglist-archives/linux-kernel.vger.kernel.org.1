Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB32F80D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbhAOQbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbhAOQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:31:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810CC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:30:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so6337940pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEsRmwU2Zg9Pm7ZYfxs6cFkd37PnI+Hzer0Thh9MkrA=;
        b=mjEuakf3LELUuf14yi0qZ2kkoyW78JDYiY2+E/aYX9liqbWOU+kVCGRcbmmqHnVZ4N
         BZlHrO6wAh+v02tq2xVEgCgI/PIl66nBPHqZWmG+ZMJzcDLpSAMa3ykuW+SdkmHUMKvW
         9PzSNMhzVAvfegD0kw2DeEtvQvhDpmmPm4TmUW+Xr5hhatxld3zRZPaOshOsQFkM73jV
         OUpQE69cMn/aBjozPXVTURZfY7M1G9ZcO3qrOAbedHg2MI+JA1NTtD/e8RIFvrddBJ5C
         XVp9YuGAzKdzWvAIm32jSU63V1tuPozCQ/DgK8cgiRvxAMPWkxsrRntUCJIJTz97F8N6
         KPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEsRmwU2Zg9Pm7ZYfxs6cFkd37PnI+Hzer0Thh9MkrA=;
        b=YjoliHqGFrv/EtGlJbjdo0PkZX8/lJVMP8AAqL2eoqG08dBozRhjPY37RcTFKYniKV
         NLgG63ITzDMXOlPJT+MdRhviK1u6UzvnayMqgbSJI/spFhoaF+BLZ15RQifeGAjrXfcG
         x1RwO6u/cIr5D6eMz+5Yr00YYKQJOgipYMG1sHJnCjZ7auUCC7Oww/JwO0W7Ql84D4B5
         34R05wgErgt7nL9+6xkI/qLwwDc5RcPIO8dShko1qvRct/QRwkGyfsw1iUslJtQ0PS3e
         ARBzuS0MWwGPcenGkTUzbqfGY7S+ULOno+aUHnVXruflPZ3d2xjsFqXYQL6RfLDdI1Vp
         u0fA==
X-Gm-Message-State: AOAM533HFFRoSc41gd6Xu4iSmsBYRD05kAHb/mX4/zkYZSiPnSwwJ8La
        CiPbHZJC1ufDpEcKGWfkd2hgkb31rFEzyobS7wvowA==
X-Google-Smtp-Source: ABdhPJygTqWrqfXQl+LwpvjBXUDWBUPUCYqWkZlbDeDTV6dmnmVOHnwRaZEPJ9H/Thwpz1E6NBRIcAzspA7rzMSCRJM=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr13127964pfh.24.1610728252059; Fri, 15
 Jan 2021 08:30:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com> <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
 <20210113165441.GC27045@gaia>
In-Reply-To: <20210113165441.GC27045@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 17:30:40 +0100
Message-ID: <CAAeHK+y8VyBnAmx_c6N6-40RqKSUKpn-vzfeOEhzAnij93hnqw@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 5:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jan 13, 2021 at 05:03:30PM +0100, Andrey Konovalov wrote:
> > As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
> > that is passed to report_tag_fault has pointer tags in the format of 0x0X,
> > while KASAN uses 0xFX format (note the difference in the top 4 bits).
> >
> > Fix up the pointer tag before calling kasan_report.
> >
> > Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
> > Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
> > Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/mm/fault.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 3c40da479899..a218f6f2fdc8 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
> >  {
> >       bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> >
> > +     /* The format of KASAN tags is 0xF<x>. */
> > +     addr |= (0xF0UL << MTE_TAG_SHIFT);
>
> Ah, I see, that top 4 bits are zeroed by do_tag_check_fault(). When this
> was added, the only tag faults were generated for user addresses.
>
> Anyway, I'd rather fix it in there based on bit 55, something like (only
> compile-tested):
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 3c40da479899..2b71079d2d32 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -709,10 +709,11 @@ static int do_tag_check_fault(unsigned long far, unsigned int esr,
>                               struct pt_regs *regs)
>  {
>         /*
> -        * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
> -        * check faults. Mask them out now so that userspace doesn't see them.
> +        * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN
> +        * for tag check faults. Set them to the corresponding bits in the
> +        * untagged address.
>          */
> -       far &= (1UL << 60) - 1;
> +       far = (untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK) ;
>         do_bad_area(far, esr, regs);
>         return 0;
>  }

BTW, we can do "untagged_addr(far) | (far & MTE_TAG_MASK)" here, as
untagged_addr() doesn't change kernel pointers.
