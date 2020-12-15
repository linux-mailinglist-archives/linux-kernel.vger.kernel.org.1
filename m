Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E32DAFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgLOPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:02:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729709AbgLOOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/v7TjZoHK7SUgKoEpQNmto82yYxN7Hm3NV55qpnAAYk=;
        b=Rp8N2Fol7duVtuYxju9FCJrsMe+9r7kFcwc7A9Ipbu5zHtJZ2ukg+xsTp/wY4sRHoPWraG
        Owdu9wIGxjNDxL/wSFKrtYwdeW5pkBMQjvQIoqlQsTbzv6VMl1vSa+UEWzYP28W1j0/bXV
        AZOQFd3T4v3yFKIlqUG856C4OpT9OTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-6_fCJYOsNmqiRGrqR05V7g-1; Tue, 15 Dec 2020 09:45:17 -0500
X-MC-Unique: 6_fCJYOsNmqiRGrqR05V7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 435F6801AC3;
        Tue, 15 Dec 2020 14:45:16 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B38B60C15;
        Tue, 15 Dec 2020 14:45:13 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Oren Duer <oren@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 14/18] vdpa_sim: set vringh notify callback
Date:   Tue, 15 Dec 2020 15:42:52 +0100
Message-Id: <20201215144256.155342-15-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling the vq callback directly, we can leverage the
vringh_notify() function, adding vdpasim_vq_notify() and setting it
in the vringh notify callback.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- cleared notify during reset [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index e219aa852ef8..19ff5e352782 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -131,6 +131,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
 	return vdpa_to_sim(vdpa);
 }
 
+static void vdpasim_vq_notify(struct vringh *vring)
+{
+	struct vdpasim_virtqueue *vq =
+		container_of(vring, struct vdpasim_virtqueue, vring);
+
+	if (!vq->cb)
+		return;
+
+	vq->cb(vq->private);
+}
+
 static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
@@ -142,6 +153,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->driver_addr,
 			  (struct vring_used *)
 			  (uintptr_t)vq->device_addr);
+
+	vq->vring.notify = vdpasim_vq_notify;
 }
 
 static void vdpasim_vq_reset(struct vdpasim *vdpasim,
@@ -155,6 +168,8 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->private = NULL;
 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
 			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
+
+	vq->vring.notify = NULL;
 }
 
 static void vdpasim_reset(struct vdpasim *vdpasim)
@@ -231,10 +246,10 @@ static void vdpasim_net_work(struct work_struct *work)
 		smp_wmb();
 
 		local_bh_disable();
-		if (txq->cb)
-			txq->cb(txq->private);
-		if (rxq->cb)
-			rxq->cb(rxq->private);
+		if (vringh_need_notify_iotlb(&txq->vring) > 0)
+			vringh_notify(&txq->vring);
+		if (vringh_need_notify_iotlb(&rxq->vring) > 0)
+			vringh_notify(&rxq->vring);
 		local_bh_enable();
 
 		if (++pkts > 4) {
-- 
2.26.2

