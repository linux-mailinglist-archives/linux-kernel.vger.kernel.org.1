Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089F4303C37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405188AbhAZLzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392582AbhAZLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611662034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=HK5zgv0TzAJp0znH+yS6WzPBPy1aDuG2HqE9/6xDyzU=;
        b=d2djHxGJbxdRemqJ7LWPLJqML9M6K6ZbanUgKXOOCxs17M6sWVfMoP9NxvRpaXlTkMhkE+
        /IpUIyHY5LI5hGqFtCfCxgW5MHZfaFHJJrCkXT9vyaVEJQoY9/azTx09RA/ZzjxR9ieUcc
        Q+aAauSjVtC/pFaYkSGEFkoV3CMVlZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-rV-Y6hZ2N0a7k4l6cWv2BQ-1; Tue, 26 Jan 2021 06:53:51 -0500
X-MC-Unique: rV-Y6hZ2N0a7k4l6cWv2BQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754CB801FCC;
        Tue, 26 Jan 2021 11:53:49 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4319110023AB;
        Tue, 26 Jan 2021 11:53:44 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        jsnitsel@redhat.com, thomas.lendacky@amd.com, robin.murphy@arm.com,
        bhe@redhat.com, hch@infradead.org, baolu.lu@linux.intel.com
Subject: [PATCH v3 1/2] dma-iommu: use static-key to minimize the impact in the fast-path
Date:   Tue, 26 Jan 2021 19:53:36 +0800
Message-Id: <20210126115337.20068-2-lijiang@redhat.com>
In-Reply-To: <20210126115337.20068-1-lijiang@redhat.com>
References: <20210126115337.20068-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move out the is_kdump_kernel() check from iommu_dma_deferred_attach()
to iommu_dma_init(), and use the static-key in the fast-path to minimize
the impact in the normal case.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4078358ed66e..c80056f6c9f9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -51,6 +51,8 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
+
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain)
 {
@@ -383,9 +385,6 @@ static int iommu_dma_deferred_attach(struct device *dev,
 {
 	const struct iommu_ops *ops = domain->ops;
 
-	if (!is_kdump_kernel())
-		return 0;
-
 	if (unlikely(ops->is_attach_deferred &&
 			ops->is_attach_deferred(domain, dev)))
 		return iommu_attach_device(domain, dev);
@@ -535,7 +534,8 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	size_t iova_off = iova_offset(iovad, phys);
 	dma_addr_t iova;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
 	size = iova_align(iovad, size + iova_off);
@@ -693,7 +693,8 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 
 	*dma_handle = DMA_MAPPING_ERROR;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return NULL;
 
 	min_size = alloc_sizes & -alloc_sizes;
@@ -976,7 +977,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return 0;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1424,6 +1426,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 static int iommu_dma_init(void)
 {
+	if (is_kdump_kernel())
+		static_branch_enable(&iommu_deferred_attach_enabled);
+
 	return iova_cache_get();
 }
 arch_initcall(iommu_dma_init);
-- 
2.17.1

