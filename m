Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F372DC847
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 22:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgLPVWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 16:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgLPVWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:22:15 -0500
Date:   Wed, 16 Dec 2020 13:19:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608153571;
        bh=G4EsdFHItEh1ZFI7fuaDgE3SeKK9sqnMJ1KjFcImgnk=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E2H/iXWWHAdOXJ5ZtsbK/CEztR+Im+aPV1Z8CTSP4fQX2s4PuGLq7Fant6UUbMRP0
         Bybsw7AUD0HmpCvH3mMrfqDC4MHKRAjO+kMv1tOGao8ok+KU4lqUVYrLbEU0JRXy7R
         +UvrLe3dFX9zqjFjW0QsbZO7hzjo8SwqUHnnYEeX60hXEztjX71mvIaN5dDennRGQj
         AJcOWk7RBMcAzzapUMRt9dWa6hBUyr5yjUmu3embVk76NwUrjn2Rzagut0gTbIhUeq
         GKoI5XnlXxtAjymzvTVsemegTs9P+/AsD7e7lNEa099QVLqTM8fs0e0GIPClEtOqEB
         KcUOW5aYQnt5A==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
Message-ID: <20201216211931.GL2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
 <20201208150309.GP2657@paulmck-ThinkPad-P72>
 <873606tx1c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873606tx1c.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 01:27:43AM +0100, Thomas Gleixner wrote:
> On Tue, Dec 08 2020 at 07:03, Paul E. McKenney wrote:
> 
> > On Tue, Dec 08, 2020 at 09:11:29AM +0100, Peter Zijlstra wrote:
> >> On Mon, Dec 07, 2020 at 11:44:06AM -0800, Paul E. McKenney wrote:
> >> 
> >> > Also, in this particular case, why data_race() rather than READ_ONCE()?
> >> > Do we really expect the compiler to be able to optimize this case
> >> > significantly without READ_ONCE()?
> 
> There is probably not much optimization potential for the compiler if
> data_race() is used vs. READ/WRITE_ONCE() in this code.

OK, got it.

> >> It's about intent and how the code reads. READ_ONCE() is something
> >> completely different from data_race(). data_race() is correct here.
> >
> > Why?
> 
> Lemme answer that to the extent why _I_ chose data_race() - aside of my
> likely confusion over our IRC conversation.
> 
> The code does not really care about the compiler trying to be clever or
> not as it is designed to be tolerant of all sorts of concurrency
> including competing writes. It does not care about multiple reloads
> either.  It neither cares about invented stores as long as these
> invented stores are not storing phantasy values.
> 
> The only thing it cares about is store/load tearing, but there is no
> 'clever' way to use that because of the only valid transitions of
> 'cpunr' which comes from smp_processor_id() to TICK_DO_TIMER_NONE which
> is the only constant involved or the other way round (which is
> intentionally subject to competing stores).
> 
> If the compiler is free to store the 32bit value as 4 seperate bytes or
> does invented stores with phantasy values, then there is surely a reason
> to switch to READ/WRITE_ONCE(), but that'd be a really daft reason.
> 
> So my intent was to document that this code does not care about anything
> else than what I'd consider to be plain compiler bugs.
> 
> My conclusion might be wrong as usual :)

Given that there is no optimization potential, then the main reason to use
data_race() instead of *_ONCE() is to prevent KCSAN from considering the
accesses when looking for data races.  But that is mostly for debugging
accesses, in cases when these accesses are not really part of the
concurrent algorithm.

So if I understand the situation correctly, I would be using *ONCE().

							Thanx, Paul
