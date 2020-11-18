Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033172B7317
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKRAam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:30:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:7538 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgKRAal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:30:41 -0500
IronPort-SDR: 8si6jNRDXW/EVmhsdNLhIML8FIrMohEfLX6I03H/hFy++4WRo2VbIZgX/SFAeg3uSxjtDSnPmJ
 Vm6ZjGXEao1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="170258450"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="170258450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 16:30:41 -0800
IronPort-SDR: kFsvdTRSAFqEqW+3jOWemOd7pgEgabtsuUuzRfStdMjfx5gCYhgUj5QGnfyuxrA//cAhHUOEET
 nWZKBjx5Aw3g==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430630808"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 16:30:40 -0800
Subject: Re: [PATCH 13/24] x86/resctrl: Allow different CODE/DATA
 configurations to be staged
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <020e9787-68a2-5241-360c-71b582de0877@intel.com>
Date:   Tue, 17 Nov 2020 16:30:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-14-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> Now that the configuration is staged via an array, allow resctrl to
> stage more than configuration at a time for a single resource and

s/more than/more than one/ ?

> closid.
> 
> To detect that the same schema is being specified twice when the schemata
> file is written, the same slot in the staged_configuration array must be
> used for each schema. Use the conf_type enum directly as an index.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++++++++------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 +++--
>   include/linux/resctrl.h                   |  4 +++-
>   3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b107c0202cfb..f7152c7fdc1b 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c

...

> @@ -266,10 +269,11 @@ int update_domains(struct rdt_resource *r, int closid)
>   	struct resctrl_staged_config *cfg;
>   	struct rdt_hw_domain *hw_dom;
>   	struct msr_param msr_param;
> +	enum resctrl_conf_type t;
>   	cpumask_var_t cpu_mask;
>   	struct rdt_domain *d;
>   	bool mba_sc;
> -	int cpu, i;
> +	int cpu;
>   
>   	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>   		return -ENOMEM;
> @@ -281,8 +285,8 @@ int update_domains(struct rdt_resource *r, int closid)
>   	mba_sc = is_mba_sc(r);
>   	list_for_each_entry(d, &r->domains, list) {
>   		hw_dom = resctrl_to_arch_dom(d);
> -		for (i = 0; i < ARRAY_SIZE(d->staged_config); i++) {
> -			cfg = &hw_dom->resctrl.staged_config[i];
> +		for (t = 0; t < ARRAY_SIZE(d->staged_config); t++) {

Since t is now an enum, it may be easier to read if NUM_CDP_TYPES is 
used instead of ARRAY_SIZE?

> +			cfg = &hw_dom->resctrl.staged_config[t];
>   			if (!cfg->have_new_ctrl)
>   				continue;
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1092631ac0b3..5eb14dc9c579 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2747,6 +2747,7 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
>   static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
>   				 u32 closid)
>   {
> +	enum resctrl_conf_type t = s-> conf_type;

Extra space above in "s-> conf_type".

>   	struct rdt_resource *r_cdp = NULL;
>   	struct resctrl_staged_config *cfg;
>   	struct rdt_domain *d_cdp = NULL;
> @@ -2758,7 +2759,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
>   	int i;
>   
>   	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
> -	cfg = &d->staged_config[0];
> +	cfg = &d->staged_config[t];
>   	cfg->have_new_ctrl = false;
>   	cfg->new_ctrl = r->cache.shareable_bits;
>   	used_b = r->cache.shareable_bits;
> @@ -2843,7 +2844,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>   	struct rdt_domain *d;
>   
>   	list_for_each_entry(d, &r->domains, list) {
> -		cfg = &d->staged_config[0];
> +		cfg = &d->staged_config[CDP_BOTH];
>   		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
>   		cfg->closid = closid;
>   		cfg->have_new_ctrl = true;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 695247c08ba3..e33d6dfce8a1 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -25,6 +25,8 @@ enum resctrl_conf_type {
>   	CDP_CODE,
>   	CDP_DATA,
>   };
> +#define NUM_CDP_TYPES	CDP_DATA + 1
> +

There is also the option of making NUM_CDP_TYPES the last member of 
resctrl_conf_type ... and changing its name to CDP_NUM_TYPES to be 
consistent with similar usages (RDT_NUM_GROUP, RDT_NUM_MODES, 
RDT_NUM_RESOURCES)? The problem then is that you need to handle it in 
the switch statement. If you choose to keep this way then please change 
the name to be consistent with the other enums, add an empty line after 
the enum to make checkpatch happy, and add parenthesis around its value.

>   
>   /**
>    * struct resctrl_staged_config - parsed configuration to be applied
> @@ -67,7 +69,7 @@ struct rdt_domain {
>   	int				cqm_work_cpu;
>   
>   	struct pseudo_lock_region	*plr;
> -	struct resctrl_staged_config	staged_config[1];
> +	struct resctrl_staged_config	staged_config[NUM_CDP_TYPES];
>   };
>   
>   /**
> 


Reinette
