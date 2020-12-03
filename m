Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4302CDBED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501947AbgLCRJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2501933AbgLCRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/IQ5CgYG87iq4cFVye0i8EGHIOCur9MYL1pVEfl7Mg=;
        b=avvyrPM5huwWlZZX61txTA567C/LSbI9VyoVCRqbaDDHfLNFmH61l1wKcz9f/wKdzdk0pz
        +rLMVMMBRpFlNwT7xFPhSZSifLGn0zeP2PEkCUl0fpZI4lL6LJNCJIOOQONE+PAVkQY0oj
        Uv0UV+TUt28svL0Y8wo+LI/WfGh1NBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-dl0kiUnnPyWm6kZcPnf2Qw-1; Thu, 03 Dec 2020 12:07:32 -0500
X-MC-Unique: dl0kiUnnPyWm6kZcPnf2Qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53812425ED;
        Thu,  3 Dec 2020 17:07:31 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCE3E5D9CA;
        Thu,  3 Dec 2020 17:07:28 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 15/19] vdpa_sim: set vringh notify callback
Date:   Thu,  3 Dec 2020 18:05:07 +0100
Message-Id: <20201203170511.216407-16-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling the vq callback directly, we can leverage the
vringh_notify() function, adding vdpasim_vq_notify() and setting it
in the vringh notify callback.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- cleared notify during reset [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 03a8717f80ea..1243b02488f7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -123,6 +123,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
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
@@ -134,6 +145,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->driver_addr,
 			  (struct vring_used *)
 			  (uintptr_t)vq->device_addr);
+
+	vq->vring.notify = vdpasim_vq_notify;
 }
 
 static void vdpasim_vq_reset(struct vdpasim *vdpasim,
@@ -147,6 +160,8 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->private = NULL;
 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
 			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
+
+	vq->vring.notify = NULL;
 }
 
 static void vdpasim_reset(struct vdpasim *vdpasim)
@@ -223,10 +238,10 @@ static void vdpasim_net_work(struct work_struct *work)
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

