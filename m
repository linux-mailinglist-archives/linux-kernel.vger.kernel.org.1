Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A162CE6E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLDEF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgLDEF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5MCDvT08fgLwp/aut+xPMU+fLypodHK/gTdgTX0+hc=;
        b=Nnu0uRpmHP318tc0jnP+hpZXd8BGRrdjvzUXL2aoilEOHiYOLIkenKCsc7kyPvw4pdFMgp
        gULfArp5bKmbkCJxVTFx8iq7p3tBxE70fLHS1YZruj5me1EcW5sEYs068DUb/IgideWxrK
        b8kAfhVM2nZdSE7RF+7AoTnvuH+Jvoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-cUiaTRxiMM6QkHaeX2tJbg-1; Thu, 03 Dec 2020 23:04:28 -0500
X-MC-Unique: cUiaTRxiMM6QkHaeX2tJbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10E780EF81;
        Fri,  4 Dec 2020 04:04:26 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C91811F067;
        Fri,  4 Dec 2020 04:04:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 07/19] virtio-pci-modern: introduce helpers for setting and getting features
Date:   Fri,  4 Dec 2020 12:03:41 +0800
Message-Id: <20201204040353.21679-8-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces helpers for setting and getting features.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 43 +++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ccde0a41209a..cb14fc334a9c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -137,12 +137,16 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 	return p;
 }
 
-/* virtio config->get_features() implementation */
-static u64 vp_get_features(struct virtio_device *vdev)
+/*
+ * vp_modern_get_features - get features from device
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the features read from the device
+ */
+static u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
 	u64 features;
 
 	vp_iowrite32(0, &cfg->device_feature_select);
@@ -153,6 +157,14 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+/* virtio config->get_features() implementation */
+static u64 vp_get_features(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	return vp_modern_get_features(&vp_dev->mdev);
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -163,12 +175,26 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
 }
 
+/*
+ * vp_modern_set_features - set features to device
+ * @mdev: the modern virtio-pci device
+ * @features: the features set to device
+ */
+static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
+				   u64 features)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite32(0, &cfg->guest_feature_select);
+	vp_iowrite32((u32)features, &cfg->guest_feature);
+	vp_iowrite32(1, &cfg->guest_feature_select);
+	vp_iowrite32(features >> 32, &cfg->guest_feature);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
@@ -183,10 +209,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)vdev->features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(vdev->features >> 32, &cfg->guest_feature);
+	vp_modern_set_features(&vp_dev->mdev, vdev->features);
 
 	return 0;
 }
-- 
2.25.1

