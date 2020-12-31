Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A372C2E7D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 02:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgLaBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 20:03:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:3103 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgLaBDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 20:03:19 -0500
IronPort-SDR: lrmkp96jvtB2LxO56jBAtlTrYm9X3iYezvV6smLiLA4Wk3Szk50boUhv9nVNWV/99aM6AXVCFo
 3Gl4qzQtHukg==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="195158333"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="195158333"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 17:01:34 -0800
IronPort-SDR: VdyohXsM6+r+Lq5nvwH1B+WPcRdmYY9BkbiYe3k1ia9uo79YSHrJku1qlQwrqrvIGe+aa0J5dc
 CS7cH9fsZ4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="460676257"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:31 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Fix lockdep splat in sva bind()/unbind()
Date:   Thu, 31 Dec 2020 08:53:23 +0800
Message-Id: <20201231005323.2178523-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock(&iommu->lock) without disabling irq causes lockdep warnings.

========================================================
WARNING: possible irq lock inversion dependency detected
5.11.0-rc1+ #828 Not tainted
--------------------------------------------------------
kworker/0:1H/120 just changed the state of lock:
ffffffffad9ea1b8 (device_domain_lock){..-.}-{2:2}, at:
iommu_flush_dev_iotlb.part.0+0x32/0x120
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&iommu->lock){+.+.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&iommu->lock);
                               local_irq_disable();
                               lock(device_domain_lock);
                               lock(&iommu->lock);
  <Interrupt>
    lock(device_domain_lock);

 *** DEADLOCK ***

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b16a4791acfb..18a9f05df407 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -299,6 +299,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain;
 	struct device_domain_info *info;
 	struct intel_svm *svm = NULL;
+	unsigned long iflags;
 	int ret = 0;
 
 	if (WARN_ON(!iommu) || !data)
@@ -400,12 +401,12 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	 * each bind of a new device even with an existing PASID, we need to
 	 * call the nested mode setup function here.
 	 */
-	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       (pgd_t *)(uintptr_t)data->gpgd,
 				       data->hpasid, &data->vendor.vtd, dmar_domain,
 				       data->addr_width);
-	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&iommu->lock, iflags);
 	if (ret) {
 		dev_err_ratelimited(dev, "Failed to set up PASID %llu in nested mode, Err %d\n",
 				    data->hpasid, ret);
@@ -505,6 +506,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
+	unsigned long iflags;
 	int pasid_max;
 	int ret;
 
@@ -624,14 +626,14 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 			}
 		}
 
-		spin_lock(&iommu->lock);
+		spin_lock_irqsave(&iommu->lock, iflags);
 		ret = intel_pasid_setup_first_level(iommu, dev,
 				mm ? mm->pgd : init_mm.pgd,
 				svm->pasid, FLPT_DEFAULT_DID,
 				(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
 				(cpu_feature_enabled(X86_FEATURE_LA57) ?
 				 PASID_FLAG_FL5LP : 0));
-		spin_unlock(&iommu->lock);
+		spin_unlock_irqrestore(&iommu->lock, iflags);
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
@@ -651,14 +653,14 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		 * Binding a new device with existing PASID, need to setup
 		 * the PASID entry.
 		 */
-		spin_lock(&iommu->lock);
+		spin_lock_irqsave(&iommu->lock, iflags);
 		ret = intel_pasid_setup_first_level(iommu, dev,
 						mm ? mm->pgd : init_mm.pgd,
 						svm->pasid, FLPT_DEFAULT_DID,
 						(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
 						(cpu_feature_enabled(X86_FEATURE_LA57) ?
 						PASID_FLAG_FL5LP : 0));
-		spin_unlock(&iommu->lock);
+		spin_unlock_irqrestore(&iommu->lock, iflags);
 		if (ret) {
 			kfree(sdev);
 			goto out;
-- 
2.25.1

