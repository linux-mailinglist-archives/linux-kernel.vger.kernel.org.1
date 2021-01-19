Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183612FBEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392427AbhASSPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbhASSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:13:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72116C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:12:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c132so13469959pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOoggJCbzXRMl4jyfsPuja537UMtpRuFG/6/vUZLLVw=;
        b=iv99R8t2vDGOpTe1LWU469QYH8yXYR906um2UqJyt3Ml7l4OycT9h4Sj3/VAGQ72C6
         +zidYQjPqsOBYnZuDOhHevOP7/W3TiRFPzG7FwczMr832KaC3k28kfwlMy7jfkhmRva0
         6PhgcahHm0FPU6JJe4l2d+sQB5WPF3XMC43qWghip4ihA/4XHf0a3oLVj0kpsD1AOZma
         2BnrVkd0NqQYiOI1V5RXzv8TtqWXCcrUK6foASilOL54l0xXGxZ8WFX03NaiRyBvhFRZ
         vsGi8djLxcT8MCwyVFKuF+Hmw1ULOyAwocriVJGXhOPSPwxmjRR98DHyCfsZUi3+TvX7
         5r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOoggJCbzXRMl4jyfsPuja537UMtpRuFG/6/vUZLLVw=;
        b=hpjWc5qVvETG6toZfOaKa2BXJGFryK6VDGsxo8+cXJgPakIQolEEhDwFHYJbM1tlCs
         TRvqUiR5dDMUYnvwGwZM5z9vGEVG2YomR4V4kwo/KqJdUoggPVL1koqS0SCvKA6B+ore
         mur/B5huKfPBHCcpYI2FTW1WCYOpnkkyV7EzVkQCrO/fFZ4cOPPh0rrFT98Qi8zX4urx
         5YsjQqPRj0I2kVQKu/rp5pv0kX17MYv9pg4xiQTJZNQHiclqOUteL6dZb2YdZUDIRcz1
         iad8r8Xyy7EaGvEF1Cvj8RdI2uE36w8yvK6ltNWW9EjzLdS5nWhdCZ84kZPiSfFGsQDy
         VTLA==
X-Gm-Message-State: AOAM531Xo+6zt7FXsAU1kvOxVJKSMbrYApVaydHNOdFYGOWXhogC+X5R
        jf5Os6hIonE5ZxPp/l/yGJHXMozR1XhM9TKIq2vrtw==
X-Google-Smtp-Source: ABdhPJwsfRtuShYHZst3VQRycWmUmqICvs41zNjVpXiFeeNNosrHLvczO2xUJrXwHSPVSHf4XHX4zJUQm40chE6qLbE=
X-Received: by 2002:a63:4644:: with SMTP id v4mr5582075pgk.440.1611079972778;
 Tue, 19 Jan 2021 10:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-6-vincenzo.frascino@arm.com> <20210119144459.GE17369@gaia>
 <1bb4355f-4341-21a7-0a53-a4a27840adee@arm.com>
In-Reply-To: <1bb4355f-4341-21a7-0a53-a4a27840adee@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 19:12:40 +0100
Message-ID: <CAAeHK+y9sw0SENeDXLLBxD8XqD396rXbg1GeBRDEm7PnMzMmHQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: mte: Inline mte_assign_mem_tag_range()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Jan 19, 2021 at 4:45 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Catalin,
>
> On 1/19/21 2:45 PM, Catalin Marinas wrote:
> > On Mon, Jan 18, 2021 at 06:30:33PM +0000, Vincenzo Frascino wrote:
> >> mte_assign_mem_tag_range() is called on production KASAN HW hot
> >> paths. It makes sense to inline it in an attempt to reduce the
> >> overhead.
> >>
> >> Inline mte_assign_mem_tag_range() based on the indications provided at
> >> [1].
> >>
> >> [1] https://lore.kernel.org/r/CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com/
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >> ---
> >>  arch/arm64/include/asm/mte.h | 26 +++++++++++++++++++++++++-
> >>  arch/arm64/lib/mte.S         | 15 ---------------
> >>  2 files changed, 25 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> >> index 237bb2f7309d..1a6fd53f82c3 100644
> >> --- a/arch/arm64/include/asm/mte.h
> >> +++ b/arch/arm64/include/asm/mte.h
> >> @@ -49,7 +49,31 @@ long get_mte_ctrl(struct task_struct *task);
> >>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
> >>                       unsigned long addr, unsigned long data);
> >>
> >> -void mte_assign_mem_tag_range(void *addr, size_t size);
> >> +static inline void mte_assign_mem_tag_range(void *addr, size_t size)
> >> +{
> >> +    u64 _addr = (u64)addr;
> >> +    u64 _end = _addr + size;
> >> +
> >> +    /*
> >> +     * This function must be invoked from an MTE enabled context.
> >> +     *
> >> +     * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> >> +     * size must be non-zero and MTE_GRANULE_SIZE aligned.
> >> +     */
> >> +    do {
> >> +            /*
> >> +             * 'asm volatile' is required to prevent the compiler to move
> >> +             * the statement outside of the loop.
> >> +             */
> >> +            asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> >> +                         :
> >> +                         : "r" (_addr)
> >> +                         : "memory");
> >> +
> >> +            _addr += MTE_GRANULE_SIZE;
> >> +    } while (_addr != _end);
> >> +}
> >
> > While I'm ok with moving this function to C, I don't think it solves the
> > inlining in the kasan code. The only interface we have to kasan is via
> > mte_{set,get}_mem_tag_range(), so the above function doesn't need to
> > live in a header.
> >
> > If you do want inlining all the way to the kasan code, we should
> > probably move the mte_{set,get}_mem_tag_range() functions to the header
> > as well (and ideally backed by some numbers to show that it matters).
> >
> > Moving it to mte.c also gives us more control on how it's called (we
> > have the WARN_ONs in place in the callers).
> >
>
> Based on the thread [1] this patch contains only an intermediate step to allow
> KASAN to call directly mte_assign_mem_tag_range() in future. At that point I
> think that mte_set_mem_tag_range() can be removed.
>
> If you agree, I would live the things like this to give to Andrey a chance to
> execute on the original plan with a separate series.

I think we should drop this patch from this series as it's unrelated.

I will pick it up into my future optimization series. Then it will be
easier to discuss it in the context. The important part that I needed
is an inlinable C implementation of mte_assign_mem_tag_range(), which
I now have with this patch.

Thanks, Vincenzo!
