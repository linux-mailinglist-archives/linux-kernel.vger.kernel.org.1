Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8B2C1456
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgKWTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgKWTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:12:57 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A79C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:12:57 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q206so20826412oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkFKVVE05DxxQZn8gUPCNJA2GtzoswBnLFvjycznboA=;
        b=B0WPvS5cX1vh7WcbwvFULs6V49mSQJI5mklyizuz6mRTnR0smBcGNV2KveycRToSg6
         PDbNj9L6Vny8/fkqrX7Kk7hnPOqmrBF1m8F7tV6sS6oAQfmRuWIE9hSyQZ940cE5zMXp
         RyvClPePh5gB2cKcKuZGNgkm1j4g3Sq3ObzjltBTBqmhKSB8qvyLZQaodzWiDCvW+v0z
         89DIYYnTxKcF6jqsSnr7INvme0uqhJLN6GTpGTh4bbsuZamATknOJcBCc502Kqx17BvV
         6aAgHk1nHCK2W93jSlGIkInL8PpEkocmtf95rrv6Qm1FYWcusO0u4dYRhmHDekixJx1s
         vpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkFKVVE05DxxQZn8gUPCNJA2GtzoswBnLFvjycznboA=;
        b=AignDN3lJUMw/Frx1dEn7qqasALSheLUCgsh1kjDKNjxkL5MIY8tweIHpdOE/LG79J
         A39MO2zQa5oIsBVSFXCMxrbAfJgf4q6q+KOuLybki8OjnWBYKU/eABDjGvuq1Y7n8qLP
         A9JkZ2UDXvHeC+SHxEB/FgoORUHC1ZN8LAXR6V7PT6z4pUHhDgrf+JIhjsjeRRLnHXtR
         IskYR/+MDlXge+Inu2gtJzOmn8uqJl123FuQS+DqIFOUVWglyt8Bz+Z39y0Dj+m9O3gF
         ALjpvUxhsmobfc3jnW0z7wVU8/5MBUwqFRPX+dGvWe5y+UMaTs+EcVpktjcOxa3q3fa0
         d1zQ==
X-Gm-Message-State: AOAM533fulPAw6rUD496x9p58q9pl+yCs1QKNJV5zSKMMjqKm56/unxr
        kXtZFTpuxgyuQKSKLvmlsO9R0bvyIvrXmu0U7A711g==
X-Google-Smtp-Source: ABdhPJxtM4a5n5IQmwpNR+Xj4I97E2W+t+5QcauITjNyguGsV9COpv5Kj4u0+cOXz1dJYUTpDdd11H+vSoqEF7wquLs=
X-Received: by 2002:a54:4394:: with SMTP id u20mr299277oiv.70.1606158776324;
 Mon, 23 Nov 2020 11:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20201123132300.1759342-1-elver@google.com> <20201123135512.GM3021@hirez.programming.kicks-ass.net>
 <CANpmjNPwuq8Hph3oOyJCVgWQ_d-gOTPEOT3BpbR2pnm5LBeJbw@mail.gmail.com>
 <20201123155746.GA2203226@elver.google.com> <20201123160823.GC2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201123160823.GC2414@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 23 Nov 2020 20:12:44 +0100
Message-ID: <CANpmjNMzeU8GBkNr-_6Rq8+9CNW476DBMpck9oeFw-pE5J0beg@mail.gmail.com>
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

On Mon, 23 Nov 2020 at 17:08, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Nov 23, 2020 at 04:57:46PM +0100, Marco Elver wrote:
> > Let me know what you prefer.
> >
>
> > @@ -288,27 +288,19 @@ static u32 kcsan_prandom_u32_max(u32 ep_ro)
> >       u32 res;
> >
> >       /*
> > +      * Avoid recursion with scheduler by disabling KCSAN because
> > +      * preempt_enable_notrace() will still call into scheduler code.
> >        */
> > +     kcsan_disable_current();
> >       preempt_disable_notrace();
> >       state = raw_cpu_ptr(&kcsan_rand_state);
> >       res = prandom_u32_state(state);
> > +     preempt_enable_notrace();
> > +     kcsan_enable_current_nowarn();
> >
> >       return (u32)(((u64) res * ep_ro) >> 32);
> >  }
>
> This is much preferred over the other. The thing with _no_resched is that
> you can miss a preemption for an unbounded amount of time, which is bad.

Ah, I think this is rubbish, too. Because it might fix one problem,
but now I'm left with the problem that kcsan_prandom_u32_max() is
called for udelay() later and at that point we lose skip_count
randomness entirely.

I think relying on lib/random32.c already caused too many headaches,
so I'm tempted to just get rid of that dependency entirely. And
instead do the simplest possible thing, which might just be calling
get_cycles() (all we need is to introduce some non-determinism).

> The _only_ valid use of _no_resched is when there's a call to schedule()
> right after it.
