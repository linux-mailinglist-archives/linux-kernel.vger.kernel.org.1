Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69866299250
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785820AbgJZQYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:24:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:32081 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775757AbgJZQYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:24:19 -0400
IronPort-SDR: 1QuRE+UZGOVlpmJVh7Q0+397DL0eLJJhRiYfeIFWRE8+5MT1+SrJWg9QOmPBpwLScOFFBqZqxb
 BLSSw91HvB+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155728225"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="155728225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 09:24:16 -0700
IronPort-SDR: 6hu59CXN9JhJsLRHhrmNo2UZD4jcBRaKd2GGQyftMb3zXr0yODRGhwD311yj5h5JerLDcK/dny
 hgbK4bM6B+yQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="360421659"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.244.245]) ([10.212.244.245])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 09:24:15 -0700
Subject: Re: [PATCH] x86/resctrl: Fix memory leak on kernfs dir removal
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        Willem de Bruijn <willemb@google.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <20201026150913.2485171-1-willemdebruijn.kernel@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <20632c6d-fbc6-f857-bee3-872a8500a442@intel.com>
Date:   Mon, 26 Oct 2020 09:24:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026150913.2485171-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Xiaochen

Hi Willem,

As you described in the report you sent directly to us there are indeed 
more issues than the one described here surrounding the kernfs node 
reference counting in resctrl. Xiaochen is actively working on patch(es) 
for all the issues and you could continue working with him ... now 
externally?

On 10/26/2020 8:09 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Resctrl takes an extra kernfs ref on directory entries, to access
> the entry on cleanup in rdtgroup_kn_unlock after removing the entire
> subtree with kfree_remove.
> 
> But the path takes an extra ref both on mkdir and on rmdir.
> 

On resource group (control as well as monitoring) creation via a mkdir 
an extra kernfs node reference is obtained to ensure that the rdtgroup 
structure remains accessible for the rdtgroup_kn_unlock() calls where it 
is removed on deletion. This symmetry ties the resource group's lifetime 
with the kernfs node. The extra kernfs node reference count is dropped 
by kernfs_put() in rdtgroup_kn_unlock() as is documented in the comment 
removed by this patch.

As you state there is an extra reference obtained in rmdir, that is 
unnecessary.

> The kernfs_get on mkdir causes a memleak in the unlikely exit with
> error in the same function, as no extra kernfs_put exists and no extra
> rdtgroup_kn_unlock occurs.

This is a bug.

> 
> More importantly, essentially the same happens in the normal path, as
> this simple program demonstrates:
> 
>      for i in {1..200000}; do
>        mkdir /sys/fs/resctrl/task1
>        rmdir /sys/fs/resctrl/task1
>      done
>      slabtop
> 
> When taking an extra ref for the duration of kernfs_remove, it is
> easiest to reason about when holding this extra ref as short as
> possible. For that, the refcnt on error reason and free on umount
> (rmdir_all_sub), remove the first kernfs_get on mkdir, leaving the
> other on rmdir.

rmdir_all_sub() may be prevented from just removing the resource group 
if there are any waiters. In this case the resource group would be 
removed by rdtgroup_kn_unlock() by the last waiter at which point a 
reference would be dropped. With this patch there would be no reference 
to drop.

Indeed, there is another issue where the kfree(rdtgrp) in 
rmdir_all_sub() (the case when there are no waiters) is missing a 
kernfs_put(). Xiaochen is meticulously working through all of this.

> 
> As the caller of rdtgroup_rmdir, kernfs_iop_rmdir, itself takes a
> reference on the kernfs object, the extra reference is possibly not
> needed at all.

This is not obvious to me. Are you referring to 
kernfs_iop_rmdir()->kernfs_get_active(kn)? That is a different reference 
(kn->active as opposed to kn->count)?

> 
> Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 4d02ec8f371e..115a86bf6bd8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2839,14 +2839,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   	}
>   	rdtgrp->kn = kn;
>   
> -	/*
> -	 * kernfs_remove() will drop the reference count on "kn" which
> -	 * will free it. But we still need it to stick around for the
> -	 * rdtgroup_kn_unlock(kn} call below. Take one extra reference
> -	 * here, which will be dropped inside rdtgroup_kn_unlock().
> -	 */
> -	kernfs_get(kn);
> -
>   	ret = rdtgroup_kn_set_ugid(kn);
>   	if (ret) {
>   		rdt_last_cmd_puts("kernfs perm error\n");
> 


Reinette
