Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D562C023E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgKWJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:26:28 -0500
Received: from foss.arm.com ([217.140.110.172]:38040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgKWJ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:26:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80117101E;
        Mon, 23 Nov 2020 01:26:27 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9398C3F70D;
        Mon, 23 Nov 2020 01:26:25 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        patrick.bellasi@matbug.net, lenb@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        ionela.voinescu@arm.com, qperret@google.com,
        viresh.kumar@linaro.org
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
Message-ID: <31ab5111-8cea-3a95-823e-f3a84476f7d6@arm.com>
Date:   Mon, 23 Nov 2020 10:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2020 08:55, Peter Zijlstra wrote:

[...]

> PELT (Per Entity Load Tracking)
> -------------------------------

[...]

> Using this we track 2 key metrics: 'running' and 'runnable'. 'Running'
> reflects the time an entity spends on the CPU, while 'runnable' reflects the
> time an entity spends on the runqueue. When there is only a single task these
> two metrics are the same, but once there is contention for the CPU 'running'
> will decrease to reflect the fraction of time each task spends on the CPU
> while 'runnable' will increase to reflect the amount of contention.

People might find it confusing to map 'running and 'runnable' into the 3
PELT signals (load_avg, runnable_avg and util_avg) being used in the
scheduler ... with load_avg being 'runnable' and 'weight' based.

> For more detail see: kernel/sched/pelt.c
> 
> 
> Frequency- / Heterogeneous Invariance
> -------------------------------------

We call 'Heterogeneous Invariance' CPU invariance in chapter 2.3
Documentation/scheduler/sched-capacity.rst.

[...]

> For more detail see:
> 
>  - kernel/sched/pelt.h:update_rq_clock_pelt()
>  - arch/x86/kernel/smpboot.c:"APERF/MPERF frequency ratio computation."

drivers/base/arch_topology.c:"f_cur/f_max ratio computation".

> UTIL_EST / UTIL_EST_FASTUP
> --------------------------

[...]

>   util_est := \Sum_t max( t_running, t_util_est_ewma )
> 
> For more detail see: kernel/sched/fair.h:util_est_dequeue()

s/fair.h/fair.c

> UCLAMP
> ------
> 
> It is possible to set effective u_min and u_max clamps on each task; the

s/on each task/on each CFS or RT task

[...]
