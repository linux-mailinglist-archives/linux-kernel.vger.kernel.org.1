Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9005F2C5784
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391228AbgKZOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:52:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391130AbgKZOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIZQuC92hOTgurxgbN1im+JxeaiI1Jbob3QIExGfXoc=;
        b=FyqtsV0hFU//+sswuXUU2r4AaYdKSDonbQkM0duXzykZIXCAUb9XZZDUkBCrZ6iGQJX4Ph
        JIiUZsANS8y/caYGPRwcw/XTJrgyEk6fi7uk9wsR5vcqD186NKbfj4LPmcvdYGpow52ecq
        +0SUQ7hFRXac21Sn4J19/++hjrnaBb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-SXfNE8VOMVOlzYosuK7ZkA-1; Thu, 26 Nov 2020 09:52:28 -0500
X-MC-Unique: SXfNE8VOMVOlzYosuK7ZkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E99F91E7D3;
        Thu, 26 Nov 2020 14:52:26 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9678610013C0;
        Thu, 26 Nov 2020 14:52:18 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 16/17] vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov
Date:   Thu, 26 Nov 2020 15:49:49 +0100
Message-Id: <20201126144950.92850-17-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vringh_getdesc_iotlb() manages 2 iovs for writable and readable
descriptors. This is very useful for the block device, where for
each request we have both types of descriptor.

Let's split the vdpasim_virtqueue's iov field in out_iov and
in_iov to use them with vringh_getdesc_iotlb().

We are using VIRTIO terminology for "out" (readable by the device)
and "in" (writable by the device) descriptors.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- used VIRTIO terminology [Stefan]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index f5f41f20ee0b..f8ee261ef4ae 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -33,7 +33,8 @@ u8 macaddr_buf[ETH_ALEN];
 
 struct vdpasim_virtqueue {
 	struct vringh vring;
-	struct vringh_kiov iov;
+	struct vringh_kiov in_iov;
+	struct vringh_kiov out_iov;
 	unsigned short head;
 	bool ready;
 	u64 desc_addr;
@@ -197,12 +198,12 @@ static void vdpasim_net_work(struct work_struct *work)
 
 	while (true) {
 		total_write = 0;
-		err = vringh_getdesc_iotlb(&txq->vring, &txq->iov, NULL,
+		err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
 					   &txq->head, GFP_ATOMIC);
 		if (err <= 0)
 			break;
 
-		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->iov,
+		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
 					   &rxq->head, GFP_ATOMIC);
 		if (err <= 0) {
 			vringh_complete_iotlb(&txq->vring, txq->head, 0);
@@ -210,13 +211,13 @@ static void vdpasim_net_work(struct work_struct *work)
 		}
 
 		while (true) {
-			read = vringh_iov_pull_iotlb(&txq->vring, &txq->iov,
+			read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
 						     vdpasim->buffer,
 						     PAGE_SIZE);
 			if (read <= 0)
 				break;
 
-			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->iov,
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
 						      vdpasim->buffer, read);
 			if (write <= 0)
 				break;
-- 
2.26.2

