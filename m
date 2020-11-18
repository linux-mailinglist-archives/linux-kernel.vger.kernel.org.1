Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAE2B7AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgKRJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:51:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgKRJvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:51:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B255111D4;
        Wed, 18 Nov 2020 01:51:40 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91653F719;
        Wed, 18 Nov 2020 01:51:39 -0800 (PST)
References: <20201116142005.GE3121392@hirez.programming.kicks-ass.net> <20201116193149.GW3371@techsingularity.net> <20201117083016.GK3121392@hirez.programming.kicks-ass.net> <20201117091545.GA31837@willie-the-truck> <20201117092936.GA3121406@hirez.programming.kicks-ass.net> <20201117094621.GE3121429@hirez.programming.kicks-ass.net> <jhjv9e4w3gj.mognet@arm.com> <jhjtutovvtm.mognet@arm.com> <20201117161318.GP3121392@hirez.programming.kicks-ass.net> <jhjo8jvwzi7.mognet@arm.com> <20201118080515.GR3121392@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
In-reply-to: <20201118080515.GR3121392@hirez.programming.kicks-ass.net>
Date:   Wed, 18 Nov 2020 09:51:33 +0000
Message-ID: <jhjmtzfvvq2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/11/20 08:05, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 07:32:16PM +0000, Valentin Schneider wrote:
>> 
>> On 17/11/20 16:13, Peter Zijlstra wrote:
>> > On Tue, Nov 17, 2020 at 03:37:24PM +0000, Valentin Schneider wrote:
>> >
>> >> >> +	/*
>> >> >> +	 * This field must not be in the scheduler word above due to wakelist
>> >> >> +	 * queueing no longer being serialized by p->on_cpu. However:
>> >> >> +	 *
>> >> >> +	 * p->XXX = X;			ttwu()
>> >> >> +	 * schedule()			  if (p->on_rq && ..) // false
>> >> >> +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
>> >> >> +	 *   deactivate_task()		      ttwu_queue_wakelist())
>> >> >> +	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
>> >> >> +	 *
>> >> >> +	 * guarantees all stores of 'current' are visible before
>> >> >> +	 * ->sched_remote_wakeup gets used, so it can be in this word.
>> >> >> +	 */
>> >> >
>> >> > Isn't the control dep between that ttwu() p->on_rq read and
>> >> > p->sched_remote_wakeup write "sufficient"?
>> >> 
>> >> smp_acquire__after_ctrl_dep() that is, since we need
>> >>   ->on_rq load => 'current' bits load + store
>> >
>> > I don't think we need that extra barrier; after all, there will be a
>> > complete schedule() between waking the task and it actually becoming
>> > current.
>> 
>> Apologies for the messy train of thought; what I was trying to say is that
>> we have already the following, which AIUI is sufficient:
>> 
>> 	* p->XXX = X;			ttwu()
>> 	* schedule()			  if (p->on_rq && ..) // false
>> 	*   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
>> 	*   deactivate_task()		  ttwu_queue_wakelist()
>> 	*     p->on_rq = 0;		    p->sched_remote_wakeup = Y;
>> 
>
> Ah, you meant the existing smp_acquire__after_ctrl_dep(). Yeah, that's
> not required here either ;-)
>
> The reason I had the ->on_cpu thing in there is because it shows we
> violate the regular ->on_cpu handoff rules, not for the acquire.
>

Gotcha

> The only ordering that matters on the RHS of that thing is the ->on_rq
> load to p->sched_remote_wakeup store ctrl dep. That, combined with the
> LHS, guarantees there is a strict order on the stores.
>
> Makes sense?

Yep, thanks!
