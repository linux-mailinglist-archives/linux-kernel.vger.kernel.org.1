Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC0E1B39A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDVIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 04:09:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:3118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVIJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:09:25 -0400
IronPort-SDR: hVFHsqi6jxkyTGBM/TYcIS/SikadhyBBEj+B1dGrRbfUtCny/8gzuGUMzS1cmAq7W8GtCTE9v5
 OXBk9TCQMrwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 01:09:24 -0700
IronPort-SDR: UlaxMmyr+2XAw7r4e/MzMg07FMMcVh4Qp1vmPWv/DnU8FeOsWjZSIPhi28dkAaTmvHkyN4ykEZ
 PBjLAlEYQz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="365609624"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 01:09:22 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/4] iommu/vt-d: Multiple descriptors per qi_submit_sync()
Date:   Wed, 22 Apr 2020 16:06:08 +0800
Message-Id: <20200422080611.15689-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422080611.15689-1-baolu.lu@linux.intel.com>
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current qi_submit_sync() only supports single invalidation descriptor
per submission and appends wait descriptor after each submission to
poll the hardware completion. This extends the qi_submit_sync() helper
to support multiple descriptors, and add an option so that the caller
could specify the Page-request Drain (PD) bit in the wait descriptor.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c                | 63 +++++++++++++++++------------
 drivers/iommu/intel-pasid.c         |  4 +-
 drivers/iommu/intel-svm.c           |  6 +--
 drivers/iommu/intel_irq_remapping.c |  2 +-
 include/linux/intel-iommu.h         |  9 ++++-
 5 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index d9dc787feef7..61d049e91f84 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1157,12 +1157,11 @@ static inline void reclaim_free_desc(struct q_inval *qi)
 	}
 }
 
-static int qi_check_fault(struct intel_iommu *iommu, int index)
+static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
 	struct q_inval *qi = iommu->qi;
-	int wait_index = (index + 1) % QI_LENGTH;
 	int shift = qi_shift(iommu);
 
 	if (qi->desc_status[wait_index] == QI_ABORT)
@@ -1225,17 +1224,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 }
 
 /*
- * Submit the queued invalidation descriptor to the remapping
- * hardware unit and wait for its completion.
+ * Function to submit invalidation descriptors of all types to the queued
+ * invalidation interface(QI). Multiple descriptors can be submitted at a
+ * time, a wait descriptor will be appended to each submission to ensure
+ * hardware has completed the invalidation before return. Wait descriptors
+ * can be part of the submission but it will not be polled for completion.
  */
-int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
+int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
+		   unsigned int count, unsigned long options)
 {
-	int rc;
 	struct q_inval *qi = iommu->qi;
-	int offset, shift, length;
 	struct qi_desc wait_desc;
 	int wait_index, index;
 	unsigned long flags;
+	int offset, shift;
+	int rc, i;
 
 	if (!qi)
 		return 0;
@@ -1244,32 +1247,41 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 	rc = 0;
 
 	raw_spin_lock_irqsave(&qi->q_lock, flags);
-	while (qi->free_cnt < 3) {
+	/*
+	 * Check if we have enough empty slots in the queue to submit,
+	 * the calculation is based on:
+	 * # of desc + 1 wait desc + 1 space between head and tail
+	 */
+	while (qi->free_cnt < count + 2) {
 		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
 		cpu_relax();
 		raw_spin_lock_irqsave(&qi->q_lock, flags);
 	}
 
 	index = qi->free_head;
-	wait_index = (index + 1) % QI_LENGTH;
+	wait_index = (index + count) % QI_LENGTH;
 	shift = qi_shift(iommu);
-	length = 1 << shift;
 
-	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
+	for (i = 0; i < count; i++) {
+		offset = ((index + i) % QI_LENGTH) << shift;
+		memcpy(qi->desc + offset, &desc[i], 1 << shift);
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
+	}
+	qi->desc_status[wait_index] = QI_IN_USE;
 
-	offset = index << shift;
-	memcpy(qi->desc + offset, desc, length);
 	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
 			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
+	if (options & QI_OPT_WAIT_DRAIN)
+		wait_desc.qw0 |= QI_IWD_PRQ_DRAIN;
 	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
 	wait_desc.qw2 = 0;
 	wait_desc.qw3 = 0;
 
 	offset = wait_index << shift;
-	memcpy(qi->desc + offset, &wait_desc, length);
+	memcpy(qi->desc + offset, &wait_desc, 1 << shift);
 
-	qi->free_head = (qi->free_head + 2) % QI_LENGTH;
-	qi->free_cnt -= 2;
+	qi->free_head = (qi->free_head + count + 1) % QI_LENGTH;
+	qi->free_cnt -= count + 1;
 
 	/*
 	 * update the HW tail register indicating the presence of
@@ -1285,7 +1297,7 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 		 * a deadlock where the interrupt context can wait indefinitely
 		 * for free slots in the queue.
 		 */
-		rc = qi_check_fault(iommu, index);
+		rc = qi_check_fault(iommu, index, wait_index);
 		if (rc)
 			break;
 
@@ -1294,7 +1306,8 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 		raw_spin_lock(&qi->q_lock);
 	}
 
-	qi->desc_status[index] = QI_DONE;
+	for (i = 0; i < count; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
 
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
@@ -1318,7 +1331,7 @@ void qi_global_iec(struct intel_iommu *iommu)
 	desc.qw3 = 0;
 
 	/* should never fail */
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
@@ -1332,7 +1345,7 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
@@ -1356,7 +1369,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
@@ -1378,7 +1391,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 /* PASID-based IOTLB invalidation */
@@ -1419,7 +1432,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 /* PASID-based device IOTLB Invalidate */
@@ -1448,7 +1461,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	if (size_order)
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
@@ -1458,7 +1471,7 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
 
 	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
 			QI_PC_GRAN(granu) | QI_PC_TYPE;
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 /*
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 48cc9ca5f3dc..7969e3dac2ad 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -498,7 +498,7 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static void
@@ -512,7 +512,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static void
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e9f4e979a71f..83dc4319f661 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -138,7 +138,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 	}
 	desc.qw2 = 0;
 	desc.qw3 = 0;
-	qi_submit_sync(&desc, svm->iommu);
+	qi_submit_sync(svm->iommu, &desc, 1, 0);
 
 	if (sdev->dev_iotlb) {
 		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
@@ -162,7 +162,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 		}
 		desc.qw2 = 0;
 		desc.qw3 = 0;
-		qi_submit_sync(&desc, svm->iommu);
+		qi_submit_sync(svm->iommu, &desc, 1, 0);
 	}
 }
 
@@ -850,7 +850,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 				       sizeof(req->priv_data));
 			resp.qw2 = 0;
 			resp.qw3 = 0;
-			qi_submit_sync(&resp, iommu);
+			qi_submit_sync(iommu, &resp, 1, 0);
 		}
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 81e43c1df7ec..a042f123b091 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -151,7 +151,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	return qi_submit_sync(&desc, iommu);
+	return qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static int modify_irte(struct irq_2_iommu *irq_iommu,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index cfe720f10112..cca1e5f9aeaa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -333,6 +333,7 @@ enum {
 
 #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
 #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
+#define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
 
 #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
 #define QI_IOTLB_DR(dr) 	(((u64)dr) << 7)
@@ -710,7 +711,13 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  int pasid);
 
-extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
+int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
+		   unsigned int count, unsigned long options);
+/*
+ * Options used in qi_submit_sync:
+ * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
+ */
+#define QI_OPT_WAIT_DRAIN		BIT(0)
 
 extern int dmar_ir_support(void);
 
-- 
2.17.1

