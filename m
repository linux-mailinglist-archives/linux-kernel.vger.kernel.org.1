Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58C22B1CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKMORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:17:03 -0500
Received: from foss.arm.com ([217.140.110.172]:38948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMORD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:17:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20ACF142F;
        Fri, 13 Nov 2020 06:17:03 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C29D3F6CF;
        Fri, 13 Nov 2020 06:17:01 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:16:58 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: implement CPPC FFH support using AMUs
Message-ID: <20201113141658.v2oq47nzerx3abga@bogus>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106125334.21570-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:53:34PM +0000, Ionela Voinescu wrote:
> If Activity Monitors (AMUs) are present, two of the counters can be used
> to implement support for CPPC's (Collaborative Processor Performance
> Control) delivered and reference performance monitoring functionality
> using FFH (Functional Fixed Hardware).
>
> Given that counters for a certain CPU can only be read from that CPU,
> while FFH operations can be called from any CPU for any of the CPUs, use
> smp_call_function_single() to provide the requested values.
>
> Therefore, depending on the register addresses, the following values
> are returned:
>  - 0x0 (DeliveredPerformanceCounterRegister): AMU core counter
>  - 0x1 (ReferencePerformanceCounterRegister): AMU constant counter
>
> The use of Activity Monitors is hidden behind the generic
> cpu_read_{corecnt,constcnt}() functions.
>
> Read functionality for these two registers represents the only current
> FFH support for CPPC. Read operations for other register values or write
> operation for all registers are unsupported. Therefore, keep CPPC's FFH
> unsupported if no CPUs have valid AMU frequency counters. For this
> purpose, the get_cpu_with_amu_feat() is introduced.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/cpufeature.h |  3 ++
>  arch/arm64/kernel/cpufeature.c      | 10 +++++
>  arch/arm64/kernel/topology.c        | 64 +++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 751bd9d3376b..f5b44ac354dc 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -772,6 +772,9 @@ static inline bool cpu_has_amu_feat(int cpu)
>  }
>  #endif
>
> +/* Get a cpu that supports the Activity Monitors Unit (AMU) */
> +extern int get_cpu_with_amu_feat(void);
> +
>  static inline unsigned int get_vmid_bits(u64 mmfr1)
>  {
>  	int vmid_bits;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 1142970e985b..6b08ae74ad0a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1526,6 +1526,11 @@ bool cpu_has_amu_feat(int cpu)
>  	return cpumask_test_cpu(cpu, &amu_cpus);
>  }
>
> +int get_cpu_with_amu_feat(void)
> +{
> +	return cpumask_any(&amu_cpus);
> +}
> +
>  static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  {
>  	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> @@ -1554,6 +1559,11 @@ static bool has_amu(const struct arm64_cpu_capabilities *cap,
>
>  	return true;
>  }
> +#else
> +int get_cpu_with_amu_feat(void)
> +{
> +	return nr_cpu_ids;
> +}
>  #endif
>
>  #ifdef CONFIG_ARM64_VHE
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b8cb16e3a2cc..7c9b6a0ecd6a 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -147,6 +147,9 @@ void update_freq_counters_refs(void)
>
>  static inline bool freq_counters_valid(int cpu)
>  {
> +	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> +		return false;
> +
>  	if (!cpu_has_amu_feat(cpu)) {
>  		pr_debug("CPU%d: counters are not supported.\n", cpu);
>  		return false;
> @@ -323,3 +326,64 @@ void topology_scale_freq_tick(void)
>  	this_cpu_write(arch_core_cycles_prev, core_cnt);
>  	this_cpu_write(arch_const_cycles_prev, const_cnt);
>  }
> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +#include <acpi/cppc_acpi.h>

Not sure what arm64 maintainers prefer, but this code has nothing to do
with topolopy strictly speaking. I wonder if we can put it in separate
file conditionally compiled if CONFIG_ACPI_CPPC_LIB is enabled there
by eliminating #ifdef(main reason for raising this point).

Either way:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
