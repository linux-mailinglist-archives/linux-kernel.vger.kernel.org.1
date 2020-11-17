Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629F52B6F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgKQT5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:17421 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgKQT5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:17 -0500
IronPort-SDR: Zd72MtliA27wpIOaH+3219c6sRfsjWpfQsjv5Fn39l4ZxjTgvAshE0UnjjtQoODACuwoSsVRuN
 nypBdKP6n/uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="232614297"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="232614297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:14 -0800
IronPort-SDR: EEfAP5uPnsEiAZODd9IHKaEYN2jvTzg4ndBD6D0VqiHyzEMs2hiMa6mGP8XaMWRiz+HEBmeoGM
 ye+MRz0XH1Ow==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430576843"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:13 -0800
Subject: Re: [PATCH 03/24] x86/resctrl: Add resctrl_arch_get_num_closid()
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0d34167f-17b6-61f8-aa3e-7d49747ca95a@intel.com>
Date:   Tue, 17 Nov 2020 11:57:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-4-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:10 AM, James Morse wrote:
> resctrl chooses whether to enable CDP, once it does, half the number
> of closid are available. MPAM doesn't behave like this, an in-kernel user
> of MPAM could be 'using CDP' while resctrl is not.
> 
> To move the 'half the closids' behaviour to be part of the core code,
> each schema would have a num_closids. This may be different from the
> single resources num_closid if CDP is in use.
> 
> Add a helper to read the resource's num_closid, this should return the
> number of closid that the resource supports, regardless of whether CDP
> is in use.
> 
> For now return the hw_res->num_closid, which is already adjusted for CDP.
> Once the CODE/DATA/BOTH resources are merged, resctrl can make the
> adjustment when copying the value to the schema's num_closid.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        |  5 +++++
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  9 +++------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++---------
>   include/linux/resctrl.h                   |  3 +++
>   4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 97040a54cc9a..5d5b566c4359 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -443,6 +443,11 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>   	return NULL;
>   }
>   
> +u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
> +{
> +	return resctrl_to_arch_res(r)->num_closid;
> +}
> +

Helper returns the value but also changes the type. Could you please add 
motivation for this in a comment?


>   void rdt_ctrl_update(void *arg)
>   {
>   	struct msr_param *m = arg;
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 2e7466659af3..14ea6a40993f 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -286,12 +286,11 @@ int update_domains(struct rdt_resource *r, int closid)
>   static int rdtgroup_parse_resource(char *resname, char *tok,
>   				   struct rdtgroup *rdtgrp)
>   {
> -	struct rdt_hw_resource *hw_res;
>   	struct rdt_resource *r;
>   
>   	for_each_alloc_enabled_rdt_resource(r) {
> -		hw_res = resctrl_to_arch_res(r);
> -		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
> +		if (!strcmp(resname, r->name) &&
> +		     rdtgrp->closid < resctrl_arch_get_num_closid(r))

Please let alignment match open parenthesis.

>   			return parse_line(tok, r, rdtgrp);
>   	}
>   	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
> @@ -400,7 +399,6 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
>   int rdtgroup_schemata_show(struct kernfs_open_file *of,
>   			   struct seq_file *s, void *v)
>   {
> -	struct rdt_hw_resource *hw_res;
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_resource *r;
>   	int ret = 0;
> @@ -425,8 +423,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>   		} else {
>   			closid = rdtgrp->closid;
>   			for_each_alloc_enabled_rdt_resource(r) {
> -				hw_res = resctrl_to_arch_res(r);
> -				if (closid < hw_res->num_closid)
> +				if (closid < resctrl_arch_get_num_closid(r))
>   					show_doms(s, r, closid);
>   			}
>   		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b55861ff4e34..df10135f021e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -100,15 +100,13 @@ int closids_supported(void)
>   
>   static void closid_init(void)
>   {
> -	struct rdt_hw_resource *hw_res;
> +	u32 rdt_min_closid = 32;
>   	struct rdt_resource *r;
> -	int rdt_min_closid = 32;
>   
>   	/* Compute rdt_min_closid across all resources */
> -	for_each_alloc_enabled_rdt_resource(r) {
> -		hw_res = resctrl_to_arch_res(r);
> -		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
> -	}
> +	for_each_alloc_enabled_rdt_resource(r)
> +		rdt_min_closid = min(rdt_min_closid,
> +				     resctrl_arch_get_num_closid(r));
>   
>   	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>   
> @@ -847,10 +845,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
>   				struct seq_file *seq, void *v)
>   {
>   	struct rdt_resource *r = of->kn->parent->priv;
> -	struct rdt_hw_resource *hw_res;
>   
> -	hw_res = resctrl_to_arch_res(r);
> -	seq_printf(seq, "%d\n", hw_res->num_closid);
> +	seq_printf(seq, "%d\n", resctrl_arch_get_num_closid(r));
>   	return 0;

Now that this type is changed this will need to be %u?

>   }
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f5af59b8f2a9..dfb0f32b73a1 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -163,4 +163,7 @@ struct rdt_resource {
>   
>   };
>   
> +/* The number of closid supported by this resource regardless of CDP */
> +u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
> +
>   #endif /* _RESCTRL_H */
> 


The purpose of this change is unclear and introducing confusion. It 
introduces a helper that returns the num_closid associated with a 
resource but it does not use the helper in all the cases where this 
value is needed. After this change some code uses this new helper while 
other code continue to access the value directly.

Could you please elaborate in the commit message why this helper is not 
used everywhere and how the places that were changed were chosen? Seems 
like the places that _don't_ need the (eventual) value of 
resctrl_arch_get_num_closid() are changed (so that it is easier to move 
to the schema's num_closid later) while the places that actually do need 
the helper are not changed?

Reinette
