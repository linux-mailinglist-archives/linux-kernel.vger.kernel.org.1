Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279872CE6EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgLDEGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgLDEGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlSrvPYi7Sf8S1ru+B79DHoQTOX3kJJE4+lQVOglXBY=;
        b=FGqxf/7l15Mdn8i+qkbyyN9EGCRsAlMGILsOATGfDwXMNvhqtx0hkG2h8noAal98lflcFX
        JB0nZgSw28aBzcmrpQYpkAW5C4KiWPphWyGds809jve29xA3vdD3afpRgZx0/Aw9nfUKdf
        wI2LKzzNZRMCogvSDw+GhXD/z7dsSbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-lwagjO8PNXOT0IdvcRSONw-1; Thu, 03 Dec 2020 23:04:50 -0500
X-MC-Unique: lwagjO8PNXOT0IdvcRSONw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3868D1842140;
        Fri,  4 Dec 2020 04:04:49 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CDC01A890;
        Fri,  4 Dec 2020 04:04:45 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 13/19] virtio-pci-modern: introduce helper for getting queue nums
Date:   Fri,  4 Dec 2020 12:03:47 +0800
Message-Id: <20201204040353.21679-14-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces helper for getting queue num of modern device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7a89226135af..bccad1329871 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -292,6 +292,17 @@ static u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 
 }
 
+/*
+ * vp_modern_get_num_queues - get the number of virtqueues
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the number of virtqueues
+ */
+static u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
+{
+	return vp_ioread16(&mdev->common->num_queues);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -510,7 +521,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	u16 num, off;
 	int err;
 
-	if (index >= vp_ioread16(&cfg->num_queues))
+	if (index >= vp_modern_get_num_queues(mdev))
 		return ERR_PTR(-ENOENT);
 
 	/* Select the queue we're interested in */
-- 
2.25.1

