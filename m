Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4722EB7CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbhAFBxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:53:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:48745 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbhAFBxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:53:03 -0500
IronPort-SDR: 8ktyD+EiB2iNIK8cY0JZ0I82yauyWWP0b2lKGapVBJBqji1h0f1POtP1T0DGu5Bk6PRdaNaqjo
 H5nuS5NkwnkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="156402499"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="156402499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 17:51:50 -0800
IronPort-SDR: k62Jq6/0eJrj291dQ2noAqaAEB9k7tjg6h5cogUPnrkcGX1/KN+vjAyRM00ySerYqGv1cImK1y
 sEBYmzmxi7Kw==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="361387910"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 17:51:50 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, ricardo.neri@intel.com, ravi.v.shankar@intel.com,
        kevin.tian@intel.com, ashok.raj@intel.com, sohil.mehta@intel.com,
        kyung.min.park@intel.com
Subject: [PATCH v4 2/3] iommu/vt-d: Move capability check code to cap_audit files
Date:   Tue,  5 Jan 2021 17:30:34 -0800
Message-Id: <20210106013035.6476-3-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106013035.6476-1-kyung.min.park@intel.com>
References: <20210106013035.6476-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move IOMMU capability check and sanity check code to cap_audit files.
Also implement some helper functions for sanity checks.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/cap_audit.c | 20 +++++++++
 drivers/iommu/intel/cap_audit.h | 20 +++++++++
 drivers/iommu/intel/iommu.c     | 76 +--------------------------------
 3 files changed, 42 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 4a062fc719d2..cf5326eb1d72 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -186,3 +186,23 @@ int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
 
 	return -EFAULT;
 }
+
+bool intel_cap_smts_sanity(void)
+{
+	return ecap_smts(intel_iommu_ecap_sanity);
+}
+
+bool intel_cap_pasid_sanity(void)
+{
+	return ecap_pasid(intel_iommu_ecap_sanity);
+}
+
+bool intel_cap_nest_sanity(void)
+{
+	return ecap_nest(intel_iommu_ecap_sanity);
+}
+
+bool intel_cap_flts_sanity(void)
+{
+	return ecap_flts(intel_iommu_ecap_sanity);
+}
diff --git a/drivers/iommu/intel/cap_audit.h b/drivers/iommu/intel/cap_audit.h
index 866236581dd3..1ce1dc314950 100644
--- a/drivers/iommu/intel/cap_audit.h
+++ b/drivers/iommu/intel/cap_audit.h
@@ -103,4 +103,24 @@ enum cap_audit_type {
 	CAP_AUDIT_HOTPLUG_IRQR,
 };
 
+bool intel_cap_smts_sanity(void);
+bool intel_cap_pasid_sanity(void);
+bool intel_cap_nest_sanity(void);
+bool intel_cap_flts_sanity(void);
+
+static inline bool scalable_mode_support(void)
+{
+	return (intel_iommu_sm && intel_cap_smts_sanity());
+}
+
+static inline bool pasid_mode_support(void)
+{
+	return scalable_mode_support() && intel_cap_pasid_sanity();
+}
+
+static inline bool nested_mode_support(void)
+{
+	return scalable_mode_support() && intel_cap_nest_sanity();
+}
+
 int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd8f41a5e4fa..75add2fd300a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1846,25 +1846,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  */
 static bool first_level_by_default(void)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	static int first_level_support = -1;
-
-	if (likely(first_level_support != -1))
-		return first_level_support;
-
-	first_level_support = 1;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu) || !ecap_flts(iommu->ecap)) {
-			first_level_support = 0;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return first_level_support;
+	return scalable_mode_support() && intel_cap_flts_sanity();
 }
 
 static struct dmar_domain *alloc_domain(int flags)
@@ -5666,60 +5648,6 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static inline bool scalable_mode_support(void)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu)) {
-			ret = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-static inline bool iommu_pasid_support(void)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!pasid_supported(iommu)) {
-			ret = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-static inline bool nested_mode_support(void)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
-			ret = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
@@ -5973,7 +5901,7 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		int ret;
 
 		if (!dev_is_pci(dev) || dmar_disabled ||
-		    !scalable_mode_support() || !iommu_pasid_support())
+		    !scalable_mode_support() || !pasid_mode_support())
 			return false;
 
 		ret = pci_pasid_features(to_pci_dev(dev));
-- 
2.17.1

