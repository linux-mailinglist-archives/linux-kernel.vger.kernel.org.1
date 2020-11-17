Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B092B68D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKQPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:37:34 -0500
Received: from foss.arm.com ([217.140.110.172]:60078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgKQPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:37:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5F0BD6E;
        Tue, 17 Nov 2020 07:37:32 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B948E3F718;
        Tue, 17 Nov 2020 07:37:31 -0800 (PST)
References: <20201116091054.GL3371@techsingularity.net> <20201116131102.GA29992@willie-the-truck> <20201116133721.GQ3371@techsingularity.net> <20201116142005.GE3121392@hirez.programming.kicks-ass.net> <20201116193149.GW3371@techsingularity.net> <20201117083016.GK3121392@hirez.programming.kicks-ass.net> <20201117091545.GA31837@willie-the-truck> <20201117092936.GA3121406@hirez.programming.kicks-ass.net> <20201117094621.GE3121429@hirez.programming.kicks-ass.net> <jhjv9e4w3gj.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <jhjtutovvtm.mognet@arm.com>
In-reply-to: <jhjv9e4w3gj.mognet@arm.com>
Date:   Tue, 17 Nov 2020 15:37:24 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/11/20 12:52, Valentin Schneider wrote:
> On 17/11/20 09:46, Peter Zijlstra wrote:
>> How's this then? It still doesn't explicitly call out the specific race,
>> but does mention the more fundamental issue that wakelist queueing
>> doesn't respect the regular rules anymore.
>>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -775,7 +775,6 @@ struct task_struct {
>>  	unsigned			sched_reset_on_fork:1;
>>  	unsigned			sched_contributes_to_load:1;
>>  	unsigned			sched_migrated:1;
>> -	unsigned			sched_remote_wakeup:1;
>>  #ifdef CONFIG_PSI
>>  	unsigned			sched_psi_wake_requeue:1;
>>  #endif
>> @@ -785,6 +784,21 @@ struct task_struct {
>>  
>>  	/* Unserialized, strictly 'current' */
>>  
>> +	/*
>> +	 * This field must not be in the scheduler word above due to wakelist
>> +	 * queueing no longer being serialized by p->on_cpu. However:
>> +	 *
>> +	 * p->XXX = X;			ttwu()
>> +	 * schedule()			  if (p->on_rq && ..) // false
>> +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
>> +	 *   deactivate_task()		      ttwu_queue_wakelist())
>> +	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
>> +	 *
>> +	 * guarantees all stores of 'current' are visible before
>> +	 * ->sched_remote_wakeup gets used, so it can be in this word.
>> +	 */
>
> Isn't the control dep between that ttwu() p->on_rq read and
> p->sched_remote_wakeup write "sufficient"?

smp_acquire__after_ctrl_dep() that is, since we need
  ->on_rq load => 'current' bits load + store

> That should be giving the right
> ordering for the rest of ttwu() wrt. those 'current' bits, considering they
> are written before that smp_mb__after_spinlock().
>
> In any case, consider me convinced:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
>> +	unsigned			sched_remote_wakeup:1;
>> +
>>  	/* Bit to tell LSMs we're in execve(): */
>>  	unsigned			in_execve:1;
>>  	unsigned			in_iowait:1;

