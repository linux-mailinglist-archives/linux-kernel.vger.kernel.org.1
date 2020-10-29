Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465F29EBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ2MYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgJ2MXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603974181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uu1tSUlQesEvUDOvu71K/Re9PS7yCI/Ckixv81heB68=;
        b=MrXt5Z81enyxcclTA3ygBvjNS87Zpsd+41hSuiDE/JR8D4ygQtx5J3P50yqpRFOilCq4fR
        rgMST2gfnLo6K0npf5NUJTTzQkbJusw5cYwR0Gl0au3xl2eoesRwzScgedoX7vR57YPTiv
        g/fEujsUXnaZRM9ZGjgTk8xkXTBLHlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-JN7Y5NHFNI29WG7XpYQt1g-1; Thu, 29 Oct 2020 08:20:55 -0400
X-MC-Unique: JN7Y5NHFNI29WG7XpYQt1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9152287952A;
        Thu, 29 Oct 2020 12:20:54 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-197.ams2.redhat.com [10.36.113.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD3B6266E;
        Thu, 29 Oct 2020 12:20:52 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/2] vdpasim: fix MAC address configuration
Date:   Thu, 29 Oct 2020 13:20:49 +0100
Message-Id: <20201029122050.776445-2-lvivier@redhat.com>
In-Reply-To: <20201029122050.776445-1-lvivier@redhat.com>
References: <20201029122050.776445-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdpa_sim generates a ramdom MAC address but it is never used by upper
layers because the VIRTIO_NET_F_MAC bit is not set in the features list.

Because of that, virtio-net always regenerates a random MAC address each
time it is loaded whereas the address should only change on vdpa_sim
load/unload.

Fix that by adding VIRTIO_NET_F_MAC in the features list of vdpa_sim.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Cc: jasowang@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2629911c29bb..7f8ebc9924ac 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -60,7 +60,8 @@ struct vdpasim_virtqueue {
 
 static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 			      (1ULL << VIRTIO_F_VERSION_1)  |
-			      (1ULL << VIRTIO_F_ACCESS_PLATFORM);
+			      (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
+			      (1ULL << VIRTIO_NET_F_MAC);
 
 /* State of each vdpasim device */
 struct vdpasim {
-- 
2.26.2

