Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F719CF56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 06:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgDCEep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 00:34:45 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56794 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727727AbgDCEeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:34:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0334UFof026706;
        Thu, 2 Apr 2020 21:34:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=TkWTj8x6cVbPGq0lNl8q94o3EtXBBghb8lVzJFHginc=;
 b=v7qWN9oGpr0rveIprpgo3l5JhMR600Qw+5wNnZOoj5szbo9JZrwBW+aq8ZRcG+ph3WCx
 tnWDkkiKy4ErNn8PZTuxQKrclSo9VMipcYVI0hCt5Qjgxpeb5ChjMJTaZHhFvTNHqp9+
 03W2hRAtqvibzMukvbyOAYtylcBnR0dRkmejHnDFi26vPJUMdKgLPSsZyJjfG2N/FYAB
 X0Sgw0aQo0RXoZ453YUlaniVcWyA6nRIeFR26jairYAirMpNn7GTJqIWpVhpWN28aqWS
 fpHY38vYXeeTDpqQmIwVkEIVo5nm2vk+0PVQ3HtORR6n2ZNoISJ4v4nqk1Ox37C+yFPR Jg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 304855w1xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 21:34:36 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 21:34:34 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 21:34:34 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Apr 2020 21:34:30 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <jean-philippe@linaro.org>, <joro@8bytes.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <eric.auger.pro@gmail.com>, <eric.auger@redhat.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [RFC PATCH v4] iommu/virtio: Use page size bitmap supported by endpoint
Date:   Fri, 3 Apr 2020 10:04:29 +0530
Message-ID: <20200403043429.28484-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_02:2020-04-02,2020-04-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different endpoint can support different page size, probe
endpoint if it supports specific page size otherwise use
global page sizes.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v3->v4:
 - Fix whitespace error

v2->v3:
 - Fixed error return for incompatible endpoint
 - __u64 changed to __le64 in header file

 drivers/iommu/virtio-iommu.c      | 53 +++++++++++++++++++++++++++----
 include/uapi/linux/virtio_iommu.h |  7 ++++
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index cce329d71fba..ab09c04b1702 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -78,6 +78,7 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+	u64				pgsize_bitmap;
 };
 
 struct viommu_request {
@@ -415,6 +416,19 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
 	return ret;
 }
 
+static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
+				    struct virtio_iommu_probe_pgsize_mask *mask,
+				    size_t len)
+{
+	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
+
+	if (len < sizeof(*mask))
+		return -EINVAL;
+
+	vdev->pgsize_bitmap = pgsize_bitmap;
+	return 0;
+}
+
 static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
@@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
 			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
 			break;
+		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
+			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
+			break;
 		default:
 			dev_err(dev, "unknown viommu prop 0x%x\n", type);
 		}
@@ -607,16 +624,17 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	return &vdomain->domain;
 }
 
-static int viommu_domain_finalise(struct viommu_dev *viommu,
+static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 				  struct iommu_domain *domain)
 {
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct viommu_dev *viommu = vdev->viommu;
 
 	vdomain->viommu		= viommu;
 	vdomain->map_flags	= viommu->map_flags;
 
-	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
+	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
 	domain->geometry	= viommu->geometry;
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
@@ -642,6 +660,29 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	kfree(vdomain);
 }
 
+/*
+ * Check whether the endpoint's capabilities are compatible with other
+ * endpoints in the domain. Report any inconsistency.
+ */
+static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
+					  struct viommu_domain *vdomain)
+{
+	struct device *dev = vdev->dev;
+
+	if (vdomain->viommu != vdev->viommu) {
+		dev_err(dev, "cannot attach to foreign vIOMMU\n");
+		return false;
+	}
+
+	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
+		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
+			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
+		return false;
+	}
+
+	return true;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int i;
@@ -657,10 +698,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * Properly initialize the domain now that we know which viommu
 		 * owns it.
 		 */
-		ret = viommu_domain_finalise(vdev->viommu, domain);
-	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+		ret = viommu_domain_finalise(vdev, domain);
+	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
@@ -875,6 +915,7 @@ static int viommu_add_device(struct device *dev)
 
 	vdev->dev = dev;
 	vdev->viommu = viommu;
+	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
 	INIT_LIST_HEAD(&vdev->resv_regions);
 	fwspec->iommu_priv = vdev;
 
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..bd0a1a844081 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
 
 #define VIRTIO_IOMMU_PROBE_T_NONE		0
 #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
 
 #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
 
@@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
 	__le16					length;
 };
 
+struct virtio_iommu_probe_pgsize_mask {
+	struct virtio_iommu_probe_property	head;
+	__u8					reserved[4];
+	__le64					pgsize_bitmap;
+};
+
 #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
 #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
 
-- 
2.17.1

