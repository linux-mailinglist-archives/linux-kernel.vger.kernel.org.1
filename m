Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC10E2EF2D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhAHNCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:02:00 -0500
Received: from foss.arm.com ([217.140.110.172]:51048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbhAHNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:01:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41543ED1;
        Fri,  8 Jan 2021 05:01:14 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950DB3F719;
        Fri,  8 Jan 2021 05:01:12 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:01:10 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20210108130110.cj3zqsnjdt5mg3uz@e107158-lin>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108102738.GB3592@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/21 10:27, Mel Gorman wrote:
>  	for_each_cpu_wrap(cpu, cpus, target) {
> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
> +			/* Adjust cost of a successful scan */
> +			loops <<= 2;
> +
>  			break;
> +		}
>  
> -		if (loops >= nr) {
> +		if (++loops >= nr) {
>  			cpu = -1;
>  			break;
>  		}
> -		loops++;

Random (out of the blue) comment.

Now this will increment loops before the comparison/break. ie: we're
effectively doing one iteration less IIRC. Should loops be initialized to
0 instead of 1?

Thanks

--
Qais Yousef
