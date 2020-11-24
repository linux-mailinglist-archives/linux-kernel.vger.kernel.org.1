Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22942C1FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgKXI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:63905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKXI2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:31 -0500
IronPort-SDR: eDy4ftgTtJccn7OUAY1eT5c4oub9KQIxDzo/YXW9QEhzoHJn1xPRwWZ4KKopNfRhCbN3DaVZYU
 2dap9pfDrMag==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171129624"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171129624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:28:31 -0800
IronPort-SDR: boH4SooheGOgG1fz/kdQppBdAH2sb1DFXK3MFGqnMv5w3ppG60l7J0QfwbeehTImmdGfwq3BHU
 tqY4YrXSrNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432539715"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 00:28:28 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v6 2/7] iommu: Add iommu_dma_free_cpu_cached_iovas()
Date:   Tue, 24 Nov 2020 16:20:52 +0800
Message-Id: <20201124082057.2614359-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
References: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

Add a iommu_dma_free_cpu_cached_iovas function to allow drivers which
use the dma-iommu ops to free cached cpu iovas.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 include/linux/dma-iommu.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9c827a4d2207..de521e22bafb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -49,6 +49,15 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+
+	free_cpu_cached_iovas(cpu, iovad);
+}
+
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21f73d8..706b68d1359b 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -78,5 +81,10 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain)
+{
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
-- 
2.25.1

