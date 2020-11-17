Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875412B70EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgKQV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:29:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:24731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQV30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:29:26 -0500
IronPort-SDR: SVcTRADv1jDA2qoJNpBNT6CaAUAoNzPa8UgVak9ErXD5gMkCrwEsIseQ1wbRD/mYzPdeB33BUs
 1cvTSpFjPfEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="232630721"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="232630721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:29:23 -0800
IronPort-SDR: TJ622ACXLdJWhNiKnnEsJ7IV9zVGj3dQ/KaLheykUX6+SVxN44Y5znYezx9T1jS0Qr7hSEGZAA
 ZxQl4qZhdmYA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430594946"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:29:22 -0800
Subject: Re: [PATCH 04/24] x86/resctrl: Add a separate schema list for resctrl
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-5-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <8c95f0d5-c543-a5bf-b3b6-df5c7a6f6c3c@intel.com>
Date:   Tue, 17 Nov 2020 13:29:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-5-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> To support multiple architectures, the resctrl code needs to be split
> into a 'fs' specific part in core code, and an arch-specific backend.
> 
> It should be difficult for the arch-specific backends to diverge,
> supporting slightly different ABIs for user-space. For example,
> generating, parsing and validating the schema configuration values
> should be done in what becomes the core code to prevent divergence.
> Today, the schema emerge from which entries in the rdt_resources_all
> array the arch code has chosen to enable.
> 
> Start by creating a struct resctrl_schema, which will eventually hold
> the name and pending configuration values for resctrl.

Looking ahead I am not able to identify the "pending configuration 
values" that will eventually be held in resctrl_schema. With entire 
series applied there is the name, type, num_closid, and pointer to the 
resource.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 43 +++++++++++++++++++++++++-
>   include/linux/resctrl.h                |  9 ++++++
>   3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index f7aab9245259..682e84aebd14 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -106,6 +106,7 @@ extern unsigned int resctrl_cqm_threshold;
>   extern bool rdt_alloc_capable;
>   extern bool rdt_mon_capable;
>   extern unsigned int rdt_mon_features;
> +extern struct list_head resctrl_all_schema;

Considering the relationship with rdt_resources_all it seems more 
consistent to call it resctrl_schema_all?

>   
>   enum rdt_group_type {
>   	RDTCTRL_GROUP = 0,
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index df10135f021e..f79a5e548138 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -39,6 +39,9 @@ static struct kernfs_root *rdt_root;
>   struct rdtgroup rdtgroup_default;
>   LIST_HEAD(rdt_all_groups);
>   
> +/* list of entries for the schemata file */
> +LIST_HEAD(resctrl_all_schema);
> +
>   /* Kernel fs node for "info" directory under root */
>   static struct kernfs_node *kn_info;
>   
> @@ -2117,6 +2120,35 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   	return ret;
>   }
>   
> +static int create_schemata_list(void)
> +{

Could you please use the new namespace (schema_list_) as a prefix 
instead of suffix? That will make it easier to search.

> +	struct resctrl_schema *s;
> +	struct rdt_resource *r;
> +
> +	for_each_alloc_enabled_rdt_resource(r) {
> +		s = kzalloc(sizeof(*s), GFP_KERNEL);
> +		if (!s)
> +			return -ENOMEM;
> +
> +		s->res = r;
> +
> +		INIT_LIST_HEAD(&s->list);
> +		list_add(&s->list, &resctrl_all_schema);
> +	}
> +
> +	return 0;
> +}
> +
> +static void destroy_schemata_list(void)
> +{
> +	struct resctrl_schema *s, *tmp;
> +
> +	list_for_each_entry_safe(s, tmp, &resctrl_all_schema, list) {
> +		list_del(&s->list);
> +		kfree(s);
> +	}
> +}
> +
>   static int rdt_get_tree(struct fs_context *fc)
>   {
>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index dfb0f32b73a1..de6cbc725753 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -163,6 +163,15 @@ struct rdt_resource {
>   
>   };
>   
> +/**

Missing a kernel-doc description here

> + * @list:	Member of resctrl's schema list
> + * @res:	The rdt_resource for this entry
> + */
> +struct resctrl_schema {
> +	struct list_head		list;
> +	struct rdt_resource		*res;
> +};
> +
>   /* The number of closid supported by this resource regardless of CDP */
>   u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>   
> 

Reinette
