Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE320C504
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 02:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgF1AiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 20:38:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:54808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgF1AiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:38:00 -0400
IronPort-SDR: JSqxOMdJNQPogdkI695aXms/50xa5Vn2+RIsg3cfMn8HqAZbF/0KiqDJ9NxfzTy1r9yK+ppdk/
 +/APk1oaLg5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="144805160"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="144805160"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 17:37:59 -0700
IronPort-SDR: IGaiE1CSeOMVzu+4bKCt6VncimMiduyyjUds0IrbJTeZld/N4RyavWi8g1zo37eW+OLNW948OB
 pN3r+2T62nhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="302695017"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2020 17:37:57 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Report page request faults for guest SVA
Date:   Sun, 28 Jun 2020 08:33:31 +0800
Message-Id: <20200628003332.5720-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628003332.5720-1-baolu.lu@linux.intel.com>
References: <20200628003332.5720-1-baolu.lu@linux.intel.com>
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
callback.

Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 83 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c23167877b2b..4800bb6f8794 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -815,6 +815,69 @@ static void intel_svm_drain_prq(struct device *dev, int pasid)
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
+intel_svm_prq_report(struct intel_iommu *iommu, struct page_req_dsc *desc)
+{
+	struct iommu_fault_event event;
+	struct pci_dev *pdev;
+	u8 bus, devfn;
+	int ret = 0;
+
+	memset(&event, 0, sizeof(struct iommu_fault_event));
+	bus = PCI_BUS_NUM(desc->rid);
+	devfn = desc->rid & 0xff;
+	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
+
+	if (!pdev) {
+		pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
+		       bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		return -ENODEV;
+	}
+
+	/* Fill in event data for device specific processing */
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = desc->addr;
+	event.fault.prm.pasid = desc->pasid;
+	event.fault.prm.grpid = desc->prg_index;
+	event.fault.prm.perm = prq_to_iommu_prot(desc);
+
+	/*
+	 * Set last page in group bit if private data is present,
+	 * page response is required as it does for LPIG.
+	 */
+	if (desc->lpig)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (desc->pasid_present)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	if (desc->priv_data_present) {
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
+		memcpy(event.fault.prm.private_data, desc->priv_data,
+		       sizeof(desc->priv_data));
+	}
+
+	ret = iommu_report_device_fault(&pdev->dev, &event);
+	pci_dev_put(pdev);
+
+	return ret;
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -874,6 +937,19 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!is_canonical_address(address))
 			goto bad_req;
 
+		/*
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		if (svm->flags & SVM_FLAG_GUEST_MODE) {
+			int res = intel_svm_prq_report(iommu, req);
+
+			if (!res)
+				goto prq_advance;
+			else
+				goto bad_req;
+		}
+
 		/* If the mm is already defunct, don't handle faults. */
 		if (!mmget_not_zero(svm->mm))
 			goto bad_req;
@@ -892,10 +968,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto invalid;
 
 		result = QI_RESP_SUCCESS;
-	invalid:
+invalid:
 		mmap_read_unlock(svm->mm);
 		mmput(svm->mm);
-	bad_req:
+bad_req:
 		/* Accounting for major/minor faults? */
 		rcu_read_lock();
 		list_for_each_entry_rcu(sdev, &svm->devs, list) {
@@ -920,7 +996,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
 		svm = NULL;
-	no_pasid:
+no_pasid:
 		if (req->lpig || req->priv_data_present) {
 			/*
 			 * Per VT-d spec. v3.0 ch7.7, system software must
@@ -945,6 +1021,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			resp.qw3 = 0;
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
+prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
-- 
2.17.1

