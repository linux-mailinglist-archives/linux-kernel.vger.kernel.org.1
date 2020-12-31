Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362132E7D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 02:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgLaBDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 20:03:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:3107 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgLaBDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 20:03:21 -0500
IronPort-SDR: LsJxDLAhOfiHVUSdBAfcKRr95LzUhR79hG952FLVQvLpAImy4zBU2BXzVi4pDHxHkwCSqr+xN7
 bYuyLzsuwnxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="195158328"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="195158328"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 17:01:32 -0800
IronPort-SDR: V+LVHnOUFLusyl8gaHp7GxPAxgaZpx2PmwWTBWOwirBWJCXIaRMiWplzxvvzZbOXFCV0ASI7YL
 /rSlwEg5v4Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="460676233"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:25 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
Date:   Thu, 31 Dec 2020 08:53:21 +0800
Message-Id: <20201231005323.2178523-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
the iommu ops"), the trace events for dma map/unmap have no users any
more. Remove them so that they don't show up under
/sys/kernel/debug/tracing/events/intel_iommu. The users should use the
map/unmap traces defined in the iommu core from now on.

Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/trace/events/intel_iommu.h | 119 -----------------------------
 1 file changed, 119 deletions(-)

diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index 112bd06487bf..31c74202d8c3 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -16,125 +16,6 @@
 #include <linux/tracepoint.h>
 #include <linux/intel-iommu.h>
 
-DECLARE_EVENT_CLASS(dma_map,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-
-	TP_ARGS(dev, dev_addr, phys_addr, size),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(phys_addr_t, phys_addr)
-		__field(size_t,	size)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = dev_addr;
-		__entry->phys_addr = phys_addr;
-		__entry->size = size;
-	),
-
-	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
-		  __get_str(dev_name),
-		  (unsigned long long)__entry->dev_addr,
-		  (unsigned long long)__entry->phys_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_map, map_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
-DEFINE_EVENT(dma_map, bounce_map_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
-DECLARE_EVENT_CLASS(dma_unmap,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-
-	TP_ARGS(dev, dev_addr, size),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(size_t,	size)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = dev_addr;
-		__entry->size = size;
-	),
-
-	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
-		  __get_str(dev_name),
-		  (unsigned long long)__entry->dev_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_unmap, unmap_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DEFINE_EVENT(dma_unmap, unmap_sg,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DEFINE_EVENT(dma_unmap, bounce_unmap_single,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
-	TP_ARGS(dev, dev_addr, size)
-);
-
-DECLARE_EVENT_CLASS(dma_map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-
-	TP_ARGS(dev, index, total, sg),
-
-	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
-		__field(dma_addr_t, dev_addr)
-		__field(phys_addr_t, phys_addr)
-		__field(size_t,	size)
-		__field(int, index)
-		__field(int, total)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
-		__entry->dev_addr = sg->dma_address;
-		__entry->phys_addr = sg_phys(sg);
-		__entry->size = sg->dma_length;
-		__entry->index = index;
-		__entry->total = total;
-	),
-
-	TP_printk("dev=%s [%d/%d] dev_addr=0x%llx phys_addr=0x%llx size=%zu",
-		  __get_str(dev_name), __entry->index, __entry->total,
-		  (unsigned long long)__entry->dev_addr,
-		  (unsigned long long)__entry->phys_addr,
-		  __entry->size)
-);
-
-DEFINE_EVENT(dma_map_sg, map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-	TP_ARGS(dev, index, total, sg)
-);
-
-DEFINE_EVENT(dma_map_sg, bounce_map_sg,
-	TP_PROTO(struct device *dev, int index, int total,
-		 struct scatterlist *sg),
-	TP_ARGS(dev, index, total, sg)
-);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.25.1

