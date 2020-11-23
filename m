Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8E2C0E99
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbgKWPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732197AbgKWPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:17:13 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257DAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:17:13 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id z13so4018954ooa.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01wWOa3KrZt/xsoNZQpghL+y/uBnQBFRvt5GfUXKKDw=;
        b=N84kzZfUdOIHKoskaZ7/SzxTFLGDBv9YekZbXOnpqwnqbnztxD2bTRRcgJOta4fqeU
         8RCDVN4j+ocDqJHoG2wlk+DWZ165qH6ti74WoVXjWmk1RCGiRts3TUOO+7C1IgdVthtP
         CZ45M4LlRyjDvEH9otGlsACEHrdcNTb7eFA3bkfOiWrTjRuV0vrSMqEETASrsXu8MLXi
         WKacfnCmbcZvZ5WuF/6x/eZHabNfb4ORTnmBbFuq1zcIddxGOyvL4dw5iFmz7KEjVyUe
         M3zqufpX1p6P9c14ZaDVYn71EuiYmO5I5y7trk1O8fXfmV3Uau6/RI5Czxci98P4AbD3
         18Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01wWOa3KrZt/xsoNZQpghL+y/uBnQBFRvt5GfUXKKDw=;
        b=d6RJORpd4aGa6cndHU0di+/bCI/RylCovua7B6rPgdy46JDCmy3kIwzFqZwvLswp76
         QFKlzGFHlYwNxbbtxoiXpIQf1CwF1PNWSX9wNpiaPNJ35teDHbzMXS78wJchsl3O+c28
         gDtPa9i9SM2ymh4nE7eiw+SYMJ9vKfC2Mm2ncMXzWYmtOIYdwTKQPjnEoUjWEDqWpGWC
         HgRS+ZDmlI0QZ70UAJ8KJFzZnp1mEMm6sP9j5BwqS0R60TWqM9gJOhjE0OpQoJ4W+z9N
         FnOn3D8CxQOFI6u57PsUCLTStn7X4CB+E6G3/r3IL3Bb70+I4nb5KN5kf5mI2zg6PYnY
         INuw==
X-Gm-Message-State: AOAM530CnuoRlVENoQdsjtvRCTDiSUClgCUSLOexQ4uvNIoRsFqLBScb
        UOghJOhnYuxGmUneYN6HpPzuj09Ciy3y75RFTF2YMg==
X-Google-Smtp-Source: ABdhPJy6n4PeKK9loF5ES07tiZosa6WsuYlaI455Jpzv7huAQyAw9CK1rm144MgCInSh1QHxCGEPTDSufeJaR4pfjnM=
X-Received: by 2002:a4a:e4cc:: with SMTP id w12mr22858288oov.36.1606144632330;
 Mon, 23 Nov 2020 07:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20201123132300.1759342-1-elver@google.com> <20201123135512.GM3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201123135512.GM3021@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 23 Nov 2020 16:17:00 +0100
Message-ID: <CANpmjNPwuq8Hph3oOyJCVgWQ_d-gOTPEOT3BpbR2pnm5LBeJbw@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: Avoid scheduler recursion by using
 non-instrumented preempt_{disable,enable}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 at 14:55, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Nov 23, 2020 at 02:23:00PM +0100, Marco Elver wrote:
> > When enabling KCSAN for kernel/sched (remove KCSAN_SANITIZE := n from
> > kernel/sched/Makefile), with CONFIG_DEBUG_PREEMPT=y, we can observe
> > recursion due to:
> >
> >       check_access() [via instrumentation]
> >         kcsan_setup_watchpoint()
> >           reset_kcsan_skip()
> >             kcsan_prandom_u32_max()
> >               get_cpu_var()
> >                 preempt_disable()
> >                   preempt_count_add() [in kernel/sched/core.c]
> >                     check_access() [via instrumentation]
> >
> > Avoid this by rewriting kcsan_prandom_u32_max() to only use safe
> > versions of preempt_disable() and preempt_enable() that do not call into
> > scheduler code.
> >
> > Note, while this currently does not affect an unmodified kernel, it'd be
> > good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
> > from kernel/sched/Makefile to permit testing scheduler code with KCSAN
> > if desired.
> >
> > Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Update comment to also point out preempt_enable().
> > ---
> >  kernel/kcsan/core.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 3994a217bde7..10513f3e2349 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -284,10 +284,19 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
> >   */
> >  static u32 kcsan_prandom_u32_max(u32 ep_ro)
> >  {
> > -     struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
> > -     const u32 res = prandom_u32_state(state);
> > +     struct rnd_state *state;
> > +     u32 res;
> > +
> > +     /*
> > +      * Avoid recursion with scheduler by using non-tracing versions of
> > +      * preempt_disable() and preempt_enable() that do not call into
> > +      * scheduler code.
> > +      */
> > +     preempt_disable_notrace();
> > +     state = raw_cpu_ptr(&kcsan_rand_state);
> > +     res = prandom_u32_state(state);
> > +     preempt_enable_no_resched_notrace();
>
> This is a preemption bug. Does preempt_enable_notrace() not work?

No it didn't, because we end up calling preempt_schedule_notrace(),
which again might end in recursion.

Normally we could surround this by
kcsan_disable_current/kcsan_enable_current(), but that doesn't work
because we have this sequence:

     reset_kcsan_skip();
     if (!kcsan_is_enabled())
         ...

to avoid underflowing the skip counter if KCSAN is disabled. That
could be solved by writing to the skip-counter twice: once with a
non-random value, and if KCSAN is enabled with a random value. Would
that be better?

And I'd like to avoid adding __no_kcsan to scheduler functions.

Any recommendation?

Thanks,
-- Marco


>
> >
> > -     put_cpu_var(kcsan_rand_state);
> >       return (u32)(((u64) res * ep_ro) >> 32);
> >  }
> >
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
