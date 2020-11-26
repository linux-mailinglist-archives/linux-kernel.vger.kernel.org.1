Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0720F2C5121
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbgKZJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389305AbgKZJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vAaTuyjpc3k087BgLURQpk+B64VgFJLoCQx8GPQxT0=;
        b=XF7JvP52+1BObuKci45wd1xgUWZl/kcOQzzhiWE5eHbZWlK8YO1NGHsRfebilR/jKFCUOm
        Hx0XuqSEZTI6RlsJJfEUQcC6ay5fchrQMKk78ZF71wzm1ajSihQJy2+pyy7A3G2Qe39t8P
        f8nMH7dUHhCy5QJTta5ikqU9Jar/FqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-l5soPUjZPJKwGcX35IObxQ-1; Thu, 26 Nov 2020 04:26:23 -0500
X-MC-Unique: l5soPUjZPJKwGcX35IObxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8031006C94;
        Thu, 26 Nov 2020 09:26:22 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E29B19C71;
        Thu, 26 Nov 2020 09:26:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 04/14] virtio-pci: move the notification sanity check to vp_modern_probe()
Date:   Thu, 26 Nov 2020 17:25:54 +0800
Message-Id: <20201126092604.208033-5-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the notification sanity check to
vp_modern_probe(). This can make sure the logic could be reused by
modules other than virtio-pci.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 02688c3b3fbd..d001c74beefe 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -384,17 +384,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
-	/* offset should not wrap */
-	if ((u64)off * mdev->notify_offset_multiplier + 2
-		> mdev->notify_len) {
-		dev_warn(&vp_dev->pci_dev->dev,
-			 "bad notification offset %u (x %u) "
-			 "for queue %u > %zd",
-			 off, mdev->notify_offset_multiplier,
-			 index, mdev->notify_len);
-		err = -EINVAL;
-		goto err_map_notify;
-	}
 	vq->priv = (void __force *)mdev->notify_base +
 		off * mdev->notify_offset_multiplier;
 
@@ -695,9 +684,11 @@ static inline void check_offsets(void)
 static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 {
 	struct pci_dev *pci_dev = mdev->pci_dev;
-	int err, common, isr, notify, device;
+	int err, common, isr, notify, device, i;
+	unsigned int num_queues;
 	u32 notify_length;
 	u32 notify_offset;
+	u16 off;
 
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
@@ -796,6 +787,25 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	if (!mdev->notify_base)
 		goto err;
 
+	num_queues = vp_ioread16(&mdev->common->num_queues);
+
+	/* offset should not wrap */
+	for (i = 0; i < num_queues; i++) {
+		vp_iowrite16(i, &mdev->common->queue_select);
+		off = vp_ioread16(&mdev->common->queue_notify_off);
+
+		if ((u64)off * mdev->notify_offset_multiplier + 2
+			> mdev->notify_len) {
+			dev_warn(&pci_dev->dev,
+			 "bad notification offset %u (x %u) "
+			 "for queue %u > %zd",
+			 off, mdev->notify_offset_multiplier,
+			 i, mdev->notify_len);
+			err = -EINVAL;
+			goto err;
+		}
+	}
+
 	/* We don't know how much we should map, but PAGE_SIZE
 	 * is more than enough for all existing devices.
 	 */
-- 
2.25.1

