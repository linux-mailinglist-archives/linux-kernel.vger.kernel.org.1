Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2321997C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 09:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgGIHKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 03:10:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:2905 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgGIHKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:10:21 -0400
IronPort-SDR: 2NNYCYJyO2OQ/H78+Qp2r52rRw4B0I1u2llOrBXJbDWjBjmZUIO0lPksfjnYBT2Dy1jvkVO1x9
 /at7vxvJKezg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="127534980"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="127534980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 00:10:20 -0700
IronPort-SDR: +Bg+OK1bmHNxsgsBcwnmv3uY3nFz6FYaYToM/YNsjsq5Ju9beVCgf3PcUmzVRFk38l0MRanFJk
 9d7Zr1cCeTNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="316138849"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2020 00:10:18 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/4] iommu/vt-d: Report page request faults for guest SVA
Date:   Thu,  9 Jul 2020 15:05:36 +0800
Message-Id: <20200709070537.18473-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709070537.18473-1-baolu.lu@linux.intel.com>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pasid might be bound to a page table from a VM guest via the iommu
ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
on the physical IOMMU, we need to inject the page fault request into
the guest. After the guest completes handling the page fault, a page
response need to be sent back via the iommu ops.page_response().

This adds support to report a page request fault. Any external module
which is interested in handling this fault should regiester a notifier
with iommu_register_device_fault_handler().

Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 103 +++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c23167877b2b..d24e71bac8db 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -815,8 +815,63 @@ static void intel_svm_drain_prq(struct device *dev, int pasid)
 	}
 }
 
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_FAULT_PERM_READ;
+	if (req->wr_req)
+		prot |= IOMMU_FAULT_PERM_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_FAULT_PERM_EXEC;
+	if (req->pm_req)
+		prot |= IOMMU_FAULT_PERM_PRIV;
+
+	return prot;
+}
+
+static int
+intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
+{
+	struct iommu_fault_event event;
+
+	/* Fill in event data for device specific processing */
+	memset(&event, 0, sizeof(struct iommu_fault_event));
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = desc->addr;
+	event.fault.prm.pasid = desc->pasid;
+	event.fault.prm.grpid = desc->prg_index;
+	event.fault.prm.perm = prq_to_iommu_prot(desc);
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	if (desc->lpig)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (desc->pasid_present) {
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+	}
+	if (desc->priv_data_present) {
+		/*
+		 * Set last page in group bit if private data is present,
+		 * page response is required as it does for LPIG.
+		 * iommu_report_device_fault() doesn't understand this vendor
+		 * specific requirement thus we set last_page as a workaround.
+		 */
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
+		memcpy(event.fault.prm.private_data, desc->priv_data,
+		       sizeof(desc->priv_data));
+	}
+
+	return iommu_report_device_fault(dev, &event);
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
+	struct intel_svm_dev *sdev = NULL;
 	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
 	int head, tail, handled = 0;
@@ -828,7 +883,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	while (head != tail) {
-		struct intel_svm_dev *sdev;
 		struct vm_area_struct *vma;
 		struct page_req_dsc *req;
 		struct qi_desc resp;
@@ -864,6 +918,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			}
 		}
 
+		if (!sdev || sdev->sid != req->rid) {
+			struct intel_svm_dev *t;
+
+			sdev = NULL;
+			rcu_read_lock();
+			list_for_each_entry_rcu(t, &svm->devs, list) {
+				if (t->sid == req->rid) {
+					sdev = t;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
+
 		result = QI_RESP_INVALID;
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
@@ -874,6 +942,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!is_canonical_address(address))
 			goto bad_req;
 
+		/*
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		if (svm->flags & SVM_FLAG_GUEST_MODE) {
+			if (sdev && !intel_svm_prq_report(sdev->dev, req))
+				goto prq_advance;
+			else
+				goto bad_req;
+		}
+
 		/* If the mm is already defunct, don't handle faults. */
 		if (!mmget_not_zero(svm->mm))
 			goto bad_req;
@@ -892,24 +971,11 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto invalid;
 
 		result = QI_RESP_SUCCESS;
-	invalid:
+invalid:
 		mmap_read_unlock(svm->mm);
 		mmput(svm->mm);
-	bad_req:
-		/* Accounting for major/minor faults? */
-		rcu_read_lock();
-		list_for_each_entry_rcu(sdev, &svm->devs, list) {
-			if (sdev->sid == req->rid)
-				break;
-		}
-		/* Other devices can go away, but the drivers are not permitted
-		 * to unbind while any page faults might be in flight. So it's
-		 * OK to drop the 'lock' here now we have it. */
-		rcu_read_unlock();
-
-		if (WARN_ON(&sdev->list == &svm->devs))
-			sdev = NULL;
-
+bad_req:
+		WARN_ON(!sdev);
 		if (sdev && sdev->ops && sdev->ops->fault_cb) {
 			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
 				(req->exe_req << 1) | (req->pm_req);
@@ -920,7 +986,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
 		svm = NULL;
-	no_pasid:
+no_pasid:
 		if (req->lpig || req->priv_data_present) {
 			/*
 			 * Per VT-d spec. v3.0 ch7.7, system software must
@@ -945,6 +1011,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			resp.qw3 = 0;
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
+prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
-- 
2.17.1

