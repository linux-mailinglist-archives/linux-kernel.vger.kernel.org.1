Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682B329FBD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgJ3C62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:23856 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgJ3C6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:17 -0400
IronPort-SDR: M8nWjXFH30GTTZnpmzHLGigkUs5IiHWQJMucIblk06jaKrFqGgGuCQ/m7TZcC7/EgT/9MhgH76
 j1KlcJdxx+ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156326126"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="156326126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 19:58:16 -0700
IronPort-SDR: uL0VWrOYLs8oaetVA266Zi8E2ifbVqy3XTPqUkkhkLyIlQNQgyUd0gPHaw/vpg/xyDvhXrGEXc
 9QGAWFvV3VMA==
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="469374401"
Received: from yisun1-ubuntu2.bj.intel.com ([10.238.144.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 29 Oct 2020 19:58:14 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        jean-philippe@linaro.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.l.liu@intel.com, jacob.jun.pan@linux.intel.com,
        Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v2 1/2] iommu/vt-d: Fix sid not set issue in intel_svm_bind_gpasid()
Date:   Fri, 30 Oct 2020 10:37:23 +0800
Message-Id: <1604025444-6954-2-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

Should get correct sid and set it into sdev. Because we execute
'sdev->sid != req->rid' in the loop of prq_event_thread().

Fixes: eb8d93ea3c1d ("iommu/vt-d: Report page request faults for guest SVA")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f1861fa..7584669 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -279,6 +279,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev = NULL;
 	struct dmar_domain *dmar_domain;
+	struct device_domain_info *info;
 	struct intel_svm *svm = NULL;
 	int ret = 0;
 
@@ -310,6 +311,10 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
 		return -EINVAL;
 
+	info = get_domain_info(dev);
+	if (!info)
+		return -EINVAL;
+
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
@@ -357,6 +362,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		goto out;
 	}
 	sdev->dev = dev;
+	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	/* Only count users if device has aux domains */
 	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
-- 
2.7.4

