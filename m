Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA122D2DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgLHPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbgLHPF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:05:26 -0500
Date:   Tue, 8 Dec 2020 07:04:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607439886;
        bh=KIsLRem+6hmsW80d/+NaUnBYFXS6q1ZASBK6XHnoAro=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZwBLAa1Y3fjPwwvd6RYhG5Xp9+zN5stdMitEBNCNUexd/XYW4vlxhxsSMqlMtyUPN
         rs9SG9pmhW9/EzsYlNJtx8q80tZoHQZrrk/HiKoRvXOTl9jXcgzFFl4fNCjnOss0XP
         YzyEsdI/4ylHFSCgRnAx/tlSAaWWmJbVxabqL1Swgb57xRhI0tABg9dmRfoaJEiyA5
         Yf/EOArLiQ17+UWXzhff8f1Wv9WcQgIrCJdulH7zS9a98+Tth55JWAuYnN2cNjKbNu
         5RLIXyNp9mxcJUN850DKPCNe6LUmyRxPY34MFm/VAHtjJQcYzX08gv3QZ/B+w4jFHk
         lgzQFmlDyyC5A==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201208150446.GQ2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207130753.kpxf2ydroccjzrge@linutronix.de>
 <87a6up7kpt.fsf@nanos.tec.linutronix.de>
 <20201207152533.rybefuzd57kxxv57@linutronix.de>
 <20201207160648.GF2657@paulmck-ThinkPad-P72>
 <20201208085049.vnhudd6qwcsbdepl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208085049.vnhudd6qwcsbdepl@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:50:49AM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-07 08:06:48 [-0800], Paul E. McKenney wrote:
> > > Yes, but it triggers frequently. Like `rcuc' is somehow is aligned with
> > > the timeout.
> > 
> > Given that a lot of RCU processing is event-driven based on timers,
> > and given that the scheduling-clock interrupts are synchronized for
> > energy-efficiency reasons on many configs, maybe this alignment is
> > expected behavior?
> 
> No, it is the fact that rcu_preempt has a higher priority than
> ksoftirqd. So immediately after the wakeup (of rcu_preempt) there is a
> context switch and expire_timers() has this:
> 
> |   raw_spin_unlock_irq(&base->lock);
> |   call_timer_fn(timer, fn, baseclk);
> |   raw_spin_lock_irq(&base->lock);
> |   base->running_timer = NULL;
> |   timer_sync_wait_running(base);
> 
> So ->running_timer isn't reset and try_to_del_timer_sync() (that
> del_timer_sync() from schedule_timeout()) returns -1 and then the corner
> case is handled where `expiry_lock' is acquired. So everything goes as
> expected.

Makes sense!  Thank you for the explanation!

							Thanx, Paul
