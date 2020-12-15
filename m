Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACEE2DB312
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgLORxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgLORxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:53:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F36C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:52:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608054770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbfIuzVbnJ5p6qHXhYoAEwcKSRAUkwux0pazCWFg+ZE=;
        b=e6vV4jWqNpoK02cHt+Qzby9o6L/qOqFxGrw3JtWTaXWrBWPncBv++X9giYZPdbk9dEuah9
        72Cwa/4TqR5fKHm+ajrL7fXXo+0cXav0PivbFrTMihMxbJH0e4yIsM8RK+C0bvaxzEUVBD
        XeVY5/a8kICh65NJQPNtdJUjdokrH2xfUpQ7KiQj6EgjskzFyUW/yuzf1N5sPklGnvpCX3
        uN62bkZ9T9DpCizEswkyp0bUYzdEcoczkwiu9grXNnG/xUG0z+IM55jwTrMe8WQOh1d9Ps
        XsbeO8rFwt3EMUXflV8fN1vTuvaLV+9sT7dgOQMFVvd0zf/QMjBe8GA+qdTecA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608054770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbfIuzVbnJ5p6qHXhYoAEwcKSRAUkwux0pazCWFg+ZE=;
        b=a5tfQDaRLbnNP3sv0k0lJ0QHUYBCnQkNzX45WhhuncmaiPSDL9rEgeqSMSr1gOPG9fOhzr
        0FpmWS2iFwARH5Bg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
In-Reply-To: <20201215150529.GI3040@hirez.programming.kicks-ass.net>
References: <20201215104400.9435-1-anna-maria@linutronix.de> <20201215111806.GF3040@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.2012151449260.1448@somnus> <20201215093415.5b2898ef@gandalf.local.home> <20201215150529.GI3040@hirez.programming.kicks-ass.net>
Date:   Tue, 15 Dec 2020 18:52:49 +0100
Message-ID: <87mtyft0r2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15 2020 at 16:05, Peter Zijlstra wrote:
> On Tue, Dec 15, 2020 at 09:34:15AM -0500, Steven Rostedt wrote:
>> On Tue, 15 Dec 2020 15:23:39 +0100 (CET)
>> Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:
>> 
>> > > > +	/*
>> > > > +	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
>> > > > +	 * load balancing when not active
>> > > > +	 */
>> > > > +	nohz_balance_exit_idle(rq);
>> > > > +
>> > > >  	set_cpu_active(cpu, false);
>> > > >  	/*
>> > > >  	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU  
>> > > 
>> > > OK, so we must clear the state before !active, because getting an
>> > > interrupt/softirq after would trigger the badness. And we're guaranteed
>> > > nothing blocks between them to re-set it.  
>> > 
>> > As far as I understood, it is not a problem whether the delete is before or
>> > after !active. When it is deleted after, the remote CPU will return in
>> > kick_ilb() because cpu is not idle, because it is running the hotplug
>> > thread.
>> 
>> I was thinking that disabling it after may also cause some badness. Even if
>> it does not, I think there's no harm in clearing it just before setting cpu
>> active to false. And I find that the safer option.
>
> The paranoid in me wanted to write it like:
>
> 	preempt_disable();
> 	nohz_balance_exit_idle(rq);
> 	set_cpu_active(cpu, false);
> 	preempt_enable();
>
> (or possibly even local_irq_disable), to guarantee we don't hit idle
> between them (which could re-set the nohz idle state we just cleared).
>
> But then I gave up :-)

I might be missing something, but how is the CPU which runs the pinned
kernel thread, i.e. the hotplug thread, supposed to go idle between the
two calls?

Really the order is completely irrelevant.

  Remote kick_ilb() checks nohz_mask _AND_ idle_cpu()

  Local nohz_enter() checks cpu_active()

I still might be missing something magic though, mushrooms perhaps. :)

Thanks,

        tglx

