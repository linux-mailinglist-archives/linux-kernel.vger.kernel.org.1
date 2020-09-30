Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11A327E09B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgI3Fsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:48:33 -0400
Received: from z5.mailgun.us ([104.130.96.5]:39501 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI3Fsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:48:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601444912; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ICRz9bRTsq/bDpqKNT04D4ibLj+YBqbEAedTTF1vnRM=; b=fYmgx/YnCVNbJ7PBLrwnK6f8ATJ0rXssqkYngYyNMuoQkjOLNhiCt79lhjZX9v4+bmFUHZ9J
 dnbPy9exzQyeUHxfVwotnC0Ep02i8Q0EykHv9HxXei2gsAg4JK3rdoNXaauCbM9cNDWk4VVK
 H27XfhPwXUHyOSb++TSUk0tdrUM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f741c3097ca3ed0fbb3eda2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 05:48:32
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD1A8C433CA; Wed, 30 Sep 2020 05:48:31 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47B5CC433CB;
        Wed, 30 Sep 2020 05:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47B5CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <07270e29-c9d4-ae8c-a236-eb6fefccbf6c@arm.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <8efbdd09-8f0f-e6fe-ab82-db08f6d5b5b5@codeaurora.org>
Date:   Wed, 30 Sep 2020 11:18:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <07270e29-c9d4-ae8c-a236-eb6fefccbf6c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2020 7:48 PM, Robin Murphy wrote:
> On 2020-08-20 13:49, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> When ever a new iova alloc request comes iova is always searched
>> from the cached node and the nodes which are previous to cached
>> node. So, even if there is free iova space available in the nodes
>> which are next to the cached node iova allocation can still fail
>> because of this approach.
>>
>> Consider the following sequence of iova alloc and frees on
>> 1GB of iova space
>>
>> 1) alloc - 500MB
>> 2) alloc - 12MB
>> 3) alloc - 499MB
>> 4) free -  12MB which was allocated in step 2
>> 5) alloc - 13MB
>>
>> After the above sequence we will have 12MB of free iova space and
>> cached node will be pointing to the iova pfn of last alloc of 13MB
>> which will be the lowest iova pfn of that iova space. Now if we get an
>> alloc request of 2MB we just search from cached node and then look
>> for lower iova pfn's for free iova and as they aren't any, iova alloc
>> fails though there is 12MB of free iova space.
>>
>> To avoid such iova search failures do a retry from the last rb tree node
>> when iova search fails, this will search the entire tree and get an iova
>> if its available.
>>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>   drivers/iommu/iova.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 49fc01f..4e77116 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>       struct rb_node *curr, *prev;
>>       struct iova *curr_iova;
>>       unsigned long flags;
>> -    unsigned long new_pfn;
>> +    unsigned long new_pfn, low_pfn_new;
>>       unsigned long align_mask = ~0UL;
>> +    unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
>>         if (size_aligned)
>>           align_mask <<= fls_long(size - 1);
>> @@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>         curr = __get_cached_rbnode(iovad, limit_pfn);
>>       curr_iova = rb_entry(curr, struct iova, node);
>> +    low_pfn_new = curr_iova->pfn_hi + 1;
> 
> Could we call "low_pfn_new" something like "retry_pfn" instead? This
> code already has unavoidable readability struggles with so many
> different "pfn"s in play, so having two different meanings of "new"
> really doesn't help.
> 
> Other than that, I think this looks OK (IIRC it's basically what I
> originally suggested), so with the naming tweaked,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 

Thanks for review, I have renamed it to retry_pfn in v4.

Thanks,
Vijay
>> +
>> +retry:
>>       do {
>> -        limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>> -        new_pfn = (limit_pfn - size) & align_mask;
>> +        high_pfn = min(high_pfn, curr_iova->pfn_lo);
>> +        new_pfn = (high_pfn - size) & align_mask;
>>           prev = curr;
>>           curr = rb_prev(curr);
>>           curr_iova = rb_entry(curr, struct iova, node);
>> -    } while (curr && new_pfn <= curr_iova->pfn_hi);
>> -
>> -    if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>> +    } while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >=
>> low_pfn);
>> +
>> +    if (high_pfn < size || new_pfn < low_pfn) {
>> +        if (low_pfn == iovad->start_pfn && low_pfn_new < limit_pfn) {
>> +            high_pfn = limit_pfn;
>> +            low_pfn = low_pfn_new;
>> +            curr = &iovad->anchor.node;
>> +            curr_iova = rb_entry(curr, struct iova, node);
>> +            goto retry;
>> +        }
>>           iovad->max32_alloc_size = size;
>>           goto iova32_full;
>>       }
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
