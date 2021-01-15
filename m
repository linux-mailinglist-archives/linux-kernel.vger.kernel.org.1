Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE92F7886
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbhAOMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:15:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbhAOMPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:15:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D06E1509;
        Fri, 15 Jan 2021 04:14:57 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9F1A3F70D;
        Fri, 15 Jan 2021 04:14:52 -0800 (PST)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
Subject: [PATCH RFC v1 13/15] iommu/virtio: Attach Arm PASID tables when available
Date:   Fri, 15 Jan 2021 17:43:40 +0530
Message-Id: <20210115121342.15093-14-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When the ARM PASID table format is reported in a probe, send an attach
request and install the page tables for iommu_map/iommu_unmap use.
Architecture-specific components are already abstracted to libraries. We
just need to pass config bits around and setup an alternative mechanism to
the mapping tree.

We reuse the convention already adopted by other IOMMU architectures (ARM
SMMU and AMD IOMMU), that entry 0 in the PASID table is reserved for
non-PASID traffic. Bind the PASID table, and setup entry 0 to be modified
with iommu_map/unmap.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Bunch of refactoring and clean-ups to use iommu-pasid-table APIs,
        creating iommu_pasid_table, and configuring based on reported
	pasid format. Couple of additional methods have also been created
	to configure vendor specific pasid configuration]
Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/virtio-iommu.c | 314 +++++++++++++++++++++++++++++++++++
 1 file changed, 314 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 004ea94e3731..b5222da1dc74 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -25,6 +25,7 @@
 #include <linux/wait.h>
 
 #include <uapi/linux/virtio_iommu.h>
+#include "iommu-pasid-table.h"
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -33,6 +34,9 @@
 #define VIOMMU_EVENT_VQ			1
 #define VIOMMU_NR_VQS			2
 
