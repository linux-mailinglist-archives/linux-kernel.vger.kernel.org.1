Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2972B6E77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgKQTVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:21:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:50273 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgKQTUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:20:41 -0500
IronPort-SDR: 4E3Ci6KutWcndpw/MHyxj1Sz0ZcTfFH0OVeKQqva3TFUg7V64e48/Ox4yPBwh3w7ccKrp2kg/D
 TEjT3IdF2XoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="189054421"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="189054421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:38 -0800
IronPort-SDR: u3MVC9Ej4k86LUEXENouHjHF8w2wHoqPWzsnI8bg1vWlCCk/Qlse3l+oyrbsm4pLpPutdU6pnZ
 CFyo0zM3KWYg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430566932"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:38 -0800
Subject: Re: [PATCH 01/24] x86/resctrl: Split struct rdt_resource
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <8a49d89f-a68b-bd10-60c1-33f59258ea9f@intel.com>
Date:   Tue, 17 Nov 2020 11:20:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-2-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:10 AM, James Morse wrote:
> resctrl is the defacto Linux ABI for SoC resource partitioning features.
> To support it on another architecture, it needs to be abstracted from
> Intel RDT, and moved it to /fs/.

Current support for AMD PQoS should also be considered.

s/and moved it to/and moved to/?

> 
> Start by splitting struct rdt_resource, (the name is kept to keep the noise
> down), and add some type-trickery to keep the foreach helpers working.
> 
> Move everything that that is particular to resctrl into a new header

s/that that/that/

> file, keeping the x86 hardware accessors where they are. resctrl code
> paths touching a 'hw' struct indicates where an abstraction is needed.
> 
> Splitting rdt_domain up in a similar way happens in the next patch.
> No change in behaviour, this patch just moves types around.

Please remove the "this patch" term.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        | 258 ++++++++++++----------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  14 +-
>   arch/x86/kernel/cpu/resctrl/internal.h    | 138 +++---------
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  32 +--
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  69 +++---
>   include/linux/resctrl.h                   | 117 ++++++++++
>   7 files changed, 362 insertions(+), 270 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e5f4ee8f4c3b..470661f2eb68 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c

...

