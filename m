Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874212B7117
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgKQVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:49:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:13199 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:49:59 -0500
IronPort-SDR: HkV4DXCwNGLeYbS1lFtBk+kf4yNqabEDRRU8qeHni02Zxs+aDer54qRbBdQ9QWJzmNdLdD6kq6
 4FonDhL62O7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171188739"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171188739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:49:58 -0800
IronPort-SDR: MUd20WUGZZeJjp6AuhQpcd3n/IobUluRO429CzN5vARY7hVDAGJbFVnFP7PVyQJ244X9Cgx27A
 n94xsVh9qW3w==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430599755"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:49:57 -0800
Subject: Re: [PATCH 05/24] x86/resctrl: Pass the schema in resdir's private
 pointer
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f2726df3-a694-3265-16e3-057f8b7e2d92@intel.com>
Date:   Tue, 17 Nov 2020 13:49:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-6-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

It is not clear what "resdir" mentioned in subject line refers to. Could 
it be changed to "info dir"?


On 10/30/2020 9:11 AM, James Morse wrote:
> Moving properties that resctrl exposes to user-space into the core
> 'fs' code, (e.g. the name of the schema), means some of the functions
> that back the filesystem need the schema struct, but currently take the
> resource.

I think a simple addition would help to parse the above ...

" ... need the schema struct (to where the properties are moved), ..."

> 
> Once the CDP resources are merged, the resource doesn't reflect the
> right level of information.
> 
> For the info dirs that represent a control, the information needed
> is in the schema, as this is how the resource is being used. For the
> monitors, its the resource as L3CODE_MON doesn't make sense, and would
> monitor data too.
> 
> This difference means the type of the private pointers varies
> between control and monitor info dirs.
> 
> If the flags are RF_MON_INFO, its a struct rdt_resource. If the
> flags are RF_CTRL_INFO, its a struct resctrl_schema. Nothing in
> res_common_files[] has both flags.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Fake schema for monitors may simplify this if anyone thinks that is
> preferable.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 37 +++++++++++++++++---------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f79a5e548138..cb16454a6b0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

...

> @@ -1794,6 +1803,7 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
>   
>   static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>   {
> +	struct resctrl_schema *s;
>   	struct rdt_resource *r;
>   	unsigned long fflags;
>   	char name[32];
> @@ -1809,9 +1819,10 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>   	if (ret)
>   		goto out_destroy;
>   
> -	for_each_alloc_enabled_rdt_resource(r) {
> +	list_for_each_entry(s, &resctrl_all_schema, list) {
> +		r = s->res;
>   		fflags =  r->fflags | RF_CTRL_INFO;
> -		ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
> +		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
>   		if (ret)
>   			goto out_destroy;
>   	}
> 

I think it would be helpful to add a comment here to compensate for the 
symmetry that is removed ("for_each_alloc_enabled_rdt_resource()" 
followed by a "for_each_mon_enabled_rdt_resource()").


Reinette
