Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949FB27AE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1MmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:42:11 -0400
Received: from z5.mailgun.us ([104.130.96.5]:11451 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgI1MmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:42:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601296930; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=oWltz7hycQksUaxhpl7WV0Rt0J+p0DnC6Q3UxfGwchE=; b=k82kkIz7T5dWrDyyQ6aNl2XxOU+Pea/JG/RcGBYlGjGVRDI3r7XYUb0o6ugRF5WP+81fZtd8
 JXQJRoyzn/pS1YTJ1utE3eTh1Sjz2/Wd4XPS9UqiSHY8/ESxO6UAx/T1gOH610Id1Sjudo6E
 K0/bKGRbM8QGtdMbCjGU3vpCWr8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f71da2283f5ac99db0175d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 12:42:10
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68B79C433F1; Mon, 28 Sep 2020 12:42:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.43.216] (unknown [157.44.92.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8413C433CA;
        Mon, 28 Sep 2020 12:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8413C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
 <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <9dac89a4-553a-efe2-08a1-6a3a5fbc97a8@codeaurora.org>
Date:   Mon, 28 Sep 2020 18:11:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2020 8:11 PM, Robin Murphy wrote:
> On 2020-08-20 13:49, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> When ever an iova alloc request fails we free the iova
>> ranges present in the percpu iova rcaches and then retry
>> but the global iova rcache is not freed as a result we could
>> still see iova alloc failure even after retry as global
>> rcache is holding the iova's which can cause fragmentation.
>> So, free the global iova rcache as well and then go for the
>> retry.
>>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>>   include/linux/iova.h |  6 ++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 4e77116..5836c87 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad,
>> unsigned long pfn)
>>           flush_rcache = false;
>>           for_each_online_cpu(cpu)
>>               free_cpu_cached_iovas(cpu, iovad);
>> +        free_global_cached_iovas(iovad);
>>           goto retry;
>>       }
>>   @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu,
>> struct iova_domain *iovad)
>>       }
>>   }
>>   +/*
>> + * free all the IOVA ranges of global cache
>> + */
>> +void free_global_cached_iovas(struct iova_domain *iovad)
> 
> As John pointed out last time, this should be static and the header
> changes dropped.
> 
> (TBH we should probably register our own hotplug notifier instance for a
> flush queue, so that external code has no need to poke at the per-CPU
> caches either)
> 
> Robin.
> 

Right, I have made it static and dropped header changes in v3.
can you please review that.

Thanks,
Vijay
>> +{
>> +    struct iova_rcache *rcache;
>> +    unsigned long flags;
>> +    int i, j;
>> +
>> +    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +        rcache = &iovad->rcaches[i];
>> +        spin_lock_irqsave(&rcache->lock, flags);
>> +        for (j = 0; j < rcache->depot_size; ++j) {
>> +            iova_magazine_free_pfns(rcache->depot[j], iovad);
>> +            iova_magazine_free(rcache->depot[j]);
>> +            rcache->depot[j] = NULL;
>> +        }
>> +        rcache->depot_size = 0;
>> +        spin_unlock_irqrestore(&rcache->lock, flags);
>> +    }
>> +}
>> +
>>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>>   MODULE_LICENSE("GPL");
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index a0637ab..a905726 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>>   struct iova *split_and_remove_iova(struct iova_domain *iovad,
>>       struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>>   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain
>> *iovad);
>> +void free_global_cached_iovas(struct iova_domain *iovad);
>>   #else
>>   static inline int iova_cache_get(void)
>>   {
>> @@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned
>> int cpu,
>>                        struct iova_domain *iovad)
>>   {
>>   }
>> +
>> +static inline void free_global_cached_iovas(struct iova_domain *iovad)
>> +{
>> +}
>> +
>>   #endif
>>     #endif
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
