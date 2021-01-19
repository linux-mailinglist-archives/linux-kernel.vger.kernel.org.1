Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC82FB7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbhASLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731968AbhASLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611054994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=L6+c3Vrsc2G0Y6QY0bLM+Q44pFCn23ZD9DERi2fP1T0=;
        b=P4aQvQc0JUmvT3VPRGKACB8OYIZHG3I2dKuzmtgCT5cqmio9nQWXbGGsCebMckN3la9/b1
        4pviSL96F72ZZYOmawTTCFIqK45Ag4ATwRq090D6p3Zes6HFT6oE0M7sKNpdk73FhtS10U
        fUMVOC76vd8xlG95B51lPYO4Y2MvzBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-oaxPZWknMRCgquA9_si1og-1; Tue, 19 Jan 2021 06:16:32 -0500
X-MC-Unique: oaxPZWknMRCgquA9_si1og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F44F800D55;
        Tue, 19 Jan 2021 11:16:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40189709A6;
        Tue, 19 Jan 2021 11:16:27 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        jsnitsel@redhat.com, thomas.lendacky@amd.com, robin.murphy@arm.com,
        bhe@redhat.com
Subject: [PATCH 2/2 v2] iommu: use the __iommu_attach_device() directly for deferred attach
Date:   Tue, 19 Jan 2021 19:16:16 +0800
Message-Id: <20210119111616.12761-3-lijiang@redhat.com>
In-Reply-To: <20210119111616.12761-1-lijiang@redhat.com>
References: <20210119111616.12761-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, because domain attach allows to be deferred from iommu
driver to device driver, and when iommu initializes, the devices
on the bus will be scanned and the default groups will be allocated.

Due to the above changes, some devices could be added to the same
group as below:

[    3.859417] pci 0000:01:00.0: Adding to iommu group 16
[    3.864572] pci 0000:01:00.1: Adding to iommu group 16
[    3.869738] pci 0000:02:00.0: Adding to iommu group 17
[    3.874892] pci 0000:02:00.1: Adding to iommu group 17

But when attaching these devices, it doesn't allow that a group has
more than one device, otherwise it will return an error. This conflicts
with the deferred attaching. Unfortunately, it has two devices in the
same group for my side, for example:

[    9.627014] iommu_group_device_count(): device name[0]:0000:01:00.0
[    9.633545] iommu_group_device_count(): device name[1]:0000:01:00.1
...
[   10.255609] iommu_group_device_count(): device name[0]:0000:02:00.0
[   10.262144] iommu_group_device_count(): device name[1]:0000:02:00.1

Finally, which caused the failure of tg3 driver when tg3 driver calls
the dma_alloc_coherent() to allocate coherent memory in the tg3_test_dma().

[    9.660310] tg3 0000:01:00.0: DMA engine test failed, aborting
[    9.754085] tg3: probe of 0000:01:00.0 failed with error -12
[    9.997512] tg3 0000:01:00.1: DMA engine test failed, aborting
[   10.043053] tg3: probe of 0000:01:00.1 failed with error -12
[   10.288905] tg3 0000:02:00.0: DMA engine test failed, aborting
[   10.334070] tg3: probe of 0000:02:00.0 failed with error -12
[   10.578303] tg3 0000:02:00.1: DMA engine test failed, aborting
[   10.622629] tg3: probe of 0000:02:00.1 failed with error -12

In addition, the similar situations also occur in other drivers such
as the bnxt_en driver. That can be reproduced easily in kdump kernel
when SME is active

Let's move the handling currently in iommu_dma_deferred_attach() into
the iommu core code so that it can call the __iommu_attach_device()
directly instead of the iommu_attach_device(). The external interface
iommu_attach_device() is not suitable for handling this situation.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 drivers/iommu/dma-iommu.c | 18 +++---------------
 drivers/iommu/iommu.c     | 12 ++++++++++++
 include/linux/iommu.h     |  2 ++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3711b4a6e4f9..fa6f9098e77d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -380,18 +380,6 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
-static int iommu_dma_deferred_attach(struct device *dev,
-		struct iommu_domain *domain)
-{
-	const struct iommu_ops *ops = domain->ops;
-
-	if (unlikely(ops->is_attach_deferred &&
-			ops->is_attach_deferred(domain, dev)))
-		return iommu_attach_device(domain, dev);
-
-	return 0;
-}
-
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
@@ -535,7 +523,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	dma_addr_t iova;
 
 	if (static_branch_unlikely(&__deferred_attach) &&
-	    iommu_dma_deferred_attach(dev, domain))
+	    iommu_do_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
 	size = iova_align(iovad, size + iova_off);
@@ -694,7 +682,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	*dma_handle = DMA_MAPPING_ERROR;
 
 	if (static_branch_unlikely(&__deferred_attach) &&
-	    iommu_dma_deferred_attach(dev, domain))
+	    iommu_do_deferred_attach(dev, domain))
 		return NULL;
 
 	min_size = alloc_sizes & -alloc_sizes;
@@ -1005,7 +993,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	if (static_branch_unlikely(&__deferred_attach) &&
-	    iommu_dma_deferred_attach(dev, domain))
+	    iommu_do_deferred_attach(dev, domain))
 		return 0;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ffeebda8d6de..32164d355d2e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1980,6 +1980,18 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+int iommu_do_deferred_attach(struct device *dev,
+			     struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = domain->ops;
+
+	if (unlikely(ops->is_attach_deferred &&
+		     ops->is_attach_deferred(domain, dev)))
+		return __iommu_attach_device(domain, dev);
+
+	return 0;
+}
+
 /*
  * Check flags and other user provided data for valid combinations. We also
  * make sure no reserved fields or unused flags are set. This is to ensure
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..c04bbd30aa1d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -424,6 +424,8 @@ extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
+extern int iommu_do_deferred_attach(struct device *dev,
+				    struct iommu_domain *domain);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
-- 
2.17.1

