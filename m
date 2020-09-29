Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DC27BDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgI2HSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbgI2HSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:18:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601363916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqDN9tUnkCAER2xt9wvJ3nQcMuC2iXObTaiCP0dBqfw=;
        b=HrM0UiNPDBHYB7eCeC9qdPuP/b/1++HrEx6WYZKX2hefrIBfSPPYF3GSuh6LgLSYtPY8pV
        Sk63B44KmFo3QKkWyANoGyN6nIXWa1ibuXLW9iIrPOLTW3KEV9C1qXrVyJ4b/E1OAWKie1
        GhIOt8FALZdD9rXrWjO6qe3ecYqGjjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-8w6kPzPOOnmTtrT2E7qrZQ-1; Tue, 29 Sep 2020 03:18:32 -0400
X-MC-Unique: 8w6kPzPOOnmTtrT2E7qrZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C57C1005513;
        Tue, 29 Sep 2020 07:18:30 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 050F710013BD;
        Tue, 29 Sep 2020 07:18:23 +0000 (UTC)
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and
 iommu aperture
To:     Alex Williamson <alex.williamson@redhat.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        dwmw2@infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928164224.12350d84@w520.home>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1cbaf3e7-cf88-77f6-4cc4-46dcd60eb649@redhat.com>
Date:   Tue, 29 Sep 2020 09:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200928164224.12350d84@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[also correcting some outdated email addresses + adding Lorenzo in cc]

On 9/29/20 12:42 AM, Alex Williamson wrote:
> On Mon, 28 Sep 2020 21:50:34 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> VFIO currently exposes the usable IOVA regions through the
>> VFIO_IOMMU_GET_INFO ioctl / VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
>> capability. However it fails to take into account the dma_mask
>> of the devices within the container. The top limit currently is
>> defined by the iommu aperture.
> 
> I think that dma_mask is traditionally a DMA API interface for a device
> driver to indicate to the DMA layer which mappings are accessible to the
> device.  On the other hand, vfio makes use of the IOMMU API where the
> driver is in userspace.  That userspace driver has full control of the
> IOVA range of the device, therefore dma_mask is mostly irrelevant to
> vfio.  I think the issue you're trying to tackle is that the IORT code
> is making use of the dma_mask to try to describe a DMA address
> limitation imposed by the PCI root bus, living between the endpoint
> device and the IOMMU.  Therefore, if the IORT code is exposing a
> topology or system imposed device limitation, this seems much more akin
> to something like an MSI reserved range, where it's not necessarily the
> device or the IOMMU with the limitation, but something that sits
> between them.

