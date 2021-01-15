Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B362F7883
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbhAOMPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:15:40 -0500
Received: from foss.arm.com ([217.140.110.172]:37740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbhAOMPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:15:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62FA11480;
        Fri, 15 Jan 2021 04:14:47 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E01B63F70D;
        Fri, 15 Jan 2021 04:14:42 -0800 (PST)
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
Subject: [PATCH RFC v1 11/15] iommu/virtio: Add headers for binding pasid table in iommu
Date:   Fri, 15 Jan 2021 17:43:38 +0530
Message-Id: <20210115121342.15093-12-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Add the required UAPI defines for binding pasid tables in virtio-iommu.
This mode allows to hand stage-1 page tables over to the guest.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Refactor to cleanup headers for invalidation]
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
 include/uapi/linux/virtio_iommu.h | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 8a0624bab4b2..3481e4a3dd24 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_ATTACH_TABLE		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -44,6 +45,8 @@ struct virtio_iommu_config {
 #define VIRTIO_IOMMU_T_MAP			0x03
 #define VIRTIO_IOMMU_T_UNMAP			0x04
 #define VIRTIO_IOMMU_T_PROBE			0x05
+#define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
+#define VIRTIO_IOMMU_T_INVALIDATE		0x07
 
 /* Status types */
 #define VIRTIO_IOMMU_S_OK			0x00
@@ -82,6 +85,37 @@ struct virtio_iommu_req_detach {
 	struct virtio_iommu_req_tail		tail;
 };
 
+struct virtio_iommu_req_attach_table {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+	__le16					format;
+	__u8					reserved[62];
+	struct virtio_iommu_req_tail		tail;
+};
+
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_LINEAR	0x0
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_4KL2	0x1
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_64KL2	0x2
+
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_TERM	0x0
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_BYPASS 0x1
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_0	0x2
+
+/* Arm SMMUv3 PASID Table Descriptor */
+struct virtio_iommu_req_attach_pst_arm {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+	__le16					format;
+	__u8					s1fmt;
+	__u8					s1dss;
+	__le64					s1contextptr;
+	__le32					s1cdmax;
+	__u8					reserved[48];
+	struct virtio_iommu_req_tail		tail;
+};
+
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
@@ -188,6 +222,40 @@ struct virtio_iommu_req_probe {
 	 */
 };
 
+#define VIRTIO_IOMMU_INVAL_G_DOMAIN		(1 << 0)
+#define VIRTIO_IOMMU_INVAL_G_PASID		(1 << 1)
+#define VIRTIO_IOMMU_INVAL_G_VA			(1 << 2)
+
+#define VIRTIO_IOMMU_INV_T_IOTLB		(1 << 0)
+#define VIRTIO_IOMMU_INV_T_DEV_IOTLB		(1 << 1)
+#define VIRTIO_IOMMU_INV_T_PASID		(1 << 2)
+
+#define VIRTIO_IOMMU_INVAL_F_PASID		(1 << 0)
+#define VIRTIO_IOMMU_INVAL_F_ARCHID		(1 << 1)
+#define VIRTIO_IOMMU_INVAL_F_LEAF		(1 << 2)
+
+struct virtio_iommu_req_invalidate {
+	struct virtio_iommu_req_head		head;
+	__le16					inv_gran;
+	__le16					inv_type;
+
+	__le16					flags;
+	__u8					reserved1[2];
+	__le32					domain;
+
+	__le32					pasid;
+	__u8					reserved2[4];
+
+	__le64					archid;
+	__le64					virt_start;
+	__le64					nr_pages;
+
+	/* Page size, in nr of bits, typically 12 for 4k, 30 for 2MB, etc.) */
+	__u8					granule;
+	__u8					reserved3[11];
+	struct virtio_iommu_req_tail		tail;
+};
+
 /* Fault types */
 #define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
 #define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
-- 
2.17.1

