Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23212FB7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbhASLbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731962AbhASLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611054992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=clijVsuGJsN6v/S5oJ1Qq4eJ3SLfaT5+lOHt7h/o1/s=;
        b=D8aTwJA7ifzw4czuHMQ7a0f3T+90q0tYWddwO+vE0t7z1+vCIhqdRZlGvPJC66OMNpSp6Q
        f2tUdtO7Woax8DY1hKK3eleRB4M+OGpAfg0VewRGnk9Uf6QO35DJWzX0Tz86BgC64tQuXw
        ovtOndXla/UNwiB6UGZgJcSje1mRgAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-WWTcPQgNMgSsur4eOS4tkQ-1; Tue, 19 Jan 2021 06:16:29 -0500
X-MC-Unique: WWTcPQgNMgSsur4eOS4tkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD261926DA0;
        Tue, 19 Jan 2021 11:16:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CDA436FA;
        Tue, 19 Jan 2021 11:16:23 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        jsnitsel@redhat.com, thomas.lendacky@amd.com, robin.murphy@arm.com,
        bhe@redhat.com
Subject: [PATCH 1/2 v2] dma-iommu: use static-key to minimize the impact in the fast-path
Date:   Tue, 19 Jan 2021 19:16:15 +0800
Message-Id: <20210119111616.12761-2-lijiang@redhat.com>
In-Reply-To: <20210119111616.12761-1-lijiang@redhat.com>
References: <20210119111616.12761-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index f0305e6aac1b..3711b4a6e4f9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -51,6 +51,8 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+static DEFINE_STATIC_KEY_FALSE(__deferred_attach);
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
+	if (static_branch_unlikely(&__deferred_attach) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
 	size = iova_align(iovad, size + iova_off);
@@ -693,7 +693,8 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 
 	*dma_handle = DMA_MAPPING_ERROR;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&__deferred_attach) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return NULL;
 
 	min_size = alloc_sizes & -alloc_sizes;
@@ -1003,7 +1004,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&__deferred_attach) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return 0;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1451,6 +1453,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 static int iommu_dma_init(void)
 {
+	if (is_kdump_kernel())
+		static_branch_enable(&__deferred_attach);
+
 	return iova_cache_get();
 }
 arch_initcall(iommu_dma_init);
-- 
2.17.1

