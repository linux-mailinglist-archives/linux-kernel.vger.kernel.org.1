Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389882A4BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgKCQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:48:16 -0500
Received: from foss.arm.com ([217.140.110.172]:52118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:48:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D0A139F;
        Tue,  3 Nov 2020 08:48:15 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C173F718;
        Tue,  3 Nov 2020 08:48:13 -0800 (PST)
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot
 fills
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc:     xiyou.wangcong@gmail.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
Date:   Tue, 3 Nov 2020 16:48:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1603733501-211004-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 17:31, John Garry wrote:
> Leizhen reported some time ago that IOVA performance may degrade over time
> [0], but unfortunately his solution to fix this problem was not given
> attention.
> 
> To summarize, the issue is that as time goes by, the CPU rcache and depot
> rcache continue to grow. As such, IOVA RB tree access time also continues
> to grow.

I'm struggling to see how this is not simply indicative of a leak 
originating elsewhere. For the number of magazines to continually grow, 
it means IOVAs *of a particular size* are being freed faster than they 
are being allocated, while the only place that ongoing allocations 
should be coming from is those same magazines!

Now indeed that could happen over the short term if IOVAs are allocated 
and freed again in giant batches larger than the total global cache 
capacity, but that would show a cyclic behaviour - when activity starts, 
everything is first allocated straight from the tree, then when it ends 
the caches would get overwhelmed by the large burst of freeing and start 
having to release things back to the tree, but eventually that would 
stop once everything *is* freed, then when activity begins again the 
next round of allocating would inherently clear out all the caches 
before going anywhere near the tree. To me the "steady decline" 
behaviour suggests that someone somewhere is making DMA unmap calls with 
a smaller size than they were mapped with (you tend to notice it quicker 
the other way round due to all the device errors and random memory 
corruption) - in many cases that would appear to work out fine from the 
driver's point of view, but would provoke exactly this behaviour in the 
IOVA allocator.

Robin.

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
>   drivers/iommu/iova.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 1f3f0f8b12e0..386005055aca 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -901,7 +901,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   				 struct iova_rcache *rcache,
>   				 unsigned long iova_pfn)
>   {
> -	struct iova_magazine *mag_to_free = NULL;
>   	struct iova_cpu_rcache *cpu_rcache;
>   	bool can_insert = false;
>   	unsigned long flags;
> @@ -923,13 +922,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   				if (cpu_rcache->loaded)
>   					rcache->depot[rcache->depot_size++] =
>   							cpu_rcache->loaded;
> -			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				can_insert = true;
> +				cpu_rcache->loaded = new_mag;
>   			}
>   			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
> +			if (!can_insert)
> +				iova_magazine_free(new_mag);
>   		}
>   	}
>   
> @@ -938,10 +936,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>   
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
> -	}
> +	if (!can_insert)
> +		free_all_cpu_cached_iovas(iovad);
>   
>   	return can_insert;
>   }
> 
