Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9901270009
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIROlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:41:03 -0400
Received: from foss.arm.com ([217.140.110.172]:44134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIROlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 079E51045;
        Fri, 18 Sep 2020 07:41:03 -0700 (PDT)
Received: from [10.57.47.84] (unknown [10.57.47.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A923F718;
        Fri, 18 Sep 2020 07:41:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     vjitta@codeaurora.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
Date:   Fri, 18 Sep 2020 15:41:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-20 13:49, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> When ever an iova alloc request fails we free the iova
> ranges present in the percpu iova rcaches and then retry
> but the global iova rcache is not freed as a result we could
> still see iova alloc failure even after retry as global
> rcache is holding the iova's which can cause fragmentation.
> So, free the global iova rcache as well and then go for the
> retry.
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>   include/linux/iova.h |  6 ++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 4e77116..5836c87 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
>   		flush_rcache = false;
>   		for_each_online_cpu(cpu)
>   			free_cpu_cached_iovas(cpu, iovad);
> +		free_global_cached_iovas(iovad);
>   		goto retry;
>   	}
>   
> @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   	}
>   }
>   
> +/*
> + * free all the IOVA ranges of global cache
> + */
> +void free_global_cached_iovas(struct iova_domain *iovad)

As John pointed out last time, this should be static and the header 
changes dropped.

(TBH we should probably register our own hotplug notifier instance for a 
flush queue, so that external code has no need to poke at the per-CPU 
caches either)

Robin.

> +{
> +	struct iova_rcache *rcache;
> +	unsigned long flags;
> +	int i, j;
> +
> +	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		rcache = &iovad->rcaches[i];
> +		spin_lock_irqsave(&rcache->lock, flags);
> +		for (j = 0; j < rcache->depot_size; ++j) {
> +			iova_magazine_free_pfns(rcache->depot[j], iovad);
> +			iova_magazine_free(rcache->depot[j]);
> +			rcache->depot[j] = NULL;
> +		}
> +		rcache->depot_size = 0;
> +		spin_unlock_irqrestore(&rcache->lock, flags);
> +	}
> +}
> +
>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>   MODULE_LICENSE("GPL");
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index a0637ab..a905726 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>   struct iova *split_and_remove_iova(struct iova_domain *iovad,
>   	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> +void free_global_cached_iovas(struct iova_domain *iovad);
>   #else
>   static inline int iova_cache_get(void)
>   {
> @@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
>   					 struct iova_domain *iovad)
>   {
>   }
> +
> +static inline void free_global_cached_iovas(struct iova_domain *iovad)
> +{
> +}
> +
>   #endif
>   
>   #endif
> 
