Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8442D3E05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgLII7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:59:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9138 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgLII7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:59:48 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CrWDT6szNz15YnX;
        Wed,  9 Dec 2020 16:58:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 16:58:56 +0800
Subject: Re: [RESEND PATCH v3 1/4] iommu/iova: Add free_all_cpu_cached_iovas()
To:     John Garry <john.garry@huawei.com>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <xiyou.wangcong@gmail.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-2-git-send-email-john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0ae7688c-10b7-aa6b-c398-ac0917f7ae71@huawei.com>
Date:   Wed, 9 Dec 2020 16:58:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1605608734-84416-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/17 18:25, John Garry wrote:
> Add a helper function to free the CPU rcache for all online CPUs.
> 
> There also exists a function of the same name in
> drivers/iommu/intel/iommu.c, but the parameters are different, and there
> should be no conflict.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iova.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 30d969a4c5fd..81b7399dd5e8 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -227,6 +227,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	return -ENOMEM;
>  }
>  
> +static void free_all_cpu_cached_iovas(struct iova_domain *iovad)
> +{
> +	unsigned int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		free_cpu_cached_iovas(cpu, iovad);
> +}
> +
>  static struct kmem_cache *iova_cache;
>  static unsigned int iova_cache_users;
>  static DEFINE_MUTEX(iova_cache_mutex);
> @@ -422,15 +430,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  retry:
>  	new_iova = alloc_iova(iovad, size, limit_pfn, true);
>  	if (!new_iova) {
> -		unsigned int cpu;
> -
>  		if (!flush_rcache)
>  			return 0;
>  
>  		/* Try replenishing IOVAs by flushing rcache. */
>  		flush_rcache = false;
> -		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> +		free_all_cpu_cached_iovas(iovad);
>  		goto retry;
>  	}
>  

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 

