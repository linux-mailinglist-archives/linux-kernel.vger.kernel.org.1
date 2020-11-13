Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB22B1C60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMNtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgKMNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUWlJHRXTci3OE9aKsACoxuZyffR9CQAnZGBUFnY9/4=;
        b=PRth3PyCPas1RCeJOa9f9oT8xDp5t8iHsg1RP0hlicpdNr9VnLhwJectH4dQA5HX1NnPDM
        aNtE4p1MtC4I53V3ZPNvMmSMmKZ31NafgdX6CoCcafyyXpf3OmY9BVGjK1syLHT7pPiHhX
        KH3GkWl3ViWCe4yogoMJrCz8sEAxa+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Q5dfMm2JN-uBAE7tf67S5Q-1; Fri, 13 Nov 2020 08:48:45 -0500
X-MC-Unique: Q5dfMm2JN-uBAE7tf67S5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD6F31084C96;
        Fri, 13 Nov 2020 13:48:44 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 064605D9F3;
        Fri, 13 Nov 2020 13:48:42 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field in riov and wiov
Date:   Fri, 13 Nov 2020 14:47:10 +0100
Message-Id: <20201113134712.69744-11-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vringh_getdesc_iotlb() manages 2 iovs for writable and readable
descriptors. This is very useful for the block device, where for
each request we have both types of descriptor.

Let's split the vdpasim_virtqueue's iov field in riov and wiov
to use them with vringh_getdesc_iotlb().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 6 +++---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 8 ++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index cc21e07aa2f7..0d4629675e4b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -27,7 +27,8 @@ struct vdpasim;
 
 struct vdpasim_virtqueue {
 	struct vringh vring;
-	struct vringh_kiov iov;
+	struct vringh_kiov riov;
+	struct vringh_kiov wiov;
 	unsigned short head;
 	bool ready;
 	u64 desc_addr;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 122a3c039507..8e41b3ab98d5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -41,13 +41,13 @@ static void vdpasim_blk_work(struct work_struct *work)
 		if (!vq->ready)
 			continue;
 
-		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
+		while (vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
 					    &vq->head, GFP_ATOMIC) > 0) {
 
 			int write;
 
-			vq->iov.i = vq->iov.used - 1;
-			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
+			vq->wiov.i = vq->wiov.used - 1;
+			write = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
 			if (write <= 0)
 				break;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index d0a1403f64b2..783b1e85b09c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -47,12 +47,12 @@ static void vdpasim_net_work(struct work_struct *work)
 
 	while (true) {
 		total_write = 0;
-		err = vringh_getdesc_iotlb(&txq->vring, &txq->iov, NULL,
+		err = vringh_getdesc_iotlb(&txq->vring, &txq->riov, NULL,
 					   &txq->head, GFP_ATOMIC);
 		if (err <= 0)
 			break;
 
-		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->iov,
+		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->wiov,
 					   &rxq->head, GFP_ATOMIC);
 		if (err <= 0) {
 			vringh_complete_iotlb(&txq->vring, txq->head, 0);
@@ -60,13 +60,13 @@ static void vdpasim_net_work(struct work_struct *work)
 		}
 
 		while (true) {
-			read = vringh_iov_pull_iotlb(&txq->vring, &txq->iov,
+			read = vringh_iov_pull_iotlb(&txq->vring, &txq->riov,
 						     vdpasim->buffer,
 						     PAGE_SIZE);
 			if (read <= 0)
 				break;
 
-			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->iov,
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->wiov,
 						      vdpasim->buffer, read);
 			if (write <= 0)
 				break;
-- 
2.26.2

