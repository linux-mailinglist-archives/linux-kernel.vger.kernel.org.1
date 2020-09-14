Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8427A2689BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINLJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:09:02 -0400
Received: from foss.arm.com ([217.140.110.172]:34470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgINLIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:08:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645A3113E;
        Mon, 14 Sep 2020 04:08:14 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1AD43F68F;
        Mon, 14 Sep 2020 04:08:12 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:08:10 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
Message-ID: <20200914110809.2nu7vt2s3lzlvxoz@e107158-lin.cambridge.arm.com>
References: <20200910054203.525420-1-aubrey.li@intel.com>
 <20200910054203.525420-2-aubrey.li@intel.com>
 <20200911162853.xldy6fvvqph2lahj@e107158-lin.cambridge.arm.com>
 <3f1571ea-b74c-fc40-2696-39ef3fe8b968@linux.intel.com>
 <jhjmu1s644x.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjmu1s644x.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/20 11:31, Valentin Schneider wrote:
> 
> On 12/09/20 00:04, Li, Aubrey wrote:
> >>> +++ b/include/linux/sched/topology.h
> >>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
> >>>     atomic_t	ref;
> >>>     atomic_t	nr_busy_cpus;
> >>>     int		has_idle_cores;
> >>> +	/*
> >>> +	 * Span of all idle CPUs in this domain.
> >>> +	 *
> >>> +	 * NOTE: this field is variable length. (Allocated dynamically
> >>> +	 * by attaching extra space to the end of the structure,
> >>> +	 * depending on how many CPUs the kernel has booted up with)
> >>> +	 */
> >>> +	unsigned long	idle_cpus_span[];
> >>
> >> Can't you use cpumask_var_t and zalloc_cpumask_var() instead?
> >
> > I can use the existing free code. Do we have a problem of this?
> >
> 
> Nah, flexible array members are the preferred approach here; this also

Is this your opinion or a rule written somewhere I missed?

> means we don't let CONFIG_CPUMASK_OFFSTACK dictate where this gets
> allocated.
> 
> See struct numa_group, struct sched_group, struct sched_domain, struct
> em_perf_domain...

struct root_domain, struct cpupri_vec, struct generic_pm_domain,
struct irq_common_data..

Use cpumask_var_t.

Both approach look correct to me, so no objection in principle. cpumask_var_t
looks neater IMO and will be necessary once more than one cpumask are required
in a struct.

> 
> >>
> >> The patch looks useful. Did it help you with any particular workload? It'd be
> >> good to expand on that in the commit message.
> >>
> > Odd, that included in patch v1 0/1, did you receive it?

Aubrey,

Sorry I didn't see that no. It's important justification to be part of the
commit message, I think worth adding it.

Thanks

--
Qais Yousef
