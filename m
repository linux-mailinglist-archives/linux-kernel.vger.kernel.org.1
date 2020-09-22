Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F013F27405B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIVLF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:05:57 -0400
Received: from foss.arm.com ([217.140.110.172]:35696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgIVLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7D6113E;
        Tue, 22 Sep 2020 04:05:56 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162F83F70D;
        Tue, 22 Sep 2020 04:05:54 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu
 api
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com>
 <001f4446-7c43-9832-42d8-55dc4a13c2ae@linux.intel.com>
 <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d4633137-136e-d96c-877a-b523018c51e7@arm.com>
Date:   Tue, 22 Sep 2020 12:05:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-15 09:31, Tvrtko Ursulin wrote:
> 
> On 15/09/2020 02:47, Lu Baolu wrote:
>> Hi Tvrtko,
>>
>> On 9/14/20 4:04 PM, Tvrtko Ursulin wrote:
>>>
>>> Hi,
>>>
>>> On 12/09/2020 04:21, Lu Baolu wrote:
>>>> Tom Murphy has almost done all the work. His latest patch series was
>>>> posted here.
>>>>
>>>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/ 
>>>>
>>>>
>>>> Thanks a lot!
>>>>
>>>> This series is a follow-up with below changes:
>>>>
>>>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>>>> letter.
>>>
>>> Last week I have copied you on an i915 series which appears to remove 
>>> the need for this quirk. so if we get those i915 patches reviewed and 
>>> merged, do you still want to pursue this quirk?
>>
>> It's up to the graphic guys. I don't know the details in i915 driver.
>> I don't think my tests could cover all cases.
> 
> I am the graphic guy. :) I just need some reviews (internally) for my 
> series and then we can merge it, at which point you don't need the quirk 
> patch any more. I'll try to accelerate this.
> 
> With regards to testing, you could send your series with my patches on 
> top to our trybot mailing list (intel-gfx-trybot@lists.freedesktop.org / 
> https://patchwork.freedesktop.org/project/intel-gfx-trybot/series/?ordering=-last_updated) 
> which would show you if it is still hitting the DMAR issues in i915.
> 
>>>
>>>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>>>> bounce buffers" to make the bounce buffer work for untrusted devices.
>>>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>>
>>> With the previous version of the series I hit a problem on Ivybridge 
>>> where apparently the dma engine width is not respected. At least that 
>>> is my layman interpretation of the errors. From the older thread:
>>>
>>> <3> [209.526605] DMAR: intel_iommu_map: iommu width (39) is not 
>>> sufficient for the mapped address (ffff008000)
>>>
>>> Relevant iommu boot related messages are:
>>>
>>> <6>[    0.184234] DMAR: Host address width 36
>>> <6>[    0.184245] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
>>> <6>[    0.184288] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 
>>> c0000020e60262 ecap f0101a
>>> <6>[    0.184308] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
>>> <6>[    0.184337] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap 
>>> c9008020660262 ecap f0105a
>>> <6>[    0.184357] DMAR: RMRR base: 0x000000d8d28000 end: 
>>> 0x000000d8d46fff
>>> <6>[    0.184377] DMAR: RMRR base: 0x000000db000000 end: 
>>> 0x000000df1fffff
>>> <6>[    0.184398] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 
>>> IOMMU 1
>>> <6>[    0.184414] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
>>> <6>[    0.184428] DMAR-IR: Queued invalidation will be enabled to 
>>> support x2apic and Intr-remapping.
>>> <6>[    0.185173] DMAR-IR: Enabled IRQ remapping in x2apic mode
>>>
>>> <6>[    0.878934] DMAR: No ATSR found
>>> <6>[    0.878966] DMAR: dmar0: Using Queued invalidation
>>> <6>[    0.879007] DMAR: dmar1: Using Queued invalidation
>>>
>>> <6>[    0.915032] DMAR: Intel(R) Virtualization Technology for 
>>> Directed I/O
>>> <6>[    0.915060] PCI-DMA: Using software bounce buffering for IO 
>>> (SWIOTLB)
>>> <6>[    0.915084] software IO TLB: mapped [mem 0xc80d4000-0xcc0d4000] 
>>> (64MB)
>>>
>>> (Full boot log at 
>>> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7054/fi-ivb-3770/boot0.txt, 
>>> failures at 
>>> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7054/fi-ivb-3770/igt@i915_selftest@live@blt.html.) 
>>>
>>>
>>> Does this look familiar or at least plausible to you? Is this 
>>> something your new series has fixed?
>>
>> This happens during attaching a domain to device. It has nothing to do
>> with this patch series. I will look into this issue, but not in this
>> email thread context.
> 
> I am not sure what step is attaching domain to device, but these type 
> messages:
> 
> <3> [209.526605] DMAR: intel_iommu_map: iommu width (39) is not
>  >> sufficient for the mapped address (ffff008000)
> 
> They definitely appear to happen at runtime, as i915 is getting 
> exercised by userspace.

AFAICS this certainly might be related to this series - iommu-dma will 
constrain IOVA allocation based on the domain geometry that the driver 
reports, which in this case is set only once when first allocating the 
domain. Thus it looks like both the dmar_domain->gaw adjustment in 
prepare_domain_attach_device() and the domain_use_first_level() business 
in intel_alloc_iova() effectively get lost in this conversion, since the 
domain geometry never gets updated to reflect those additional constraints.

Robin.

> 
> Regards,
> 
> Tvrtko
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
