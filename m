Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7642E6D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgL2D3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:29:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:40111 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgL2D3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:29:34 -0500
IronPort-SDR: hZQVQ0MRgl7LoyWtgbB67one7j4Z9N57RZk+X7C+cbGujSfMKFHUcUU0ELWS2evpU7OXyFoDrk
 3gDDRnJ7CRRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261204201"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="261204201"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 19:28:53 -0800
IronPort-SDR: jQXpMnPQGILCAqZBzOiiiZFI0RmXSH7f7diuIqua+f2Qt8vxKttjqx9F9eD127rmlSI9dYSC7C
 MxH8uvR6yNqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="392962898"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com) ([10.238.156.135])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2020 19:28:51 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, jun.j.tian@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation for subdevices
Date:   Tue, 29 Dec 2020 11:25:13 +0800
Message-Id: <20201229032513.486395-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229032513.486395-1-yi.l.liu@intel.com>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
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
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7720a836268..d48a60b61ba6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -719,6 +719,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	return nid;
 }
 
+static void domain_update_iotlb(struct dmar_domain *domain);
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
@@ -744,6 +746,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
 	else
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
+
+	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1464,17 +1468,22 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 
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
+		if (info && info->ats_enabled) {
 			has_iotlb_device = true;
 			break;
 		}
+
+	if (!has_iotlb_device) {
+		struct subdev_domain_info *sinfo;
+
+		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
+			info = get_domain_info(sinfo->pdev);
+			if (info && info->ats_enabled) {
+				has_iotlb_device = true;
+				break;
+			}
+		}
 	}
 
 	domain->has_iotlb_device = has_iotlb_device;
@@ -1555,25 +1564,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
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

