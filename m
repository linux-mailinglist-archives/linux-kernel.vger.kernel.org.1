Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913EB2C576E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgKZOuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389756AbgKZOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6pFL40zOfd0tqmsESxpEqmuQVPd0caaEj6DcUiifgB8=;
        b=UNaPY7Dgyvpq9OM1kTle9BRxpZcZEdcHaDkWrD9470/Yy+zDikIwQe67cmAdk0q9yM+CwT
        7BPqEif7xT7im7lIKHwDO14l1yeJU+Bd9Dsl6zj8XoJCmIYd4gfi60gvVHOOzw1gJUVpNO
        ItOtcDpHTw9Oy+5qy6wwqRzR2WdVGP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-KMmRDZWeNl2n_MkIOF3ONA-1; Thu, 26 Nov 2020 09:50:36 -0500
X-MC-Unique: KMmRDZWeNl2n_MkIOF3ONA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 832C6805BFF;
        Thu, 26 Nov 2020 14:50:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77FD65C1BD;
        Thu, 26 Nov 2020 14:50:27 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 04/17] vdpa_sim: remove the limit of IOTLB entries
Date:   Thu, 26 Nov 2020 15:49:37 +0100
Message-Id: <20201126144950.92850-5-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simulated devices can support multiple queues, so this limit
should be defined according to the number of queues supported by
the device.

Since we are in a simulator, let's simply remove that limit.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- added VDPASIM_IOTLB_LIMIT macro [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index ad72f7b1a4eb..40664d87f303 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -46,6 +46,7 @@ struct vdpasim_virtqueue {
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_DEVICE_ID 0x1
 #define VDPASIM_VENDOR_ID 0
+#define VDPASIM_IOTLB_LIMIT 0 /* unlimited */
 #define VDPASIM_VQ_NUM 0x2
 #define VDPASIM_NAME "vdpasim-netdev"
 
@@ -365,7 +366,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->vqs)
 		goto err_iommu;
 
-	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
+	vdpasim->iommu = vhost_iotlb_alloc(VDPASIM_IOTLB_LIMIT, 0);
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-- 
2.26.2

