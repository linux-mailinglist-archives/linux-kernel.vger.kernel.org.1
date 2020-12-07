Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A62D108C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLGM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgLGM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:26:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A840CC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMHvh9xDEViq9Wttdh76WcHcHftlsk/1mfEYbi1JYyE=; b=k5IwLzqpi6ft6ZcfFqvMkO4lDT
        XlUejawfGpbUWjPoFIXIl0aSdWugKA7iRGqz85cLGu8ApxFibfro3UfRr+PWjidaez//znbv/hArr
        xZvmxl9FHlmVk4xU3YecvxFnRaGRclt9a+vSEc9K+HreO4xYu8tXMgqGxJaIsmKdvkhz0riaaybbK
        JtvGaznp2pLufwdnn00b4QisrhfjZavcpDkPsYQ+CngJHmIC6M1p+xWaKVJwcD6B36uZYkRFt8+ib
        eha2HtSXRqnyca8zqniCaT8lHJugPHf7Mw3FNwgFUx96PJ6P0mthL+MDoj3cXmY0llhG/MMpuWeD8
        cBsKX88w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmFZt-0001Im-0n; Mon, 07 Dec 2020 12:25:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01349305C1C;
        Mon,  7 Dec 2020 13:25:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3EFE20299B5F; Mon,  7 Dec 2020 13:25:13 +0100 (CET)
Date:   Mon, 7 Dec 2020 13:25:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201207122513.GT3021@hirez.programming.kicks-ass.net>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207011013.GB113660@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207011013.GB113660@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:10:13AM +0100, Frederic Weisbecker wrote:
> On Sun, Dec 06, 2020 at 10:40:07PM +0100, Thomas Gleixner wrote:
> > syzbot reported KCSAN data races vs. timer_base::timer_running being set to
> > NULL without holding base::lock in expire_timers().
> > 
> > This looks innocent and most reads are clearly not problematic but for a
> > non-RT kernel it's completely irrelevant whether the store happens before
> > or after taking the lock. For an RT kernel moving the store under the lock
> > requires an extra unlock/lock pair in the case that there is a waiter for
> > the timer. But that's not the end of the world and definitely not worth the
> > trouble of adding boatloads of comments and annotations to the code. Famous
> > last words...
> 
> There is another thing I noticed lately wrt. del_timer_sync() VS timer execution:

> Here if the timer has previously executed on CPU 1 and then CPU 0 sees base->running_timer == NULL,
> it will return, assuming the timer has completed. But there is nothing to enforce the fact that x
> will be equal to 1. Enforcing that is a behaviour I would expect in this case since this is a kind
> of "wait for completion" function. But perhaps it doesn't apply here, in fact I have no idea...
> 
> But if we recognize that as an issue, we would need a mirroring load_acquire()/store_release() on
> base->running_timer.

Yeah, I think you're right. del_timer_sync() explicitly states it waits
for completion of the handler, so it isn't weird to then also expect to
be able to observe the results of the handler.

Thomas' patch fixes this.
