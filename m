Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6855C2E90A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbhADG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 01:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbhADG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 01:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609743372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vh5cz5at1G+5ld0pHqqsQA1nJo4RyhpJ3/S1fZfR/fY=;
        b=MxRUE6yVJPPDouqUbgnl4rR7q1Eogsh3BjB//5hbPK55wxhCi61q0SrFWrij5a8UoJsj24
        AXQnFT4CYTtYqUfcwkp3r3NjlU0CjKwRCpD7497Bpsp6Q4+//sG0P8XmKetISBQocT76c2
        hLsEHRK/e6mfiTVV6kBdCBFj/Us2qSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-aD5CUk07NpOCKarpVvm-pQ-1; Mon, 04 Jan 2021 01:56:11 -0500
X-MC-Unique: aD5CUk07NpOCKarpVvm-pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E87A9803620;
        Mon,  4 Jan 2021 06:56:09 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 481251002388;
        Mon,  4 Jan 2021 06:56:03 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, lulu@redhat.com, sgarzare@redhat.com,
        rdunlap@infradead.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 15/19] virito-pci-modern: rename map_capability() to vp_modern_map_capability()
Date:   Mon,  4 Jan 2021 14:54:59 +0800
Message-Id: <20210104065503.199631-16-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ease the split, map_capability() was renamed to
vp_modern_map_capability(). While at it, add the comments for the
arguments and switch to use virtio_pci_modern_device as the first
parameter.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 46 +++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 217573f2588d..a5e3a5e40323 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -63,12 +63,25 @@ static void vp_iowrite64_twopart(u64 val,
 	vp_iowrite32(val >> 32, hi);
 }
 
-static void __iomem *map_capability(struct pci_dev *dev, int off,
-				    size_t minlen,
-				    u32 align,
-				    u32 start, u32 size,
-				    size_t *len)
+/*
+ * vp_modern_map_capability - map a part of virtio pci capability
+ * @mdev: the modern virtio-pci device
+ * @off: offset of the capability
+ * @minlen: minimal length of the capability
+ * @align: align requirement
+ * @start: start from the capability
+ * @size: map size
+ * @len: the length that is actually mapped
+ *
+ * Returns the io address of for the part of the capability
+ */
+void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
+				       size_t minlen,
+				       u32 align,
+				       u32 start, u32 size,
+				       size_t *len)
 {
+	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
 	u32 offset, length;
 	void __iomem *p;
@@ -582,7 +595,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		vq->priv = (void __force *)mdev->notify_base +
 			off * mdev->notify_offset_multiplier;
 	} else {
-		vq->priv = (void __force *)map_capability(mdev->pci_dev,
+		vq->priv = (void __force *)vp_modern_map_capability(mdev,
 							  mdev->notify_map_cap, 2, 2,
 							  off * mdev->notify_offset_multiplier, 2,
 							  NULL);
@@ -956,15 +969,15 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 		return err;
 
 	err = -EINVAL;
-	mdev->common = map_capability(pci_dev, common,
+	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
 				      0, sizeof(struct virtio_pci_common_cfg),
 				      NULL);
 	if (!mdev->common)
 		goto err_map_common;
-	mdev->isr = map_capability(pci_dev, isr, sizeof(u8), 1,
-				   0, 1,
-				   NULL);
+	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
+					     0, 1,
+					     NULL);
 	if (!mdev->isr)
 		goto err_map_isr;
 
@@ -989,9 +1002,10 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	 * Otherwise, map each VQ individually later.
 	 */
 	if ((u64)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
-		mdev->notify_base = map_capability(pci_dev, notify, 2, 2,
-						   0, notify_length,
-						   &mdev->notify_len);
+		mdev->notify_base = vp_modern_map_capability(mdev, notify,
+							     2, 2,
+							     0, notify_length,
+							     &mdev->notify_len);
 		if (!mdev->notify_base)
 			goto err_map_notify;
 	} else {
@@ -1002,9 +1016,9 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	 * is more than enough for all existing devices.
 	 */
 	if (device) {
-		mdev->device = map_capability(pci_dev, device, 0, 4,
-					      0, PAGE_SIZE,
-					      &mdev->device_len);
+		mdev->device = vp_modern_map_capability(mdev, device, 0, 4,
+							0, PAGE_SIZE,
+							&mdev->device_len);
 		if (!mdev->device)
 			goto err_map_device;
 	}
-- 
2.25.1

