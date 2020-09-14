Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3426894F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgINKbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:31:50 -0400
Received: from foss.arm.com ([217.140.110.172]:34070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgINKbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:31:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1DDD1FB;
        Mon, 14 Sep 2020 03:31:48 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 400583F68F;
        Mon, 14 Sep 2020 03:31:47 -0700 (PDT)
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com> <20200911162853.xldy6fvvqph2lahj@e107158-lin.cambridge.arm.com> <3f1571ea-b74c-fc40-2696-39ef3fe8b968@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Li\, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Aubrey Li <aubrey.li@intel.com>,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask in sched domain
In-reply-to: <3f1571ea-b74c-fc40-2696-39ef3fe8b968@linux.intel.com>
Date:   Mon, 14 Sep 2020 11:31:42 +0100
Message-ID: <jhjmu1s644x.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/09/20 00:04, Li, Aubrey wrote:
>>> +++ b/include/linux/sched/topology.h
>>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>>>     atomic_t	ref;
>>>     atomic_t	nr_busy_cpus;
>>>     int		has_idle_cores;
>>> +	/*
>>> +	 * Span of all idle CPUs in this domain.
>>> +	 *
>>> +	 * NOTE: this field is variable length. (Allocated dynamically
>>> +	 * by attaching extra space to the end of the structure,
>>> +	 * depending on how many CPUs the kernel has booted up with)
>>> +	 */
>>> +	unsigned long	idle_cpus_span[];
>>
>> Can't you use cpumask_var_t and zalloc_cpumask_var() instead?
>
> I can use the existing free code. Do we have a problem of this?
>

Nah, flexible array members are the preferred approach here; this also
means we don't let CONFIG_CPUMASK_OFFSTACK dictate where this gets
allocated.

See struct numa_group, struct sched_group, struct sched_domain, struct
em_perf_domain...

>>
>> The patch looks useful. Did it help you with any particular workload? It'd be
>> good to expand on that in the commit message.
>>
> Odd, that included in patch v1 0/1, did you receive it?
>
> Thanks,
> -Aubrey
