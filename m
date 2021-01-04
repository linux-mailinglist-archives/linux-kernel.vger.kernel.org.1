Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2C2E909B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbhADG5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 01:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbhADG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 01:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609743345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWQOtPyifN/PjEn3xTBf4iGLE1QrxjMiv/aT+1c7dfI=;
        b=YKhsf/ZcA16yIMao/trj85+4/K5Fl2Yp9FSASG18chmDLBmUSLxYabcgqYaublow8es34l
        bJA6Og6s4mdHD3ywQlQaw41dEJ1ACCbDqHh8ql7N73QSZkyHeN2hpmdNb3x2yQle6M5Xdm
        0x9YgAD3X8x8uqouyo4nK0QSx3S1EfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-PR6Oina1Mji3ezzOKe1c0w-1; Mon, 04 Jan 2021 01:55:42 -0500
X-MC-Unique: PR6Oina1Mji3ezzOKe1c0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5095E800D55;
        Mon,  4 Jan 2021 06:55:41 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD5D1002388;
        Mon,  4 Jan 2021 06:55:38 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, lulu@redhat.com, sgarzare@redhat.com,
        rdunlap@infradead.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 08/19] virtio-pci-modern: introduce vp_modern_generation()
Date:   Mon,  4 Jan 2021 14:54:52 +0800
Message-Id: <20210104065503.199631-9-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces vp_modern_generation() to get device generation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index cb14fc334a9c..a128e5814045 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -289,15 +289,26 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	}
 }
 
-static u32 vp_generation(struct virtio_device *vdev)
+/*
+ * vp_modern_generation - get the device genreation
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the genreation read from device
+ */
+static u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	return vp_ioread8(&cfg->config_generation);
 }
 
+static u32 vp_generation(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	return vp_modern_generation(&vp_dev->mdev);
+}
+
 /*
  * vp_modern_get_status - get the device status
  * @mdev: the modern virtio-pci device
-- 
2.25.1

