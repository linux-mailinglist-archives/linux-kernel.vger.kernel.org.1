Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6212C5777
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbgKZOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391157AbgKZOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgeuJHqaj3U5wNqlggBJs76w7QiOxVJJ27PT5+3lfuM=;
        b=UZEk5UQojEKj3ElYwI0Uco99xQ3xyNZbA+Fy28Lx2Ef5cuRqb31e9QtGWUTED4RGqDw0zr
        mrEk3AQ2ntHyMpNFAKN1cxzmfB3e9N4lnut863O9ZsVzOr9sryeMEIM2z409eEhQEzobpr
        oik0AS2L9k//dSbTKSz0OVU6ATsi1oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-jKWCr-bYNNC1mwQ2urLg7Q-1; Thu, 26 Nov 2020 09:51:54 -0500
X-MC-Unique: jKWCr-bYNNC1mwQ2urLg7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22810180E48E;
        Thu, 26 Nov 2020 14:51:53 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5003B60855;
        Thu, 26 Nov 2020 14:51:51 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 13/17] vdpa_sim: set vringh notify callback
Date:   Thu, 26 Nov 2020 15:49:46 +0100
Message-Id: <20201126144950.92850-14-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling the vq callback directly, we can leverage the
vringh_notify() function, adding vdpasim_vq_notify() and setting it
in the vringh notify callback.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8b87ce0485b6..4327efd6d41e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -120,6 +120,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
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
@@ -131,6 +142,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->driver_addr,
 			  (struct vring_used *)
 			  (uintptr_t)vq->device_addr);
+
+	vq->vring.notify = vdpasim_vq_notify;
 }
 
 static void vdpasim_vq_reset(struct vdpasim *vdpasim,
@@ -220,10 +233,10 @@ static void vdpasim_net_work(struct work_struct *work)
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

