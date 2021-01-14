Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5382F5D04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbhANJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:14:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:44138 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbhANJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:14:12 -0500
IronPort-SDR: bM7pkbXhAYTaOpFxDQi48OePzlmd2q9etV+tgG3UgbAmQgukrJNm33BELl02c1CDez3jAMYRKz
 uas4waYJoeIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="242407238"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="242407238"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 01:12:25 -0800
IronPort-SDR: gEEbcp93x6S9GWz3wMSCRHA4+GfNELOpQvByPK2fHON94GrmT7df6kM5BzKhRvaeS7l5pszYkX
 NSYIVxwiljdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="465192041"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2021 01:12:23 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Add qi_submit trace event
Date:   Thu, 14 Jan 2021 17:04:00 +0800
Message-Id: <20210114090400.736104-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new trace event to track the submissions of requests to the
invalidation queue. This event will provide the information like:
- IOMMU name
- Invalidation type
- Descriptor raw data

A sample output like:
| qi_submit: iotlb_inv dmar1: 0x100e2 0x0 0x0 0x0
| qi_submit: dev_tlb_inv dmar1: 0x1000000003 0x7ffffffffffff001 0x0 0x0
| qi_submit: iotlb_inv dmar2: 0x800f2 0xf9a00005 0x0 0x0

This will be helpful for queued invalidation related debugging.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c         |  3 +++
 include/trace/events/intel_iommu.h | 37 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 004feaed3c72..bd51f33642e0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -31,6 +31,7 @@
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
+#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 
@@ -1307,6 +1308,8 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		offset = ((index + i) % QI_LENGTH) << shift;
 		memcpy(qi->desc + offset, &desc[i], 1 << shift);
 		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
+		trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
+				desc[i].qw2, desc[i].qw3);
 	}
 	qi->desc_status[wait_index] = QI_IN_USE;
 
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index 112bd06487bf..aad2ff0c1e2e 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -135,6 +135,43 @@ DEFINE_EVENT(dma_map_sg, bounce_map_sg,
 		 struct scatterlist *sg),
 	TP_ARGS(dev, index, total, sg)
 );
+
+TRACE_EVENT(qi_submit,
+	TP_PROTO(struct intel_iommu *iommu, u64 qw0, u64 qw1, u64 qw2, u64 qw3),
+
+	TP_ARGS(iommu, qw0, qw1, qw2, qw3),
+
+	TP_STRUCT__entry(
+		__field(u64, qw0)
+		__field(u64, qw1)
+		__field(u64, qw2)
+		__field(u64, qw3)
+		__string(iommu, iommu->name)
+	),
+
+	TP_fast_assign(
+		__assign_str(iommu, iommu->name);
+		__entry->qw0 = qw0;
+		__entry->qw1 = qw1;
+		__entry->qw2 = qw2;
+		__entry->qw3 = qw3;
+	),
+
+	TP_printk("%s %s: 0x%llx 0x%llx 0x%llx 0x%llx",
+		  __print_symbolic(__entry->qw0 & 0xf,
+				   { QI_CC_TYPE,	"cc_inv" },
+				   { QI_IOTLB_TYPE,	"iotlb_inv" },
+				   { QI_DIOTLB_TYPE,	"dev_tlb_inv" },
+				   { QI_IEC_TYPE,	"iec_inv" },
+				   { QI_IWD_TYPE,	"inv_wait" },
+				   { QI_EIOTLB_TYPE,	"p_iotlb_inv" },
+				   { QI_PC_TYPE,	"pc_inv" },
+				   { QI_DEIOTLB_TYPE,	"p_dev_tlb_inv" },
+				   { QI_PGRP_RESP_TYPE,	"page_grp_resp" }),
+		__get_str(iommu),
+		__entry->qw0, __entry->qw1, __entry->qw2, __entry->qw3
+	)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.25.1

