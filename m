Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6962E18EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgLWG2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:28:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:31824 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgLWG2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:28:46 -0500
IronPort-SDR: QrCDn/mPsEu067zGdQn8CzscIwy5VF6bxnwcG9BSTWXOBTqbll4Yf5r9hbv8la3M4rmdn3ptBf
 o/NqDdQoMZBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="163027479"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="163027479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 22:27:53 -0800
IronPort-SDR: WGXaI/Dk3DFMjRBTzmi2/8NIjS+mFn1z99YVnXDdvJcFSlM+Gq74zincqzLtuogdoWnXZhSly8
 tdAfLj/x+yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="338703599"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com) ([10.238.156.135])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2020 22:27:50 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        jacob.jun.pan@linux.intel.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, yi.l.liu@intel.com,
        jun.j.tian@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation for subdevices
Date:   Wed, 23 Dec 2020 14:27:20 +0800
Message-Id: <20201223062720.29364-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223062720.29364-1-yi.l.liu@intel.com>
References: <20201223062720.29364-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
loops the devices which are full-attached to the domain. For sub-devices,
this is ineffective. This results in invalid caching entries left on the
device. Fix it by adding loop for subdevices as well. Also, the domain->
has_iotlb_device needs to be updated when attaching to subdevices.

Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain attach/detach")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 63 +++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acfe0a5b955e..e97c5ac1d7fc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -726,6 +726,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	return nid;
 }
 
+static void domain_update_iotlb(struct dmar_domain *domain);
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
@@ -739,6 +741,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	 */
 	if (domain->nid == NUMA_NO_NODE)
 		domain->nid = domain_update_device_node(domain);
+
+	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 	return NULL;
 }
 
+static bool dev_iotlb_enabled(struct device_domain_info *info)
+{
+	struct pci_dev *pdev;
+
+	if (!info->dev || !dev_is_pci(info->dev))
+		return false;
+
+	pdev = to_pci_dev(info->dev);
+
+	return !!pdev->ats_enabled;
+}
+
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
@@ -1466,17 +1482,20 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 
 	assert_spin_locked(&device_domain_lock);
 
-	list_for_each_entry(info, &domain->devices, link) {
-		struct pci_dev *pdev;
-
-		if (!info->dev || !dev_is_pci(info->dev))
-			continue;
-
-		pdev = to_pci_dev(info->dev);
-		if (pdev->ats_enabled) {
+	list_for_each_entry(info, &domain->devices, link)
+		if (dev_iotlb_enabled(info)) {
 			has_iotlb_device = true;
 			break;
 		}
+
+	if (!has_iotlb_device) {
+		struct subdev_domain_info *sinfo;
+
+		list_for_each_entry(sinfo, &domain->subdevices, link_domain)
+			if (dev_iotlb_enabled(get_domain_info(sinfo->pdev))) {
+				has_iotlb_device = true;
+				break;
+			}
 	}
 
 	domain->has_iotlb_device = has_iotlb_device;
@@ -1557,25 +1576,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 #endif
 }
 
+static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
+				    u64 addr, unsigned int mask)
+{
+	u16 sid, qdep;
+
+	if (!info || !info->ats_enabled)
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+			   qdep, addr, mask);
+}
+
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	u16 sid, qdep;
 	unsigned long flags;
 	struct device_domain_info *info;
+	struct subdev_domain_info *sinfo;
 
 	if (!domain->has_iotlb_device)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->ats_enabled)
-			continue;
+	list_for_each_entry(info, &domain->devices, link)
+		__iommu_flush_dev_iotlb(info, addr, mask);
 
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				qdep, addr, mask);
+	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
+		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
+					addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
-- 
2.25.1

