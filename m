Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC79D2B1C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKMNsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgKMNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmwRVxQsc/qPsoRgsbehfRwdGseE/2GhYjwbTfPKCsU=;
        b=TiAM8OZZLtI9xVn7W8qLFn3P+cf2UAG52pdyyUiMpPfUTj6ISjo0f5Wx0Xx9q852lv7l/t
        QmKjN0zLfagJRsIWyFEWoBWMT/8TooJBv0lu7FDSODQNF08GExFtXxhubkMrvB17vxRa1O
        sO4Eb8SazLPK7eIUFuZ14/fT1qAWZm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-g0kZstaGM5WQhPfq2LYcNA-1; Fri, 13 Nov 2020 08:48:09 -0500
X-MC-Unique: g0kZstaGM5WQhPfq2LYcNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADFF9802B76;
        Fri, 13 Nov 2020 13:48:08 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0BA419C66;
        Fri, 13 Nov 2020 13:48:06 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 07/12] vdpa_sim: move config management outside of the core
Date:   Fri, 13 Nov 2020 14:47:07 +0100
Message-Id: <20201113134712.69744-8-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify the code of the vdpa_sim core, we move the
config management in each device simulator.

The device must provide the size of config structure and a callback
to update this structure called during the vdpasim_set_features().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 29 +++++-----------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 27 ++++++++++++++++----------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 12 ++++++++++++
 4 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 76e642042eb0..f7e1fe0a88d3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -10,8 +10,6 @@
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/virtio_config.h>
-#include <uapi/linux/virtio_net.h>
-#include <uapi/linux/virtio_blk.h>
 
 #define DRV_VERSION  "0.1"
 #define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
@@ -42,8 +40,11 @@ struct vdpasim_virtqueue {
 
 struct vdpasim_device {
 	u64 supported_features;
+	size_t config_size;
 	u32 id;
 	int nvqs;
+
+	void (*update_config)(struct vdpasim *vdpasim);
 };
 
 struct vdpasim_init_attr {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d053bd14b3f8..9c29c2013661 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -185,14 +185,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 {
 	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
-	u32 device_id;
 	struct device *dev;
-	int i, size, ret = -ENOMEM;
-
-	device_id = attr->device.id;
-	/* Currently, we only accept the network and block devices. */
-	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
-		return ERR_PTR(-EOPNOTSUPP);
+	int i, ret = -ENOMEM;
 
 	if (attr->batch_mapping)
 		ops = &vdpasim_batch_config_ops;
@@ -206,11 +200,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 
 	vdpasim->device = attr->device;
 
-	if (device_id == VIRTIO_ID_NET)
-		size = sizeof(struct virtio_net_config);
-	else
-		size = sizeof(struct virtio_blk_config);
-	vdpasim->config = kzalloc(size, GFP_KERNEL);
+	vdpasim->config = kzalloc(vdpasim->device.config_size, GFP_KERNEL);
 	if (!vdpasim->config)
 		goto err_iommu;
 
@@ -364,13 +354,8 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
 	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
 	 */
-	if (vdpasim->device.id == VIRTIO_ID_NET) {
-		struct virtio_net_config *config =
-			(struct virtio_net_config *)vdpasim->config;
-
-		config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
-		config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	}
+	if (vdpasim->device.update_config)
+		vdpasim->device.update_config(vdpasim);
 
 	return 0;
 }
@@ -426,11 +411,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	if (vdpasim->device.id == VIRTIO_ID_BLOCK &&
-	    (offset + len < sizeof(struct virtio_blk_config)))
-		memcpy(buf, vdpasim->config + offset, len);
-	else if (vdpasim->device.id == VIRTIO_ID_NET &&
-		 (offset + len < sizeof(struct virtio_net_config)))
+	if (offset + len < vdpasim->device.config_size)
 		memcpy(buf, vdpasim->config + offset, len);
 }
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 363273d72e26..f456a0e4e097 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <uapi/linux/virtio_blk.h>
 
 #include "vdpa_sim.h"
 
@@ -72,16 +73,31 @@ static void vdpasim_blk_work(struct work_struct *work)
 
 }
 