+/* Some architectures need an Address Space ID for each page table */
+static DEFINE_IDA(asid_ida);
+
 struct viommu_dev {
 	struct iommu_device		iommu;
 	struct device			*dev;
@@ -55,6 +59,7 @@ struct viommu_dev {
 	u32				probe_size;
 
 	bool				has_map:1;
+	bool				has_table:1;
 };
 
 struct viommu_mapping {
@@ -76,6 +81,7 @@ struct viommu_domain {
 	struct mutex			mutex; /* protects viommu pointer */
 	unsigned int			id;
 	u32				map_flags;
+	struct iommu_pasid_table	*pasid_tbl;
 
 	/* Default address space when a table is bound */
 	struct viommu_mm		mm;
@@ -891,6 +897,285 @@ static int viommu_simple_attach(struct viommu_domain *vdomain,
 	return ret;
 }
 
+static int viommu_teardown_pgtable(struct viommu_domain *vdomain)
+{
+	struct iommu_vendor_psdtable_cfg *pst_cfg;
+	struct arm_smmu_cfg_info *cfgi;
+	u32 asid;
+
+	if (!vdomain->mm.ops)
+		return 0;
+
+	free_io_pgtable_ops(vdomain->mm.ops);
+	vdomain->mm.ops = NULL;
+
+	if (vdomain->pasid_tbl) {
+		pst_cfg = &vdomain->pasid_tbl->cfg;
+		cfgi = &pst_cfg->vendor.cfg;
+		asid = cfgi->s1_cfg->cd.asid;
+
+		iommu_psdtable_write(vdomain->pasid_tbl, pst_cfg, 0, NULL);
+		ida_simple_remove(&asid_ida, asid);
+	}
+
+	return 0;
+}
+
+static int viommu_setup_pgtable(struct viommu_endpoint *vdev,
+				struct viommu_domain *vdomain)
+{
+	int ret, id;
+	u32 asid;
+	enum io_pgtable_fmt fmt;
+	struct io_pgtable_ops *ops = NULL;
+	struct viommu_dev *viommu = vdev->viommu;
+	struct virtio_iommu_probe_table_format *desc = vdev->pgtf;
+	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
+	struct iommu_vendor_psdtable_cfg *pst_cfg;
+	struct arm_smmu_cfg_info *cfgi;
+	struct io_pgtable_cfg cfg = {
+		.iommu_dev	= viommu->dev->parent,
+		.tlb		= &viommu_flush_ops,
+		.pgsize_bitmap	= vdev->pgsize_mask ? vdev->pgsize_mask :
+				  vdomain->domain.pgsize_bitmap,
+		.ias		= (vdev->input_end ? ilog2(vdev->input_end) :
+				   ilog2(vdomain->domain.geometry.aperture_end)) + 1,
+		.oas		= vdev->output_bits,
+	};
+
+	if (!desc)
+		return -EINVAL;
+
+	if (!vdev->output_bits)
+		return -ENODEV;
+
+	switch (le16_to_cpu(desc->format)) {
+	case VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE:
+		fmt = ARM_64_LPAE_S1;
+		break;
+	default:
+		dev_err(vdev->dev, "unsupported page table format 0x%x\n",
+			le16_to_cpu(desc->format));
+		return -EINVAL;
+	}
+
+	if (vdomain->mm.ops) {
+		/*
+		 * TODO: attach additional endpoint to the domain. Check that
+		 * the config is sane.
+		 */
+		return -EEXIST;
+	}
+
+	vdomain->mm.domain = vdomain;
+	ops = alloc_io_pgtable_ops(fmt, &cfg, &vdomain->mm);
+	if (!ops)
+		return -ENOMEM;
+
+	pst_cfg = &tbl->cfg;
+	cfgi = &pst_cfg->vendor.cfg;
+	id = ida_simple_get(&asid_ida, 1, 1 << desc->asid_bits, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto err_free_pgtable;
+	}
+
+	asid = id;
+	ret = iommu_psdtable_prepare(tbl, pst_cfg, &cfg, asid);
+	if (ret)
+		goto err_free_asid;
+
+	/*
+	 * Strange to setup an op here?
+	 * cd-lib is the actual user of sync op, and therefore the platform
+	 * drivers should assign this sync/maintenance ops as per need.
+	 */
+	tbl->ops->sync = viommu_flush_pasid;
+
+	/* Right now only PASID 0 supported ?? */
+	ret = iommu_psdtable_write(tbl, pst_cfg, 0, &cfgi->s1_cfg->cd);
+	if (ret)
+		goto err_free_asid;
+
+	vdomain->mm.ops = ops;
+	dev_dbg(vdev->dev, "using page table format 0x%x\n", fmt);
+
+	return 0;
+
+err_free_asid:
+	ida_simple_remove(&asid_ida, asid);
+err_free_pgtable:
+	free_io_pgtable_ops(ops);
+	return ret;
+}
+
+static int viommu_config_arm_pst(struct iommu_vendor_psdtable_cfg *pst_cfg,
+				 struct virtio_iommu_req_attach_pst_arm *req)
+{
+	struct arm_smmu_s1_cfg *s1_cfg = pst_cfg->vendor.cfg.s1_cfg;
+
+	if (!s1_cfg)
+		return -ENODEV;
+
+	req->format	= cpu_to_le16(VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3);
+	req->s1fmt	= s1_cfg->s1fmt;
+	req->s1dss	= VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_0;
+	req->s1contextptr = cpu_to_le64(pst_cfg->base);
+	req->s1cdmax	= cpu_to_le32(s1_cfg->s1cdmax);
+
+	return 0;
+}
+
+static int viommu_config_pst(struct iommu_vendor_psdtable_cfg *pst_cfg,
+			     void *req, enum pasid_table_fmt fmt)
+{
+	int ret;
+
+	switch (fmt) {
+	case PASID_TABLE_ARM_SMMU_V3:
+		ret = viommu_config_arm_pst(pst_cfg, req);
+		break;
+	default:
+		ret = -EINVAL;
+		WARN_ON(1);
+	}
+
+	return ret;
+}
+
+static int viommu_prepare_arm_pst(struct viommu_endpoint *vdev,
+				  struct iommu_vendor_psdtable_cfg *pst_cfg)
+{
+	struct virtio_iommu_probe_table_format *pgtf = vdev->pgtf;
+	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
+	struct arm_smmu_s1_cfg *cfg;
+
+	/* Some sanity checks */
+	if (pgtf->asid_bits != 8 && pgtf->asid_bits != 16)
+		return -EINVAL;
+
+	cfg = devm_kzalloc(pst_cfg->iommu_dev, sizeof(cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	cfgi->s1_cfg = cfg;
+	cfg->s1cdmax = vdev->pasid_bits;
+	cfg->cd.asid = pgtf->asid_bits;
+
+	pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
+	/* XXX HACK: set feature bit ARM_SMMU_FEAT_2_LVL_CDTAB */
+	pst_cfg->vendor.cfg.feat_flag |= (1 << 1);
+
+	return 0;
+}
+
+static int viommu_prepare_pst(struct viommu_endpoint *vdev,
+			      struct iommu_vendor_psdtable_cfg *pst_cfg,
+			      enum pasid_table_fmt fmt)
+{
+	int ret;
+
+	switch (fmt) {
+	case PASID_TABLE_ARM_SMMU_V3:
+		ret = viommu_prepare_arm_pst(vdev, pst_cfg);
+		break;
+	default:
+		dev_err(vdev->dev, "unsupported PASID table format 0x%x\n", fmt);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
+				     struct viommu_domain *vdomain)
+{
+	int ret;
+	int i, eid;
+	enum pasid_table_fmt fmt = -1;
+	struct virtio_iommu_probe_table_format *desc = vdev->pstf;
+	struct virtio_iommu_req_attach_table req = {
+		.head.type	= VIRTIO_IOMMU_T_ATTACH_TABLE,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+	struct viommu_dev *viommu = vdev->viommu;
+	struct iommu_pasid_table *tbl;
+	struct iommu_vendor_psdtable_cfg *pst_cfg;
+
+	if (!viommu->has_table)
+		return 0;
+
+	if (!desc)
+		return -ENODEV;
+
+	/* Prepare PASID tables configuration */
+	switch (le16_to_cpu(desc->format)) {
+	case VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3:
+		fmt = PASID_TABLE_ARM_SMMU_V3;
+		break;
+	default:
+		dev_err(vdev->dev, "unsupported PASID table format 0x%x\n",
+			le16_to_cpu(desc->format));
+		return 0;
+	}
+
+	if (!tbl) {
+		tbl = iommu_register_pasid_table(fmt, viommu->dev->parent, vdomain);
+		if (!tbl)
+			return -ENOMEM;
+
+		vdomain->pasid_tbl = tbl;
+		pst_cfg = &tbl->cfg;
+
+		pst_cfg->iommu_dev = viommu->dev->parent;
+
+		/* Prepare PASID tables info to allocate a new table */
+		ret = viommu_prepare_pst(vdev, pst_cfg, fmt);
+		if (ret)
+			return ret;
+
+		ret = iommu_psdtable_alloc(tbl, pst_cfg);
+		if (ret)
+			return ret;
+
+		pst_cfg->iommu_dev = viommu->dev->parent;
+		pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
+
+		ret = viommu_setup_pgtable(vdev, vdomain);
+		if (ret) {
+			dev_err(vdev->dev, "could not install page tables\n");
+			goto err_free_psdtable;
+		}
+
+		/* Add arch-specific configuration */
+		ret = viommu_config_pst(pst_cfg, (void *)&req, fmt);
+		if (ret)
+			goto err_free_ops;
+
+		vdev_for_each_id(i, eid, vdev) {
+			req.endpoint = cpu_to_le32(eid);
+			ret = viommu_send_req_sync(viommu, &req, sizeof(req));
+			if (ret)
+				goto err_free_ops;
+		}
+	} else {
+		/* TODO: otherwise, check for compatibility with vdev. */
+		return -ENOSYS;
+	}
+
+	dev_dbg(vdev->dev, "uses PASID table format 0x%x\n", fmt);
+
+	return 0;
+
+err_free_ops:
+	if (vdomain->mm.ops)
+		viommu_teardown_pgtable(vdomain);
+err_free_psdtable:
+	iommu_psdtable_free(tbl, &tbl->cfg);
+
+	return ret;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -928,6 +1213,17 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (vdev->vdomain)
 		vdev->vdomain->nr_endpoints--;
 
+	ret = viommu_attach_pasid_table(vdev, vdomain);
+	if (ret) {
+		/*
+		 * No PASID support, too bad. Perhaps we can bind a single set
+		 * of page tables?
+		 */
+		ret = viommu_setup_pgtable(vdev, vdomain);
+		if (ret)
+			dev_err(vdev->dev, "could not install tables\n");
+	}
+
 	if (!vdomain->mm.ops) {
 		/* If we couldn't bind any table, use the mapping tree */
 		ret = viommu_simple_attach(vdomain, vdev);
@@ -948,6 +1244,10 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 	u32 flags;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct io_pgtable_ops *ops = vdomain->mm.ops;
+
+	if (ops)
+		return ops->map(ops, iova, paddr, size, prot, gfp);
 
 	flags = (prot & IOMMU_READ ? VIRTIO_IOMMU_MAP_F_READ : 0) |
 		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
@@ -986,6 +1286,10 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	size_t unmapped;
 	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct io_pgtable_ops *ops = vdomain->mm.ops;
+
+	if (ops)
+		return ops->unmap(ops, iova, size, gather);
 
 	unmapped = viommu_del_mappings(vdomain, iova, size);
 	if (unmapped < size)
@@ -1014,6 +1318,10 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
 	struct viommu_mapping *mapping;
 	struct interval_tree_node *node;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct io_pgtable_ops *ops = vdomain->mm.ops;
+
+	if (ops)
+		return ops->iova_to_phys(ops, iova);
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
 	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
@@ -1264,7 +1572,12 @@ static int viommu_probe(struct virtio_device *vdev)
 				struct virtio_iommu_config, probe_size,
 				&viommu->probe_size);
 
+	viommu->has_table = virtio_has_feature(vdev, VIRTIO_IOMMU_F_ATTACH_TABLE);
 	viommu->has_map = virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP);
+	if (!viommu->has_table && !viommu->has_map) {
+		ret = -EINVAL;
+		goto err_free_vqs;
+	}
 
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
@@ -1356,6 +1669,7 @@ static unsigned int features[] = {
 	VIRTIO_IOMMU_F_DOMAIN_RANGE,
 	VIRTIO_IOMMU_F_PROBE,
 	VIRTIO_IOMMU_F_MMIO,
+	VIRTIO_IOMMU_F_ATTACH_TABLE,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.17.1

