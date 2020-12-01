Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93C2C9564
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLACqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:46:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:2881 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLACqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:46:39 -0500
IronPort-SDR: PdAKlKeRl+6WeY7cZEQ9lB/uFzC5STHKaxXY2JfFR2AEETYk79ktXdHyRjvMMOQv/4sTuDza0g
 qNdnUQFsZ6Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="257461851"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="257461851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 18:44:58 -0800
IronPort-SDR: pAVrtwovzBP9hzHfyu8zxU+R0f0gt2Iwi81AK+urnntZmSqxVsG+61j+NQpE0IY+jLyKpFypoc
 SXUNg8NkifOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="434495516"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2020 18:44:56 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@kernel.vger.org
Subject: Re: Question about domain_init (v5.3-v5.7)
To:     Jerry Snitselaar <jsnitsel@redhat.com>
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
 <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
 <87r1oaka46.fsf@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <da740dc6-0a03-afd5-b684-6f8109279d9b@linux.intel.com>
Date:   Tue, 1 Dec 2020 10:37:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87r1oaka46.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On 12/1/20 1:50 AM, Jerry Snitselaar wrote:
> 
> Lu Baolu @ 2020-11-26 19:12 MST:
> 
>> Hi Jerry,
>>
>> On 11/27/20 5:35 AM, Jerry Snitselaar wrote:
>>> Lu Baolu @ 2020-11-26 04:01 MST:
>>>
>>>> Hi Jerry,
>>>>
>>>> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>>>>> Is there a reason we check the requested guest address width against
>>>>> the
>>>>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>>>>> I've run into a case with a new system where the mgaw reported is 57,
>>>>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>>>>> the highest supported agaw is 48 and the domain_init code fails here. In
>>>>
>>>> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
>>>> maybe have to add a platform specific quirk to set mgaw to the highest
>>>> supported agaw?
>>>>
>>>> Best regards,
>>>> baolu
>>> Is there somewhere you can point me to that discusses how they
>>> should be
>>> setting the mgaw? I misunderstood when I previously asked you about
>>> whether the mgaw could be a value that was greater than any of sagaw.
>>> If it is a bios issue, then they should fix it there.
>>
>> MGAW indicates the max gpa width supported by 2nd translation. The VT-d
>> spec requires that this value must be at least equal to the host
>> physical addressibility. According to this, BIOS is good, right?
>>
>> For this failure case, domain_init() just wants to find a suitable agaw
>> for the private domain. I think it makes sense to check against
>> iommu->agaw instead of cap_mgaw.
>>
>> Best regards,
>> baolu
>>
> 
>  From this bit in the spec about MGAW:
> 
>      Guest addressability for a given DMA request is limited to the
>      minimum of the value reported through this field and the adjusted
>      guest address width of the corresponding page-table structure.
>      (Adjusted guest address widths supported by hardware are reported
>      through the SAGAW field).
> 
> That does suggest it should be adjusted down to the sagaw value in this case, yes?
> Just want to make sure I'm understanding it correctly.

Yes. I think so.

Best regards,
baolu

> 
>>>
>>>>
>>>>> other places like prepare_domain_attach_device, the dmar domain agaw
>>>>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>>>>> determined based off what is reported for sagaw. I'm wondering if it
>>>>> can't instead do:
>>>>> ---
>>>>>     drivers/iommu/intel-iommu.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>> diff --git a/drivers/iommu/intel-iommu.c
>>>>> b/drivers/iommu/intel-iommu.c
>>>>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>>>>> --- a/drivers/iommu/intel-iommu.c
>>>>> +++ b/drivers/iommu/intel-iommu.c
>>>>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>>>     	domain_reserve_special_ranges(domain);
>>>>>     	/* calculate AGAW */
>>>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>>>> -	        guest_width = cap_mgaw(iommu->cap);
>>>>> +	if (guest_width > agaw_to_width(iommu->agaw))
>>>>> +	        guest_width = agaw_to_width(iommu->agaw);
>>>>>     	domain->gaw = guest_width;
>>>>>     	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>>>     	agaw = width_to_agaw(adjust_width);
>>>>> --
>>>>> 2.27.0
>>>>>
>>>>> Thoughts? With the former code the ehci device for the ilo fails when
>>>>> trying to get a private domain.
>>>>> Thanks,
>>>>> Jerry
>>>>>
>>>
> 
