Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96B2E18EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLWG2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:28:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:31824 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgLWG2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:28:30 -0500
IronPort-SDR: lCYH8XU/fE8RSziqgqa64DTsSM4xwrSnMJAPl3ML36/yNwWJz9eVtOs9evM0jOS53yZWkInxkd
 fmpyJ8aOje0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="163027472"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="163027472"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 22:27:48 -0800
IronPort-SDR: LWTwXHIpczvKue0sKqENqdKrN5o/ZqrQA+C29jeAsNedfP4qwb68e5S3x65+GvIxQ7n0G9kqX6
 W3iAOvZ8B4Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="338703572"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com) ([10.238.156.135])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2020 22:27:46 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        jacob.jun.pan@linux.intel.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, yi.l.liu@intel.com,
        jun.j.tian@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Xin Zeng <xin.zeng@intel.com>
Subject: [PATCH v2 2/3] iommu/vt-d: Track device aux-attach with subdevice_domain_info
Date:   Wed, 23 Dec 2020 14:27:19 +0800
Message-Id: <20201223062720.29364-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223062720.29364-1-yi.l.liu@intel.com>
References: <20201223062720.29364-1-yi.l.liu@intel.com>
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
index a49afa11673c..acfe0a5b955e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1881,6 +1881,7 @@ static struct dmar_domain *alloc_domain(int flags)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->subdevices);
 
 	return domain;
 }
@@ -2632,7 +2633,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->iommu = iommu;
 	info->pasid_table = NULL;
 	info->auxd_enabled = 0;
-	INIT_LIST_HEAD(&info->auxiliary_domains);
+	INIT_LIST_HEAD(&info->subdevices);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5172,33 +5173,61 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
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
-		ioasid_free(domain->default_pasid);
+	return ret;
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5227,6 +5256,19 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
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
@@ -5245,10 +5287,9 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
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
@@ -5257,8 +5298,10 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	domain_detach_iommu(domain, iommu);
 attach_failed:
 	spin_unlock(&iommu->lock);
+	auxiliary_unlink_device(domain, dev);
+link_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-	if (!domain->auxd_refcnt && domain->default_pasid > 0)
+	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
 		ioasid_free(domain->default_pasid);
 
 	return ret;
@@ -5278,14 +5321,18 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
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
+		ioasid_free(domain->default_pasid);
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

