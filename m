Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8368526FF24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIRNvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:51:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIRNve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:51:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3797330E;
        Fri, 18 Sep 2020 06:51:34 -0700 (PDT)
Received: from [10.57.47.84] (unknown [10.57.47.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 603C83F718;
        Fri, 18 Sep 2020 06:51:33 -0700 (PDT)
Subject: Re: [PATCH] Handle init_iova_flush_queue failure in dma-iommu path
To:     Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200910122539.3662-1-murphyt7@tcd.ie>
 <20200918085501.GJ31590@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <82d5f9c9-1001-3ed3-05f2-1a3b87ca023d@arm.com>
Date:   Fri, 18 Sep 2020 14:51:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200918085501.GJ31590@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-18 09:55, Joerg Roedel wrote:
> On Thu, Sep 10, 2020 at 01:25:38PM +0100, Tom Murphy wrote:
>> init_iova_flush_queue can fail if we run out of memory. Fall back to noflush
>>   queue if it fails.
>>
>> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
>> ---
>>   drivers/iommu/dma-iommu.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 4959f5df21bd..5f69126f3e91 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -343,8 +343,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   
>>   	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
>>   			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
>> -		cookie->fq_domain = domain;
>> -		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
>> +		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
>> +					NULL))
>> +			pr_warn("iova flush queue initialization failed\n");
>> +		else
>> +			cookie->fq_domain = domain;
>>   	}
>>   
>>   	if (!dev)
> 
> Looks good to me, but Robin should also have a look.

Yup, seems reasonable, thanks Tom!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
