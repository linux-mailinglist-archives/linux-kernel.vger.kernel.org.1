Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEA2A8546
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgKERrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:47:25 -0500
Received: from foss.arm.com ([217.140.110.172]:38670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKERrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:47:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E501142F;
        Thu,  5 Nov 2020 09:47:23 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CB3F3F719;
        Thu,  5 Nov 2020 09:47:22 -0800 (PST)
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus> <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo> <20201105164312.GD485884@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <483cd043-980e-81fb-cccb-385206a699df@arm.com>
Date:   Thu, 5 Nov 2020 17:47:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105164312.GD485884@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 16:43, Thierry Reding wrote:
> On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
>> On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
>>> On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
>>>> On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>
>>>>> Reserved memory regions can be marked as "active" if hardware is
>>>>> expected to access the regions during boot and before the operating
>>>>> system can take control. One example where this is useful is for the
>>>>> operating system to infer whether the region needs to be identity-
>>>>> mapped through an IOMMU.
>>>>
>>>> I like simple solutions, but this hardly seems adequate to solve the
>>>> problem of passing IOMMU setup from bootloader/firmware to the OS. Like
>>>> what is the IOVA that's supposed to be used if identity mapping is not
>>>> used?
>>>
>>> The assumption here is that if the region is not active there is no need
>>> for the IOVA to be specified because the kernel will allocate memory and
>>> assign any IOVA of its choosing.
>>>
>>> Also, note that this is not meant as a way of passing IOMMU setup from
>>> the bootloader or firmware to the OS. The purpose of this is to specify
>>> that some region of memory is actively being accessed during boot. The
>>> particular case that I'm looking at is where the bootloader set up a
>>> splash screen and keeps it on during boot. The bootloader has not set up
>>> an IOMMU mapping and the identity mapping serves as a way of keeping the
>>> accesses by the display hardware working during the transitional period
>>> after the IOMMU translations have been enabled by the kernel but before
>>> the kernel display driver has had a chance to set up its own IOMMU
>>> mappings.
>>>
>>>> If you know enough about the regions to assume identity mapping, then
>>>> can't you know if active or not?
>>>
>>> We could alternatively add some property that describes the region as
>>> requiring an identity mapping. But note that we can't make any
>>> assumptions here about the usage of these regions because the IOMMU
>>> driver simply has no way of knowing what they are being used for.
>>>
>>> Some additional information is required in device tree for the IOMMU
>>> driver to be able to make that decision.
>>
>> Rob, can you provide any hints on exactly how you want to move this
>> forward? I don't know in what direction you'd like to proceed.
> 
> Hi Rob,
> 
> do you have any suggestions on how to proceed with this? I'd like to get
> this moving again because it's something that's been nagging me for some
> months now. It also requires changes across two levels in the bootloader
> stack as well as Linux and it takes quite a bit of work to make all the
> changes, so before I go and rewrite everything I'd like to get the DT
> bindings sorted out first.
> 
> So just to summarize why I think this simple solution is good enough: it
> tries to solve a very narrow and simple problem. This is not an attempt
> at describing the firmware's full IOMMU setup to the kernel. In fact, it
> is primarily targetted at cases where the firmware hasn't setup an IOMMU
> at all, and we just want to make sure that when the kernel takes over
> and does want to enable the IOMMU, that all the regions that are
> actively being accessed by non-quiesced hardware (the most typical
> example would be a framebuffer scanning out a splat screen or animation,
> but it could equally well be some sort of welcoming tone or music being
> played back) are described in device tree.
> 
> In other words, and this is perhaps better answering your second
> question: in addition to describing reserved memory regions, we want to
> add a bit of information here about the usage of these memory regions.
> Some memory regions may contain information that the kernel may want to
> use (such an external memory frequency scaling tables) and those I would
> describe as "inactive" memory because it isn't being accessed by
> hardware. The framebuffer in this case is the opposite and it is being
> actively accessed (hence it is marked "active") by hardware while the
> kernel is busy setting everything up so that it can reconfigure that
> hardware and take over with its own framebuffer (for the console, for
> example). It's also not so much that we know enough about the region to
> assume it needs identity mapping. We don't really care about that from
> the DT point of view. In fact, depending on the rest of the system
> configuration, we may not need identity mapping (i.e. if none of the
> users of the reserved memory region are behind an IOMMU). But the point
> here is that the IOMMU drivers can use this "active" property to
> determine that if a device is using an "active" region and it is behind
> an IOMMU, then it must identity map that region in order for the
> hardware, which is not under the kernel's control yet, to be able to
> continue to access that memory through an IOMMU mapping.

Hmm, "active" is not a property of the memory itself, though, it's 
really a property of the device accessing it. If several distinct 
devices share a carveout region, and for simplicity the bootloader marks 
it as active because one of those devices happens to be using some part 
of it at boot, we don't really want to have to do all the reserved 
region setup for all the other devices unnecessarily, when all that 
matters is not disrupting one of them when resetting the IOMMU.

That leads to another possible hiccup - some bindings already have a 
defined meaning for a "memory-region" property. If we use that to point 
to some small region for a temporary low-resolution bootsplash screen 
for visibility to an IOMMU driver, the device's own driver might also 
interpret it as a private carveout from which it is expected to allocate 
everything, and thus could end up failing to work well or at all.

I agree that we should only need a relatively simple binding, and that 
piggybacking off reserved-memory nodes seems like an ideal way of 
getting address range descriptions without too much extra complexity; 
the tricky part is how best to associate those with the other 
information needed, which is really the "iommus" property of the 
relevant device, and how to make it as generically discoverable as 
possible. Perhaps it might be workable to follow almost the same 
approach but with a dedicated property (e.g. "active-memory-region") 
that the IOMMU code can simply scan the DT for to determine relevant 
device nodes. Otherwise properties on the IOMMU node itself would seem 
the next most practical option.

We've also finally got things going on the IORT RMR side[1], which helps 
add a bit more shape to things too; beyond the actual firmware parsing, 
DT and ACPI systems should definitely be converging on the same internal 
implementation in the IOMMU layer.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com/
