Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C8B19DE15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404551AbgDCSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 14:36:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:4672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404351AbgDCSg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:36:29 -0400
IronPort-SDR: rNb+AClTldkUPCMvOdSzqFD3Mwtx7HqXXcUCp7Re4g5hFmlLkHu8ok+64aWp7c8Ia4fiJSTjMw
 Rxnq4ECZPfgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 11:36:27 -0700
IronPort-SDR: z2cnAQWbaKSMtDcPJ6NHp9j2ZVyXhTpgvQl3g3wHaIkhN4+nl8ogu+5FGrGM/CpNUk/CqekS+l
 BU5alqvrFaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="268439830"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2020 11:36:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org
Subject: [PATCH v11 07/10] iommu/vt-d: Add svm/sva invalidate function
Date:   Fri,  3 Apr 2020 11:42:11 -0700
Message-Id: <1585939334-21396-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Shared Virtual Address (SVA) is enabled for a guest OS via
vIOMMU, we need to provide invalidation support at IOMMU API and driver
level. This patch adds Intel VT-d specific function to implement
iommu passdown invalidate API for shared virtual address.

The use case is for supporting caching structure invalidation
of assigned SVM capable devices. Emulated IOMMU exposes queue
invalidation capability and passes down all descriptors from the guest
to the physical IOMMU.

The assumption is that guest to host device ID mapping should be
resolved prior to calling IOMMU driver. Based on the device handle,
host IOMMU driver can replace certain fields before submit to the
invalidation queue.

---
v11 - Removed 2D map array, use -EINVAL in granularity lookup array.
      Fixed devTLB invalidation granularity mapping. Disregard G=1 case
      and use address selective invalidation only.

v7 review fixed in v10
---

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 94c7993dac6a..045c5c08d71d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5594,6 +5594,163 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
 	aux_domain_remove_dev(to_dmar_domain(domain), dev);
 }
 
+/*
+ * 2D array for converting and sanitizing IOMMU generic TLB granularity to
+ * VT-d granularity. Invalidation is typically included in the unmap operation
+ * as a result of DMA or VFIO unmap. However, for assigned devices guest
+ * owns the first level page tables. Invalidations of translation caches in the
+ * guest are trapped and passed down to the host.
+ *
+ * vIOMMU in the guest will only expose first level page tables, therefore
+ * we do not support IOTLB granularity for request without PASID (second level).
+ *
+ * For example, to find the VT-d granularity encoding for IOTLB
+ * type and page selective granularity within PASID:
+ * X: indexed by iommu cache type
+ * Y: indexed by enum iommu_inv_granularity
+ * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
+ */
+
+const static int inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
+	/*
+	 * PASID based IOTLB invalidation: PASID selective (per PASID),
+	 * page selective (address granularity)
+	 */
+	{-EINVAL, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
+	/* PASID based dev TLBs */
+	{-EINVAL, -EINVAL, QI_DEV_IOTLB_GRAN_PASID_SEL},
+	/* PASID cache */
+	{-EINVAL, -EINVAL, -EINVAL}
+};
+
+static inline int to_vtd_granularity(int type, int granu)
+{
+	return inv_type_granu_table[type][granu];
+}
+
+static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
+{
+	u64 nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
+
+	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
+	 * IOMMU cache invalidate API passes granu_size in bytes, and number of
+	 * granu size in contiguous memory.
+	 */
+	return order_base_2(nr_pages);
+}
+
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+	unsigned long flags;
+	int cache_type;
+	u8 bus, devfn;
+	u16 did, sid;
+	int ret = 0;
+	u64 size = 0;
+
+	if (!inv_info || !dmar_domain ||
+		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
+	if (!info) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	sid = PCI_DEVID(bus, devfn);
+
+	/* Size is only valid in non-PASID selective invalidation */
+	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
+		size = to_vtd_size(inv_info->addr_info.granule_size,
+				   inv_info->addr_info.nb_granules);
+
+	for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache, IOMMU_CACHE_INV_TYPE_NR) {
+		int granu = 0;
+		u64 pasid = 0;
+
+		granu = to_vtd_granularity(cache_type, inv_info->granularity);
+		if (granu == -EINVAL) {
+			pr_err("Invalid cache type and granu combination %d/%d\n", cache_type,
+				inv_info->granularity);
+			break;
+		}
+
+		/* PASID is stored in different locations based on granularity */
+		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
+			inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID)
+			pasid = inv_info->pasid_info.pasid;
+		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
+			inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID)
+			pasid = inv_info->addr_info.pasid;
+
+		switch (BIT(cache_type)) {
+		case IOMMU_CACHE_INV_TYPE_IOTLB:
+			if ((inv_info->granularity == IOMMU_INV_GRANU_ADDR) &&
+				size && (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
+				pr_err("Address out of range, 0x%llx, size order %llu\n",
+					inv_info->addr_info.addr, size);
+				ret = -ERANGE;
+				goto out_unlock;
+			}
+
+			qi_flush_piotlb(iommu, did,
+					pasid,
+					mm_to_dma_pfn(inv_info->addr_info.addr),
+					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
+					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
+
+			/*
+			 * Always flush device IOTLB if ATS is enabled. vIOMMU
+			 * in the guest may assume IOTLB flush is inclusive,
+			 * which is more efficient.
+			 */
+			if (info->ats_enabled)
+				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
+						pasid, info->ats_qdep,
+						inv_info->addr_info.addr, size,
+						granu);
+			break;
+		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
+			if (info->ats_enabled)
+				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
+						inv_info->addr_info.pasid, info->ats_qdep,
+						inv_info->addr_info.addr, size,
+						granu);
+			else
+				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
+			break;
+		case IOMMU_CACHE_INV_TYPE_PASID:
+			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid_info.pasid);
+			break;
+		default:
+			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
+				cache_type);
+			ret = -EINVAL;
+		}
+	}
+out_unlock:
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+#endif
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot, gfp_t gfp)
@@ -6179,6 +6336,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 #ifdef CONFIG_INTEL_IOMMU_SVM
+	.cache_invalidate	= intel_iommu_sva_invalidate,
 	.sva_bind_gpasid	= intel_svm_bind_gpasid,
 	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
 #endif
-- 
2.7.4

