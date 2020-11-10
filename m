Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B180B2AD574
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgKJLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbgKJLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:39:25 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:39:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so8395452wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cxwsKAS7f0ShqVjeBwSt/htKkV68dkqRsu7im58l3Po=;
        b=d/67jq+OobHpQoRDIk+13Pq/a3N2zGHrz03c8CBQNHfxLX/FS4lfxl1Lf31Oa0IcmH
         3orlTYtfeu2ULBDLT8rMcNmZlSVbeLwAtPUfv8nMEJXAd+pINIKT8Hw4JmyfUAA8bUqn
         Kjg47txxhhtYrFAu4+eM5vM9yH/QjyHD/SkW96kNfQ3IlYjlz79a8cDbXfX7gCHX1PDJ
         gD3ZM+j+iea7A4QWpDxR2wbURPMMt5gSqCI0WkBXEH8yE9mb59zzXey8oMrnT+8RYMfT
         Cru3fLOPat5ZWyjTOsSOz8l25FdMegi5wnrGYKgPYKc9npqbb3vZbqJ/tFep7RLmxpNk
         gtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxwsKAS7f0ShqVjeBwSt/htKkV68dkqRsu7im58l3Po=;
        b=OELnJYpX1cljBqimX6E8+n5/K3fWPfphkJeX/Gj+AAFa65sMDtVzusqFh5UP1UkpyO
         vMTL77wW5POPLEhFOs5fi9bcf3je6aZ7z5IaRSXhHIcEUexPlSzrLNgyU/MIZooFDcvQ
         DCV7wWg/OWk4/3raS+cDkCfHEXxOz5RN4+VpUlni/AdPnBwPJf0UwFCbqOQz4PqeFh1i
         VkCJfpBQpX1bwOHodL6rIAlhbopdovFRNYJaoiz48k/NDMajg63xmKa5SY5MEGPpv61u
         MGSC/GhmvXM2SpOVAgeMnHN5++thLqawlbvh57aarLEp3Yg7fkecSv0QAMtRC7MVFWBM
         Nlxw==
X-Gm-Message-State: AOAM53015Gm1n4EieEdz3tlwo3zUYnW03tXbgWrNirMko05CmM0MnyZh
        4Vr8jovRDKNwfvxQ4voqrXi92w==
X-Google-Smtp-Source: ABdhPJwUoSY+QbRHzXs+BScMDnFxyyzVu+Vq6KWbSmQSF/skWxaeOYsSEXAD2UMTH6dD0pv59Ztoig==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr22865837wrc.74.1605008363482;
        Tue, 10 Nov 2020 03:39:23 -0800 (PST)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id b1sm2755521wmd.43.2020.11.10.03.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 03:39:22 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:39:22 +0000
From:   Jamie Iles <jamie@nuviainc.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
Subject: Re: [PATCH 10/24] x86/resctrl: Move the schema names into struct
 resctrl_schema
Message-ID: <20201110113922.GA94467@poplar>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-11-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030161120.227225-11-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Oct 30, 2020 at 04:11:06PM +0000, James Morse wrote:
> Move the names used for the schemata file out of the resource and
> into struct resctrl_schema. This allows one resource to have two
> different names, based on the other schema properties.
> 
> This patch copies the names, eventually resctrl will generate them.
> 
> Remove the arch code's max_name_width, this is now resctrl's
> problem.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  9 ++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 +++-------
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 17 ++++++++++++-----
>  include/linux/resctrl.h                   |  7 +++++++
>  5 files changed, 25 insertions(+), 20 deletions(-)
...
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 27671a654f8b..5294ae0c3ed9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -248,7 +248,7 @@ struct rdtgroup {
>  /* List of all resource groups */
>  extern struct list_head rdt_all_groups;
>  
> -extern int max_name_width, max_data_width;
> +extern int max_data_width;
>  
>  int __init rdtgroup_init(void);
>  void __exit rdtgroup_exit(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 311a3890bc53..48f4d6783647 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1440,8 +1440,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  			rdt_last_cmd_puts("Cache domain offline\n");
>  			ret = -ENODEV;
>  		} else {
> -			seq_printf(s, "%*s:", max_name_width,
> -				   rdtgrp->plr->s->res->name);
> +			seq_printf(s, "%*s:", RESCTRL_NAME_LEN,
> +				   rdtgrp->plr->s->name);
>  			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
>  						    rdtgrp->plr->d,
>  						    rdtgrp->plr->cbm);
> @@ -1454,7 +1454,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  		r = schema->res;
>  
>  		sep = false;
> -		seq_printf(s, "%*s:", max_name_width, r->name);
> +		seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);
>  		list_for_each_entry(d, &r->domains, list) {
>  			hw_dom = resctrl_to_arch_dom(d);
>  			if (sep)
> @@ -1827,7 +1827,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  	list_for_each_entry(s, &resctrl_all_schema, list) {
>  		r = s->res;
>  		fflags =  r->fflags | RF_CTRL_INFO;
> -		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
> +		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
>  		if (ret)
>  			goto out_destroy;
>  	}
> @@ -2140,6 +2140,7 @@ static int create_schemata_list(void)
>  {
>  	struct resctrl_schema *s;
>  	struct rdt_resource *r;
> +	int ret;
>  
>  	for_each_alloc_enabled_rdt_resource(r) {
>  		s = kzalloc(sizeof(*s), GFP_KERNEL);
> @@ -2150,6 +2151,12 @@ static int create_schemata_list(void)
>  		s->num_closid = resctrl_arch_get_num_closid(r);
>  		s->conf_type = resctrl_to_arch_res(r)->conf_type;
>  
> +		ret = snprintf(s->name, sizeof(s->name), r->name);
> +		if (ret >= sizeof(s->name)) {
> +			kfree(s);
> +			return -EINVAL;
> +		}
> +

How about:

+		ret = strscpy(s->name, r->name, sizeof(s->name));
+		if (ret < 0)) {
+			kfree(s);
+			return -EINVAL;
+		}

So that there isn't a non-constant format specifier that'll trip 
Coverity+friends up later?

Thanks,

Jamie
