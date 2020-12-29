Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F802E6D97
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgL2D00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:26:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:39945 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgL2D0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:26:25 -0500
IronPort-SDR: uZSLcNBbnvmVHIfm4v9OAC1on8jCeUEh/FM0CfZuMA86MCf7O1PtOugrRhKUdMHnjJLiruTp1R
 NmOFcFB8qieg==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261204038"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="261204038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 19:25:45 -0800
IronPort-SDR: PXIQ17mgvELYfAN6IZbE3vgpmO79FwcPdCJhS3UEKstlA6ytnAO2mtv8YLerbydG1CPxiiJ/21
 ZY24xwEQ0/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="392962425"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com) ([10.238.156.135])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2020 19:25:42 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, jun.j.tian@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xin Zeng <xin.zeng@intel.com>
Subject: [PATCH v3 2/3] iommu/vt-d: Track device aux-attach with subdevice_domain_info
Date:   Tue, 29 Dec 2020 11:25:12 +0800
Message-Id: <20201229032513.486395-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229032513.486395-1-yi.l.liu@intel.com>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the existing code, loop all devices attached to a domain does not
include sub-devices attached via iommu_aux_attach_device().

This was found by when I'm working on the belwo patch, There is no
device in the domain->devices list, thus unable to get the cap and
ecap of iommu unit. But this domain actually has subdevice which is
attached via aux-manner. But it is tracked by domain. This patch is
going to fix it.

https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/

And this fix goes beyond the patch above, such sub-device tracking is
necessary for other cases. For example, flushing device_iotlb for a
domain which has sub-devices attached by auxiliary manner.

Co-developed-by: Xin Zeng <xin.zeng@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 95 +++++++++++++++++++++++++++----------
 include/linux/intel-iommu.h | 16 +++++--
 2 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 788119c5b021..d7720a836268 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1877,6 +1877,7 @@ static struct dmar_domain *alloc_domain(int flags)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->subdevices);
 
 	return domain;
 }
@@ -2547,7 +2548,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->iommu = iommu;
 	info->pasid_table = NULL;
 	info->auxd_enabled = 0;
-	INIT_LIST_HEAD(&info->auxiliary_domains);
+	INIT_LIST_HEAD(&info->subdevices);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -4475,33 +4476,61 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
 			domain->type == IOMMU_DOMAIN_UNMANAGED;
 }
 
-static void auxiliary_link_device(struct dmar_domain *domain,
-				  struct device *dev)
+static inline struct subdev_domain_info *
+lookup_subdev_info(struct dmar_domain *domain, struct device *dev)
+{
+	struct subdev_domain_info *sinfo;
+
+	if (!list_empty(&domain->subdevices)) {
+		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
+			if (sinfo->pdev == dev)
+				return sinfo;
+		}
+	}
+
+	return NULL;
+}
+
+static int auxiliary_link_device(struct dmar_domain *domain,
+				 struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
+	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
 
 	assert_spin_locked(&device_domain_lock);
 	if (WARN_ON(!info))
-		return;
+		return -EINVAL;
+
+	if (!sinfo) {
+		sinfo = kzalloc(sizeof(*sinfo), GFP_ATOMIC);
+		sinfo->domain = domain;
+		sinfo->pdev = dev;
+		list_add(&sinfo->link_phys, &info->subdevices);
+		list_add(&sinfo->link_domain, &domain->subdevices);
+	}
 
-	domain->auxd_refcnt++;
-	list_add(&domain->auxd, &info->auxiliary_domains);
+	return ++sinfo->users;
 }
 
-static void auxiliary_unlink_device(struct dmar_domain *domain,
-				    struct device *dev)
+static int auxiliary_unlink_device(struct dmar_domain *domain,
+				   struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
+	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
+	int ret;
 
 	assert_spin_locked(&device_domain_lock);
-	if (WARN_ON(!info))
-		return;
+	if (WARN_ON(!info || !sinfo || sinfo->users <= 0))
+		return -EINVAL;
 
-	list_del(&domain->auxd);
-	domain->auxd_refcnt--;
+	ret = --sinfo->users;
+	if (!ret) {
+		list_del(&sinfo->link_phys);
+		list_del(&sinfo->link_domain);
+		kfree(sinfo);
+	}
 
-	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+	return ret;
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -4530,6 +4559,19 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	}
 
 	spin_lock_irqsave(&device_domain_lock, flags);
+	ret = auxiliary_link_device(domain, dev);
+	if (ret <= 0)
+		goto link_failed;
+
+	/*
+	 * Subdevices from the same physical device can be attached to the
+	 * same domain. For such cases, only the first subdevice attachment
+	 * needs to go through the full steps in this function. So if ret >
+	 * 1, just goto out.
+	 */
+	if (ret > 1)
+		goto out;
+
 	/*
 	 * iommu->lock must be held to attach domain to iommu and setup the
 	 * pasid entry for second level translation.
@@ -4548,10 +4590,9 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 						     domain->default_pasid);
 	if (ret)
 		goto table_failed;
-	spin_unlock(&iommu->lock);
-
-	auxiliary_link_device(domain, dev);
 
+	spin_unlock(&iommu->lock);
+out:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return 0;
@@ -4560,8 +4601,10 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	domain_detach_iommu(domain, iommu);
 attach_failed:
 	spin_unlock(&iommu->lock);
+	auxiliary_unlink_device(domain, dev);
+link_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-	if (!domain->auxd_refcnt && domain->default_pasid > 0)
+	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
 		ioasid_put(domain->default_pasid);
 
 	return ret;
@@ -4581,14 +4624,18 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	info = get_domain_info(dev);
 	iommu = info->iommu;
 
-	auxiliary_unlink_device(domain, dev);
-
-	spin_lock(&iommu->lock);
-	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid, false);
-	domain_detach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
+	if (!auxiliary_unlink_device(domain, dev)) {
+		spin_lock(&iommu->lock);
+		intel_pasid_tear_down_entry(iommu, dev,
+					    domain->default_pasid, false);
+		domain_detach_iommu(domain, iommu);
+		spin_unlock(&iommu->lock);
+	}
 
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
+		ioasid_put(domain->default_pasid);
 }
 
 static int prepare_domain_attach_device(struct iommu_domain *domain,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 94522685a0d9..09c6a0bf3892 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -533,11 +533,10 @@ struct dmar_domain {
 					/* Domain ids per IOMMU. Use u16 since
 					 * domain ids are 16 bit wide according
 					 * to VT-d spec, section 9.3 */
-	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
 
 	bool has_iotlb_device;
 	struct list_head devices;	/* all devices' list */
-	struct list_head auxd;		/* link to device's auxiliary list */
+	struct list_head subdevices;	/* all subdevices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -610,14 +609,21 @@ struct intel_iommu {
 	struct dmar_drhd_unit *drhd;
 };
 
+/* Per subdevice private data */
+struct subdev_domain_info {
+	struct list_head link_phys;	/* link to phys device siblings */
+	struct list_head link_domain;	/* link to domain siblings */
+	struct device *pdev;		/* physical device derived from */
+	struct dmar_domain *domain;	/* aux-domain */
+	int users;			/* user count */
+};
+
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
 	struct list_head global; /* link to global list */
 	struct list_head table;	/* link to pasid table */
-	struct list_head auxiliary_domains; /* auxiliary domains
-					     * attached to this device
-					     */
+	struct list_head subdevices; /* subdevices sibling */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
-- 
2.25.1

