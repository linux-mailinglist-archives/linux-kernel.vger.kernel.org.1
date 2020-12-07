Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E662D10EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLGMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgLGMt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:49:59 -0500
Date:   Mon, 7 Dec 2020 13:49:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607345358;
        bh=ZNQEaUl3PGbta51yYsdSDMk+7RZzpLcxTTQZrNbN/wY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE+TIQ2QMQr2Da5omag8OrWaqryzeHBUKhJxrylDFudoLClbZaFFtj8ACaSVIY2n7
         SjyUxnJ8X6OVRZfZQoVwaJRxZqWO8N14kdu3iaHrd8cT3Pt2kT4hnMIzaQgDPCTDD4
         rp6LAy8HoVdLWckKZFXZL4O5SfGa0dW0qN1XOBITGMwrGyWbZh7nOAPFrVuwYz8Xpv
         vPwvuVnGNkFIThBak0U5nsloEdPU8SwAEmtEDKQBzmFPkraNJkbHVqR7M99AKqeZ3J
         Sq1RJte0YsM4aXwAsnl4ImdMf4TFVLBvRSwIoPQRUBbJKYMHR7dVPaOcmk39bL5900
         WSRJLca8c0pEQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201207124915.GA122233@lothringen>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207011013.GB113660@lothringen>
 <20201207122513.GT3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207122513.GT3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:25:13PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 07, 2020 at 02:10:13AM +0100, Frederic Weisbecker wrote:
> > On Sun, Dec 06, 2020 at 10:40:07PM +0100, Thomas Gleixner wrote:
> > > syzbot reported KCSAN data races vs. timer_base::timer_running being set to
> > > NULL without holding base::lock in expire_timers().
> > > 
> > > This looks innocent and most reads are clearly not problematic but for a
> > > non-RT kernel it's completely irrelevant whether the store happens before
> > > or after taking the lock. For an RT kernel moving the store under the lock
> > > requires an extra unlock/lock pair in the case that there is a waiter for
> > > the timer. But that's not the end of the world and definitely not worth the
> > > trouble of adding boatloads of comments and annotations to the code. Famous
> > > last words...
> > 
> > There is another thing I noticed lately wrt. del_timer_sync() VS timer execution:
> 
> > Here if the timer has previously executed on CPU 1 and then CPU 0 sees base->running_timer == NULL,
> > it will return, assuming the timer has completed. But there is nothing to enforce the fact that x
> > will be equal to 1. Enforcing that is a behaviour I would expect in this case since this is a kind
> > of "wait for completion" function. But perhaps it doesn't apply here, in fact I have no idea...
> > 
> > But if we recognize that as an issue, we would need a mirroring load_acquire()/store_release() on
> > base->running_timer.
> 
> Yeah, I think you're right. del_timer_sync() explicitly states it waits
> for completion of the handler, so it isn't weird to then also expect to
> be able to observe the results of the handler.
> 
> Thomas' patch fixes this.

Indeed!

Thanks.
