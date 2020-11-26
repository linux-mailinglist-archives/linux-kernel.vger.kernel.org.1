Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932BC2C5129
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbgKZJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389404AbgKZJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JtJSGoa5TRfuuBNc87icAYiWh/b5eXjv2GjseWaFBo=;
        b=Q9nfseggyxRTpwHxHXMOVc+wmInwLFNN8wN9cG3FYDYGDEp3R8RBQM8jOKyGz2h1Q0bWC6
        q6/s1K+oSNKijpaBi8wE47rP17sYU18IV+ssL8hUoNN4Oq7WeuvLFxUrwXLlERUbMexQVy
        hp2vpKxG+cPDKbea2Fwp3pFsMSVYcTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-b-2MMO6uNYWeFOwxk8YKnQ-1; Thu, 26 Nov 2020 04:26:48 -0500
X-MC-Unique: b-2MMO6uNYWeFOwxk8YKnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26628185E48E;
        Thu, 26 Nov 2020 09:26:47 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4180F19C71;
        Thu, 26 Nov 2020 09:26:44 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 13/14] virtio_vdpa: don't warn when fail to disable vq
Date:   Thu, 26 Nov 2020 17:26:03 +0800
Message-Id: <20201126092604.208033-14-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no guarantee that the device can disable a specific virtqueue
through set_vq_ready(). One example is the modern virtio-pci
device. So this patch removes the warning.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 4a9ddb44b2a7..e28acf482e0c 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -225,9 +225,8 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq)
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vd_dev->lock, flags);
 
-	/* Select and deactivate the queue */
+	/* Select and deactivate the queue (best effort) */
 	ops->set_vq_ready(vdpa, index, 0);
-	WARN_ON(ops->get_vq_ready(vdpa, index));
 
 	vring_del_virtqueue(vq);
 
-- 
2.25.1

