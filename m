Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F642CE6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgLDEFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgLDEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cz4Cg3nnzO3FS98gTMZZAIPsbgh47yB+xmLOC1GVS+Q=;
        b=hHaYcr11qFFnhVQN6j53Wm5ntj1AvZrAgQQTEu4H90jU/S/Z25ynKt6lCbTAHRZyKTaDHD
        5v5DhbVXJSikjc2HUeQVc8OOR5sTBUuZf84ByoZyigIayjBWEDBWmcvuTt5TTfl0JB8uYu
        l1KaPqXL0KO5AnDG5Q0Gt4vYC5J8Rxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-SU7UvmOUPOmDkQ95573oSg-1; Thu, 03 Dec 2020 23:04:22 -0500
X-MC-Unique: SU7UvmOUPOmDkQ95573oSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 617E01005504;
        Fri,  4 Dec 2020 04:04:21 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7860F1A4D0;
        Fri,  4 Dec 2020 04:04:15 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 05/19] virtio-pci-modern: introduce helper to set config vector
Date:   Fri,  4 Dec 2020 12:03:39 +0800
Message-Id: <20201204040353.21679-6-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

