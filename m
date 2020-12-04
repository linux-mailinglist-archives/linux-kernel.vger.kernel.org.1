Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106362CE6E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgLDEFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgLDEFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsLbOav7/E39nNDxLtrE61Pdclqr7iYbX9oecocZesI=;
        b=FxQqWcG6RMgXwN2y7RvNZUEpZ0vIGc77Hwh2+LG+Lqr2YV7CdzmhEeU97PKfYzm18Dpu1h
        QiE32LkDyoQjxaLqAXUqhDFVo/l7ZJyW8UehU01+wn59CzLRLAplYfwpccj82RpGeWbGRc
        0sg96GHsWzWjzprds44fkap3BwsPeEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-wE3NmI_iNcOBIOBUglUgaQ-1; Thu, 03 Dec 2020 23:04:15 -0500
X-MC-Unique: wE3NmI_iNcOBIOBUglUgaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92DC5107ACE3;
        Fri,  4 Dec 2020 04:04:14 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD541A890;
        Fri,  4 Dec 2020 04:04:11 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 04/19] virtio-pci-modern: introduce vp_modern_remove()
Date:   Fri,  4 Dec 2020 12:03:38 +0800
Message-Id: <20201204040353.21679-5-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces vp_modern_remove() doing device resources
cleanup to make it can be used.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5d2d2ae0dfdb..4be9afad547e 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -873,9 +873,12 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	return 0;
 }
 
-void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
+/*
+ * vp_modern_probe: remove and cleanup the modern virtio pci device
+ * @mdev: the modern virtio-pci device
+ */
+static void vp_modern_remove(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct pci_dev *pci_dev = mdev->pci_dev;
 
 	if (mdev->device)
@@ -886,3 +889,10 @@ void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 	pci_iounmap(pci_dev, mdev->common);
 	pci_release_selected_regions(pci_dev, mdev->modern_bars);
 }
+
+void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
+{
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+
+	vp_modern_remove(mdev);
+}
-- 
2.25.1

