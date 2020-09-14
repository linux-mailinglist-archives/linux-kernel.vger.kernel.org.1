Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C666C268A07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgINL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:28:08 -0400
Received: from foss.arm.com ([217.140.110.172]:34758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgINL0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:26:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34438106F;
        Mon, 14 Sep 2020 04:26:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854733F68F;
        Mon, 14 Sep 2020 04:26:49 -0700 (PDT)
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com> <20200911162853.xldy6fvvqph2lahj@e107158-lin.cambridge.arm.com> <3f1571ea-b74c-fc40-2696-39ef3fe8b968@linux.intel.com> <jhjmu1s644x.mognet@arm.com> <20200914110809.2nu7vt2s3lzlvxoz@e107158-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Li\, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask in sched domain
In-reply-to: <20200914110809.2nu7vt2s3lzlvxoz@e107158-lin.cambridge.arm.com>
Date:   Mon, 14 Sep 2020 12:26:47 +0100
Message-ID: <jhjk0ww61l4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/09/20 12:08, Qais Yousef wrote:
> On 09/14/20 11:31, Valentin Schneider wrote:
>>
>> On 12/09/20 00:04, Li, Aubrey wrote:
>> >>> +++ b/include/linux/sched/topology.h
>> >>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>> >>>     atomic_t	ref;
>> >>>     atomic_t	nr_busy_cpus;
>> >>>     int		has_idle_cores;
>> >>> +	/*
>> >>> +	 * Span of all idle CPUs in this domain.
>> >>> +	 *
>> >>> +	 * NOTE: this field is variable length. (Allocated dynamically
>> >>> +	 * by attaching extra space to the end of the structure,
>> >>> +	 * depending on how many CPUs the kernel has booted up with)
>> >>> +	 */
>> >>> +	unsigned long	idle_cpus_span[];
>> >>
>> >> Can't you use cpumask_var_t and zalloc_cpumask_var() instead?
>> >
>> > I can use the existing free code. Do we have a problem of this?
>> >
>>
>> Nah, flexible array members are the preferred approach here; this also
>
> Is this your opinion or a rule written somewhere I missed?

I don't think there's a written rule, but AIUI it is preferred by at
least Peter:

https://lore.kernel.org/linux-pm/20180612125930.GP12217@hirez.programming.kicks-ass.net/
https://lore.kernel.org/lkml/20180619110734.GO2458@hirez.programming.kicks-ass.net/

And my opinion is that, if you can, having fewer separate allocation is better.

>
>> means we don't let CONFIG_CPUMASK_OFFSTACK dictate where this gets
>> allocated.
>>
>> See struct numa_group, struct sched_group, struct sched_domain, struct
>> em_perf_domain...
>
> struct root_domain, struct cpupri_vec, struct generic_pm_domain,
> struct irq_common_data..
>
> Use cpumask_var_t.
>
> Both approach look correct to me, so no objection in principle. cpumask_var_t
> looks neater IMO and will be necessary once more than one cpumask are required
> in a struct.
>

You're right in that cpumask_var_t becomes necessary when you need more
than one mask. For those that use it despite requiring only one mask
(cpupri stuff, struct nohz too), I'm not sure.
