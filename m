Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816462CDBEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501939AbgLCRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2501933AbgLCRJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+DtPcNrkAVlytmGf4lB/estLQSwJ5Xy0BaXAW7yudY=;
        b=KoXMTKtZpQGVUnjpfDIm2un/nQYvwpg7wgIRUG2Qj3OIJiHf0RjWokiUoLKUnsuipYcxHu
        +SwvWFzhO5SMw8f4I8HgtlKcg/z1Yto08JDPzAOJ37DwLlwNQItLsOvJZjKHm2ghQj83iw
        dNSMMHjuKSmKPsVVtq6LRf1L27xjBeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-o4izIjauPieiOA3G1Acj5g-1; Thu, 03 Dec 2020 12:07:30 -0500
X-MC-Unique: o4izIjauPieiOA3G1Acj5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C28819611AA;
        Thu,  3 Dec 2020 17:07:28 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42BE05D9CA;
        Thu,  3 Dec 2020 17:07:25 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 14/19] vdpa_sim: add set_config callback in vdpasim_dev_attr
Date:   Thu,  3 Dec 2020 18:05:06 +0100
Message-Id: <20201203170511.216407-15-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set_config callback can be used by the device to parse the
config structure modified by the driver.

The callback will be invoked, if set, in vdpasim_set_config() after
copying bytes from caller buffer into vdpasim->config buffer.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index f935ade0806b..03a8717f80ea 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -70,6 +70,7 @@ struct vdpasim_dev_attr {
 
 	work_func_t work_fn;
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
+	void (*set_config)(struct vdpasim *vdpasim, const void *config);
 };
 
 /* State of each vdpasim device */
@@ -598,7 +599,15 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
 			     const void *buf, unsigned int len)
 {
-	/* No writable config supportted by vdpasim */
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (offset + len > vdpasim->dev_attr.config_size)
+		return;
+
+	memcpy(vdpasim->config + offset, buf, len);
+
+	if (vdpasim->dev_attr.set_config)
+		vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
 }
 
 static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
-- 
2.26.2

