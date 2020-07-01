Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510B0210F32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbgGAP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:27:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:54824 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732022AbgGAP12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:27:28 -0400
IronPort-SDR: nrV4yNxET3yD85Ukv1hiMfL6UornXzTUKyDABJNWAw0ApVXxwFyLSAvRq5jHm2o1YL7pJoQNee
 g4mr3bLTFOaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126699722"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="126699722"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:27:23 -0700
IronPort-SDR: o3kPELFdh3tJaTgju06GQE4B3xyVAEGLqog6K3SnGHeZ0Qz4vdr0fO1PKiAf9yDUcu4NYJJNHY
 d5+1AbHcsYKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="295591658"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2020 08:27:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
Date:   Wed,  1 Jul 2020 08:33:56 -0700
Message-Id: <1593617636-79385-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the unlikely use case where multiple aux domains from the same pdev
are attached to a single guest and then bound to a single process
(thus same PASID) within that guest, we cannot easily support this case
by refcounting the number of users. As there is only one SL page table
per PASID while we have multiple aux domains thus multiple SL page tables
for the same PASID.

Extra unbinding guest PASID can happen due to race between normal and
exception cases. Termination of one aux domain may affect others unless
we actively track and switch aux domains to ensure the validity of SL
page tables and TLB states in the shared PASID entry.

Support for sharing second level PGDs across domains can reduce the
complexity but this is not available due to the limitations on VFIO
container architecture. We can revisit this decision once sharing PGDs
are available.

Overall, the complexity and potential glitch do not warrant this unlikely
use case thereby removed by this patch.

Fixes: 56722a4398a30 ("iommu/vt-d: Add bind guest PASID support")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6c87c807a0ab..d386853121a2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -277,20 +277,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			goto out;
 		}
 
+		/*
+		 * Do not allow multiple bindings of the same device-PASID since
+		 * there is only one SL page tables per PASID. We may revisit
+		 * once sharing PGD across domains are supported.
+		 */
 		for_each_svm_dev(sdev, svm, dev) {
-			/*
-			 * For devices with aux domains, we should allow
-			 * multiple bind calls with the same PASID and pdev.
-			 */
-			if (iommu_dev_feature_enabled(dev,
-						      IOMMU_DEV_FEAT_AUX)) {
-				sdev->users++;
-			} else {
-				dev_warn_ratelimited(dev,
-						     "Already bound with PASID %u\n",
-						     svm->pasid);
-				ret = -EBUSY;
-			}
+			dev_warn_ratelimited(dev,
+					     "Already bound with PASID %u\n",
+					     svm->pasid);
+			ret = -EBUSY;
 			goto out;
 		}
 	} else {
-- 
2.7.4

