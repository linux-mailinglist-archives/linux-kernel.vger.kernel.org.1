Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D2266400
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIKQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:29:22 -0400
Received: from foss.arm.com ([217.140.110.172]:38784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgIKQ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:28:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F062106F;
        Fri, 11 Sep 2020 09:28:58 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35473F73C;
        Fri, 11 Sep 2020 09:28:56 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:28:54 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
Message-ID: <20200911162853.xldy6fvvqph2lahj@e107158-lin.cambridge.arm.com>
References: <20200910054203.525420-1-aubrey.li@intel.com>
 <20200910054203.525420-2-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910054203.525420-2-aubrey.li@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/20 13:42, Aubrey Li wrote:
> Added idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, its corresponding bit in the idle cpumask will be set,
> and when the CPU exits idle, its bit will be cleared.
> 
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  include/linux/sched/topology.h | 13 +++++++++++++
>  kernel/sched/fair.c            |  4 +++-
>  kernel/sched/topology.c        |  2 +-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index fb11091129b3..43a641d26154 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +	/*
> +	 * Span of all idle CPUs in this domain.
> +	 *
> +	 * NOTE: this field is variable length. (Allocated dynamically
> +	 * by attaching extra space to the end of the structure,
> +	 * depending on how many CPUs the kernel has booted up with)
> +	 */
> +	unsigned long	idle_cpus_span[];

Can't you use cpumask_var_t and zalloc_cpumask_var() instead?

The patch looks useful. Did it help you with any particular workload? It'd be
good to expand on that in the commit message.

Thanks

--
Qais Yousef
