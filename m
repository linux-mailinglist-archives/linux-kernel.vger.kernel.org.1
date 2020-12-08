Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A22D287E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgLHKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:08:10 -0500
Received: from foss.arm.com ([217.140.110.172]:46782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgLHKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:08:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E691FB;
        Tue,  8 Dec 2020 02:07:23 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219BA3F68F;
        Tue,  8 Dec 2020 02:07:20 -0800 (PST)
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
Date:   Tue, 8 Dec 2020 11:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207091516.24683-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2020 10:15, Mel Gorman wrote:
> SIS_AVG_CPU was introduced as a means of avoiding a search when the
> average search cost indicated that the search would likely fail. It
> was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
> select_idle_cpu() more aggressive") and later replaced with a proportional
> search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
> scale select_idle_cpu()").
> 
> While there are corner cases where SIS_AVG_CPU is better, it has now been
> disabled for almost three years. As the intent of SIS_PROP is to reduce
> the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
> on SIS_PROP as a throttling mechanism.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c     | 3 ---
>  kernel/sched/features.h | 1 -
>  2 files changed, 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 98075f9ea9a8..23934dbac635 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6161,9 +6161,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	avg_idle = this_rq()->avg_idle / 512;
>  	avg_cost = this_sd->avg_scan_cost + 1;
>  
> -	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
> -		return -1;
> -
>  	if (sched_feat(SIS_PROP)) {
>  		u64 span_avg = sd->span_weight * avg_idle;
>  		if (span_avg > 4*avg_cost)

Nitpick:

Since now avg_cost and avg_idle are only used w/ SIS_PROP, they could go
completely into the SIS_PROP if condition.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09f6f0edead4..fce9457cccb9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6121,7 +6121,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
-	u64 avg_cost, avg_idle;
 	u64 time;
 	int this = smp_processor_id();
 	int cpu, nr = INT_MAX;
@@ -6130,14 +6129,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (!this_sd)
 		return -1;
 
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
-	avg_cost = this_sd->avg_scan_cost + 1;
-
 	if (sched_feat(SIS_PROP)) {
+		/*
+		 * Due to large variance we need a large fuzz factor; hackbench in
+		 * particularly is sensitive here.
+		 */
+		u64 avg_idle = this_rq()->avg_idle / 512;
+		u64 avg_cost = this_sd->avg_scan_cost + 1;
 		u64 span_avg = sd->span_weight * avg_idle;
 		if (span_avg > 4*avg_cost)
 			nr = div_u64(span_avg, avg_cost);
-- 
2.17.1
