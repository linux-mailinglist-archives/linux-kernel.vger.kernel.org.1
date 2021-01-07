Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFA2EEA03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbhAGXyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:54:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:43624 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbhAGXyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:54:38 -0500
IronPort-SDR: KPzm0TVKueA9LWdFGJxyGzMjkvMTqNn5DmFxjj6o+pJajpsH/tRRrX18t9YtXkh6Ww4648RTmL
 vyNLgHeM8UcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="174935433"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="174935433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 15:52:52 -0800
IronPort-SDR: STUYzP1dmLk5rXkzTQFfUHnw4R0sK1nl2mGZ8Xx/VvgmNgfthmWjQSqGTB1GPv3B9u0R6fZTvR
 qJkph4PCMZ3g==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="379907722"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.120]) ([10.255.31.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 15:52:49 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
To:     Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
 <20210105190357.GA12182@willie-the-truck>
 <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Message-ID: <9b26b7ac-b5c7-f38a-a078-b53a6b6bf375@linux.intel.com>
Date:   Fri, 8 Jan 2021 07:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021/1/6 9:09, Lu Baolu wrote:
> Hi Will,
> 
> Happy New Year!
> 
> On 2021/1/6 3:03, Will Deacon wrote:
>> On Thu, Dec 31, 2020 at 08:53:20AM +0800, Lu Baolu wrote:
>>> The VT-d hardware will ignore those Addr bits which have been masked by
>>> the AM field in the PASID-based-IOTLB invalidation descriptor. As the
>>> result, if the starting address in the descriptor is not aligned with
>>> the address mask, some IOTLB caches might not invalidate. Hence people
>>> will see below errors.
>>>
>>> [ 1093.704661] dmar_fault: 29 callbacks suppressed
>>> [ 1093.704664] DMAR: DRHD: handling fault status reg 3
>>> [ 1093.712738] DMAR: [DMA Read] Request device [7a:02.0] PASID 2
>>>                 fault addr 7f81c968d000 [fault reason 113]
>>>                 SM: Present bit in first-level paging entry is clear
>>>
>>> Fix this by using aligned address for PASID-based-IOTLB invalidation.
>>>
>>> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable 
>>> mode")
>>> Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/svm.c | 22 ++++++++++++++++++++--
>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 69566695d032..b16a4791acfb 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -118,8 +118,10 @@ void intel_svm_check(struct intel_iommu *iommu)
>>>       iommu->flags |= VTD_FLAG_SVM_CAPABLE;
>>>   }
>>> -static void intel_flush_svm_range_dev (struct intel_svm *svm, struct 
>>> intel_svm_dev *sdev,
>>> -                unsigned long address, unsigned long pages, int ih)
>>> +static void __flush_svm_range_dev(struct intel_svm *svm,
>>> +                  struct intel_svm_dev *sdev,
>>> +                  unsigned long address,
>>> +                  unsigned long pages, int ih)
>>>   {
>>>       struct qi_desc desc;
>>> @@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev (struct 
>>> intel_svm *svm, struct intel_svm_d
>>>       }
>>>   }
>>> +static void intel_flush_svm_range_dev(struct intel_svm *svm,
>>> +                      struct intel_svm_dev *sdev,
>>> +                      unsigned long address,
>>> +                      unsigned long pages, int ih)
>>> +{
>>> +    unsigned long shift = ilog2(__roundup_pow_of_two(pages));
>>> +    unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
>>> +    unsigned long start = ALIGN_DOWN(address, align);
>>> +    unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), 
>>> align);
>>> +
>>> +    while (start < end) {
>>> +        __flush_svm_range_dev(svm, sdev, start, align >> 
>>> VTD_PAGE_SHIFT, ih);
>>> +        start += align;
>>> +    }
>>> +}
>>
>> Given that this only seems to be called from intel_invalidate_range(), 
>> which
>> has to compute 'pages' only to have it pulled apart again here, 
>> perhaps it
>> would be cleaner for intel_flush_svm_range() to take something like an
>> 'order' argument instead?
>>
>> What do you think?
> 
> We need to clean up here. It's duplicate with the qi_flush_piotlb()
> helper. I have a patch under testing for this. I will post it for review
> later.

I'm sorry, above reply is a little vague.

I meant to say, let's take 'pages' as the argument. We are going to use
qi_flush_piotlb() here to avoid duplicate QI interactions. The
qi_flush_piotlb() helper also takes 'pages', so keep 'pages' here will
make things easier.

My cleanup patch is for v5.12. Can you please take this for v5.11?

Best regards,
baolu
