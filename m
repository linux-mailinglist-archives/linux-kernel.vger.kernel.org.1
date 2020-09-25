Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAA278653
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgIYLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:53:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgIYLxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B57F101E;
        Fri, 25 Sep 2020 04:53:09 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A52A53F70D;
        Fri, 25 Sep 2020 04:53:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu/iova: Flush CPU rcache for when a depot fills
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com, linuxarm@huawei.com,
        xiyou.wangcong@gmail.com, thunder.leizhen@huawei.com
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
 <1601027469-221812-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
Date:   Fri, 25 Sep 2020 12:53:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1601027469-221812-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-25 10:51, John Garry wrote:
> Leizhen reported some time ago that IOVA performance may degrade over time
> [0], but unfortunately his solution to fix this problem was not given
> attention.
> 
> To summarize, the issue is that as time goes by, the CPU rcache and depot
> rcache continue to grow. As such, IOVA RB tree access time also continues
> to grow.
> 
> At a certain point, a depot may become full, and also some CPU rcaches may
> also be full when we try to insert another IOVA. For this scenario,
> currently we free the "loaded" CPU rcache and create a new one. This
> free'ing means that we need to free many IOVAs in the RB tree, which
> makes IO throughput performance fall off a cliff in our storage scenario:
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
> example we had to wait 16 hours for this to occur. Also note that IO
> throughput also becomes gradually becomes more unstable leading up to this
> point.
> 
> As a solution this issue, we judge that the IOVA rcaches have grown too
> big, and just flush all the CPUs rcaches instead.
> 
> The depot rcaches, however, are not flushed, as they can be used to
> immediately replenish active CPUs.
> 
> In future, some IOVA rcache compaction could be implemented to solve the
> instabilty issue, which I figure could be quite complex to implement.
> 
> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
> 
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 45a251da5453..05e0b462e0d9 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -892,9 +892,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   				 struct iova_rcache *rcache,
>   				 unsigned long iova_pfn)
>   {
> -	struct iova_magazine *mag_to_free = NULL;
>   	struct iova_cpu_rcache *cpu_rcache;
> -	bool can_insert = false;
> +	bool can_insert = false, flush = false;
>   	unsigned long flags;
>   
>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
> @@ -913,13 +912,19 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>   				rcache->depot[rcache->depot_size++] =
>   						cpu_rcache->loaded;
> +				can_insert = true;
> +				cpu_rcache->loaded = new_mag;
>   			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				/*
> +				 * The depot is full, meaning that a very large
> +				 * cache of IOVAs has built up, which slows
> +				 * down RB tree accesses significantly
> +				 * -> let's flush at this point.
> +				 */
> +				flush = true;
> +				iova_magazine_free(new_mag);
>   			}
>   			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
>   		}
>   	}
>   
> @@ -928,9 +933,11 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>   
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
> +	if (flush) {

Do you really need this flag, or is it effectively just mirroring 
"!can_insert" - in theory if there wasn't enough memory to allocate a 
new magazine, then freeing some more IOVAs wouldn't necessarily be a bad 
thing to do anyway.

Other than that, I think this looks reasonable. Every time I look at 
__iova_rcache_insert() I'm convinced there must be a way to restructure 
it to be more streamlined overall, but I can never quite see exactly how...

Thanks,
Robin.

> +		int cpu;
> +
> +		for_each_online_cpu(cpu)
> +			free_cpu_cached_iovas(cpu, iovad);
>   	}
>   
>   	return can_insert;
> 
