Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA67B2F7C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbhAONNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbhAONNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:13:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB6C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:12:36 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c79so5479103pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3t7IOxf9Vkdfiy1MFmpsGSvvf/wDyt1mm0FiJiJHkU=;
        b=TgoQzblgqtKn/uwL88l5pcnNltSdtUN3pNbr/lY71Do+YJQPensFiSR5/ah564m4QF
         Zdm8BQVTAFN8Zh+B5QtZJuyQ422wG3Bs/TfwzQQGuci398KLfOCKGeioJ41Hz2z0mdPF
         k5J3sqENcm3poD3aY3WT6X1rbtlhXUZczU80YMiNMEK1qXfJCXYtvwtFDMwP4vQjXLG2
         Hf+R43rSGYBomq0cT4yigyNQG78jPO+4Bi5/7S2Zog/mtUW+lDE+89EYw5qhwnxmsKSh
         vQouaFKrGzDNQwoiUcRyc7dYpjUmzZqHVJyYvgXaWDWel8dz4Xx9hTrtG4KXM/kLXtp2
         VVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3t7IOxf9Vkdfiy1MFmpsGSvvf/wDyt1mm0FiJiJHkU=;
        b=Zvfv19Ak9wdBHgb3Zs0BGUbLeqJJbvbHnUbW4+KI8+FbQjsVyr45nxK7+tRwhNgyyb
         0lg2XpWKMxKT2KnTY8MQIcRuCMtUVWiATEltD0zUrZWiOEREhA34qbRspGrDYJBSNxnA
         PhDI5fMMJLo4G8hTzNMGNc5PeXNhnwKA2PP+qyDRUXRvxNeNxlNniatotaEenOnMJrDf
         fYJ60Hw5nUAeFFuZiCll+lvArIE34rj1d3/jNfHU4UnBnFsGmVw3qEtvGy9b5o3IdyxE
         P41BK3ibm4gxbQcfK8gxjpo2Pd4e9UYoUwQX42uGDpB9/hdUfTl3WUfeU99kNDHgUKmU
         EqdA==
X-Gm-Message-State: AOAM530KV7NQ51rglCeW8YsEr7NkWRG+N/cKLIlXXey6Hlf3kX+UuRjM
        mML7rbvZ7ryc57v+znPVMEhj6bsBl5YGTPW1lbd8BA==
X-Google-Smtp-Source: ABdhPJwFVrYjSsy2BLuWM4G5tBfKnbXV+mvCUg9g9CziKhY5Xquz+DAVF15CNEmxnJ73snI+ZrmcibNqVLMsqQ5tRVc=
X-Received: by 2002:a62:115:0:b029:1b4:c593:acd4 with SMTP id
 21-20020a6201150000b02901b4c593acd4mr289508pfb.2.1610716355514; Fri, 15 Jan
 2021 05:12:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com> <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
 <20210113165441.GC27045@gaia>
In-Reply-To: <20210113165441.GC27045@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 14:12:24 +0100
Message-ID: <CAAeHK+zThyq7ApsRTu-En7pL9yAAOrEpV45KOuJV3PCpdjVuiw@mail.gmail.com>
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

Sounds good, will do in v3, thanks!
