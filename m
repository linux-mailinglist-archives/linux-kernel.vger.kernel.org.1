Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4112CE6E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgLDEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgLDEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZZSlKtIwk5R5NiqAz/H9oLoM6u9d/BSImkhnwLknNw=;
        b=D1TPdAGHmxmaEYrz3KV5QTmAN0YTKmsRQl/TRcEk5HAWIZbmkt5rz/3pjEHfEeH4LVl7fM
        qSIWQ6m7HKttwEEEikriaMtBu+VgAeKBOTUL/mRZmgvN4p4QkR1bK4FD731UpJ52LWxXjy
        uM7HGU/ZC22VkNNjRacvH4Cc5+7U/WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-c3bjj2JkOGuzPRF527Xjrw-1; Thu, 03 Dec 2020 23:04:25 -0500
X-MC-Unique: c3bjj2JkOGuzPRF527Xjrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40AEB80EF82;
        Fri,  4 Dec 2020 04:04:24 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F07C1A890;
        Fri,  4 Dec 2020 04:04:21 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 06/19] virtio-pci-modern: introduce helpers for setting and getting status
Date:   Fri,  4 Dec 2020 12:03:40 +0800
Message-Id: <20201204040353.21679-7-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces helpers to allow set and get device status.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 37 +++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 2e37bfc89655..ccde0a41209a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -275,41 +275,62 @@ static u32 vp_generation(struct virtio_device *vdev)
 	return vp_ioread8(&cfg->config_generation);
 }
 
+/*
+ * vp_modern_get_status - get the device status
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the status read from device
+ */
+static u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	return vp_ioread8(&cfg->device_status);
+}
+
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+
+	return vp_modern_get_status(&vp_dev->mdev);
+}
+
+/*
+ * vp_modern_set_status - set status to device
+ * @mdev: the modern virtio-pci device
+ * @status: the status set to device
+ */
+static void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
+				 u8 status)
+{
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
-	return vp_ioread8(&cfg->device_status);
+	vp_iowrite8(status, &cfg->device_status);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	vp_iowrite8(status, &cfg->device_status);
+	vp_modern_set_status(&vp_dev->mdev, status);
 }
 
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* 0 status means a reset. */
-	vp_iowrite8(0, &cfg->device_status);
+	vp_modern_set_status(mdev, 0);
 	/* After writing 0 to device_status, the driver MUST wait for a read of
 	 * device_status to return 0 before reinitializing the device.
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_ioread8(&cfg->device_status))
+	while (vp_modern_get_status(mdev))
 		msleep(1);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
-- 
2.25.1

