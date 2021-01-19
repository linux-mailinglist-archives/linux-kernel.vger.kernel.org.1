Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9172FC01C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404109AbhASTgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390775AbhASTf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:35:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5936C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:34:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so13605432pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzjGhv/xtQmLzd1fmO3nz3CB6VSkFAgOhOGhk3ruAHo=;
        b=btK4sahzhn8n/ZvKOAXWg53tlRPKXWae8RKmUHzR3AqkqZLVqEpJMM1CjKQRBPkFLx
         OmxVfd1eyzwMTrMEjzBYOJCjLDByiAtCHBBBHS0qiwyBbAIlBJMp+OLTtQ1OtAGz3UVD
         hLLXFszNfn1toapAulw4VBa0GvR62IORaIW3FR1SbFWOGXkmpnvpyg5h2BtvSeTM80bY
         yVWRLulTDnSSgMKQBDMxpzBTmZvD2bnEvPJqW1yl5PHTklCGjxhQsj7X0X9Ojo1rBn0s
         pBvNK+C5SRBOvV+4bs/HBXN2cKV51T7z9agy7sHCKrIQeWaxwnSRQJ8VO7vjpywfstfH
         fbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzjGhv/xtQmLzd1fmO3nz3CB6VSkFAgOhOGhk3ruAHo=;
        b=cjra3v6fr8AkU789qoeVvvhr5sq8To/svb9yTGVQ1Izd/zHY+n0h8Tkz9NKhTK0y1X
         TbfwFkb52OlUzps8JNxo8dNb5slunBA+psnwGurqYBrNl6yj1kFf3EVETcnQzql15yfM
         +cKg29Yah4/4CrY72VLvUTI3CUYVHR+OOML2uS4/63QACl10oKM3JI/S1OkjdDWFzY8o
         fmMTHlkDrMDzteTCRvZdfCCKQb+42F0T49kod+IOvvhY/kY9m+b5ndhUE2/BpBUaTfKD
         0hiBLimLNwjU3ktKyL0kDdM8Y0iKejrJkL+0NLXdXH6p+BonBRgoggGxwJC5hdkvklRe
         Bolw==
X-Gm-Message-State: AOAM532RgCX0z5E/pSoZbNx8rg6HGeQ3k+iuhEZWK8WetTmvk4gVUgmV
        JoV63X5t/jnCY2xArZnUsweiWKfNRMsN1I6a3xLWWw==
X-Google-Smtp-Source: ABdhPJwzWwQi5vIgcGtN+LffWKqKBnrrpscjdLVZgHZZGj8pgOMQL1gYnUsRDjR43+4EweiXUn9ot2KNCuEEOKjoNCU=
X-Received: by 2002:a65:430b:: with SMTP id j11mr5646612pgq.130.1611084886235;
 Tue, 19 Jan 2021 11:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-6-vincenzo.frascino@arm.com> <20210119144459.GE17369@gaia>
 <1bb4355f-4341-21a7-0a53-a4a27840adee@arm.com> <CAAeHK+y9sw0SENeDXLLBxD8XqD396rXbg1GeBRDEm7PnMzMmHQ@mail.gmail.com>
 <20210119190037.GB26948@gaia>
