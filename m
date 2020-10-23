Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743FE296881
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374607AbgJWCZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374600AbgJWCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603419930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOE97Kgy2/CEcg3VYJ3JC+svlXGnVF61v/gPcb/O0qY=;
        b=f6WwfsHdAVxuIpcA73SW2zvWP11BGsfKs4X5y0VLt0aRMfJGhH0ccEv7kYf0vr5WzH66l8
        3LTV5874ChxYueq3+oVN1+v2q8RzkwNHvMromxF67fUq9CIRk1EpvyERNp58eH6T7SVvjf
        pHrp/BLEGDWLhUrUM9Ht6fH4zN8YIbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-89qbrNWcONqyIxd3b0aNkQ-1; Thu, 22 Oct 2020 22:25:26 -0400
X-MC-Unique: 89qbrNWcONqyIxd3b0aNkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EFE1084C93;
        Fri, 23 Oct 2020 02:25:24 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-85.pek2.redhat.com [10.72.13.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D32155770;
        Fri, 23 Oct 2020 02:25:15 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 2/3] vhost: vdpa: report iova range
Date:   Fri, 23 Oct 2020 10:24:53 +0800
Message-Id: <20201023022454.24402-3-jasowang@redhat.com>
In-Reply-To: <20201023022454.24402-1-jasowang@redhat.com>
References: <20201023022454.24402-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new ioctl for vhost-vdpa device that can
report the iova range by the device.

For device that implements get_iova_range() method, we fetch it from
the vDPA device. If device doesn't implement get_iova_range() but
depends on platform IOMMU, we will query via DOMAIN_ATTR_GEOMETRY,
otherwise [0, ULLONG_MAX] is assumed.

For safety, this patch also rules out the map request which is not in
the valid range.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 40 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a2dbc85e0b0d..562ed99116d1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -47,6 +47,7 @@ struct vhost_vdpa {
 	int minor;
 	struct eventfd_ctx *config_ctx;
 	int in_batch;
+	struct vdpa_iova_range range;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -337,6 +338,16 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 	return 0;
 }
 
+static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
+{
+	struct vhost_vdpa_iova_range range = {
+		.first = v->range.first,
+		.last = v->range.last,
+	};
+
+	return copy_to_user(argp, &range, sizeof(range));
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -470,6 +481,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_VDPA_BACKEND_FEATURES;
 		r = copy_to_user(featurep, &features, sizeof(features));
+	case VHOST_VDPA_GET_IOVA_RANGE:
+		r = vhost_vdpa_get_iova_range(v, argp);
 		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
@@ -597,6 +610,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	long pinned;
 	int ret = 0;
 
+	if (msg->iova < v->range.first ||
+	    msg->iova + msg->size - 1 > v->range.last)
+		return -EINVAL;
+
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
@@ -783,6 +800,27 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 	v->domain = NULL;
 }
 
+static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
+{
+	struct vdpa_iova_range *range = &v->range;
+	struct iommu_domain_geometry geo;
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->get_iova_range) {
+		*range = ops->get_iova_range(vdpa);
+	} else if (v->domain &&
+		   !iommu_domain_get_attr(v->domain,
+		   DOMAIN_ATTR_GEOMETRY, &geo) &&
+		   geo.force_aperture) {
+		range->first = geo.aperture_start;
+		range->last = geo.aperture_end;
+	} else {
+		range->first = 0;
+		range->last = ULLONG_MAX;
+	}
+}
+
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 {
 	struct vhost_vdpa *v;
@@ -823,6 +861,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 	if (r)
 		goto err_init_iotlb;
 
+	vhost_vdpa_set_iova_range(v);
+
 	filep->private_data = v;
 
 	return 0;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 75232185324a..c998860d7bbc 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -146,4 +146,8 @@
 
 /* Set event fd for config interrupt*/
 #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
+
+/* Get the valid iova range */
+#define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
+					     struct vhost_vdpa_iova_range)
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 9a269a88a6ff..f7f6a3a28977 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -138,6 +138,15 @@ struct vhost_vdpa_config {
 	__u8 buf[0];
 };
 
+/* vhost vdpa IOVA range
+ * @first: First address that can be mapped by vhost-vDPA
+ * @last: Last address that can be mapped by vhost-vDPA
+ */
+struct vhost_vdpa_iova_range {
+	__u64 first;
+	__u64 last;
+};
+
 /* Feature bits */
 /* Log all write descriptors. Can be changed while device is active. */
 #define VHOST_F_LOG_ALL 26
-- 
2.20.1

