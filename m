Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59F2F65FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbhANQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:31:13 -0500
Received: from foss.arm.com ([217.140.110.172]:52544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbhANQbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:31:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCEAEED1;
        Thu, 14 Jan 2021 08:30:26 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6C63F70D;
        Thu, 14 Jan 2021 08:30:25 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
To:     Ajay Kumar <ajaykumar.rs1989@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Ajay Kumar <ajaykumar.rs@samsung.com>, mark.rutland@arm.com,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com>
 <20210107130319.GA2986@willie-the-truck>
 <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
 <CADe9J7Er0wnP5ZZbWM1CkUx7ry0znKr05Lvx7PEMdHuwKr_RZQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a47fbbc0-e904-006b-9bc4-92eca915f76b@arm.com>
Date:   Thu, 14 Jan 2021 16:30:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CADe9J7Er0wnP5ZZbWM1CkUx7ry0znKr05Lvx7PEMdHuwKr_RZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-12 20:29, Ajay Kumar wrote:
> On Tue, Jan 12, 2021 at 12:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-01-07 13:03, Will Deacon wrote:
>>> On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
>>>> When PCI function drivers(ex:pci-endpoint-test) are probed for already
>>>> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
>>>> then we encounter a situation where the function driver tries to attach
>>>> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
>>>> an already initialized STE. This causes ste_live BUG_ON() in the driver.
>>
>> Note that this is actually expected behaviour, since Stream ID aliasing
>> has remained officially not supported until a sufficiently compelling
>> reason to do so appears. I always thought the most likely scenario would
>> be a legacy PCI bridge with multiple devices behind it, but even that
>> seems increasingly improbable for a modern SMMUv3-based system to ever see.
> Thanks to Will and Robin for reviewing this. I am pretty new to PCI,
> sorry about that.
> I assumed that the support for stream-id alias is already handled as
> part of this patch:
> https://www.spinics.net/lists/arm-kernel/msg626087.html
> which prevents STE re-initialization. But, what I do not understand is
> why the path
> taken by the arm-smmu-v3 driver misses the aforementioned check for my usecase.

That case is where a single device, due to combinations of PCI DMA 
aliasing conditions, has multiple IDs of its own, and two or more of 
those IDs also happen to end up the same as each other. What you have is 
two distinct devices both claiming the same ID, since apparently they 
both represent the same underlying physical device (I don't know how the 
endpoint and pcieport drivers interoperate and/or coexist, but I can 
easily imagine that some liberties may be taken that the IOMMU layer 
doesn't really anticipate).

>>> I don't understand why the endpoint is using the same stream ID as the root
>>> complex in this case. Why is that? Is the grouping logic not working
>>> properly?
>>
>> It's not so much that it isn't working properly, it's more that it needs
>> to be implemented at all ;)
> The pci_endpoint_test picks up the same of_ DMA config node as the PCI RC
> because they sit on the same PCI bus [via pci_dma_configure( )]
> While in the arm-smmu-v3 driver, I can see that the pci_device_group( ) hands
> over the same iommu group as the Root Complex to the newly added master
> device (pci_endpoint_test in our case) because they share the same stream ID.
> Shouldn't they?

I'd imagine it's most likely that the PCI grouping rules are just 
putting everything together due to a lack of ACS. Either way, I'm pretty 
sure the PCI logic *doesn't* consider actual PCI devices having 
overlapping Requester IDs, because that isn't a real thing (how would 
config accesses work?). You can consider yourself lucky that the devices 
do happen to be grouped already in your particular case, but that 
doesn't change the fact that there's basically no point in trying to 
handle Stream ID aliasing within groups without properly implementing 
the grouping-by-Stream-ID logic in the first place (note that even 
distinct ACS-isolated PCI endpoints could still alias beyond the host 
bridge at the SMMU input if the system's translation from Requester ID 
space to Stream ID space isn't 1:1)

>>>> There is an already existing check in the driver to manage duplicated ids
>>>> if duplicated ids are added in same master device, but there can be
>>>> scenarios like above where we need to extend the check for other masters
>>>> using the same stream-id.
>>>>
>>>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>
>>> It doesn't feel like the driver is the right place to fix this, as the same
>>> issue could surely occur for other IOMMUs too, right? In which case, I think
>>> we should avoid getting into the situation where different groups have
>>> overlapping stream IDs.
>>
>> Yes, this patch does not represent the correct thing to do either way.
>> The main reason that Stream ID aliasing hasn't been supported so far is
>> that the required Stream ID to group lookup is rather awkward, and
>> adding all of that complexity just for the sake of a rather unlikely
>> possibility seemed dubious. However, PRI support has always had a more
>> pressing need to implement almost the same thing (Stream ID to device),
>> so once that lands we can finally get round to adding the rest of proper
>> group support relatively easily.
> I hope the support will be added soon. Also, can you point me to few drivers
> which already handle this type of stream-ID aliasing?

We handle it in the SMMUv2 driver - the way that architecture does 
stream mapping makes it really easy to hang group pointers off the S2CRs 
and have arm_smmu_master_alloc_smes() and arm_smmu_device_group() work 
nicely together. Unfortunately it's not feasible to take the same 
approach for SMMUv3, since the Stream Table there may be up to 2^32 
entries (vs. up to 128 S2CRs), and there just isn't enough room to 
encode a group pointer directly in an STE itself (you don't want to 
imagine how much time I've spent trying to think up schemes for that...)

Robin.
