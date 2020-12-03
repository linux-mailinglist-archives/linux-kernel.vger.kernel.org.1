Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63162CDBDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgLCRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725918AbgLCRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alpK7WJxphKJly17X+Hs3orOiMRH5k8qEoiOpT1GxLM=;
        b=FesGA304NKFf8McVh5Y3awQKtDC00jbtryIk39eeQnv/VXgRO6D0uY0rSOptOfh+EXMJ8p
        s3hYYlWHs4My9g763QKM+F9eHoK2Zj5Nfq8jJPs+Fitm8S1Xv5LvvSGgz1MzlhzDjoVm/u
        +/hn8C+j6HfHC1E8Ri878cBbKnCBlUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-X2WqPhMhOGuoVKSobNRqHw-1; Thu, 03 Dec 2020 12:06:33 -0500
X-MC-Unique: X2WqPhMhOGuoVKSobNRqHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990BB107ACF6;
        Thu,  3 Dec 2020 17:06:32 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0C260BFA;
        Thu,  3 Dec 2020 17:06:23 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 08/19] vdpa_sim: add device id field in vdpasim_dev_attr
Date:   Thu,  3 Dec 2020 18:05:00 +0100
Message-Id: <20201203170511.216407-9-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove VDPASIM_DEVICE_ID macro and add 'id' field in vdpasim_dev_attr,
that will be returned by vdpasim_get_device_id().

Use VIRTIO_ID_NET for vDPA-net simulator device id.

Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index e132b886cb84..3d97bc709fb9 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -47,7 +47,6 @@ struct vdpasim_virtqueue {
 
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
-#define VDPASIM_DEVICE_ID 0x1
 #define VDPASIM_VENDOR_ID 0
 #define VDPASIM_VQ_NUM 0x2
 #define VDPASIM_NAME "vdpasim-netdev"
@@ -59,6 +58,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 
 struct vdpasim_dev_attr {
 	int nvqs;
+	u32 id;
 };
 
 /* State of each vdpasim device */
@@ -538,7 +538,9 @@ static u16 vdpasim_get_vq_num_max(struct vdpa_device *vdpa)
 
 static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
 {
-	return VDPASIM_DEVICE_ID;
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	return vdpasim->dev_attr.id;
 }
 
 static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
@@ -721,6 +723,7 @@ static int __init vdpasim_dev_init(void)
 {
 	struct vdpasim_dev_attr dev_attr = {};
 
+	dev_attr.id = VIRTIO_ID_NET;
 	dev_attr.nvqs = VDPASIM_VQ_NUM;
 
 	vdpasim_dev = vdpasim_create(&dev_attr);
-- 
2.26.2

