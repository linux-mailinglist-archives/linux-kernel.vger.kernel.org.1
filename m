Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7C2D269C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgLHIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:51:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgLHIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:51:32 -0500
Date:   Tue, 8 Dec 2020 09:50:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607417450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhmaTjxVT0XVhHW1xIN82oE/hpEXmuE06ThvXKAzb4s=;
        b=jxPjds6vX08h7Ax1v6qutO/LQuJWIGVuitHdTtbOVAmULWEygFSXie8TAhzhYNwYF+x905
        tf5okA/TWqwBLK+bWvRY6kgWmKhxefGkkTJh7Hd1YerSra91CpU2MDAEeSOyEtOfMjMyRF
        ewJQS90MMrQN+mk138O1lUIUTCgm+W/p/4ntfmG8G8SQ0TG0LveM9+o3cagwt6w7Gw1l2H
        2z0RjsqIuTMY/4it12UYBNAf0yRTYuhk1KuuntNcNOamNVYts7FGMiBDknSVsoUY3naWqQ
        VZACKGQz8JtorNaNnqc5EaTRcDoH1kvreyiPcm5LDHM66cqfhFC9fFjxOV+/9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607417450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhmaTjxVT0XVhHW1xIN82oE/hpEXmuE06ThvXKAzb4s=;
        b=OOXklvFTylOerTYfEfZMyAS2VVcAjDa0tJfWMCZI+9LToe9+nnbX9sF4KRHGORNNNHxDfx
        bZAGsJ+GkU6AQaDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201208085049.vnhudd6qwcsbdepl@linutronix.de>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207130753.kpxf2ydroccjzrge@linutronix.de>
 <87a6up7kpt.fsf@nanos.tec.linutronix.de>
 <20201207152533.rybefuzd57kxxv57@linutronix.de>
 <20201207160648.GF2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207160648.GF2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 08:06:48 [-0800], Paul E. McKenney wrote:
> > Yes, but it triggers frequently. Like `rcuc' is somehow is aligned with
> > the timeout.
> 
> Given that a lot of RCU processing is event-driven based on timers,
> and given that the scheduling-clock interrupts are synchronized for
> energy-efficiency reasons on many configs, maybe this alignment is
> expected behavior?

No, it is the fact that rcu_preempt has a higher priority than
ksoftirqd. So immediately after the wakeup (of rcu_preempt) there is a
context switch and expire_timers() has this:

|   raw_spin_unlock_irq(&base->lock);
|   call_timer_fn(timer, fn, baseclk);
|   raw_spin_lock_irq(&base->lock);
|   base->running_timer = NULL;
|   timer_sync_wait_running(base);

So ->running_timer isn't reset and try_to_del_timer_sync() (that
del_timer_sync() from schedule_timeout()) returns -1 and then the corner
case is handled where `expiry_lock' is acquired. So everything goes as
expected.

> 							Thanx, Paul

Sebastian
