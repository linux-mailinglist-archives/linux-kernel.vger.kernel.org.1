Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF12F787E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbhAOMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:15:26 -0500
Received: from foss.arm.com ([217.140.110.172]:37682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbhAOMPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:15:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87C8B13A1;
        Fri, 15 Jan 2021 04:14:22 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111C63F70D;
        Fri, 15 Jan 2021 04:14:17 -0800 (PST)
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
Subject: [PATCH RFC v1 06/15] iommu/virtio: Add headers for table format probing
Date:   Fri, 15 Jan 2021 17:43:33 +0530
Message-Id: <20210115121342.15093-7-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Add required UAPI defines for probing table format for underlying
iommu hardware. The device may provide information about hardware
tables and additional capabilities for each device.
This allows guest to correctly fabricate stage-1 page tables.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Use a single "struct virtio_iommu_probe_table_format" rather
        than separate structures for page table and pasid table format.
	Also update commit message.]
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
 include/uapi/linux/virtio_iommu.h | 44 ++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..43821e33e7af 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -2,7 +2,7 @@
 /*
  * Virtio-iommu definition v0.12
  *
- * Copyright (C) 2019 Arm Ltd.
+ * Copyright (C) 2019-2021 Arm Ltd.
  */
 #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
 #define _UAPI_LINUX_VIRTIO_IOMMU_H
@@ -111,6 +111,12 @@ struct virtio_iommu_req_unmap {
 
 #define VIRTIO_IOMMU_PROBE_T_NONE		0
 #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
+#define VIRTIO_IOMMU_PROBE_T_INPUT_RANGE	3
+#define VIRTIO_IOMMU_PROBE_T_OUTPUT_SIZE	4
+#define VIRTIO_IOMMU_PROBE_T_PASID_SIZE		5
+#define VIRTIO_IOMMU_PROBE_T_PAGE_TABLE_FMT	6
+#define VIRTIO_IOMMU_PROBE_T_PASID_TABLE_FMT	7
 
 #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
 
@@ -130,6 +136,42 @@ struct virtio_iommu_probe_resv_mem {
 	__le64					end;
 };
 
+struct virtio_iommu_probe_page_size_mask {
+	struct virtio_iommu_probe_property	head;
+	__u8					reserved[4];
+	__le64					mask;
+};
+
+struct virtio_iommu_probe_input_range {
+	struct virtio_iommu_probe_property	head;
+	__u8					reserved[4];
+	__le64					start;
+	__le64					end;
+};
+
+struct virtio_iommu_probe_output_size {
+	struct virtio_iommu_probe_property	head;
+	__u8					bits;
+	__u8					reserved[3];
+};
+
+struct virtio_iommu_probe_pasid_size {
+	struct virtio_iommu_probe_property	head;
+	__u8					bits;
+	__u8					reserved[3];
+};
+
+/* Arm LPAE page table format */
+#define VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE	1
+/* Arm smmu-v3 type PASID table format */
+#define VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3	2
+
+struct virtio_iommu_probe_table_format {
+	struct virtio_iommu_probe_property	head;
+	__le16					format;
+	__u8					reserved[2];
+};
+
 struct virtio_iommu_req_probe {
 	struct virtio_iommu_req_head		head;
 	__le32					endpoint;
-- 
2.17.1

