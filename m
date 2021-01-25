Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B143022E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 09:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbhAYImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 03:42:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:20336 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbhAYIlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 03:41:42 -0500
IronPort-SDR: mEjcgFaXfpOcMZE4qpJIdSdu+rXXZ7XZZfMf0XoTjKDJY8TfBhnI6Gn4N/4bAUNditG7GtIELQ
 r7Kcqxnlkq7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="178907778"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="178907778"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 00:30:47 -0800
IronPort-SDR: g+0sRwh72EjCtadnOwMv0x3ysX2nnnQAeIFDPcMGQRoJJn1gcqNDTDz4dTeni5jRvYhAAGQJh5
 WI6af5RlG7Xw==
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="387241797"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.249]) ([10.255.29.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 00:30:44 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Add rate limited information when PRQ
 overflows
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
 <20210121014505.1659166-2-baolu.lu@linux.intel.com>
 <MWHPR11MB18862D2EA5BD432BF22D99A48CA09@MWHPR11MB1886.namprd11.prod.outlook.com>
 <da341e11-0923-9127-3385-c2eab9e0db2b@linux.intel.com>
 <MWHPR11MB188688A4C436B318AB0CDCB98CBD9@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1a04f6c2-0c82-1693-c7e5-1333d3fced17@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:30:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB188688A4C436B318AB0CDCB98CBD9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2021/1/25 16:16, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 25, 2021 2:29 PM
>>
>> Hi Kevin,
>>
>> On 2021/1/22 14:38, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, January 21, 2021 9:45 AM
>>>>
>>>> So that the uses could get chances to know what happened.
>>>>
>>>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/svm.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>>> index 033b25886e57..f49fe715477b 100644
>>>> --- a/drivers/iommu/intel/svm.c
>>>> +++ b/drivers/iommu/intel/svm.c
>>>> @@ -895,6 +895,7 @@ static irqreturn_t prq_event_thread(int irq, void
>> *d)
>>>>    	struct intel_iommu *iommu = d;
>>>>    	struct intel_svm *svm = NULL;
>>>>    	int head, tail, handled = 0;
>>>> +	struct page_req_dsc *req;
>>>>
>>>>    	/* Clear PPR bit before reading head/tail registers, to
>>>>    	 * ensure that we get a new interrupt if needed. */
>>>> @@ -904,7 +905,6 @@ static irqreturn_t prq_event_thread(int irq, void
>> *d)
>>>>    	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>>>> PRQ_RING_MASK;
>>>>    	while (head != tail) {
>>>>    		struct vm_area_struct *vma;
>>>> -		struct page_req_dsc *req;
>>>>    		struct qi_desc resp;
>>>>    		int result;
>>>>    		vm_fault_t ret;
>>>> @@ -1042,8 +1042,14 @@ static irqreturn_t prq_event_thread(int irq,
>> void
>>>> *d)
>>>>    	 * Clear the page request overflow bit and wake up all threads that
>>>>    	 * are waiting for the completion of this handling.
>>>>    	 */
>>>> -	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO)
>>>> +	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
>>>> +		head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>>>> PRQ_RING_MASK;
>>>> +		req = &iommu->prq[head / sizeof(*req)];
>>>> +		pr_warn_ratelimited("IOMMU: %s: Page request overflow:
>>>> HEAD: %08llx %08llx",
>>>> +				    iommu->name, ((unsigned long long
>>>> *)req)[0],
>>>> +				    ((unsigned long long *)req)[1]);
>>>>    		writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
>>>> +	}
>>>>
>>>
>>> Not about rate limiting but I think we may have a problem in above
>>> logic. It is incorrect to always clear PRO when it's set w/o first checking
>>> whether the overflow condition has been cleared. This code assumes
>>> that if an overflow condition occurs it must have been cleared by earlier
>>> loop when hitting this check. However since this code runs in a threaded
>>> context, the overflow condition could occur even after you reset the head
>>> to the tail (under some extreme condition). To be sane I think we'd better
>>> read both head/tail again after seeing a pending PRO here and only clear
>>> PRO when it becomes a false indicator based on latest head/tail.
>>>
>>
>> Yes, agreed. We can check the head and tail and clear the overflow bit
>> until the queue is empty. The finial code looks like:
>>
>>           /*
>>            * Clear the page request overflow bit and wake up all threads that
>>            * are waiting for the completion of this handling.
>>            */
>>           if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
>>                   head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>> PRQ_RING_MASK;
>>                   tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
>> PRQ_RING_MASK;
>>                   if (head == tail) {
>>                           req = &iommu->prq[head / sizeof(*req)];
>>                           pr_warn_ratelimited("IOMMU: %s: Page request
>> overflow cleared: HEAD: %08llx %08llx",
>>                                               iommu->name, ((unsigned
>> long long *)req)[0],
>>                                               ((unsigned long long
>> *)req)[1]);
>>                           writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
>>                   }
>>           }
>>
>> Thought?
>>
> 
> Just a small comment. Is it useful to also print a warning in the true
> overflow condition which has to wait for next interrupt to be cleared?
> 

That's fine. :-)

> Thanks
> Kevin
> 

Best regards,
baolu
