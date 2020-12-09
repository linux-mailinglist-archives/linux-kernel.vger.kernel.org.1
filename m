Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA772D3E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgLIJOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:14:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9563 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgLIJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:14:15 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrWXx03ptzM2Rx;
        Wed,  9 Dec 2020 17:12:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 17:13:24 +0800
Subject: Re: [RESEND PATCH v3 3/4] iommu/iova: Flush CPU rcache for when a
 depot fills
To:     John Garry <john.garry@huawei.com>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <xiyou.wangcong@gmail.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-4-git-send-email-john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <76e057e3-9db8-21fc-3a8a-b9e924a95cf4@huawei.com>
Date:   Wed, 9 Dec 2020 17:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1605608734-84416-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/17 18:25, John Garry wrote:
> Leizhen reported some time ago that IOVA performance may degrade over time
> [0], but unfortunately his solution to fix this problem was not given
> attention.
> 
> To summarize, the issue is that as time goes by, the CPU rcache and depot
> rcache continue to grow. As such, IOVA RB tree access time also continues
> to grow.
> 
> At a certain point, a depot may become full, and also some CPU rcaches may
> also be full when inserting another IOVA is attempted. For this scenario,
> currently the "loaded" CPU rcache is freed and a new one is created. This
> freeing means that many IOVAs in the RB tree need to be freed, which
> makes IO throughput performance fall off a cliff in some storage scenarios:
> 
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6314MB/0KB/0KB /s] [1616K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [5669MB/0KB/0KB /s] [1451K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6673MB/0KB/0KB /s] [1708K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6761MB/0KB/0KB /s] [1731K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6685MB/0KB/0KB /s] [1711K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6178MB/0KB/0KB /s] [1582K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6731MB/0KB/0KB /s] [1723K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2387MB/0KB/0KB /s] [611K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2689MB/0KB/0KB /s] [688K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2278MB/0KB/0KB /s] [583K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1288MB/0KB/0KB /s] [330K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1632MB/0KB/0KB /s] [418K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1765MB/0KB/0KB /s] [452K/0/0 iops]
> 
> And continue in this fashion, without recovering. Note that in this
> example it was required to wait 16 hours for this to occur. Also note that
> IO throughput also becomes gradually becomes more unstable leading up to
> this point.
> 
> This problem is only seen for non-strict mode. For strict mode, the rcaches
> stay quite compact.
> 
> As a solution to this issue, judge that the IOVA caches have grown too big
> when cached magazines need to be free, and just flush all the CPUs rcaches
> instead.
> 
> The depot rcaches, however, are not flushed, as they can be used to
> immediately replenish active CPUs.
> 
> In future, some IOVA compaction could be implemented to solve the
> instabilty issue, which I figure could be quite complex to implement.
> 
> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
> 
> Analyzed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iova.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 1f3f0f8b12e0..386005055aca 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -901,7 +901,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  				 struct iova_rcache *rcache,
>  				 unsigned long iova_pfn)
>  {
> -	struct iova_magazine *mag_to_free = NULL;
>  	struct iova_cpu_rcache *cpu_rcache;
>  	bool can_insert = false;
>  	unsigned long flags;
> @@ -923,13 +922,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  				if (cpu_rcache->loaded)
>  					rcache->depot[rcache->depot_size++] =
>  							cpu_rcache->loaded;
> -			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				can_insert = true;
> +				cpu_rcache->loaded = new_mag;
>  			}
>  			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
> +			if (!can_insert)
> +				iova_magazine_free(new_mag);
>  		}
>  	}
>  
> @@ -938,10 +936,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  
>  	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>  
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
mag_to_free has been stripped out, that's why lock protection is not required here.

> -	}
> +	if (!can_insert)
> +		free_all_cpu_cached_iovas(iovad);
Lock protection required.

>  
>  	return can_insert;
>  }
> 

