Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096292B879C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKRWSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:18:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:56301 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKRWSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:18:21 -0500
IronPort-SDR: WdS4iNtbi7705KZBQVUkXqzZlD+LWngKEG/UPXpP4dxetiEcEx9eomVEqJQreFFf/6qSnQyJaW
 6iRGm0ecDztQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="189278034"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="189278034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 14:18:21 -0800
IronPort-SDR: SevrtfYwawoG7yO9b2Y1TtbLLikybLhFqF/z4EJuSGf7UYmKTgixwhS8beTy6sts0gqulIPgcH
 tEiVs4dJZieg==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="534507062"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.255.230.225]) ([10.255.230.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 14:18:20 -0800
Subject: Re: [PATCH] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
To:     Babu Moger <babu.moger@amd.com>, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
References: <160469365104.21002.2901190946502347327.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d03ac86a-5e7b-8319-7747-4b0299aaa625@intel.com>
Date:   Wed, 18 Nov 2020 14:18:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <160469365104.21002.2901190946502347327.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/6/2020 12:14 PM, Babu Moger wrote:
> When the AMD QoS feature CDP(code and data prioritization) is enabled
> or disabled, the CDP bit in MSR 0000_0C81 is written on one of the
> cpus in L3 domain(core complex). That is not correct. The CDP bit needs
> to be updated all the logical cpus in the domain.

Could you please use CPU instead of cpu throughout, in commit message as 
well as the new code comments?

> 
> This was not spelled out clearly in the spec earlier. The specification
> has been updated. The updated specification, "AMD64 Technology Platform
> Quality of Service Extensions Publication # 56375 Revision: 1.02 Issue
> Date: October 2020" is available now. Refer the section: Code and Data
> Prioritization.
> 
> Fix the issue by adding a new flag arch_needs_update_all in rdt_cache
> data structure.

I understand that naming is hard and could be a sticky point. Even so, I 
am concerned that this name is too generic. For example, there are other 
cache settings that are successfully set on a single CPU in the L3 
domain (the bitmasks for example). This new name and its description in 
the code comments below does not make it clear which cache settings it 
applies to.

I interpret this change to mean that the L[23]_QOS_CFG MSR has CPU scope 
while the other L3 QoS configuration registers have the same scope as 
the L3 cache. Could this new variable thus perhaps be named 
"arch_has_per_cpu_cfg"? I considered "arch_has_per_cpu_cdp" but when a 
new field is added to that register it may cause confusion.

> The documentation can be obtained at the links below:
> https://developer.amd.com/wp-content/resources/56375.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |    3 +++
>   arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 +++++++--
>   3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e5f4ee8f4c3b..142c92a12254 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -570,6 +570,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   
>   	if (d) {
>   		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		if (r->cache.arch_needs_update_all)
> +			rdt_domain_reconfigure_cdp(r);
>   		return;
>   	}
>   
> @@ -943,6 +945,7 @@ static __init void rdt_init_res_defs_amd(void)
>   		    r->rid == RDT_RESOURCE_L2CODE) {
>   			r->cache.arch_has_sparse_bitmaps = true;
>   			r->cache.arch_has_empty_bitmaps = true;
> +			r->cache.arch_needs_update_all = true;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
>   			r->msr_base = MSR_IA32_MBA_BW_BASE;
>   			r->msr_update = mba_wrmsr_amd;

The current pattern is to set these flags on all the architectures. 
Could you thus please set the flag within rdt_init_defs_intel()? I 
confirmed that the scope is the same as the cache domain in Intel RDT so 
the flag should be false.

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 80fa997fae60..d23262d59a51 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -360,6 +360,8 @@ struct msr_param {
>    *			executing entities
>    * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
>    * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
> + * @arch_needs_update_all:	True if arch needs to update the cache
> + *				settings on all the cpus in the domain.

Please do update this to make it clear what "cache settings" are 
referred to. Since this is in struct rdt_cache perhaps something like 
"QOS_CFG register for this cache level has CPU scope."

>    */
>   struct rdt_cache {
>   	unsigned int	cbm_len;
> @@ -369,6 +371,7 @@ struct rdt_cache {
>   	unsigned int	shareable_bits;
>   	bool		arch_has_sparse_bitmaps;
>   	bool		arch_has_empty_bitmaps;
> +	bool		arch_needs_update_all;
>   };
>   
>   /**
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index af323e2e3100..a005e90b373a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1905,8 +1905,13 @@ static int set_cache_qos_cfg(int level, bool enable)
>   
>   	r_l = &rdt_resources_all[level];
>   	list_for_each_entry(d, &r_l->domains, list) {
> -		/* Pick one CPU from each domain instance to update MSR */
> -		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +		if (r_l->cache.arch_needs_update_all)
> +			/* Pick all the cpus in the domain instance */
> +			for_each_cpu(cpu, &d->cpu_mask)
> +				cpumask_set_cpu(cpu, cpu_mask);
> +		else
> +			/* Pick one CPU from each domain instance to update MSR */
> +			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>   	}
>   	cpu = get_cpu();
>   	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
> 

The solution looks good to me, thank you very much.

Reinette