First I think I failed to explain the context. I worked on NVMe
passthrough on ARM. The QEMU NVMe backend uses VFIO to program the
physical device. The IOVA allocator there currently uses an IOVA range
within [0x10000, 1ULL << 39]. This IOVA layout rather is arbitrary if I
understand correctly. I noticed we rapidly get some VFIO MAP DMA
failures because the allocated IOVA collide with the ARM MSI reserved
IOVA window [0x8000000, 0x8100000]. Since  9b77e5c79840 ("vfio/type1:
Check reserved region conflict and update iova list"), such VFIO MAP DMA
attempts to map IOVAs belonging to host reserved IOVA windows fail. So,
by using the VFIO_IOMMU_GET_INFO ioctl /
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE I can change the IOVA allocator to
avoid allocating within this range and others. While working on this, I
tried to automatically compute the min/max IOVAs and change the
arbitrary [0x10000, 1ULL << 39]. My SMMUv2 supports up to 48b so
naturally the max IOVA was computed as 1ULL << 48. The QEMU NVMe backend
allocates at the bottom and at the top of the range. I noticed the use
case was not working as soon as the top IOVA was more than 1ULL << 42.
And then we noticed the dma_mask was set to 42 by using
cat  /sys/bus/pci/devices/0005:01:00.0/dma_mask_bits. So my
interpretation is the dma_mask was somehow containing the info the
device couldn't handle IOVAs beyond a certain limit.

In my case the 42b limit is computed in iort_dma_setup() by
acpi_dma_get_range(dev, &dmaaddr, &offset, &size);

Referring to the comment, it does "Evaluate DMA regions and return
respectively DMA region start, offset and size in dma_addr, offset and
size on parsing success". This parses the ACPI table, looking for ACPI
companions with _DMA methods.

But as Alex mentioned, the IORT also allows to define limits on "the
number of address bits, starting from the least significant bit that can
be generated by a device when it accesses memory". See Named component
node.Device Memory Address Size limit or PCI root complex node. Memory
address size limit.

        ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
        if (ret == -ENODEV)
                ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
                                      : nc_dma_get_range(dev, &size);

So eventually those info collected from the ACPI tables which do impact
the usable IOVA range seem to be stored in the dma_mask, hence that
proposal.

> 
>> So, for instance, if the IOMMU supports up to 48bits, it may give
>> the impression the max IOVA is 48b while a device may have a
>> dma_mask of 42b. So this API cannot really be used to compute
>> the max usable IOVA.
>>
>> This patch removes the IOVA region beyond the dma_mask's.
> 
> Rather it adds a reserved region accounting for the range above the
> device's dma_mask.

Yep. It adds new reserved regions in
/sys/kernel/iommu_groups/<n>/reserved_regions and remove those from the
usable regions exposed by VFIO GET_INFO.

  I don't think the IOMMU API should be consuming
> dma_mask like this though.  For example, what happens in
> pci_dma_configure() when there are no OF or ACPI DMA restrictions?
My guess was that the dma_mask was set to the max range but I did not
test it.
  It
> appears to me that the dma_mask from whatever previous driver had the
> device carries over to the new driver.  That's generally ok for the DMA
> API because a driver is required to set the device's DMA mask.  It
> doesn't make sense however to blindly consume that dma_mask and export
> it via an IOMMU API.  For example I would expect to see different
> results depending on whether a host driver has been bound to a device.
> It seems the correct IOMMU API approach would be for the IORT code to
> specifically register reserved ranges for the device.

Is it only specific to IORT table? acpi_dma_get_range() in
drivers/acpi/scan.c is generic.

> 
>> As we start to expose this reserved region in the sysfs file
>> /sys/kernel/iommu_groups/<n>/reserved_regions, we also need to
>> handle the IOVA range beyond the IOMMU aperture to handle the case
>> where the dma_mask would have a higher number of bits than the iommu
>> max input address.
> 
> Why?  The IOMMU geometry already describes this and vfio combines both
> the IOMMU geometry and the device reserved regions when generating the
> IOVA ranges? 
Yes VFIO layer does add the info about the topology but
/sys/kernel/iommu_groups/<n>/reserved_regions, generated by the IOMMU
code, does not. this latter only exposes reserved regions. Assume the
dma_mask is 48b and the IOMMU aperture is 42b (assuming it is possible),
if you only take into account the "dma_mask" limitation, the end-user
will interpret this as: I can use up to 48b.

 Who is going to consume this information?  Additionally
> it appears that reserved regions will report different information
> depending on whether a device is attached to a domain.
yes that's correct. Well at some point we decided to expose (some)
reserved regions through sysfs. Only printing a reduced set of those
also can be misleading, hence my attempt to be more comprehensive.
> 
>> This is a change to the ABI as this reserved region was not yet
>> exposed in sysfs /sys/kernel/iommu_groups/<n>/reserved_regions or
>> through the VFIO ioctl. At VFIO level we increment the version of
>> the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE capability to advertise
>> that change.
> 
> Is this really an ABI change?  The original entry for reserved regions
> includes:
> 
>   Not necessarily all reserved regions are listed. This is typically
>   used to output direct-mapped, MSI, non mappable regions.

I agree. That's not really a change in the ABI but I wanted to make
things clear about the induced changes for the end-user. On the other
end there will be a change in the number of reported resv regions.
> 
> I imagine the intention here was non-mappable relative to the IOMMU,
> but non-mappable to the device is essentially what we're including
> here.
> 
> I'm also concerned about bumping the vfio interface version for the
> IOVA range.  We're not changing the interface, we're modifying the
> result, and even then only for a fraction of users.  How many users are
> potentially broken by that change?  Are we going to bump the version
> for everyone any time the result changes on any platform?  Thanks,

The userspace needs to know if the GET_INFO is reliable to compute the
min/max IOVAs. If we do not change the version, it cannot know and must
assume it is not. Wasn't the version field meant for that somehow?

Thanks

Eric
> 
> Alex
> 

