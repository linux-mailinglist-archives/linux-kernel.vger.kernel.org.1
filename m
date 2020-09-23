Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCE275064
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIWFoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:44:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:35660 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgIWFoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:44:13 -0400
IronPort-SDR: g/MO4lQI9HdqG+EOzwhd2jDe+YMzSseFKGPw7RrMBcantFo36qrb6IuVUSWWMGlPBod5MDTywt
 1AAVbgMEHE6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="140265114"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="140265114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 22:44:11 -0700
IronPort-SDR: CkmKka6DBA6ajh/NWMmcSZBHr2cMIuifPtzoqLnwIXRahp8uvEDRyeUcEMggOqArX2oVhguqna
 hqdNfVFu4joQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="412892054"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2020 22:44:08 -0700
Cc:     baolu.lu@linux.intel.com, Intel-gfx@lists.freedesktop.org,
        Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu
 api
To:     Robin Murphy <robin.murphy@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com>
 <001f4446-7c43-9832-42d8-55dc4a13c2ae@linux.intel.com>
 <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
 <d4633137-136e-d96c-877a-b523018c51e7@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d2a5124-92ce-2cdd-42a4-d7a22aa4e02a@linux.intel.com>
Date:   Wed, 23 Sep 2020 13:38:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4633137-136e-d96c-877a-b523018c51e7@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 7:05 PM, Robin Murphy wrote:
>>>> With the previous version of the series I hit a problem on Ivybridge 
>>>> where apparently the dma engine width is not respected. At least 
>>>> that is my layman interpretation of the errors. From the older thread:
>>>>
>>>> <3> [209.526605] DMAR: intel_iommu_map: iommu width (39) is not 
>>>> sufficient for the mapped address (ffff008000)
>>>>
>>>> Relevant iommu boot related messages are:
>>>>
>>>> <6>[    0.184234] DMAR: Host address width 36
>>>> <6>[    0.184245] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
>>>> <6>[    0.184288] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 
>>>> c0000020e60262 ecap f0101a
>>>> <6>[    0.184308] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
>>>> <6>[    0.184337] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap 
>>>> c9008020660262 ecap f0105a
>>>> <6>[    0.184357] DMAR: RMRR base: 0x000000d8d28000 end: 
>>>> 0x000000d8d46fff
>>>> <6>[    0.184377] DMAR: RMRR base: 0x000000db000000 end: 
>>>> 0x000000df1fffff
>>>> <6>[    0.184398] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 
>>>> IOMMU 1
>>>> <6>[    0.184414] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
>>>> <6>[    0.184428] DMAR-IR: Queued invalidation will be enabled to 
>>>> support x2apic and Intr-remapping.
>>>> <6>[    0.185173] DMAR-IR: Enabled IRQ remapping in x2apic mode
>>>>
>>>> <6>[    0.878934] DMAR: No ATSR found
>>>> <6>[    0.878966] DMAR: dmar0: Using Queued invalidation
>>>> <6>[    0.879007] DMAR: dmar1: Using Queued invalidation
>>>>
>>>> <6>[    0.915032] DMAR: Intel(R) Virtualization Technology for 
>>>> Directed I/O
>>>> <6>[    0.915060] PCI-DMA: Using software bounce buffering for IO 
>>>> (SWIOTLB)
>>>> <6>[    0.915084] software IO TLB: mapped [mem 
>>>> 0xc80d4000-0xcc0d4000] (64MB)
>>>>
>>>> (Full boot log at 
>>>> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7054/fi-ivb-3770/boot0.txt, 
>>>> failures at 
>>>> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7054/fi-ivb-3770/igt@i915_selftest@live@blt.html.) 
>>>>
>>>>
>>>> Does this look familiar or at least plausible to you? Is this 
>>>> something your new series has fixed?
>>>
>>> This happens during attaching a domain to device. It has nothing to do
>>> with this patch series. I will look into this issue, but not in this
>>> email thread context.
>>
>> I am not sure what step is attaching domain to device, but these type 
>> messages:
>>
>> <3> [209.526605] DMAR: intel_iommu_map: iommu width (39) is not
>>  >> sufficient for the mapped address (ffff008000)
>>
>> They definitely appear to happen at runtime, as i915 is getting 
>> exercised by userspace.
> 
> AFAICS this certainly might be related to this series - iommu-dma will 

Oh! I looked at the wrong function. prepare_domain_attach_device()
prints a similar message which made me believe that it was not caused
by the this patches series.

> constrain IOVA allocation based on the domain geometry that the driver 
> reports, which in this case is set only once when first allocating the 
> domain. Thus it looks like both the dmar_domain->gaw adjustment in 
> prepare_domain_attach_device() and the domain_use_first_level() business 
> in intel_alloc_iova() effectively get lost in this conversion, since the 
> domain geometry never gets updated to reflect those additional constraints.

Sounds reasonable. I will look into the code and work out a fix.

> > Robin.
> 

Best regards,
baolu