> @@ -912,9 +938,14 @@ static __init bool get_rdt_resources(void)
>   
>   static __init void rdt_init_res_defs_intel(void)
>   {
> +	struct rdt_hw_resource *hw_res;
>   	struct rdt_resource *r;
> +	int i;
> +
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		hw_res = &rdt_resources_all[i];
> +		r = &rdt_resources_all[i].resctrl;
>   
> -	for_each_rdt_resource(r) {
>   		if (r->rid == RDT_RESOURCE_L3 ||
>   		    r->rid == RDT_RESOURCE_L3DATA ||
>   		    r->rid == RDT_RESOURCE_L3CODE ||

Could using for_each_rdt_resource() remain with the additional 
assignment of hw_res? Similar to the later usage of 
for_each_alloc_enabled_rdt_resource()?

> @@ -924,17 +955,22 @@ static __init void rdt_init_res_defs_intel(void)
>   			r->cache.arch_has_sparse_bitmaps = false;
>   			r->cache.arch_has_empty_bitmaps = false;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
> -			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
> -			r->msr_update = mba_wrmsr_intel;
> +			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
> +			hw_res->msr_update = mba_wrmsr_intel;
>   		}
>   	}
>   }
>   
>   static __init void rdt_init_res_defs_amd(void)
>   {
> +	struct rdt_hw_resource *hw_res;
>   	struct rdt_resource *r;
> +	int i;
> +
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		hw_res = &rdt_resources_all[i];
> +		r = &rdt_resources_all[i].resctrl;
>   
> -	for_each_rdt_resource(r) {
>   		if (r->rid == RDT_RESOURCE_L3 ||
>   		    r->rid == RDT_RESOURCE_L3DATA ||
>   		    r->rid == RDT_RESOURCE_L3CODE ||

Same here (keep using for_each_rdt_resource()?).

> @@ -944,8 +980,8 @@ static __init void rdt_init_res_defs_amd(void)
>   			r->cache.arch_has_sparse_bitmaps = true;
>   			r->cache.arch_has_empty_bitmaps = true;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
> -			r->msr_base = MSR_IA32_MBA_BW_BASE;
> -			r->msr_update = mba_wrmsr_amd;
> +			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
> +			hw_res->msr_update = mba_wrmsr_amd;
>   		}
>   	}
>   }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index c877642e8a14..ab6e584c9d2d 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -284,10 +284,12 @@ int update_domains(struct rdt_resource *r, int closid)
>   static int rdtgroup_parse_resource(char *resname, char *tok,
>   				   struct rdtgroup *rdtgrp)
>   {
> +	struct rdt_hw_resource *hw_res;
>   	struct rdt_resource *r;
>   
>   	for_each_alloc_enabled_rdt_resource(r) {
> -		if (!strcmp(resname, r->name) && rdtgrp->closid < r->num_closid)
> +		hw_res = resctrl_to_arch_res(r);
> +		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
>   			return parse_line(tok, r, rdtgrp);
>   	}

This is the usage of for_each_alloc_enabled_rdt_resource() I refer to 
earlier.

>   	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 80fa997fae60..bcae86138cad 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h

...

> @@ -438,56 +381,29 @@ struct rdt_parse_data {
>   };
>   
>   /**
> - * struct rdt_resource - attributes of an RDT resource
> - * @rid:		The index of the resource
> - * @alloc_enabled:	Is allocation enabled on this machine
> - * @mon_enabled:	Is monitoring enabled for this feature
> - * @alloc_capable:	Is allocation available on this machine
> - * @mon_capable:	Is monitor feature available on this machine
> - * @name:		Name to use in "schemata" file
> - * @num_closid:		Number of CLOSIDs available
> - * @cache_level:	Which cache level defines scope of this resource
> - * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> + * struct rdt_hw_resource - hw attributes of an RDT resource

Perhaps rather "hw attributes of a resctrl resource" to help with the 
transition away from being specific to Intel RDT.

> + * @num_closid:		Number of CLOSIDs available.
>    * @msr_base:		Base MSR address for CBMs
>    * @msr_update:		Function pointer to update QOS MSRs
> - * @data_width:		Character width of data when displaying
> - * @domains:		All domains for this resource
> - * @cache:		Cache allocation related data
> - * @format_str:		Per resource format string to show domain value
> - * @parse_ctrlval:	Per resource function pointer to parse control values
> - * @evt_list:		List of monitoring events
> - * @num_rmid:		Number of RMIDs available
>    * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> - * @fflags:		flags to choose base and info files
>    */
> -struct rdt_resource {
> -	int			rid;
> -	bool			alloc_enabled;
> -	bool			mon_enabled;
> -	bool			alloc_capable;
> -	bool			mon_capable;
> -	char			*name;
> +struct rdt_hw_resource {
> +	struct rdt_resource     resctrl;
> +

Please use tabs and spaces similar to the existing format.

>   	int			num_closid;
> -	int			cache_level;
> -	u32			default_ctrl;
> +

Please remove these empty lines.

>   	unsigned int		msr_base;
>   	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
>   				 struct rdt_resource *r);
> -	int			data_width;
> -	struct list_head	domains;
> -	struct rdt_cache	cache;
> -	struct rdt_membw	membw;
> -	const char		*format_str;
> -	int (*parse_ctrlval)(struct rdt_parse_data *data,
> -			     struct rdt_resource *r,
> -			     struct rdt_domain *d);
> -	struct list_head	evt_list;
> -	int			num_rmid;
>   	unsigned int		mon_scale;
>   	unsigned int		mbm_width;
> -	unsigned long		fflags;
>   };
>   
> +static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> +{
> +	return container_of(r, struct rdt_hw_resource, resctrl);
> +}
> +
>   int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>   	      struct rdt_domain *d);
>   int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,

...



> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 9b05af9b3e28..b2c2b7386d28 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -2,6 +2,8 @@
>   #ifndef _RESCTRL_H
>   #define _RESCTRL_H
>   
> +#include <linux/kernel.h>
> +#include <linux/list.h>
>   #include <linux/pid.h>
>   
>   #ifdef CONFIG_PROC_CPU_RESCTRL
> @@ -13,4 +15,119 @@ int proc_resctrl_show(struct seq_file *m,
>   
>   #endif
>   
> +struct rdt_domain;
> +
> +/**
> + * struct resctrl_cache - Cache allocation related data
> + * @cbm_len:		Length of the cache bit mask
> + * @min_cbm_bits:	Minimum number of consecutive bits to be set
> + * @cbm_idx_mult:	Multiplier of CBM index
> + * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
> + *			closid * cbm_idx_multi + cbm_idx_offset
> + *			in a cache bit mask
> + * @shareable_bits:	Bitmask of shareable resource with other
> + *			executing entities
> + * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
> + * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
> + */
> +struct resctrl_cache {
> +	u32		cbm_len;
> +	u32		min_cbm_bits;
> +	unsigned int	cbm_idx_mult;	// TODO remove this
> +	unsigned int	cbm_idx_offset; // TODO remove this
> +	u32		shareable_bits;
> +	bool		arch_has_sparse_bitmaps;
> +	bool		arch_has_empty_bitmaps;
> +};
> +
> +/**
> + * enum membw_throttle_mode - System's memory bandwidth throttling mode
> + * @THREAD_THROTTLE_UNDEFINED:	Not relevant to the system
> + * @THREAD_THROTTLE_MAX:	Memory bandwidth is throttled at the core
> + *				always using smallest bandwidth percentage
> + *				assigned to threads, aka "max throttling"
> + * @THREAD_THROTTLE_PER_THREAD:	Memory bandwidth is throttled at the thread
> + */
> +enum membw_throttle_mode {
> +	THREAD_THROTTLE_UNDEFINED = 0,
> +	THREAD_THROTTLE_MAX,
> +	THREAD_THROTTLE_PER_THREAD,
> +};
> +
> +/**
> + * struct resctrl_membw - Memory bandwidth allocation related data
> + * @min_bw:		Minimum memory bandwidth percentage user can request
> + * @bw_gran:		Granularity at which the memory bandwidth is allocated
> + * @delay_linear:	True if memory B/W delay is in linear scale
> + * @arch_needs_linear:	True if we can't configure non-linear resources
> + * @throttle_mode:	Bandwidth throttling mode when threads request
> + *			different memory bandwidths
> + * @mba_sc:		True if MBA software controller(mba_sc) is enabled
> + * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
> + */
> +struct resctrl_membw {
> +	u32				min_bw;
> +	u32				bw_gran;
> +	u32				delay_linear;
> +	bool				arch_needs_linear;
> +	enum membw_throttle_mode	throttle_mode;
> +	bool				mba_sc;
> +	u32				*mb_map;
> +};
> +
> +struct rdt_parse_data;
> +
> +/**

Missing a kernel-doc description here.

> + * @rid:		The index of the resource
> + * @alloc_enabled:	Is allocation enabled on this machine
> + * @mon_enabled:	Is monitoring enabled for this feature
> + * @alloc_capable:	Is allocation available on this machine
> + * @mon_capable:	Is monitor feature available on this machine
> + *
> + * @num_rmid:		Number of RMIDs available.
> + *
> + * @cache_level:	Which cache level defines scope of this resource
> + *
> + * @cache:		If the component has cache controls, their properties.
> + * @membw:		If the component has bandwidth controls, their properties.
> + *
> + * @domains:		All domains for this resource
> + *
> + * @name:		Name to use in "schemata" file.
> + * @data_width:		Character width of data when displaying.
> + * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> + * @format_str:		Per resource format string to show domain value
> + * @parse_ctrlval:	Per resource function pointer to parse control values
> + *
> + * @evt_list:		List of monitoring events
> + * @fflags:		flags to choose base and info files

Please remove the empty lines in the above. It hints at some grouping 
that is unclear.

> + */
> +struct rdt_resource {
> +	int			rid;
> +	bool			alloc_enabled;
> +	bool			mon_enabled;
> +	bool			alloc_capable;
> +	bool			mon_capable;
> +
> +	int			num_rmid;
> +
> +	int			cache_level;
> +
> +	struct resctrl_cache	cache;
> +	struct resctrl_membw	membw;
> +
> +	struct list_head	domains;
> +

Please remove empty lines.

> +	char			*name;
> +	int			data_width;
> +	u32			default_ctrl;
> +	const char		*format_str;
> +	int			(*parse_ctrlval)(struct rdt_parse_data *data,
> +						 struct rdt_resource *r,
> +						 struct rdt_domain *d);
> +	struct list_head	evt_list;
> +	unsigned long		fflags;
> +
> +};
> +
>   #endif /* _RESCTRL_H */
> 

Reinette