+static void vdpasim_blk_update_config(struct vdpasim *vdpasim)
+{
+	struct virtio_blk_config *config =
+		(struct virtio_blk_config *)vdpasim->config;
+
+	config->capacity = cpu_to_vdpasim64(vdpasim, VDPASIM_BLK_CAPACITY);
+	config->size_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SIZE_MAX);
+	config->seg_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SEG_MAX);
+	config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
+	config->min_io_size = cpu_to_vdpasim16(vdpasim, 1);
+	config->opt_io_size = cpu_to_vdpasim32(vdpasim, 1);
+	config->blk_size = cpu_to_vdpasim32(vdpasim, 512);
+}
+
 static int __init vdpasim_blk_init(void)
 {
 	struct vdpasim_init_attr attr = {};
-	struct virtio_blk_config *config;
 	int ret;
 
 	attr.device.id = VIRTIO_ID_BLOCK;
 	attr.device.supported_features = VDPASIM_FEATURES |
 					 VDPASIM_BLK_FEATURES;
 	attr.device.nvqs = VDPASIM_BLK_VQ_NUM;
+	attr.device.config_size = sizeof(struct virtio_blk_config);
+	attr.device.update_config = vdpasim_blk_update_config;
 
 	attr.work_fn = vdpasim_blk_work;
 
@@ -91,15 +107,6 @@ static int __init vdpasim_blk_init(void)
 		goto out;
 	}
 
-	config = (struct virtio_blk_config *)vdpasim_blk_dev->config;
-	config->capacity = cpu_to_vdpasim64(vdpasim_blk_dev, VDPASIM_BLK_CAPACITY);
-	config->size_max = cpu_to_vdpasim32(vdpasim_blk_dev, VDPASIM_BLK_SIZE_MAX);
-	config->seg_max = cpu_to_vdpasim32(vdpasim_blk_dev, VDPASIM_BLK_SEG_MAX);
-	config->num_queues = cpu_to_vdpasim16(vdpasim_blk_dev, VDPASIM_BLK_VQ_NUM);
-	config->min_io_size = cpu_to_vdpasim16(vdpasim_blk_dev, 1);
-	config->opt_io_size = cpu_to_vdpasim32(vdpasim_blk_dev, 1);
-	config->blk_size = cpu_to_vdpasim32(vdpasim_blk_dev, 512);
-
 	ret = vdpa_register_device(&vdpasim_blk_dev->vdpa);
 	if (ret)
 		goto put_dev;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 88c9569f6bd3..b9372fdf2415 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/etherdevice.h>
+#include <uapi/linux/virtio_net.h>
 
 #include "vdpa_sim.h"
 
@@ -99,6 +100,15 @@ static void vdpasim_net_work(struct work_struct *work)
 	spin_unlock(&vdpasim->lock);
 }
 
+static void vdpasim_net_update_config(struct vdpasim *vdpasim)
+{
+	struct virtio_net_config *config =
+		(struct virtio_net_config *)vdpasim->config;
+
+	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
+}
+
 static int __init vdpasim_net_init(void)
 {
 	struct vdpasim_init_attr attr = {};
@@ -109,6 +119,8 @@ static int __init vdpasim_net_init(void)
 	attr.device.supported_features = VDPASIM_FEATURES |
 					 VDPASIM_NET_FEATURES;
 	attr.device.nvqs = VDPASIM_NET_VQ_NUM;
+	attr.device.config_size = sizeof(struct virtio_net_config);
+	attr.device.update_config = vdpasim_net_update_config;
 
 	attr.work_fn = vdpasim_net_work;
 	attr.batch_mapping = batch_mapping;
-- 
2.26.2

