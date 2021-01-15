Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1732F787A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbhAOMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:14:49 -0500
Received: from foss.arm.com ([217.140.110.172]:37478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbhAOMOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:14:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78F4211FB;
        Fri, 15 Jan 2021 04:14:02 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01F233F70D;
        Fri, 15 Jan 2021 04:13:57 -0800 (PST)
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
Subject: [PATCH RFC v1 02/15] iommu: Add a simple PASID table library
Date:   Fri, 15 Jan 2021 17:43:29 +0530
Message-Id: <20210115121342.15093-3-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a small API in iommu subsystem to handle PASID table allocation
requests from different consumer drivers, such as a paravirtualized
iommu driver. The API provides ops for allocating and freeing PASID
table, writing to it and managing the table caches.

This library also provides for registering a vendor API that attaches
to these ops. The vendor APIs would eventually perform arch level
implementations for these PASID tables.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
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
 drivers/iommu/iommu-pasid-table.h | 134 ++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 drivers/iommu/iommu-pasid-table.h

diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
new file mode 100644
index 000000000000..bd4f57656f67
--- /dev/null
+++ b/drivers/iommu/iommu-pasid-table.h
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PASID table management for the IOMMU
+ *
+ * Copyright (C) 2021 Arm Ltd.
+ */
+#ifndef __IOMMU_PASID_TABLE_H
+#define __IOMMU_PASID_TABLE_H
+
+#include <linux/io-pgtable.h>
+
+#include "arm/arm-smmu-v3/arm-smmu-v3.h"
+
+enum pasid_table_fmt {
+	PASID_TABLE_ARM_SMMU_V3,
+	PASID_TABLE_NUM_FMTS,
+};
+
+/**
+ * struct arm_smmu_cfg_info - arm-smmu-v3 specific configuration data
+ *
+ * @s1_cfg: arm-smmu-v3 stage1 config data
+ * @feat_flag: features supported by arm-smmu-v3 implementation
+ */
+struct arm_smmu_cfg_info {
+	struct arm_smmu_s1_cfg	*s1_cfg;
+	u32			feat_flag;
+};
+
+/**
+ * struct iommu_vendor_psdtable_cfg - Configuration data for PASID tables
+ *
+ * @iommu_dev: device performing the DMA table walks
+ * @fmt: The PASID table format
+ * @base: DMA address of the allocated table, set by the vendor driver
+ * @cfg: arm-smmu-v3 specific config data
+ */
+struct iommu_vendor_psdtable_cfg {
+	struct device		*iommu_dev;
+	enum pasid_table_fmt	fmt;
+	dma_addr_t		base;
+	union {
+		struct arm_smmu_cfg_info	cfg;
+	} vendor;
+};
+
+struct iommu_vendor_psdtable_ops;
+
+/**
+ * struct iommu_pasid_table - describes a set of PASID tables
+ *
+ * @cookie: An opaque token provided by the IOMMU driver and passed back to any
+ * callback routine.
+ * @cfg: A copy of the PASID table configuration
+ * @ops: The PASID table operations in use for this set of page tables
+ */
+struct iommu_pasid_table {
+	void					*cookie;
+	struct iommu_vendor_psdtable_cfg	cfg;
+	struct iommu_vendor_psdtable_ops	*ops;
+};
+
+#define pasid_table_cfg_to_table(pst_cfg) \
+	container_of((pst_cfg), struct iommu_pasid_table, cfg)
+
+struct iommu_vendor_psdtable_ops {
+	int (*alloc)(struct iommu_vendor_psdtable_cfg *cfg);
+	void (*free)(struct iommu_vendor_psdtable_cfg *cfg);
+	void (*prepare)(struct iommu_vendor_psdtable_cfg *cfg,
+			struct io_pgtable_cfg *pgtbl_cfg, u32 asid);
+	int (*write)(struct iommu_vendor_psdtable_cfg *cfg, int ssid,
+		     void *cookie);
+	void (*sync)(void *cookie, int ssid, bool leaf);
+};
+
+static inline int iommu_psdtable_alloc(struct iommu_pasid_table *tbl,
+				       struct iommu_vendor_psdtable_cfg *cfg)
+{
+	if (!tbl->ops->alloc)
+		return -ENOSYS;
+
+	return tbl->ops->alloc(cfg);
+}
+
+static inline void iommu_psdtable_free(struct iommu_pasid_table *tbl,
+				       struct iommu_vendor_psdtable_cfg *cfg)
+{
+	if (!tbl->ops->free)
+		return;
+
+	tbl->ops->free(cfg);
+}
+
+static inline int iommu_psdtable_prepare(struct iommu_pasid_table *tbl,
+					 struct iommu_vendor_psdtable_cfg *cfg,
+					 struct io_pgtable_cfg *pgtbl_cfg,
+					 u32 asid)
+{
+	if (!tbl->ops->prepare)
+		return -ENOSYS;
+
+	tbl->ops->prepare(cfg, pgtbl_cfg, asid);
+	return 0;
+}
+
+static inline int iommu_psdtable_write(struct iommu_pasid_table *tbl,
+				       struct iommu_vendor_psdtable_cfg *cfg,
+				       int ssid, void *cookie)
+{
+	if (!tbl->ops->write)
+		return -ENOSYS;
+
+	return tbl->ops->write(cfg, ssid, cookie);
+}
+
+static inline int iommu_psdtable_sync(struct iommu_pasid_table *tbl,
+				      void *cookie, int ssid, bool leaf)
+{
+	if (!tbl->ops->sync)
+		return -ENOSYS;
+
+	tbl->ops->sync(cookie, ssid, leaf);
+	return 0;
+}
+
+/* A placeholder to register vendor specific pasid layer */
+static inline struct iommu_pasid_table *
+iommu_register_pasid_table(enum pasid_table_fmt fmt,
+			   struct device *dev, void *cookie)
+{
+	return NULL;
+}
+
+#endif /* __IOMMU_PASID_TABLE_H */
-- 
2.17.1

