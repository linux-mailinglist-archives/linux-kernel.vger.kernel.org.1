Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35927B7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgI1XOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgI1XOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:14:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601334844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pawf0Nt5qToWpEZxVrQjuGmslo4NTUl8RBE8gKS2hhE=;
        b=bFcWi1Qz9+cJSgb19E8yG/+BaVSuuIUu2QPM6x5+uFeca4F+YHUs0JOCCJtvZtQQu7yNRZ
        5Xn1Pqk8SFSifM14bIIpigFSgSHnCIaSB6NWOA38DJGDYRWHRjnADMTBNlNANBEnT3nEuu
        72qmi1OcqSdP3qRXe1qIkPnks+1OMZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-wZwDfrq6MYqXbig9Vv5OqA-1; Mon, 28 Sep 2020 18:42:32 -0400
X-MC-Unique: wZwDfrq6MYqXbig9Vv5OqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15086802B61;
        Mon, 28 Sep 2020 22:42:30 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F035960C11;
        Mon, 28 Sep 2020 22:42:26 +0000 (UTC)
Date:   Mon, 28 Sep 2020 16:42:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and
 iommu aperture
Message-ID: <20200928164224.12350d84@w520.home>
In-Reply-To: <20200928195037.22654-1-eric.auger@redhat.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 21:50:34 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> VFIO currently exposes the usable IOVA regions through the
> VFIO_IOMMU_GET_INFO ioctl / VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> capability. However it fails to take into account the dma_mask
> of the devices within the container. The top limit currently is
> defined by the iommu aperture.

I think that dma_mask is traditionally a DMA API interface for a device
driver to indicate to the DMA layer which mappings are accessible to the
device.  On the other hand, vfio makes use of the IOMMU API where the
driver is in userspace.  That userspace driver has full control of the
IOVA range of the device, therefore dma_mask is mostly irrelevant to
vfio.  I think the issue you're trying to tackle is that the IORT code
is making use of the dma_mask to try to describe a DMA address
limitation imposed by the PCI root bus, living between the endpoint
device and the IOMMU.  Therefore, if the IORT code is exposing a
topology or system imposed device limitation, this seems much more akin
to something like an MSI reserved range, where it's not necessarily the
device or the IOMMU with the limitation, but something that sits
between them.

> So, for instance, if the IOMMU supports up to 48bits, it may give
> the impression the max IOVA is 48b while a device may have a
> dma_mask of 42b. So this API cannot really be used to compute
> the max usable IOVA.
> 
> This patch removes the IOVA region beyond the dma_mask's.

Rather it adds a reserved region accounting for the range above the
device's dma_mask.  I don't think the IOMMU API should be consuming
dma_mask like this though.  For example, what happens in
pci_dma_configure() when there are no OF or ACPI DMA restrictions?  It
appears to me that the dma_mask from whatever previous driver had the
device carries over to the new driver.  That's generally ok for the DMA
API because a driver is required to set the device's DMA mask.  It
doesn't make sense however to blindly consume that dma_mask and export
it via an IOMMU API.  For example I would expect to see different
results depending on whether a host driver has been bound to a device.
It seems the correct IOMMU API approach would be for the IORT code to
specifically register reserved ranges for the device.

> As we start to expose this reserved region in the sysfs file
> /sys/kernel/iommu_groups/<n>/reserved_regions, we also need to
> handle the IOVA range beyond the IOMMU aperture to handle the case
> where the dma_mask would have a higher number of bits than the iommu
> max input address.

Why?  The IOMMU geometry already describes this and vfio combines both
the IOMMU geometry and the device reserved regions when generating the
IOVA ranges?  Who is going to consume this information?  Additionally
it appears that reserved regions will report different information
depending on whether a device is attached to a domain.

> This is a change to the ABI as this reserved region was not yet
> exposed in sysfs /sys/kernel/iommu_groups/<n>/reserved_regions or
> through the VFIO ioctl. At VFIO level we increment the version of
> the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE capability to advertise
> that change.

Is this really an ABI change?  The original entry for reserved regions
includes:

  Not necessarily all reserved regions are listed. This is typically
  used to output direct-mapped, MSI, non mappable regions.

I imagine the intention here was non-mappable relative to the IOMMU,
but non-mappable to the device is essentially what we're including
here.

I'm also concerned about bumping the vfio interface version for the
IOVA range.  We're not changing the interface, we're modifying the
result, and even then only for a fraction of users.  How many users are
potentially broken by that change?  Are we going to bump the version
for everyone any time the result changes on any platform?  Thanks,

Alex

