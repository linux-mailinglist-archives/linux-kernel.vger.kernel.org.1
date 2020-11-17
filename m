Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4982B7268
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKQX3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:29:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:64716 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKQX27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:28:59 -0500
IronPort-SDR: 0YHpqjGFDPM/TTFqyvVGK4726H3E12qQ9S1P0PU/nQDJdZkwQxM6QSgRBEGm6ifMx05UMAPCTf
 NP1mjfQ+oajQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150301990"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150301990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:28:59 -0800
IronPort-SDR: ah5dh/LTZZz6W9ZTKidE+bnS6QmsgOIMMDjQ/3sOQLNX6KpayiUUez3N5NoLhMzc4HnnZx1Nyt
 Z2hr4oKLwAXg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430618313"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:28:58 -0800
Subject: Re: [PATCH 11/24] x86/resctrl: Group staged configuration into a
 separate struct
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-12-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <28586ec7-608f-4857-19f9-f9a9d5c927f5@intel.com>
Date:   Tue, 17 Nov 2020 15:28:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-12-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> Arm's MPAM may have surprisingly large bitmaps for its cache
> portions as the architecture allows up to 4K portions. The size
> exposed via resctrl may not be the same, some scaling may
> occur.
> 
> The values written to hardware may be unlike the values received
> from resctrl, e.g. MBA percentages may be backed by a bitmap,
> or a maximum value that isn't a percentage.
> 
> Today resctrl's ctrlval arrays are written to directly by the

If using a cryptic word like "ctrlval" it would be easier to understand 
what is meant if it matches the variable in the code, "ctrl_val".

> resctrl filesystem code. e.g. apply_config(). This is a problem

This sentence starts with "Today" implying what code does before this 
change but the example function, apply_config() is introduced in this patch.

> if scaling or conversion is needed by the architecture.
> 
> The arch code should own the ctrlval array (to allow scaling and
> conversion), and should only need a single copy of the array for the
> values currently applied in hardware.

ok, but that is the case, no?

> 
> Move the new_ctrl bitmap value and flag into a struct for staged
> configuration changes. This is created as an array to allow one per type

This is a bit cryptic as the reader may not know while reading this 
commit message what "new_ctrl" is or where it is currently hosted.

> of configuration. Today there is only one element in the array, but
> eventually resctrl will use the array slots for CODE/DATA/BOTH to detect
> a duplicate schema being written.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 49 ++++++++++++++++-------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 22 +++++-----
>   include/linux/resctrl.h                   | 17 +++++---
>   3 files changed, 60 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 28d69c78c29e..0c95ed83eb05 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c

...

> @@ -240,15 +244,30 @@ static int parse_line(char *line, struct resctrl_schema *s,
>   	return -EINVAL;
>   }
>   
> +static void apply_config(struct rdt_hw_domain *hw_dom,
> +			 struct resctrl_staged_config *cfg, int closid,
> +			 cpumask_var_t cpu_mask, bool mba_sc)
> +{
> +	struct rdt_domain *dom = &hw_dom->resctrl;
> +	u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
> +
> +	if (cfg->new_ctrl != dc[closid]) {
> +		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
> +		dc[closid] = cfg->new_ctrl;
> +	}
> +
> +	cfg->have_new_ctrl = false;

Why is this necessary?

> +}
> +
>   int update_domains(struct rdt_resource *r, int closid)
>   {
> +	struct resctrl_staged_config *cfg;
>   	struct rdt_hw_domain *hw_dom;
>   	struct msr_param msr_param;
>   	cpumask_var_t cpu_mask;
>   	struct rdt_domain *d;
>   	bool mba_sc;
> -	u32 *dc;
> -	int cpu;
> +	int cpu, i;
>   
>   	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>   		return -ENOMEM;
> @@ -260,10 +279,12 @@ int update_domains(struct rdt_resource *r, int closid)
>   	mba_sc = is_mba_sc(r);
>   	list_for_each_entry(d, &r->domains, list) {
>   		hw_dom = resctrl_to_arch_dom(d);
> -		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
> -		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
> -			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> -			dc[closid] = d->new_ctrl;
> +		for (i = 0; i < ARRAY_SIZE(d->staged_config); i++) {

I understand it may make later patches easier but it seems too early to 
introduce this loop because apply_config() does not seem to be ready for 
it yet (it would just keep overwriting a closid's config).

> +			cfg = &hw_dom->resctrl.staged_config[i];
> +			if (!cfg->have_new_ctrl)
> +				continue;
> +
> +			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
>   		}
>   	}
>   
> @@ -338,7 +359,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   
>   	list_for_each_entry(s, &resctrl_all_schema, list) {
>   		list_for_each_entry(dom, &s->res->domains, list)
> -			dom->have_new_ctrl = false;
> +			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>   	}
>   
>   	while ((tok = strsep(&buf, "\n")) != NULL) {

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 9f71f0238239..f1164bbb66c5 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -26,13 +26,21 @@ enum resctrl_conf_type {
>   	CDP_DATA,
>   };
>   
> +/**
> + * struct resctrl_staged_config - parsed configuration to be applied
> + * @new_ctrl:		new ctrl value to be loaded
> + * @have_new_ctrl:	did user provide new_ctrl for this domain

The "for this domain" in this description is no longer appropriate after 
the copy.

> + */
> +struct resctrl_staged_config {
> +	u32			new_ctrl;
> +	bool			have_new_ctrl;
> +};
> +
>   /**
>    * struct rdt_domain - group of cpus sharing an RDT resource
>    * @list:		all instances of this resource
>    * @id:			unique id for this instance
>    * @cpu_mask:		which cpus share this resource
> - * @new_ctrl:		new ctrl value to be loaded
> - * @have_new_ctrl:	did user provide new_ctrl for this domain
>    * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
>    * @mbm_total:		saved state for MBM total bandwidth
>    * @mbm_local:		saved state for MBM local bandwidth
> @@ -41,15 +49,13 @@ enum resctrl_conf_type {
>    * @mbm_work_cpu:	worker cpu for MBM h/w counters
>    * @cqm_work_cpu:	worker cpu for CQM h/w counters
>    * @plr:		pseudo-locked region (if any) associated with domain
> + * @staged_config:	parsed configuration to be applied
>    */
>   struct rdt_domain {
>   	struct list_head		list;
>   	int				id;
>   	struct cpumask			cpu_mask;
>   
> -	u32				new_ctrl;
> -	bool				have_new_ctrl;
> -
>   	unsigned long			*rmid_busy_llc;
>   	struct mbm_state		*mbm_total;
>   	struct mbm_state		*mbm_local;
> @@ -59,6 +65,7 @@ struct rdt_domain {
>   	int				cqm_work_cpu;
>   
>   	struct pseudo_lock_region	*plr;
> +	struct resctrl_staged_config	staged_config[1];
>   };
>   
>   /**
> 

Reinette
