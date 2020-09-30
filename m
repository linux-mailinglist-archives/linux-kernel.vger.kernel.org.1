Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBD27E0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgI3F7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:59:20 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:45551 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI3F7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:59:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601445559; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=Z7oAfbjIbqFuJZ2OPG4jTiveLuRD86cSV3+ivLnS8Yw=; b=ER5MlaP1HliNoFPFvoC80G1rVUsbdyl13COXNGtP7+PO+yWkDZe+xyt3fojU5WauVPtOPl8Y
 Hau0mAyNN8Zs2ebKi2JGCC1tTHpmvj7lVrkanr6WvOt/qggj6ICsvyhEslyqoN/AVIv6rQml
 yQALy1MHXXZE6cFoLG7/bXsH4KE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f741eb797ca3ed0fbb6199b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 05:59:19
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69D5EC433FE; Wed, 30 Sep 2020 05:59:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.101] (unknown [103.248.210.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76B32C433F1;
        Wed, 30 Sep 2020 05:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76B32C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
From:   Vijayanand Jitta <vjitta@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
 <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
 <9dac89a4-553a-efe2-08a1-6a3a5fbc97a8@codeaurora.org>
Message-ID: <bb4c4fe4-50b6-5218-0cb5-43bcba9e9bff@codeaurora.org>
Date:   Wed, 30 Sep 2020 11:29:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9dac89a4-553a-efe2-08a1-6a3a5fbc97a8@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2020 6:11 PM, Vijayanand Jitta wrote:
> 
> 
> On 9/18/2020 8:11 PM, Robin Murphy wrote:
>> On 2020-08-20 13:49, vjitta@codeaurora.org wrote:
>>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>>
>>> When ever an iova alloc request fails we free the iova
>>> ranges present in the percpu iova rcaches and then retry
>>> but the global iova rcache is not freed as a result we could
>>> still see iova alloc failure even after retry as global
>>> rcache is holding the iova's which can cause fragmentation.
>>> So, free the global iova rcache as well and then go for the
>>> retry.
>>>
>>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>>> ---
>>>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>>>   include/linux/iova.h |  6 ++++++
>>>   2 files changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 4e77116..5836c87 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad,
>>> unsigned long pfn)
>>>           flush_rcache = false;
>>>           for_each_online_cpu(cpu)
>>>               free_cpu_cached_iovas(cpu, iovad);
>>> +        free_global_cached_iovas(iovad);
>>>           goto retry;
>>>       }
>>>   @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu,
>>> struct iova_domain *iovad)
>>>       }
>>>   }
>>>   +/*
>>> + * free all the IOVA ranges of global cache
>>> + */
>>> +void free_global_cached_iovas(struct iova_domain *iovad)
>>
>> As John pointed out last time, this should be static and the header
>> changes dropped.
>>
>> (TBH we should probably register our own hotplug notifier instance for a
>> flush queue, so that external code has no need to poke at the per-CPU
>> caches either)
>>
>> Robin.
>>
> 
> Right, I have made it static and dropped header changes in v3.
> can you please review that.
> 
> Thanks,
> Vijay

Please review v4 instead of v3, I have updated other patch as well in v4.

Thanks,
Vijay
>>> +{
>>> +    struct iova_rcache *rcache;
>>> +    unsigned long flags;
>>> +    int i, j;
>>> +
>>> +    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>> +        rcache = &iovad->rcaches[i];
>>> +        spin_lock_irqsave(&rcache->lock, flags);
>>> +        for (j = 0; j < rcache->depot_size; ++j) {
>>> +            iova_magazine_free_pfns(rcache->depot[j], iovad);
>>> +            iova_magazine_free(rcache->depot[j]);
>>> +            rcache->depot[j] = NULL;
>>> +        }
>>> +        rcache->depot_size = 0;
>>> +        spin_unlock_irqrestore(&rcache->lock, flags);
>>> +    }
>>> +}
>>> +
>>>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>>>   MODULE_LICENSE("GPL");
>>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>>> index a0637ab..a905726 100644
>>> --- a/include/linux/iova.h
>>> +++ b/include/linux/iova.h
>>> @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>>>   struct iova *split_and_remove_iova(struct iova_domain *iovad,
>>>       struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>>>   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain
>>> *iovad);
>>> +void free_global_cached_iovas(struct iova_domain *iovad);
>>>   #else
>>>   static inline int iova_cache_get(void)
>>>   {
>>> @@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned
>>> int cpu,
>>>                        struct iova_domain *iovad)
>>>   {
>>>   }
>>> +
>>> +static inline void free_global_cached_iovas(struct iova_domain *iovad)
>>> +{
>>> +}
>>> +
>>>   #endif
>>>     #endif
>>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
