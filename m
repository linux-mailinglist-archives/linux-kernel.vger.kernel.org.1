Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3C27B5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgI1TvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbgI1TvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:51:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601322668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C3HwQ8qYd4WkWvfVg6zz1+L4DLHgUkRm8dpfDfGjxA=;
        b=bcL3iyxsCsF1z3D3tzzZZ+ezpVWcgp8D8LQ9A4iT352kwGNFtmmMHUz9HOyLoyQqXI+HjW
        shJIB3wHvPTMLT3r4A8Kq1UPfmXX7BLNLOvCHNyQE2AJv44C0FMqI13MxVvW+xTjQqIVVK
        7u0iFF0CEFmN9IfqZd3q2H4k2TaVqUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-rrV75QiSNjqjOBgS8Zbt0A-1; Mon, 28 Sep 2020 15:51:06 -0400
X-MC-Unique: rrV75QiSNjqjOBgS8Zbt0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1EE107466F;
        Mon, 28 Sep 2020 19:51:04 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D82C614F5;
        Mon, 28 Sep 2020 19:51:02 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, dwmw2@infradead.org,
        alex.williamson@redhat.com
Cc:     baolu.lu@linux.intel.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: [RFC 3/3] vfio/type1: Increase the version of VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
Date:   Mon, 28 Sep 2020 21:50:37 +0200
Message-Id: <20200928195037.22654-4-eric.auger@redhat.com>
In-Reply-To: <20200928195037.22654-1-eric.auger@redhat.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the IOVA regions beyond the dma_mask and the vfio aperture are
removed from the usable IOVA ranges, the API becomes reliable to
compute the max IOVA. Let's advertise this by using a new version
for the capability.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5fbf0c1f7433..af4596123954 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2541,7 +2541,7 @@ static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
 	struct vfio_iommu_type1_info_cap_iova_range *iova_cap;
 
 	header = vfio_info_cap_add(caps, size,
-				   VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE, 1);
+				   VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE, 2);
 	if (IS_ERR(header))
 		return PTR_ERR(header);
 
-- 
2.21.3

