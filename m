Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3792E2F788F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbhAOMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:15:49 -0500
Received: from foss.arm.com ([217.140.110.172]:37802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbhAOMPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:15:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4104E150C;
        Fri, 15 Jan 2021 04:15:02 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE7A53F70D;
        Fri, 15 Jan 2021 04:14:57 -0800 (PST)
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
Subject: [PATCH RFC v1 14/15] iommu/virtio: Add support for Arm LPAE page table format
Date:   Fri, 15 Jan 2021 17:43:41 +0530
Message-Id: <20210115121342.15093-15-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When PASID isn't supported, we can still register one set of tables.
Add support to register Arm LPAE based page table.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Clean-ups to add right tcr definitions and accomodate
        with parent patches]
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
 drivers/iommu/virtio-iommu.c      | 131 +++++++++++++++++++++++++-----
 include/uapi/linux/virtio_iommu.h |  30 +++++++
 2 files changed, 139 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b5222da1dc74..9cc3d35125e9 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -135,6 +135,13 @@ struct viommu_event {
 #define to_viommu_domain(domain)	\
 	container_of(domain, struct viommu_domain, domain)
 
+#define VIRTIO_FIELD_PREP(_mask, _shift, _val)			\
+	({							\
+		(((_val) << VIRTIO_IOMMU_PGTF_ARM_ ## _shift) &	\
+		 (VIRTIO_IOMMU_PGTF_ARM_ ## _mask <<		\
+		  VIRTIO_IOMMU_PGTF_ARM_ ## _shift));		\
+	})
+
 static int viommu_get_req_errno(void *buf, size_t len)
 {
 	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
@@ -897,6 +904,76 @@ static int viommu_simple_attach(struct viommu_domain *vdomain,
 	return ret;
 }
 
+static int viommu_config_arm_pgt(struct viommu_endpoint *vdev,
+				 struct io_pgtable_cfg *cfg,
+				 struct virtio_iommu_req_attach_pgt_arm *req,
+				 u64 *asid)
+{
+	int id;
+	struct virtio_iommu_probe_table_format *pgtf = (void *)vdev->pgtf;
+	typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr = &cfg->arm_lpae_s1_cfg.tcr;
+	u64 __tcr;
+
+	if (pgtf->asid_bits != 8 && pgtf->asid_bits != 16)
+		return -EINVAL;
+
+	id = ida_simple_get(&asid_ida, 1, 1 << pgtf->asid_bits, GFP_KERNEL);
+	if (id < 0)
+		return -ENOMEM;
+
+	__tcr = VIRTIO_FIELD_PREP(T0SZ_MASK, T0SZ_SHIFT, tcr->tsz) |
+		VIRTIO_FIELD_PREP(IRGN0_MASK, IRGN0_SHIFT, tcr->irgn) |
+		VIRTIO_FIELD_PREP(ORGN0_MASK, ORGN0_SHIFT, tcr->orgn) |
+		VIRTIO_FIELD_PREP(SH0_MASK, SH0_SHIFT, tcr->sh) |
+		VIRTIO_FIELD_PREP(TG0_MASK, TG0_SHIFT, tcr->tg) |
+		VIRTIO_IOMMU_PGTF_ARM_EPD1 | VIRTIO_IOMMU_PGTF_ARM_HPD0 |
+		VIRTIO_IOMMU_PGTF_ARM_HPD1;
+
+	req->format	= cpu_to_le16(VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE);
+	req->ttbr	= cpu_to_le64(cfg->arm_lpae_s1_cfg.ttbr);
+	req->tcr	= cpu_to_le64(__tcr);
+	req->mair	= cpu_to_le64(cfg->arm_lpae_s1_cfg.mair);
+	req->asid	= cpu_to_le16(id);
+
+	*asid = id;
+	return 0;
+}
+
+static int viommu_attach_pgtable(struct viommu_endpoint *vdev,
+				 struct viommu_domain *vdomain,
+				 enum io_pgtable_fmt fmt,
+				 struct io_pgtable_cfg *cfg,
+				 u64 *asid)
+{
+	int ret;
+	int i, eid;
+
+	struct virtio_iommu_req_attach_table req = {
+		.head.type	= VIRTIO_IOMMU_T_ATTACH_TABLE,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	switch (fmt) {
+	case ARM_64_LPAE_S1:
+		ret = viommu_config_arm_pgt(vdev, cfg, (void *)&req, asid);
+		if (ret)
+			return ret;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	vdev_for_each_id(i, eid, vdev) {
+		req.endpoint = cpu_to_le32(eid);
+		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int viommu_teardown_pgtable(struct viommu_domain *vdomain)
 {
 	struct iommu_vendor_psdtable_cfg *pst_cfg;
@@ -972,32 +1049,42 @@ static int viommu_setup_pgtable(struct viommu_endpoint *vdev,
 	if (!ops)
 		return -ENOMEM;
 
-	pst_cfg = &tbl->cfg;
-	cfgi = &pst_cfg->vendor.cfg;
-	id = ida_simple_get(&asid_ida, 1, 1 << desc->asid_bits, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
-		goto err_free_pgtable;
-	}
+	if (!tbl) {
+		/* No PASID support, send attach_table */
+		ret = viommu_attach_pgtable(vdev, vdomain, fmt, &cfg,
+					    &vdomain->mm.archid);
+		if (ret)
+			goto err_free_pgtable;
+	} else {
+		pst_cfg = &tbl->cfg;
+		cfgi = &pst_cfg->vendor.cfg;
+		id = ida_simple_get(&asid_ida, 1, 1 << desc->asid_bits, GFP_KERNEL);
+		if (id < 0) {
+			ret = id;
+			goto err_free_pgtable;
+		}
 
-	asid = id;
-	ret = iommu_psdtable_prepare(tbl, pst_cfg, &cfg, asid);
-	if (ret)
-		goto err_free_asid;
+		asid = id;
+		ret = iommu_psdtable_prepare(tbl, pst_cfg, &cfg, asid);
+		if (ret)
+			goto err_free_asid;
 
-	/*
-	 * Strange to setup an op here?
-	 * cd-lib is the actual user of sync op, and therefore the platform
-	 * drivers should assign this sync/maintenance ops as per need.
-	 */
-	tbl->ops->sync = viommu_flush_pasid;
+		/*
+		 * Strange to setup an op here?
+		 * cd-lib is the actual user of sync op, and therefore the
+		 * cd-lib consumer drivers should assign this sync/maintenance
+		 * ops as per need.
+		 */
+		tbl->ops->sync = viommu_flush_pasid;
 
-	/* Right now only PASID 0 supported ?? */
-	ret = iommu_psdtable_write(tbl, pst_cfg, 0, &cfgi->s1_cfg->cd);
-	if (ret)
-		goto err_free_asid;
+		/* Right now only PASID 0 supported */
+		ret = iommu_psdtable_write(tbl, pst_cfg, 0, &cfgi->s1_cfg->cd);
+		if (ret)
+			goto err_free_asid;
+
+		vdomain->mm.ops = ops;
+	}
 
-	vdomain->mm.ops = ops;
 	dev_dbg(vdev->dev, "using page table format 0x%x\n", fmt);
 
 	return 0;
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 3481e4a3dd24..608c8d642e1f 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -116,6 +116,36 @@ struct virtio_iommu_req_attach_pst_arm {
 	struct virtio_iommu_req_tail		tail;
 };
 
+/* TCR_EL1 fields from Arm LPAE format */
+#define VIRTIO_IOMMU_PGTF_ARM_HPD1		(1ULL << 42)
+#define VIRTIO_IOMMU_PGTF_ARM_HPD0		(1ULL << 41)
+#define VIRTIO_IOMMU_PGTF_ARM_EPD1		(1 << 23)
+
+#define VIRTIO_IOMMU_PGTF_ARM_TG0_SHIFT		14
+#define VIRTIO_IOMMU_PGTF_ARM_TG0_MASK		0x3
+#define VIRTIO_IOMMU_PGTF_ARM_SH0_SHIFT		12
+#define VIRTIO_IOMMU_PGTF_ARM_SH0_MASK		0x3
+#define VIRTIO_IOMMU_PGTF_ARM_ORGN0_SHIFT	10
+#define VIRTIO_IOMMU_PGTF_ARM_ORGN0_MASK	0x3
+#define VIRTIO_IOMMU_PGTF_ARM_IRGN0_SHIFT	8
+#define VIRTIO_IOMMU_PGTF_ARM_IRGN0_MASK	0x3
+#define VIRTIO_IOMMU_PGTF_ARM_T0SZ_SHIFT	0
+#define VIRTIO_IOMMU_PGTF_ARM_T0SZ_MASK		0x3f
+
+/* Arm LPAE Page Table Descriptor */
+struct virtio_iommu_req_attach_pgt_arm {
+	struct virtio_iommu_req_head            head;
+	__le32                                  domain;
+	__le32                                  endpoint;
+	__le16                                  format;
+	__le16                                  asid;
+	__le64					tcr;
+	__le64					ttbr;
+	__le64					mair;
+	__u8					reserved[28];
+	struct virtio_iommu_req_tail		tail;
+};
+
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
-- 
2.17.1

