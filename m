Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB87C2E9098
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbhADG5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 01:57:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728050AbhADG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 01:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609743336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cz4Cg3nnzO3FS98gTMZZAIPsbgh47yB+xmLOC1GVS+Q=;
        b=fGF0RdfTHdXagPZeOO07vsuu+qSvdy2a2LbC05mowj+l9GI4O471OjEpFsz/W0lZAAbkuz
        0vEVhRxSXOmpFA1Vp95tGFp2uxbznnzv1y12spUzaZt7ZZo7Xj/d/CXP1uOd4a8PC21OxY
        U7xoP+QLY3n5nz7AuQXrixXwbZHP7ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Gp_mRJvgNuONC2pmOU0w4w-1; Mon, 04 Jan 2021 01:55:32 -0500
X-MC-Unique: Gp_mRJvgNuONC2pmOU0w4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B74107ACE3;
        Mon,  4 Jan 2021 06:55:31 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBC631002388;
        Mon,  4 Jan 2021 06:55:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, lulu@redhat.com, sgarzare@redhat.com,
        rdunlap@infradead.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 05/19] virtio-pci-modern: introduce helper to set config vector
Date:   Mon,  4 Jan 2021 14:54:49 +0800
Message-Id: <20210104065503.199631-6-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces vp_modern_config_vector() for setting config
vector.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 4be9afad547e..2e37bfc89655 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -315,9 +315,16 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_synchronize_vectors(vdev);
 }
 
-static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
+/*
+ * vp_modern_config_vector - set the vector for config interrupt
+ * @mdev: the modern virtio-pci device
+ * @vector: the config vector
+ *
+ * Returns the config vector read from the device
+ */
+static u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
+				   u16 vector)
 {
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* Setup the vector used for configuration events */
@@ -327,6 +334,11 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 	return vp_ioread16(&cfg->msix_config);
 }
 
+static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
+{
+	return vp_modern_config_vector(&vp_dev->mdev, vector);
+}
+
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_pci_vq_info *info,
 				  unsigned index,
-- 
2.25.1

