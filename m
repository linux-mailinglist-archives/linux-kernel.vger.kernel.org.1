Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09272B6E86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgKQTWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:22:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:7697 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgKQTWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:22:10 -0500
IronPort-SDR: QdT/Sw9GFux44eCMUAp7c98RpIkHCnaH8DDqct6rbplp1/WJBxfCxU4+Ef9kJDW2ah1zec7gH3
 f7B5qp/2vOEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="167482954"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="167482954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:22:09 -0800
IronPort-SDR: Bv0yVfud6ralZwiMWbWeglRPlJuJAQjp7KpwGJsIEt4QkB9tSsPA0X5ysQLHFpx79/R2HOP+8L
 VWU+zaTKdQUw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430567196"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:22:09 -0800
Subject: Re: [PATCH 02/24] x86/resctrl: Split struct rdt_domain
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <768d3fe3-336f-70d6-d406-1d3f25b7f3bf@intel.com>
Date:   Tue, 17 Nov 2020 11:22:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-3-james.morse@arm.com>
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

Same comments as previous patch regarding "Intel RDT" and "moved it to"

> 
> Split struct rdt_domain up too. Move everything that that is particular

s/that that/that/

> to resctrl into a new header file. resctrl code paths touching a 'hw'
> struct indicates where an abstraction is needed.
> 
> No change in behaviour, this patch just moves types around.

Please remove the "this patch" term.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        | 32 +++++++++++-------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++--
>   arch/x86/kernel/cpu/resctrl/internal.h    | 40 +++++------------------
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  8 +++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 ++++++++++------
>   include/linux/resctrl.h                   | 35 +++++++++++++++++++-
>   6 files changed, 94 insertions(+), 60 deletions(-)
> 

...
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index bcae86138cad..f7aab9245259 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -299,44 +299,22 @@ struct mbm_state {
>   };
>   
>   /**
> - * struct rdt_domain - group of cpus sharing an RDT resource
> - * @list:	all instances of this resource
> - * @id:		unique id for this instance
> - * @cpu_mask:	which cpus share this resource
> - * @rmid_busy_llc:
> - *		bitmap of which limbo RMIDs are above threshold
> - * @mbm_total:	saved state for MBM total bandwidth
> - * @mbm_local:	saved state for MBM local bandwidth
> - * @mbm_over:	worker to periodically read MBM h/w counters
> - * @cqm_limbo:	worker to periodically read CQM h/w counters
> - * @mbm_work_cpu:
> - *		worker cpu for MBM h/w counters
> - * @cqm_work_cpu:
> - *		worker cpu for CQM h/w counters
> + * struct rdt_hw_domain - group of cpus sharing an RDT resource

s/RDT/resctrl/?

Even so, looking ahead, struct rdt_hw_domain and struct rdt_domain are 
receiving duplicate descriptions that needs to be adjusted.

Also, CPU is preferred instead of cpu. I understand that in some cases 
you copy existing usage and I am actually not sure if this would be 
insisted upon when going to the next level of review. Since these are 
comments changing it does seem like a good time to use preferred term.

> + * @resctrl:    Properties exposed to the resctrl file system

Please use tabs and spaces consistently.

>    * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
>    * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
> - * @new_ctrl:	new ctrl value to be loaded
> - * @have_new_ctrl: did user provide new_ctrl for this domain
> - * @plr:	pseudo-locked region (if any) associated with domain
>    */
> -struct rdt_domain {
> -	struct list_head		list;
> -	int				id;
> -	struct cpumask			cpu_mask;
> -	unsigned long			*rmid_busy_llc;
> -	struct mbm_state		*mbm_total;
> -	struct mbm_state		*mbm_local;
> -	struct delayed_work		mbm_over;
> -	struct delayed_work		cqm_limbo;
> -	int				mbm_work_cpu;
> -	int				cqm_work_cpu;
> +struct rdt_hw_domain {
> +	struct rdt_domain		resctrl;
>   	u32				*ctrl_val;
>   	u32				*mbps_val;
> -	u32				new_ctrl;
> -	bool				have_new_ctrl;
> -	struct pseudo_lock_region	*plr;
>   };
>   
> +static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> +{
> +	return container_of(r, struct rdt_hw_domain, resctrl);
> +}
> +
>   /**
>    * struct msr_param - set a range of MSRs from a domain
>    * @res:       The resource to use

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b2c2b7386d28..f5af59b8f2a9 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,7 +15,40 @@ int proc_resctrl_show(struct seq_file *m,
>   
>   #endif
>   
> -struct rdt_domain;
> +/**
> + * struct rdt_domain - group of cpus sharing an RDT resource

Duplicate description here (same as rdt_hw_domain). Please use CPUs 
instead and resctrl instead of RDT.

> + * @list:		all instances of this resource
> + * @id:			unique id for this instance
> + * @cpu_mask:		which cpus share this resource
> + * @new_ctrl:		new ctrl value to be loaded
> + * @have_new_ctrl:	did user provide new_ctrl for this domain
> + * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
> + * @mbm_total:		saved state for MBM total bandwidth
> + * @mbm_local:		saved state for MBM local bandwidth
> + * @mbm_over:		worker to periodically read MBM h/w counters
> + * @cqm_limbo:		worker to periodically read CQM h/w counters
> + * @mbm_work_cpu:	worker cpu for MBM h/w counters
> + * @cqm_work_cpu:	worker cpu for CQM h/w counters
> + * @plr:		pseudo-locked region (if any) associated with domain
> + */

The above usages of cpu is what I considered earlier. I know that the 
x86 area prefers CPU but I also understand that you are just copying 
existing comments. I do not know if the x86 maintainers would require a 
change to CPU at this time but it seems like a good time to transition.

> +struct rdt_domain {
> +	struct list_head		list;
> +	int				id;
> +	struct cpumask			cpu_mask;
> +
> +	u32				new_ctrl;
> +	bool				have_new_ctrl;
> +
> +	unsigned long			*rmid_busy_llc;
> +	struct mbm_state		*mbm_total;
> +	struct mbm_state		*mbm_local;
> +	struct delayed_work		mbm_over;
> +	struct delayed_work		cqm_limbo;
> +	int				mbm_work_cpu;
> +	int				cqm_work_cpu;
> +
> +	struct pseudo_lock_region	*plr;
> +};
>   

Please remove the empty lines.

>   /**
>    * struct resctrl_cache - Cache allocation related data
> 

Reinette
