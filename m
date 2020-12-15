Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106982DAF58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgLOOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729912AbgLOOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFEEziORO6DLK7nkYwlfrErq3eGmAP1V7G2m/fJRym8=;
        b=WubwC8ZS+bqw8UGECiFTquEhzB87UYTLP96molDsEqROQ008qpdAMqg3LowLi9Nq1L6JHN
        Gacyxkh4lle0wTHw3FbsMKZIRcNpaI45HpXlW0BsV2FBb1eZNuCzu8AQUpemgXwAHpIXkH
        0G4z+ij7BPI7u9vQCMt9EjPEZ+NcnQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384--OVuufj1MvGr9Ut8Op1_yw-1; Tue, 15 Dec 2020 09:46:12 -0500
X-MC-Unique: -OVuufj1MvGr9Ut8Op1_yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68A738030BB;
        Tue, 15 Dec 2020 14:46:11 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C0235C224;
        Tue, 15 Dec 2020 14:46:00 +0000 (UTC)
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
Subject: [PATCH v4 17/18] vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov
Date:   Tue, 15 Dec 2020 15:42:55 +0100
Message-Id: <20201215144256.155342-18-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- used VIRTIO terminology [Stefan]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 60e45db29b15..875e42390a13 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -44,7 +44,8 @@ u8 macaddr_buf[ETH_ALEN];
 
 struct vdpasim_virtqueue {
 	struct vringh vring;
-	struct vringh_kiov iov;
+	struct vringh_kiov in_iov;
+	struct vringh_kiov out_iov;
 	unsigned short head;
 	bool ready;
 	u64 desc_addr;
@@ -210,12 +211,12 @@ static void vdpasim_net_work(struct work_struct *work)
 
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
@@ -223,13 +224,13 @@ static void vdpasim_net_work(struct work_struct *work)
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

