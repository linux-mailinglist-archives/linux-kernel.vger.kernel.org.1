Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8C2B234F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKMSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:06:40 -0500
Received: from foss.arm.com ([217.140.110.172]:43068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKMSGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:06:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB901042;
        Fri, 13 Nov 2020 10:06:39 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.53.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1546A3F718;
        Fri, 13 Nov 2020 10:06:35 -0800 (PST)
Date:   Fri, 13 Nov 2020 18:06:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v4 2/9] arm64: perf: Enable pmu counter direct access for
 perf event on armv8
Message-ID: <20201113180633.GE44988@C02TD0UTHF1T.local>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001140116.651970-3-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for this, and sorry for the long delay since this was last
reviewed. Overall this is looking pretty good, but I have a couple of
remaining concerns.

Will, I have a query for you below.

On Thu, Oct 01, 2020 at 09:01:09AM -0500, Rob Herring wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> Keep track of event opened with direct access to the hardware counters
> and modify permissions while they are open.
> 
> The strategy used here is the same which x86 uses: everytime an event
> is mapped, the permissions are set if required. The atomic field added
> in the mm_context helps keep track of the different event opened and
> de-activate the permissions when all are unmapped.
> We also need to update the permissions in the context switch code so
> that tasks keep the right permissions.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Move mapped/unmapped into arm64 code. Fixes arm32.
>  - Rebase on cap_user_time_short changes
> 
> Changes from Raphael's v4:
>   - Drop homogeneous check
>   - Disable access for chained counters
>   - Set pmc_width in user page
> ---
>  arch/arm64/include/asm/mmu.h         |  5 ++++
>  arch/arm64/include/asm/mmu_context.h |  2 ++
>  arch/arm64/include/asm/perf_event.h  | 14 ++++++++++
>  arch/arm64/kernel/perf_event.c       | 41 ++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index a7a5ecaa2e83..52cfdb676f06 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -19,6 +19,11 @@
>  
>  typedef struct {
>  	atomic64_t	id;
> +	/*
> +	 * non-zero if userspace have access to hardware
> +	 * counters directly.
> +	 */
> +	atomic_t	pmu_direct_access;
>  #ifdef CONFIG_COMPAT
>  	void		*sigpage;
>  #endif
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index f2d7537d6f83..d24589ecb07a 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -21,6 +21,7 @@
>  #include <asm/proc-fns.h>
>  #include <asm-generic/mm_hooks.h>
>  #include <asm/cputype.h>
> +#include <asm/perf_event.h>
>  #include <asm/sysreg.h>
>  #include <asm/tlbflush.h>
>  
> @@ -224,6 +225,7 @@ static inline void __switch_mm(struct mm_struct *next)
>  	}
>  
>  	check_and_switch_context(next);
> +	perf_switch_user_access(next);
>  }
>  
>  static inline void
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index 2c2d7dbe8a02..a025d9595d51 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -8,6 +8,7 @@
>  
>  #include <asm/stack_pointer.h>
>  #include <asm/ptrace.h>
> +#include <linux/mm_types.h>
>  
>  #define	ARMV8_PMU_MAX_COUNTERS	32
>  #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
> @@ -251,4 +252,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }
>  
> +static inline void perf_switch_user_access(struct mm_struct *mm)
> +{
> +	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
> +		return;
> +
> +	if (atomic_read(&mm->context.pmu_direct_access)) {
> +		write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
> +			     pmuserenr_el0);
> +	} else {
> +		write_sysreg(0, pmuserenr_el0);
> +	}
> +}

PMUSERENR.ER gives RW access to PMSELR_EL0. While we no longer use
PMSELR_EL0 in the kernel, we can preempt and migrate userspace tasks
between homogeneous CPUs, and presumably need to context-switch this
with the task (like we do for TPIDR_EL0 and friends), or clear the
register on context-switch to prevent it becoming an unintended covert
channel.

These bits also enable AArch32 access. Is there any way an AArch32 task
can enable this? If so we should probably block that given we do not
support this interface on 32-bit arm.

> +
>  #endif
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index e14f360a7883..8344dc030823 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -834,6 +834,41 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
>  	return event->hw.idx;
>  }
>  
> +static void refresh_pmuserenr(void *mm)
> +{
> +	perf_switch_user_access(mm);
> +}
> +
> +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return;
> +
> +	/*
> +	 * This function relies on not being called concurrently in two
> +	 * tasks in the same mm.  Otherwise one task could observe
> +	 * pmu_direct_access > 1 and return all the way back to
> +	 * userspace with user access disabled while another task is still
> +	 * doing on_each_cpu_mask() to enable user access.
> +	 *
> +	 * For now, this can't happen because all callers hold mmap_lock
> +	 * for write.  If this changes, we'll need a different solution.
> +	 */
> +	lockdep_assert_held_write(&mm->mmap_lock);
> +
> +	if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
> +		on_each_cpu(refresh_pmuserenr, mm, 1);
> +}
> +
> +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return;
> +
> +	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> +		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
> +}

I didn't think we kept our mm_cpumask() up-to-date in all cases on
arm64, so I'm not sure we can use it like this.

Will, can you confirm either way?

Thanks,
Mark.

> +
>  /*
>   * Add an event filter to a given event.
>   */
> @@ -1058,6 +1093,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  	cpu_pmu->filter_match		= armv8pmu_filter_match;
>  
>  	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
> +	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
> +	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
>  
>  	cpu_pmu->name			= name;
>  	cpu_pmu->map_event		= map_event;
> @@ -1218,6 +1255,10 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time = 0;
>  	userpg->cap_user_time_zero = 0;
>  	userpg->cap_user_time_short = 0;
> +	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR);
> +
> +	if (userpg->cap_user_rdpmc)
> +		userpg->pmc_width = armv8pmu_event_is_64bit(event) ? 64 : 32;
>  
>  	do {
>  		rd = sched_clock_read_begin(&seq);
> -- 
> 2.25.1
> 
