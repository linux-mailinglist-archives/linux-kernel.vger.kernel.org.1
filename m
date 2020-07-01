Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43D2101A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 03:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGABuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 21:50:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:25314 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgGABuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:50:07 -0400
IronPort-SDR: Z8R1RR7l14pHRT+G/L9/3SmR/5gsKibzUIXsvpNUVP0mtwXCkNeUawjVm/xtsdsyalHUcZR09T
 dZbg/afpgjHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231299498"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="231299498"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 18:50:06 -0700
IronPort-SDR: P4q4STTHl8YHwzmESTyZkAcHTorHeACpmx8HN8RxpEoXVDCH+UGwm/Gnmgu6+NNvxTc3I6e5OM
 YRTDZXbcRj9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="265268574"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 18:50:03 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
 <20200630103459.6c99c961@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5a2ffda-a243-ed20-63e0-50d784d3af71@linux.intel.com>
Date:   Wed, 1 Jul 2020 09:45:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630103459.6c99c961@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/1/20 1:34 AM, Jacob Pan wrote:
> On Thu, 25 Jun 2020 18:10:43 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Hi,
>>
>> On 2020/6/23 23:43, Jacob Pan wrote:
>>> For guest requested IOTLB invalidation, address and mask are
>>> provided as part of the invalidation data. VT-d HW silently ignores
>>> any address bits below the mask. SW shall also allow such case but
>>> give warning if address does not align with the mask. This patch
>>> relax the fault handling from error to warning and proceed with
>>> invalidation request with the given mask.
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c
>>> b/drivers/iommu/intel/iommu.c index 5ea5732d5ec4..50fc62413a35
>>> 100644 --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct
>>> iommu_domain *domain, struct device *dev,
>>>    		switch (BIT(cache_type)) {
>>>    		case IOMMU_CACHE_INV_TYPE_IOTLB:
>>> +			/* HW will ignore LSB bits based on
>>> address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
>>>    			    size &&
>>>    			    (inv_info->addr_info.addr &
>>> ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
>>> -				pr_err_ratelimited("Address out of
>>> range, 0x%llx, size order %llu\n",
>>> -
>>> inv_info->addr_info.addr, size);
>>> -				ret = -ERANGE;
>>> -				goto out_unlock;
>>> +				WARN_ONCE(1, "Address out of
>>> range, 0x%llx, size order %llu\n",
>>> +
>>> inv_info->addr_info.addr, size);
>> I don't think WARN_ONCE() is suitable here. It makes users think it's
>> a kernel bug. How about pr_warn_ratelimited()?
>>
> I think pr_warn_ratelimited might still be too chatty. There is no
> functional issues, we just don't to silently ignore it. Perhaps just
> say:
> WARN_ONCE(1, "User provided address not page aligned, alignment forced")
> ?
> 

WARN() is normally used for reporting a kernel bug. It dumps kernel
trace. And the users will report bug through bugzilla.kernel.org.

In this case, it's actually an unexpected user input, we shouldn't
treat it as a kernel bug and pr_err_ratelimited() is enough?

Best regards,
baolu
