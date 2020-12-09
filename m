Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C812D4341
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbgLINa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbgLINa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:30:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE67CC061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:30:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607520614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u54cFHHbY+EcmagK85Ng/IdI69Ed0eVDCQq1rnytCF0=;
        b=c9CdUPn8JK4qcNqEBHBIeRZU0+V/bfgUxaWmydY7VlB7zOV/H8ypA3g/jxkhMkqs1z0Bea
        RLorZnH8tEags1j+1fFe8JpDaoO7TxjErN5NqtBpLoTg+GpDYVQh+NwZzGcdXk94mzLhoQ
        D05N/lYemrmyBLx/64fcWR8WaZbDEXi0vLZwbvM3m/3JWl0R2bSxWNhRQsF86DzhdAENri
        +xMXuOv0GJF5WQv2jBzAgFglIzqkYfIIovX9o06trng+3Xil+v/eGqOLpTaqDw5KBDsG/X
        uxqdpIz6BwhZXj+Woq+a0aNRZaCh2JtSG8WGHJHdW6ulYB91Zv3P6Be7QjiSDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607520614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u54cFHHbY+EcmagK85Ng/IdI69Ed0eVDCQq1rnytCF0=;
        b=elB24+MnmCUjvePBO7roi7fgjAdzgns8Y/7Jssgxng5Qbrlq5hbQzefEXjREMxHsMI/rvQ
        HATHgLyH1vVoJjAQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT aware
In-Reply-To: <20201209124233.GM2414@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de> <20201204170805.114951971@linutronix.de> <20201209101102.GJ2414@hirez.programming.kicks-ass.net> <878sa717h5.fsf@nanos.tec.linutronix.de> <20201209124233.GM2414@hirez.programming.kicks-ass.net>
Date:   Wed, 09 Dec 2020 14:30:13 +0100
Message-ID: <87360f150a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09 2020 at 13:42, Peter Zijlstra wrote:
> On Wed, Dec 09, 2020 at 01:36:54PM +0100, Thomas Gleixner wrote:
>> On Wed, Dec 09 2020 at 11:11, Peter Zijlstra wrote:
>> > On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
>> >> From: Thomas Gleixner <tglx@linutronix.de>
>> >> +	/* First entry of a task into a BH disabled section? */
>> >> +	if (!current->softirq_disable_cnt) {
>> >> +		if (preemptible()) {
>> >> +			local_lock(&softirq_ctrl.lock);
>> >
>> > AFAICT this significantly changes the locking rules.
>> >
>> > Where previously we could do:
>> >
>> > 	spin_lock(&ponies)
>> > 	spin_lock_bh(&foo);
>> >
>> > vs
>> >
>> > 	spin_lock_bh(&bar);
>> > 	spin_lock(&ponies)
>> >
>> > provided the rest of the code observed: bar -> ponies -> foo
>> > and never takes ponies from in-softirq.
>> >
>> > This is now a genuine deadlock on RT.
>> 
>> I know, but making this work is trying to square the circle.
>
> :-)
>
>> Any approach we tried before going this way had worse problems than
>> this particular limitation.
>
> OK, but that would've been very good Changelog material methinks.

Let me add that.

> Also, then we should probably make sure PREEMPT_RT=n builds start
> suffering the same problem by adding the local_lock unconditionally,
> otherwise this keeps being a PREEMPT_RT special and we'll keep having to
> fix it up.

For lockdep builds I assume. I'd like to postpone that for a while like
we postponed the rawlock nesting lockdep stuff until we have the vast
majority sorted out.

Thanks,

        tglx
