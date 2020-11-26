Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FBA2C5775
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbgKZOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390888AbgKZOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VC227IjJ++QgLe8qn6v9Ot5LdCf00QlmkoCumtZGXpc=;
        b=Wl/JBGqdQDBO79+qSjduZBldbPaUuiwT3pmrFvDlw4j2Brt3LvDpbrldWfacVuAIGmd4Sf
        D8QQi0kunrzIk075e1/Y+v7N5bhv0QcGCbFA6MMajcNhydrZdC7VIlqQgEjrmFA4KSuHaU
        HnL2uJz1Iyx/NM7RG5OW/Q/ECDasbbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-lT11_URxNpa6KGwiOGWQBA-1; Thu, 26 Nov 2020 09:51:20 -0500
X-MC-Unique: lT11_URxNpa6KGwiOGWQBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA249190A7A1;
        Thu, 26 Nov 2020 14:51:19 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE9B5B4A0;
        Thu, 26 Nov 2020 14:51:17 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 10/17] vdpa_sim: store parsed MAC address in a buffer
Date:   Thu, 26 Nov 2020 15:49:43 +0100
Message-Id: <20201126144950.92850-11-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for the next patches, we store the MAC address,
parsed during the vdpasim_create(), in a buffer that will be used
to fill 'config' together with other configurations.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b84d9acd130c..9f2ca3a77025 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -29,6 +29,8 @@ static char *macaddr;
 module_param(macaddr, charp, 0);
 MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
 
+u8 macaddr_buf[ETH_ALEN];
+
 struct vdpasim_virtqueue {
 	struct vringh vring;
 	struct vringh_kiov iov;
@@ -386,13 +388,13 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		goto err_iommu;
 
 	if (macaddr) {
-		mac_pton(macaddr, vdpasim->config.mac);
-		if (!is_valid_ether_addr(vdpasim->config.mac)) {
+		mac_pton(macaddr, macaddr_buf);
+		if (!is_valid_ether_addr(macaddr_buf)) {
 			ret = -EADDRNOTAVAIL;
 			goto err_iommu;
 		}
 	} else {
-		eth_random_addr(vdpasim->config.mac);
+		eth_random_addr(macaddr_buf);
 	}
 
 	for (i = 0; i < dev_attr->nvqs; i++)
@@ -528,6 +530,8 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
+	memcpy(config->mac, macaddr_buf, ETH_ALEN);
+
 	return 0;
 }
 
-- 
2.26.2

