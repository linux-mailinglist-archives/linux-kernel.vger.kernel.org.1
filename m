Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531CB2D782E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406378AbgLKOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406203AbgLKOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:46:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0AC061794
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:45:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607697924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzGg7LxXohhH6b7FeHSZ2e3oXZj5TWyywquXxDIeY1M=;
        b=TcScHttli3W8taGeoA9zHAznrk9LTMO/StHtuW9xPLA6X5biRfbRQHd/r9EC0Or9jcb5ST
        fOhEdJraSi/swR/c5QB92LfshAUqmFDaCc7CK2EvwqhDIcTRml3UIDVTZGhtj1l62Vzyn2
        yAKXvwcrAc2hZ9+Jkv96oDriHTaACGRr0pyR13nREqbTgwM7vKua9BdopKyHCx9HAsc7V+
        ucDVRy1Fx2dR3D5TjDSdXPm/SAcAKeeSSAHleBpaBF7SIIVAmD1gD6glE7MCcSYXzquqXe
        xG2t4GgTvo9SjAE+lLzbu75JkiVyjdelevYX3H6rP7YdC/RP/L8XUEU9/tvvHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607697924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzGg7LxXohhH6b7FeHSZ2e3oXZj5TWyywquXxDIeY1M=;
        b=dtMYNoRh0UbMelk024uyoT9VJhAxI0jFDX7q98J8NU9Vxlch875rtb9WdTzXX0SYGOMA2j
        jqQx34zxwq3IOfBg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
In-Reply-To: <20201208085049.vnhudd6qwcsbdepl@linutronix.de>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de> <20201207130753.kpxf2ydroccjzrge@linutronix.de> <87a6up7kpt.fsf@nanos.tec.linutronix.de> <20201207152533.rybefuzd57kxxv57@linutronix.de> <20201207160648.GF2657@paulmck-ThinkPad-P72> <20201208085049.vnhudd6qwcsbdepl@linutronix.de>
Date:   Fri, 11 Dec 2020 15:36:27 +0100
Message-ID: <87sg8ch0k4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08 2020 at 09:50, Sebastian Andrzej Siewior wrote:
> On 2020-12-07 08:06:48 [-0800], Paul E. McKenney wrote:
>> > Yes, but it triggers frequently. Like `rcuc' is somehow is aligned with
>> > the timeout.
>> 
>> Given that a lot of RCU processing is event-driven based on timers,
>> and given that the scheduling-clock interrupts are synchronized for
>> energy-efficiency reasons on many configs, maybe this alignment is
>> expected behavior?
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

Well, but even without that change you have the same situation:

      timer_fn()
        wakeup()
          -->preemption
                        del_timer_sync()
                          if (running)
                             wait_for_running()
                               lock(expiry)

     running = NULL
     sync_wait_running()
       unlock(expiry)
         wakeup_lock()
          -->preemption
                             ...

    lock(base)
     
So the change at hand does not make things worse, right?

Thanks,

        tglx
