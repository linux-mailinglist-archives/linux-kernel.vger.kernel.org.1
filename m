Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483712DAFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgLOPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729627AbgLOOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/Ea2WAegGQYkjMF82PraLZnAGtJmBscSDdL25u9cyk=;
        b=esipWgL3DJGpL5tA15eoLB7GlnU3kieQJGSab22W0zXTD7FHAeFCr8hQRUw2MlJv25S4X1
        2UB0n068/5NxU3xQbuCqDiRNVUHsue0hYpvji0r3INbHdRbViILl9VE1HotAHwn8br/Kqv
        Pt5Gvg3+aQGJsidfnOWZ/GqxfFwTKpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-N1hAShuYO6ai6ZpfVCYTzA-1; Tue, 15 Dec 2020 09:43:51 -0500
X-MC-Unique: N1hAShuYO6ai6ZpfVCYTzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F58F107ACE4;
        Tue, 15 Dec 2020 14:43:50 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F72C19C44;
        Tue, 15 Dec 2020 14:43:46 +0000 (UTC)
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
Subject: [PATCH v4 05/18] vdpa_sim: rename vdpasim_config_ops variables
Date:   Tue, 15 Dec 2020 15:42:43 +0100
Message-Id: <20201215144256.155342-6-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variables store generic callbacks used by the vDPA simulator
core, so we can remove the 'net' word in their names.

Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d716bfaadb3b..923f29076b1b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -341,8 +341,8 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 	.free = vdpasim_free_coherent,
 };
 
-static const struct vdpa_config_ops vdpasim_net_config_ops;
-static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
+static const struct vdpa_config_ops vdpasim_config_ops;
+static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
 static struct vdpasim *vdpasim_create(void)
 {
@@ -352,9 +352,9 @@ static struct vdpasim *vdpasim_create(void)
 	int i, ret = -ENOMEM;
 
 	if (batch_mapping)
-		ops = &vdpasim_net_batch_config_ops;
+		ops = &vdpasim_batch_config_ops;
 	else
-		ops = &vdpasim_net_config_ops;
+		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
 	if (!vdpasim)
@@ -667,7 +667,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->vqs);
 }
 
-static const struct vdpa_config_ops vdpasim_net_config_ops = {
+static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
 	.set_vq_num             = vdpasim_set_vq_num,
 	.kick_vq                = vdpasim_kick_vq,
@@ -694,7 +694,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.free                   = vdpasim_free,
 };
 
-static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
+static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
 	.set_vq_num             = vdpasim_set_vq_num,
 	.kick_vq                = vdpasim_kick_vq,
-- 
2.26.2

