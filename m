Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E916F2D08B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgLGBK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgLGBK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:10:57 -0500
Date:   Mon, 7 Dec 2020 02:10:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607303416;
        bh=o81IGJgSZQXnZEBbhHAnRGzuEDw1jSKf5jRiVxLyslw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hv71Zg5b6rvZKMRtiHdv3Q6JwzsQau5XT8yLSeNvK0RsQ78+2qltOliCXJmkSSLcK
         tLuJzj0GKuk6FifcLaOF6eEk9wDgIxzkRyjBqR2s+xOTx1DFQm4JmcdeS1FJNS8nNR
         ysovuoatx1qf7R9Zw1zZgVzKaUCQ6ZZKHJO+RztZFNqI14SIEaHh+qziXSXerU3ggv
         rPUEFmShiFoYpAsIZT8lZHeBcGUcTKjboetN9EdiYqi9wpZ5xFkygCKG1qa8tBB2Nw
         X7rhb0SUUWzXuKfoa/v2JSElvsN0DroUOWr4h1BSTjbI4pSrI5Mzi1Qix6FxykfCS1
         CY3TBqxNGWfdQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201207011013.GB113660@lothringen>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 10:40:07PM +0100, Thomas Gleixner wrote:
> syzbot reported KCSAN data races vs. timer_base::timer_running being set to
> NULL without holding base::lock in expire_timers().
> 
> This looks innocent and most reads are clearly not problematic but for a
> non-RT kernel it's completely irrelevant whether the store happens before
> or after taking the lock. For an RT kernel moving the store under the lock
> requires an extra unlock/lock pair in the case that there is a waiter for
> the timer. But that's not the end of the world and definitely not worth the
> trouble of adding boatloads of comments and annotations to the code. Famous
> last words...

There is another thing I noticed lately wrt. del_timer_sync() VS timer execution:


    int data = 0;

    void timer_func(struct timer_list *t)
    {
        data = 1;
    }

                 CPU 0                                           CPU 1
    ------------------------------                             --------------------------
    base = lock_timer_base(timer, &flags);                     raw_spin_unlock(&base->lock);
    if (base->running_timer != timer)                          call_timer_fn(timer, fn, baseclk);
        ret = detach_if_pending(timer, base, true);            base->running_timer = NULL;
    raw_spin_unlock_irqrestore(&base->lock, flags);            raw_spin_lock(&base->lock);

    x = data;
    

Here if the timer has previously executed on CPU 1 and then CPU 0 sees base->running_timer == NULL,
it will return, assuming the timer has completed. But there is nothing to enforce the fact that x
will be equal to 1. Enforcing that is a behaviour I would expect in this case since this is a kind
of "wait for completion" function. But perhaps it doesn't apply here, in fact I have no idea...

But if we recognize that as an issue, we would need a mirroring load_acquire()/store_release() on
base->running_timer.
