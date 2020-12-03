Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59322CDBDD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501918AbgLCRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725918AbgLCRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hisbr3UOnYrN0Fjo9B4TjtmMCxkdxhnJogB1zcbP0DE=;
        b=MgxCnz6X/PQvL9oSaCJm5yf+spWC+pe7Yw/wiBNC/XBEoc1djRR4Nxo458J6OxAZCou95Q
        0z6+bzEawMNB56L9ufrL1ce9jQJmzOUArq6hsdPFI98/nXw9waOQQ7gw9ZJFgIrJOjNtB9
        gR6sn5LsTyor4fQaGbtQtEMFc0dyHnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7Tyy3g0GNhK0aljB993dag-1; Thu, 03 Dec 2020 12:06:03 -0500
X-MC-Unique: 7Tyy3g0GNhK0aljB993dag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8720192AB79;
        Thu,  3 Dec 2020 17:05:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D34660C69;
        Thu,  3 Dec 2020 17:05:56 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 06/19] vdpa_sim: rename vdpasim_config_ops variables
Date:   Thu,  3 Dec 2020 18:04:58 +0100
Message-Id: <20201203170511.216407-7-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 688aceaa6543..625e0f46b672 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -333,8 +333,8 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 	.free = vdpasim_free_coherent,
 };
 
-static const struct vdpa_config_ops vdpasim_net_config_ops;
-static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
+static const struct vdpa_config_ops vdpasim_config_ops;
+static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
 static struct vdpasim *vdpasim_create(void)
 {
@@ -344,9 +344,9 @@ static struct vdpasim *vdpasim_create(void)
 	int i, ret = -ENOMEM;
 
 	if (batch_mapping)
-		ops = &vdpasim_net_batch_config_ops;
+		ops = &vdpasim_batch_config_ops;
 	else
-		ops = &vdpasim_net_config_ops;
+		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
 	if (!vdpasim)
@@ -659,7 +659,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->vqs);
 }
 
-static const struct vdpa_config_ops vdpasim_net_config_ops = {
+static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
 	.set_vq_num             = vdpasim_set_vq_num,
 	.kick_vq                = vdpasim_kick_vq,
@@ -686,7 +686,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.free                   = vdpasim_free,
 };
 
-static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
+static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
 	.set_vq_num             = vdpasim_set_vq_num,
 	.kick_vq                = vdpasim_kick_vq,
-- 
2.26.2

