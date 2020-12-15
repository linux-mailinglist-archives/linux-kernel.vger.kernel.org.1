Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397172DAF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgLOOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729453AbgLOOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDSiwsG/WB/U9itTkhtrRYm6VWM51gH1rMvWGm64FGo=;
        b=A0yijXt7BNB5JrUvb5JPkLaN7cy8928UATBXn5Sj8MF6WYfit1j6ZxA5hbIqacYhmqPvKQ
        KQEh0tqu0ZoEa5998MQAdG979gaVLuyDFq3FdN0IlFLY4qhraAECCQEedxl4lRljhYZh4l
        TIBHS8LLJQ/ezem/5D9VMtFgEm6aJu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-7pg2K-pLMcKYNwsPkNX_Og-1; Tue, 15 Dec 2020 09:44:33 -0500
X-MC-Unique: 7pg2K-pLMcKYNwsPkNX_Og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F0C800D55;
        Tue, 15 Dec 2020 14:44:32 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB73710013C1;
        Tue, 15 Dec 2020 14:44:29 +0000 (UTC)
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
Subject: [PATCH v4 10/18] vdpa_sim: store parsed MAC address in a buffer
Date:   Tue, 15 Dec 2020 15:42:48 +0100
Message-Id: <20201215144256.155342-11-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for the next patches, we store the MAC address,
parsed during the vdpasim_create(), in a buffer that will be used
to fill 'config' together with other configurations.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d356929f9dd3..ccb40501cbd7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -40,6 +40,8 @@ static char *macaddr;
 module_param(macaddr, charp, 0);
 MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
 
+u8 macaddr_buf[ETH_ALEN];
+
 struct vdpasim_virtqueue {
 	struct vringh vring;
 	struct vringh_kiov iov;
@@ -396,13 +398,13 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
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
@@ -538,6 +540,8 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
+	memcpy(config->mac, macaddr_buf, ETH_ALEN);
+
 	return 0;
 }
 
-- 
2.26.2

