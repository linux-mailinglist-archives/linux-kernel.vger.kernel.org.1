Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2702B1C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKMNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbgKMNsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMBulDP8AaVIq7STiZICrzlB2gUlznRGXWnFGPjmsNE=;
        b=KTcq2w9r7fCmz7VdhY/7mTu/E4mcRFwzSFFh0YpR/YjvBoBuxvQOElFnRV/ikPzXpnZVu3
        st4tByClzW187AhT2P6Ha+fpbD5zifagsoAXve/OHBp3GZNLiJ6N37GFYEAvxj9jmgE227
        Fs/U2nbMp5YpJ6+5/ukWacdDHcMZHeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-7w8SGsMfMn2Oe56oy01bVw-1; Fri, 13 Nov 2020 08:48:05 -0500
X-MC-Unique: 7w8SGsMfMn2Oe56oy01bVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C036186DD4D;
        Fri, 13 Nov 2020 13:48:04 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 285C519C66;
        Fri, 13 Nov 2020 13:48:01 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 05/12] vdpa_sim: remove the limit of IOTLB entries
Date:   Fri, 13 Nov 2020 14:47:05 +0100
Message-Id: <20201113134712.69744-6-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simulated devices can support multiple queues, so this limit
should be defined according to the number of queues supported by
the device.

Since we are in a simulator, let's simply remove that limit.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2b4fea354413..9c9717441bbe 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -230,7 +230,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 		goto err_iommu;
 	set_dma_ops(dev, &vdpasim_dma_ops);
 
-	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
+	vdpasim->iommu = vhost_iotlb_alloc(0, 0);
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-- 
2.26.2

