Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0331CE9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgELA4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 20:56:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:36642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgELA4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:56:46 -0400
IronPort-SDR: HZxcdUb/f+3tlaRxyYYERK0xEqP5xZ8vNJGpI19Zb8unaY4OZ4V1W+bYKe4s9IASu1UeqnZV5g
 rnrTzA2GEzlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 17:56:46 -0700
IronPort-SDR: jr7IzPvIgyAb4gLoDoVbyt/l90LGhGQQ3G7tBELtjQCTY9or0v30Q3lMbfmFQwNFFpDucGPrWY
 1TnsaqDBAPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="286458429"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 17:56:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 5/5] iommu/vt-d: Remove redundant IOTLB flush
Date:   Tue, 12 May 2020 08:53:07 +0800
Message-Id: <20200512005307.19860-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512005307.19860-1-baolu.lu@linux.intel.com>
References: <20200512005307.19860-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOTLB flush already included in the PASID tear down and the page request
drain process. There is no need to flush again.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-svm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 84cc263cec47..d8e19486523f 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -209,11 +209,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * *has* to handle gracefully without affecting other processes.
 	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+	list_for_each_entry_rcu(sdev, &svm->devs, list)
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
 					    svm->pasid, true);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
-	}
 	rcu_read_unlock();
 
 }
@@ -407,7 +405,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
 			intel_svm_drain_prq(dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
@@ -647,7 +644,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
 			intel_svm_drain_prq(dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-- 
2.17.1

