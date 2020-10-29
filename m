Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EEE29EBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgJ2MZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgJ2MXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603974184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhuU63QYYA1pfwdAnRMuQGZDltzslJa5sQvMjC4VHB4=;
        b=JUVIw66+9W+0eD4BhfXjVhPIYSZc76pbpHKxviq4E1LajVzbrNKNGz6Nyfzojf/lFvKdF6
        IKSgDYzlByMk2gtoHLj5TFrNS2QkYNgODYpfi+1oufcds0Woeq+4svcg+MKxitSVGtby+h
        CkruOKM4B6lS8X95HjflhTUG/GC47+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-lFnQ0bnJOYGjYECIeoQ01w-1; Thu, 29 Oct 2020 08:20:57 -0400
X-MC-Unique: lFnQ0bnJOYGjYECIeoQ01w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB4010199A7;
        Thu, 29 Oct 2020 12:20:56 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-197.ams2.redhat.com [10.36.113.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9DC26266E;
        Thu, 29 Oct 2020 12:20:54 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/2] vdpasim: allow to assign a MAC address
Date:   Thu, 29 Oct 2020 13:20:50 +0100
Message-Id: <20201029122050.776445-3-lvivier@redhat.com>
In-Reply-To: <20201029122050.776445-1-lvivier@redhat.com>
References: <20201029122050.776445-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macaddr parameter to the module to set the MAC address to use

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 7f8ebc9924ac..9cf7079ee185 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -38,6 +38,10 @@ static int batch_mapping = 1;
 module_param(batch_mapping, int, 0444);
 MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
 
+static char *macaddr;
+module_param(macaddr, charp, 0);
+MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
+
 struct vdpasim_virtqueue {
 	struct vringh vring;
 	struct vringh_kiov iov;
@@ -373,7 +377,15 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	eth_random_addr(vdpasim->config.mac);
+	if (macaddr) {
+		mac_pton(macaddr, vdpasim->config.mac);
+		if (!is_valid_ether_addr(vdpasim->config.mac)) {
+			ret = -EADDRNOTAVAIL;
+			goto err_iommu;
+		}
+	} else {
+		eth_random_addr(vdpasim->config.mac);
+	}
 
 	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
 	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
-- 
2.26.2

