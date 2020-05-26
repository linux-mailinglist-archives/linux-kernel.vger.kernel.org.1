Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC621CE9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgELA4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 20:56:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:36642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgELA4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:56:44 -0400
IronPort-SDR: dPzjwoyey3gUQQltb+nSo3m0UxDc+PoggIGzCY8cTY3pMI8ZZdHgIfRdBQrq32D9QvunBk7ZDl
 ehdbh/mFnipA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 17:56:44 -0700
IronPort-SDR: XYAQFo+BueaUWVa0XM+w/KKRDFC3wLPgIb72PX5SSozrARhVD5bg3Kk94OBjGEGgwgi/fdkD61
 g8i4DI5Pla1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="286458420"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 17:56:42 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 4/5] iommu/vt-d: Add page request draining support
Date:   Tue, 12 May 2020 08:53:06 +0800
Message-Id: <20200512005307.19860-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512005307.19860-1-baolu.lu@linux.intel.com>
References: <20200512005307.19860-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PASID is stopped or terminated, there can be pending PRQs
(requests that haven't received responses) in remapping hardware.
This adds the interface to drain page requests and call it when a
PASID is terminated.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 107 ++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |   4 ++
 2 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9561ba59a170..84cc263cec47 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -23,6 +23,7 @@
 #include "intel-pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
+static void intel_svm_drain_prq(struct device *dev, int pasid);
 
 #define PRQ_ORDER 0
 
@@ -66,6 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
 	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
 
+	init_completion(&iommu->prq_complete);
+
 	return 0;
 }
 
@@ -403,12 +406,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 			list_del_rcu(&sdev->list);
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
+			intel_svm_drain_prq(dev, svm->pasid);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
-			/* TODO: Drain in flight PRQ for the PASID since it
-			 * may get reused soon, we don't want to
-			 * confuse with its previous life.
-			 * intel_svm_drain_prq(dev, pasid);
-			 */
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
@@ -647,6 +646,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
+			intel_svm_drain_prq(dev, svm->pasid);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
@@ -725,6 +725,93 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
+/**
+ * intel_svm_drain_prq - Drain page requests and responses for a pasid
+ * @dev: target device
+ * @pasid: pasid for draining
+ *
+ * Drain all pending page requests and responses related to @pasid in both
+ * software and hardware. This is supposed to be called after the device
+ * driver has stopped DMA, the pasid entry has been cleared, and both IOTLB
+ * and DevTLB have been invalidated.
+ *
+ * It waits until all pending page requests for @pasid in the page fault
+ * queue are completed by the prq handling thread. Then follow the steps
+ * described in VT-d spec CH7.10 to drain all page requests and page
+ * responses pending in the hardware.
+ */
+static void intel_svm_drain_prq(struct device *dev, int pasid)
+{
+	struct device_domain_info *info;
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	struct qi_desc desc[3];
+	struct pci_dev *pdev;
+	int head, tail;
+	u16 sid, did;
+	int qdep;
+
+	info = get_domain_info(dev);
+	if (WARN_ON(!info || !dev_is_pci(dev)))
+		return;
+
+	if (!info->pri_enabled)
+		return;
+
+	iommu = info->iommu;
+	domain = info->domain;
+	pdev = to_pci_dev(dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+	did = domain->iommu_did[iommu->seq_id];
+	qdep = pci_ats_queue_depth(pdev);
+
+	/*
+	 * Check and wait until all pending page requests in the queue are
+	 * handled by the prq handling thread.
+	 */
+prq_retry:
+	reinit_completion(&iommu->prq_complete);
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	while (head != tail) {
+		struct page_req_dsc *req;
+
+		req = &iommu->prq[head / sizeof(*req)];
+		if (!req->pasid_present || req->pasid != pasid) {
+			head = (head + sizeof(*req)) & PRQ_RING_MASK;
+			continue;
+		}
+
+		wait_for_completion(&iommu->prq_complete);
+		goto prq_retry;
+	}
+
+	/*
+	 * Perform steps described in VT-d spec CH7.10 to drain page
+	 * requests and responses in hardware.
+	 */
+	memset(desc, 0, sizeof(desc));
+	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
+			QI_IWD_FENCE |
+			QI_IWD_TYPE;
+	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
+			QI_EIOTLB_DID(did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+			QI_EIOTLB_TYPE;
+	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
+			QI_DEV_EIOTLB_SID(sid) |
+			QI_DEV_EIOTLB_QDEP(qdep) |
+			QI_DEIOTLB_TYPE |
+			QI_DEV_IOTLB_PFSID(info->pfsid);
+qi_retry:
+	reinit_completion(&iommu->prq_complete);
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		wait_for_completion(&iommu->prq_complete);
+		goto qi_retry;
+	}
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -860,6 +947,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
 
+	/*
+	 * Clear the page request overflow bit and wake up all threads that
+	 * are waiting for the completion of this handling.
+	 */
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO)
+		writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+
+	if (!completion_done(&iommu->prq_complete))
+		complete(&iommu->prq_complete);
+
 	return IRQ_RETVAL(handled);
 }
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index cca1e5f9aeaa..a0512b401a59 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -292,6 +292,8 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_PRS_PRO	((u32)2)
+
 #define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
@@ -333,6 +335,7 @@ enum {
 
 #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
 #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
+#define QI_IWD_FENCE		(((u64)1) << 6)
 #define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
 
 #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
@@ -590,6 +593,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct completion prq_complete;
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.17.1

