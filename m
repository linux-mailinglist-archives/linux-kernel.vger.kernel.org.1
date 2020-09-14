Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5B268774
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgINIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:46:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2811 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbgINIq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:46:28 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E1553BC8B82C58024CAD;
        Mon, 14 Sep 2020 09:46:26 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.249) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 14 Sep
 2020 09:46:26 +0100
Subject: Re: [PATCH 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>
CC:     <vinmenon@codeaurora.org>, <iommu@lists.linux-foundation.org>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
 <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
 <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
 <20200812151608.GG3721@8bytes.org>
 <b6c7eb2b-d1f5-058f-943c-1b7c14fe1f7c@codeaurora.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8f3cbf23-eedc-d734-e4b3-41e8baabca15@huawei.com>
Date:   Mon, 14 Sep 2020 09:43:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b6c7eb2b-d1f5-058f-943c-1b7c14fe1f7c@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.249]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2020 06:36, Vijayanand Jitta wrote:
> 
> 
> On 8/12/2020 8:46 PM, Joerg Roedel wrote:
>> On Mon, Aug 03, 2020 at 03:30:48PM +0530, Vijayanand Jitta wrote:
>>> ping?
>>
>> Please repost when v5.9-rc1 is released and add
>>
>> 	Robin Murphy <robin.murphy@arm.com>
>>
>> on your Cc list.
>>
>> Thanks,
>>
>> 	Joerg
>>
> 
> Sure, will do.
> 
> Thanks,
> Vijay
> 

And a cover letter would be useful also, to at least us know what 
changes have been made per version.

 >
 > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
 > index 4e77116..5836c87 100644
 > --- a/drivers/iommu/iova.c
 > +++ b/drivers/iommu/iova.c
 > @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad, 
unsigned long pfn)
 >   		flush_rcache = false;
 >   		for_each_online_cpu(cpu)
 >   			free_cpu_cached_iovas(cpu, iovad);
 > +		free_global_cached_iovas(iovad);

Have you seen an issue where this is needed?

If we have filled the IOVA space, then as a measure we flush all the CPU 
rcaches, and then there should be free IOVA space and we can make 
progress. And it may be useful to still have the global depots to use 
straightaway then to swap into empty CPU rcaches.

 >   		goto retry;
 >   	}
 >
 > @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu, 
struct iova_domain *iovad)
 >   	}
 >   }
 >
 > +/*
 > + * free all the IOVA ranges of global cache
 > + */
 > +void free_global_cached_iovas(struct iova_domain *iovad)
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

why is this in the iova.h, when it is only used internally in iova.c?

 > @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 >   struct iova *split_and_remove_iova(struct iova_domain *iovad,
 >   	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 >   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain 
*iovad);
 > +void free_global_cached_iovas(struct iova_domain *iovad);
 >   #else
 >   static inline int iova_cache_get(void)
 >   {
 > @@ -270,6 +271,11 @@ static inline void 
free_cpu_cached_iovas(unsigned int cpu,
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


