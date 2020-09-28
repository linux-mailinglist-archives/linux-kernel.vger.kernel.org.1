Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8EC27B5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgI1TvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgI1TvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:51:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601322664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iNKAwz7MdlqRrpBvwDfW+Xi4s3UXuDJ7jQBLRXyHSRk=;
        b=dzqruOhwFjP9xbjIq53ssHZsNiccSgOSUYvUjNv5RgQ8DVS8+85jqNuMxfNgDBNoyJUmrM
        XSJWCnIMzc5K3VewVQWKWBpAfFrABFKZiRrAUMCjpIstGlRTXKgB02CvMLzu2gFvpfltH7
        7ugBsvipmAWG6/nW3l280UVcAS1Kiz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-bmWu5N4PNQq4bQk8g_S4mw-1; Mon, 28 Sep 2020 15:50:58 -0400
X-MC-Unique: bmWu5N4PNQq4bQk8g_S4mw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86A7420EA;
        Mon, 28 Sep 2020 19:50:55 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F07E614F5;
        Mon, 28 Sep 2020 19:50:46 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, dwmw2@infradead.org,
        alex.williamson@redhat.com
Cc:     baolu.lu@linux.intel.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and iommu aperture
Date:   Mon, 28 Sep 2020 21:50:34 +0200
Message-Id: <20200928195037.22654-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO currently exposes the usable IOVA regions through the
VFIO_IOMMU_GET_INFO ioctl / VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
capability. However it fails to take into account the dma_mask
of the devices within the container. The top limit currently is
defined by the iommu aperture.

So, for instance, if the IOMMU supports up to 48bits, it may give
the impression the max IOVA is 48b while a device may have a
dma_mask of 42b. So this API cannot really be used to compute
the max usable IOVA.

This patch removes the IOVA region beyond the dma_mask's.
As we start to expose this reserved region in the sysfs file
/sys/kernel/iommu_groups/<n>/reserved_regions, we also need to
handle the IOVA range beyond the IOMMU aperture to handle the case
where the dma_mask would have a higher number of bits than the iommu
max input address.

This is a change to the ABI as this reserved region was not yet
exposed in sysfs /sys/kernel/iommu_groups/<n>/reserved_regions or
through the VFIO ioctl. At VFIO level we increment the version of
the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE capability to advertise
that change.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/dma_mask_rfc

Eric Auger (3):
  iommu: Fix merging in iommu_insert_resv_region
  iommu: Account for dma_mask and iommu aperture in IOVA reserved
    regions
  vfio/type1: Increase the version of
    VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE

 .../ABI/testing/sysfs-kernel-iommu_groups     |  7 ++++
 drivers/iommu/iommu.c                         | 41 ++++++++++++++++++-
 drivers/vfio/vfio_iommu_type1.c               |  2 +-
 3 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.21.3