In-Reply-To: <20210119190037.GB26948@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 20:34:34 +0100
Message-ID: <CAAeHK+w3+StvU60KNPknQyEnGH_8BfwFdJbTifPb3gGQhXLDyw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: mte: Inline mte_assign_mem_tag_range()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 8:00 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jan 19, 2021 at 07:12:40PM +0100, Andrey Konovalov wrote:
> > On Tue, Jan 19, 2021 at 4:45 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > > On 1/19/21 2:45 PM, Catalin Marinas wrote:
> > > > On Mon, Jan 18, 2021 at 06:30:33PM +0000, Vincenzo Frascino wrote:
> > > >> mte_assign_mem_tag_range() is called on production KASAN HW hot
> > > >> paths. It makes sense to inline it in an attempt to reduce the
> > > >> overhead.
> > > >>
> > > >> Inline mte_assign_mem_tag_range() based on the indications provided at
> > > >> [1].
> > > >>
> > > >> [1] https://lore.kernel.org/r/CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com/
> > > >>
> > > >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > >> Cc: Will Deacon <will@kernel.org>
> > > >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > >> ---
> > > >>  arch/arm64/include/asm/mte.h | 26 +++++++++++++++++++++++++-
> > > >>  arch/arm64/lib/mte.S         | 15 ---------------
> > > >>  2 files changed, 25 insertions(+), 16 deletions(-)
> > > >>
> > > >> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > > >> index 237bb2f7309d..1a6fd53f82c3 100644
> > > >> --- a/arch/arm64/include/asm/mte.h
> > > >> +++ b/arch/arm64/include/asm/mte.h
> > > >> @@ -49,7 +49,31 @@ long get_mte_ctrl(struct task_struct *task);
> > > >>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
> > > >>                       unsigned long addr, unsigned long data);
> > > >>
> > > >> -void mte_assign_mem_tag_range(void *addr, size_t size);
> > > >> +static inline void mte_assign_mem_tag_range(void *addr, size_t size)
> > > >> +{
> > > >> +    u64 _addr = (u64)addr;
> > > >> +    u64 _end = _addr + size;
> > > >> +
> > > >> +    /*
> > > >> +     * This function must be invoked from an MTE enabled context.
> > > >> +     *
> > > >> +     * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> > > >> +     * size must be non-zero and MTE_GRANULE_SIZE aligned.
> > > >> +     */
> > > >> +    do {
> > > >> +            /*
> > > >> +             * 'asm volatile' is required to prevent the compiler to move
> > > >> +             * the statement outside of the loop.
> > > >> +             */
> > > >> +            asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> > > >> +                         :
> > > >> +                         : "r" (_addr)
> > > >> +                         : "memory");
> > > >> +
> > > >> +            _addr += MTE_GRANULE_SIZE;
> > > >> +    } while (_addr != _end);
> > > >> +}
> > > >
> > > > While I'm ok with moving this function to C, I don't think it solves the
> > > > inlining in the kasan code. The only interface we have to kasan is via
> > > > mte_{set,get}_mem_tag_range(), so the above function doesn't need to
> > > > live in a header.
> > > >
> > > > If you do want inlining all the way to the kasan code, we should
> > > > probably move the mte_{set,get}_mem_tag_range() functions to the header
> > > > as well (and ideally backed by some numbers to show that it matters).
> > > >
> > > > Moving it to mte.c also gives us more control on how it's called (we
> > > > have the WARN_ONs in place in the callers).
> > > >
> > >
> > > Based on the thread [1] this patch contains only an intermediate step to allow
> > > KASAN to call directly mte_assign_mem_tag_range() in future. At that point I
> > > think that mte_set_mem_tag_range() can be removed.
> > >
> > > If you agree, I would live the things like this to give to Andrey a chance to
> > > execute on the original plan with a separate series.
> >
> > I think we should drop this patch from this series as it's unrelated.
> >
> > I will pick it up into my future optimization series. Then it will be
> > easier to discuss it in the context. The important part that I needed
> > is an inlinable C implementation of mte_assign_mem_tag_range(), which
> > I now have with this patch.
>
> That's fine by me but we may want to add some forced-alignment on the
> addr and size as the loop here depends on them being aligned, otherwise
> it gets stuck. The mte_set_mem_tag_range() at least had a WARN_ON in
> place. Here we could do:
>
>         addr &= MTE_GRANULE_MASK;
>         size = ALIGN(size, MTE_GRANULE_SIZE);
>
> (or maybe trim "size" with MTE_GRANULE_MASK)
>
> That's unless the call places are well known and guarantee this
> alignment (only had a very brief look).

No problem. I'll either add the ALIGN or change the call site to
ensure alignment.
