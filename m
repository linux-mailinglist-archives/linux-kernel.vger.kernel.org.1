Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE192C5771
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390351AbgKZOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389756AbgKZOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgeOvdyIExWUoyLX31++F3PhFzZaDc7ReaHXAYKQi0E=;
        b=TpJ4/KNBCl/idNC6c9IfCbmFihIgZcsdiPBDq3Kzkz/ZzKFSE1Z01AK2UTiObLjYtI2jby
        /+6b3bRT2LlrblsQQHbJTmH1l+8/NiY7Ms8Avu24FPKqv5qky4+kvQwjptHZs3c/c1Ttw+
        srwjPz1KvLpHN6OAr9ZuYkkfexlg2qE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-KtY14Q4pPNeDm9PhnlYJUg-1; Thu, 26 Nov 2020 09:50:43 -0500
X-MC-Unique: KtY14Q4pPNeDm9PhnlYJUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C51805BFA;
        Thu, 26 Nov 2020 14:50:41 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19F1B5C1BD;
        Thu, 26 Nov 2020 14:50:39 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 07/17] vdpa_sim: add device id field in vdpasim_dev_attr
Date:   Thu, 26 Nov 2020 15:49:40 +0100
Message-Id: <20201126144950.92850-8-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove VDPASIM_DEVICE_ID macro and add 'id' field in vdpasim_dev_attr,
that will be returned by vdpasim_get_device_id().

Use VIRTIO_ID_NET for vDPA-net simulator device id.

Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index f98262add0e1..393b54a9f0e4 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -44,7 +44,6 @@ struct vdpasim_virtqueue {
 
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
-#define VDPASIM_DEVICE_ID 0x1
 #define VDPASIM_VENDOR_ID 0
 #define VDPASIM_IOTLB_LIMIT 0 /* unlimited */
 #define VDPASIM_VQ_NUM 0x2
@@ -57,6 +56,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 
 struct vdpasim_dev_attr {
 	int nvqs;
+	u32 id;
 };
 
 /* State of each vdpasim device */
@@ -536,7 +536,9 @@ static u16 vdpasim_get_vq_num_max(struct vdpa_device *vdpa)
 
 static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
 {
-	return VDPASIM_DEVICE_ID;
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	return vdpasim->dev_attr.id;
 }
 
 static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
@@ -719,6 +721,7 @@ static int __init vdpasim_dev_init(void)
 {
 	struct vdpasim_dev_attr dev_attr = {};
 
+	dev_attr.id = VIRTIO_ID_NET;
 	dev_attr.nvqs = VDPASIM_VQ_NUM;
 
 	vdpasim_dev = vdpasim_create(&dev_attr);
-- 
2.26.2

