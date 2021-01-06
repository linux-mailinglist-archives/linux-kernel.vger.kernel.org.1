Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E734C2ECB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 08:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbhAGHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 02:51:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:19927 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbhAGHvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:51:20 -0500
IronPort-SDR: prHvJ0n5KoCnSYnEnmhOGobVu2PCWvruSRVndboKF932nkGiWWXZ40RmWu7NRgOJqo/nQTE6Nf
 I6/+9Mmtfj0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="156577794"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="156577794"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 23:50:31 -0800
IronPort-SDR: zvJu60gQiuMjKGjz4BpZ+r0uDdEysFv1uBDV1rpEAxymaJlovjnAkSEXhna7R+Ngg2yDn494zw
 Ij/0+3SvLZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="351169626"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev2.bj.intel.com) ([10.238.156.135])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2021 23:50:29 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, yi.l.liu@intel.com, dan.carpenter@oracle.com
Subject: [PATCH v4 3/3] iommu/vt-d: Fix ineffective devTLB invalidation for subdevices
Date:   Thu,  7 Jan 2021 00:03:57 +0800
Message-Id: <1609949037-25291-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
References: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
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
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 53 +++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7720a8..65cf06d 100644
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
+		if (info->ats_enabled) {
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
+		info = get_domain_info(sinfo->pdev);
+		__iommu_flush_dev_iotlb(info, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
-- 
2.7.4

