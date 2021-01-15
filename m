Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FDC2F7881
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbhAOMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:15:35 -0500
Received: from foss.arm.com ([217.140.110.172]:37738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbhAOMPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:15:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE1C14BF;
        Fri, 15 Jan 2021 04:14:42 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC5FA3F70D;
        Fri, 15 Jan 2021 04:14:37 -0800 (PST)
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
Subject: [PATCH RFC v1 10/15] iommu/virtio: Prepare to add attach pasid table infrastructure
Date:   Fri, 15 Jan 2021 17:43:37 +0530
Message-Id: <20210115121342.15093-11-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add attach pasid table op, separate out the
existing attach request code to a separate method.

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
 drivers/iommu/virtio-iommu.c | 73 +++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 12d73321dbf4..ae5dfd3f8269 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -52,6 +52,8 @@ struct viommu_dev {
 	/* Supported MAP flags */
 	u32				map_flags;
 	u32				probe_size;
+
+	bool				has_map:1;
 };
 
 struct viommu_mapping {
@@ -60,6 +62,11 @@ struct viommu_mapping {
 	u32				flags;
 };
 
+struct viommu_mm {
+	struct io_pgtable_ops		*ops;
+	struct viommu_domain		*domain;
+};
+
 struct viommu_domain {
 	struct iommu_domain		domain;
 	struct viommu_dev		*viommu;
@@ -67,12 +74,20 @@ struct viommu_domain {
 	unsigned int			id;
 	u32				map_flags;
 
+	/* Default address space when a table is bound */
+	struct viommu_mm		mm;
+
+	/* When no table is bound, use generic mappings */
 	spinlock_t			mappings_lock;
 	struct rb_root_cached		mappings;
 
 	unsigned long			nr_endpoints;
 };
 
+#define vdev_for_each_id(i, eid, vdev)					\
+	for (i = 0; i < vdev->dev->iommu->fwspec->num_ids &&		\
+		({ eid = vdev->dev->iommu->fwspec->ids[i]; 1; }); i++)
+
 struct viommu_endpoint {
 	struct device			*dev;
 	struct viommu_dev		*viommu;
@@ -750,12 +765,40 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	kfree(vdomain);
 }
 
+static int viommu_simple_attach(struct viommu_domain *vdomain,
+				struct viommu_endpoint *vdev)
+{
+	int i, eid, ret;
+	struct virtio_iommu_req_attach req = {
+		.head.type	= VIRTIO_IOMMU_T_ATTACH,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	if (!vdomain->viommu->has_map)
+		return -ENODEV;
+
+	vdev_for_each_id(i, eid, vdev) {
+		req.endpoint = cpu_to_le32(eid);
+
+		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
+		if (ret)
+			return ret;
+	}
+
+	if (!vdomain->nr_endpoints) {
+		/*
+		 * This endpoint is the first to be attached to the domain.
+		 * Replay existing mappings if any (e.g. SW MSI).
+		 */
+		ret = viommu_replay_mappings(vdomain);
+	}
+
+	return ret;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	int i;
 	int ret = 0;
-	struct virtio_iommu_req_attach req;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -790,25 +833,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (vdev->vdomain)
 		vdev->vdomain->nr_endpoints--;
 
-	req = (struct virtio_iommu_req_attach) {
-		.head.type	= VIRTIO_IOMMU_T_ATTACH,
-		.domain		= cpu_to_le32(vdomain->id),
-	};
-
-	for (i = 0; i < fwspec->num_ids; i++) {
-		req.endpoint = cpu_to_le32(fwspec->ids[i]);
-
-		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
-		if (ret)
-			return ret;
-	}
-
-	if (!vdomain->nr_endpoints) {
-		/*
-		 * This endpoint is the first to be attached to the domain.
-		 * Replay existing mappings (e.g. SW MSI).
-		 */
-		ret = viommu_replay_mappings(vdomain);
+	if (!vdomain->mm.ops) {
+		/* If we couldn't bind any table, use the mapping tree */
+		ret = viommu_simple_attach(vdomain, vdev);
 		if (ret)
 			return ret;
 	}
@@ -1142,6 +1169,8 @@ static int viommu_probe(struct virtio_device *vdev)
 				struct virtio_iommu_config, probe_size,
 				&viommu->probe_size);
 
+	viommu->has_map = virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP);
+
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
 		.aperture_end	= input_end,
-- 
2.17.1

