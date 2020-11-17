Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709FB2B7198
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgKQWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:30:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:28550 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgKQWaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:30:15 -0500
IronPort-SDR: 3a0cFuXdo+sc2YNW3y2XF7A20ZitU9JxLRI8b1Oq/4L+5eYs5LTSuLmYukcNz6UZeOJYw7LGaI
 NPzeDqUjKOog==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171122266"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171122266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:30:14 -0800
IronPort-SDR: C9yolD4gKeJ2G5zpjKFCqjYNa7Lrq0O4qpCrC4CDGP8+zTmBHsAXa7INbkSBU9TI7JAo4qj0K4
 bP8cxwR3ZmZg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430607336"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:30:13 -0800
Subject: Re: [PATCH 07/24] x86/resctrl: Label the resources with their
 configuration type
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <2de84538-9741-c902-9be0-5b279bbe162f@intel.com>
Date:   Tue, 17 Nov 2020 14:30:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-8-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> Before the name for the schema can be generated, the type of the
> configuration being applied to the resource needs to be known. Label
> all the entries in rdt_resources_all[], and copy that value in to struct

s/in to/into/ or s/in to/to/ ?

> resctrl_schema.
> 

This commit message does not explain why it is needed to copy this value.

> Subsequent patches will generate the schema names in what will become
> the fs code. Eventually the fs code will generate pairs of CODE/DATA if
> the platform supports CDP for this resource.

Explaining how the copy is a step towards accomplishing this goal would 
be very helpful.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     | 7 +++++++
>   arch/x86/kernel/cpu/resctrl/internal.h | 1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 +
>   include/linux/resctrl.h                | 8 ++++++++
>   4 files changed, 17 insertions(+)
> 


> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 682e84aebd14..6c87a81946b1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -367,6 +367,7 @@ struct rdt_parse_data {
>    * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
>    */
>   struct rdt_hw_resource {
> +	enum resctrl_conf_type	conf_type;
>   	struct rdt_resource     resctrl;
>   

Missing an accompanying kernel-doc entry?

>   	int			num_closid;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1bd785b1920c..628e5eb4d7a9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2141,6 +2141,7 @@ static int create_schemata_list(void)
>   
>   		s->res = r;
>   		s->num_closid = resctrl_arch_get_num_closid(r);

Above seems to be last user of this helper remaining ... why is helper 
needed instead of something similar to below?

> +		s->conf_type = resctrl_to_arch_res(r)->conf_type;
>   
>   		INIT_LIST_HEAD(&s->list);
>   		list_add(&s->list, &resctrl_all_schema);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b32152968bca..20d8b6dd4af4 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,6 +15,12 @@ int proc_resctrl_show(struct seq_file *m,
>   
>   #endif
>   
> +enum resctrl_conf_type {
> +	CDP_BOTH,
> +	CDP_CODE,
> +	CDP_DATA,
> +};
> +
>   /**
>    * struct rdt_domain - group of cpus sharing an RDT resource
>    * @list:		all instances of this resource
> @@ -165,11 +171,13 @@ struct rdt_resource {
>   
>   /**
>    * @list:	Member of resctrl's schema list
> + * @cdp_type:	Whether this entry is for code/data/both

Typo? This is fixed in the next patch so that hunk could be merged here.

>    * @res:	The rdt_resource for this entry
>    * @num_closid	Number of CLOSIDs available for this resource
>    */
>   struct resctrl_schema {
>   	struct list_head		list;
> +	enum resctrl_conf_type		conf_type;
>   	struct rdt_resource		*res;
>   	u32				num_closid;
>   };
> 

Reinette
