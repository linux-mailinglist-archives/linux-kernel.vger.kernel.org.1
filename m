Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A82B71FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgKQXLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:11:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:32122 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKQXLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:11:23 -0500
IronPort-SDR: d2k06afAQHYlUatZ78j9ITqA81Rbyz7kXd4RpFVdEtasjYmb5c+CDI/FKyQA1n0A5rHw4Nmynq
 35UcR4cLFI7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="232644976"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="232644976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:11:22 -0800
IronPort-SDR: UPCBrw9Tcn8BFG9ICLlXNq//adbTskYIKSWl1ilK9tY37MF9hjwPulGOHA6t06/6OaJVvBfrgn
 Jycu2zjKM0LA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430615596"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:11:22 -0800
Subject: Re: [PATCH 10/24] x86/resctrl: Move the schema names into struct
 resctrl_schema
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <30449b04-c5c8-9790-f36f-5843efdd2924@intel.com>
Date:   Tue, 17 Nov 2020 15:11:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-11-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> Move the names used for the schemata file out of the resource and
> into struct resctrl_schema. This allows one resource to have two
> different names, based on the other schema properties.
> 
> This patch copies the names, eventually resctrl will generate them.

Please remove "This patch".

> 
> Remove the arch code's max_name_width, this is now resctrl's
> problem.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        |  9 ++-------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 +++-------
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 17 ++++++++++++-----
>   include/linux/resctrl.h                   |  7 +++++++
>   5 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1ed5e04031e6..cda071009fed 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -37,10 +37,10 @@ DEFINE_MUTEX(rdtgroup_mutex);
>   DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>   
>   /*
> - * Used to store the max resource name width and max resource data width
> + * Used to store the max resource data width
>    * to display the schemata in a tabular format
>    */
> -int max_name_width, max_data_width;
> +int max_data_width;
>   
>   /*
>    * Global boolean for rdt_alloc which is true if any
> @@ -776,13 +776,8 @@ static int resctrl_offline_cpu(unsigned int cpu)
>   static __init void rdt_init_padding(void)
>   {
>   	struct rdt_resource *r;
> -	int cl;
>   
>   	for_each_alloc_capable_rdt_resource(r) {
> -		cl = strlen(r->name);
> -		if (cl > max_name_width)
> -			max_name_width = cl;
> -
>   		if (r->data_width > max_data_width)
>   			max_data_width = r->data_width;
>   	}

The original code determines the maximum width based on resources 
supported by the platform.

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index a65ff53394ed..28d69c78c29e 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c

...

> @@ -391,7 +389,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   	bool sep = false;
>   	u32 ctrl_val;
>   
> -	seq_printf(s, "%*s:", max_name_width, r->name);
> +	seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);

 From what I understand this changes what some users will see. In the 
original code the "max_name_width" is computed based on the maximum 
length of resources supported. Systems that only support MBA would thus 
show a schemata of:

MB:0=100;1=100

I expect the above change would change the output to:
     MB:0=100;1=100


>   	list_for_each_entry(dom, &r->domains, list) {
>   		hw_dom = resctrl_to_arch_dom(dom);
>   		if (sep)

...


> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8a12f4128209..9f71f0238239 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,6 +15,11 @@ int proc_resctrl_show(struct seq_file *m,
>   
>   #endif
>   
> +/*
> + * The longest name we expect in the schemata file:
> + */
> +#define RESCTRL_NAME_LEN	7
> +
>   enum resctrl_conf_type {
>   	CDP_BOTH,
>   	CDP_CODE,
> @@ -172,12 +177,14 @@ struct rdt_resource {
>   
>   /**
>    * @list:	Member of resctrl's schema list
> + * @names:	Name to use in "schemata" file

s/names/name/?

>    * @conf_type:	Type of configuration, e.g. code/data/both
>    * @res:	The rdt_resource for this entry
>    * @num_closid	Number of CLOSIDs available for this resource
>    */
>   struct resctrl_schema {
>   	struct list_head		list;
> +	char				name[RESCTRL_NAME_LEN];
>   	enum resctrl_conf_type		conf_type;
>   	struct rdt_resource		*res;
>   	u32				num_closid;
> 


Reinette
