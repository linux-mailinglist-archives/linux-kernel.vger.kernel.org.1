Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77E2B729E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgKQXqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:46:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:21473 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgKQXqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:46:52 -0500
IronPort-SDR: 9lLT9mhhy6OvdRRt0n87B/YdGOB/e759P8YZAmpRHrQ7j4UV8qI4x6MlfbOH9vTJycg9LvY/FA
 F6tE9wZQ6U7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171204621"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171204621"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:46:51 -0800
IronPort-SDR: dPoE8Mry3EOZlB76A95Qt4lS1JkP8PSz9zr3glyzFDYL7slqMLMhMBWXuiEp0mDwCGVqol7zsg
 e4CSGHK9HT9g==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430622167"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:46:50 -0800
Subject: Re: [PATCH 12/24] x86/resctrl: Add closid to the staged config
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <136b0a82-7d77-dc08-80ca-5265d4af30fd@intel.com>
Date:   Tue, 17 Nov 2020 15:46:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-13-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> Once the L2/L2CODE/L2DATA resources are merged, there may be two
> configurations staged for one resource when CDP is enabled. The
> closid should always be passed with the type of configuration to the
> arch code.
> 
> Because update_domains() will eventually apply a set of configurations,
> it should take the closid from the same place, so they pair up.
> 
> Move the closid to be a staged parameter.

Move implies that it is taken from one location and added to another. 
This seems like a copy instead?

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++++--
>   include/linux/resctrl.h                   |  2 ++
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 0c95ed83eb05..b107c0202cfb 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -72,6 +72,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   	if (!bw_validate(data->buf, &bw_val, r))
>   		return -EINVAL;
>   	cfg->new_ctrl = bw_val;
> +	cfg->closid = data->rdtgrp->closid;
>   	cfg->have_new_ctrl = true;
>   
>   	return 0;
> @@ -178,6 +179,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>   	}
>   
>   	cfg->new_ctrl = cbm_val;
> +	cfg->closid = data->rdtgrp->closid;
>   	cfg->have_new_ctrl = true;
>   

rdtgrp is already available so it could just be:
cfg->closid = rdtgrp->closid?

>   	return 0;
> @@ -245,15 +247,15 @@ static int parse_line(char *line, struct resctrl_schema *s,
>   }
>   
>   static void apply_config(struct rdt_hw_domain *hw_dom,
> -			 struct resctrl_staged_config *cfg, int closid,
> +			 struct resctrl_staged_config *cfg,
>   			 cpumask_var_t cpu_mask, bool mba_sc)
>   {
>   	struct rdt_domain *dom = &hw_dom->resctrl;
>   	u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
>   
> -	if (cfg->new_ctrl != dc[closid]) {
> +	if (cfg->new_ctrl != dc[cfg->closid]) {
>   		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
> -		dc[closid] = cfg->new_ctrl;
> +		dc[cfg->closid] = cfg->new_ctrl;
>   	}
>   
>   	cfg->have_new_ctrl = false;
> @@ -284,7 +286,7 @@ int update_domains(struct rdt_resource *r, int closid)
>   			if (!cfg->have_new_ctrl)
>   				continue;
>   
> -			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
> +			apply_config(hw_dom, cfg, cpu_mask, mba_sc);
>   		}
>   	}

It is not clear to me that storing the closid in the staged config is 
necessary. A closid is associated with a resource group so when the user 
writes to the schemata file all configurations would be (from the 
resource group perspective) for the same closid. This is the value 
provided here to update domains. Looking ahead in this series this 
closid is later used to compute the index (get_config_index()) that 
would use as input cfg->closid, but that cfg->closid would be identical 
for all resources/staged configs and then the new index would be 
computed based on the resource type. Having the closid in the staged 
config thus does not seem to be necessary, it could remain as this 
function parameter and be used for all staged configs?

>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f1164bbb66c5..695247c08ba3 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -28,10 +28,12 @@ enum resctrl_conf_type {
>   
>   /**
>    * struct resctrl_staged_config - parsed configuration to be applied
> + * @closid:		The closid the new configuration applies to

Please be consistent on how descriptions are started with or without 
capital letters.

>    * @new_ctrl:		new ctrl value to be loaded
>    * @have_new_ctrl:	did user provide new_ctrl for this domain
>    */
>   struct resctrl_staged_config {
> +	u32			closid;
>   	u32			new_ctrl;
>   	bool			have_new_ctrl;
>   };
> 

Reinette
