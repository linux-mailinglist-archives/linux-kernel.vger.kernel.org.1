Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A637B2107C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgGAJNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 05:13:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726715AbgGAJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593594809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANjSp1CGZSsGz6Jj2Dxzgjt9bQwE2jGuP+C3WvRPMLM=;
        b=DK2XChVbBzQSUMziLJZ/gzur00uyarb+Vz2bfZDMxmF4XE2+XAl8fi/9ojsP6FbT9EJgui
        +Q7R4Sa/q2nbEs6G/jA7AScaJmwamff75bZcg/xULlsOYdK7v+f5tf1agJ7Ec6Nmxp/pyh
        GxNDmFCjSpok6j+FDBs3Pr/o+5e7a3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-yv45vbF_PWiasw5_gEzo8Q-1; Wed, 01 Jul 2020 05:13:26 -0400
X-MC-Unique: yv45vbF_PWiasw5_gEzo8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 516B6BFC0;
        Wed,  1 Jul 2020 09:13:24 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E08CD9035F;
        Wed,  1 Jul 2020 09:12:02 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5/5] vdpasim: support batch updating
Date:   Wed,  1 Jul 2020 17:08:39 +0800
Message-Id: <20200701090839.12994-6-jasowang@redhat.com>
In-Reply-To: <20200701090839.12994-1-jasowang@redhat.com>
References: <20200701090839.12994-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDPA simulator support both set_map() and dma_map()/dma_unmap()
operations. But vhost-vdpa can only use one of them. So this patch
introduce a module parameter (batch_mapping) that let vpda_sim to
support only one of those dma operations. The batched mapping via
set_map() is enabled by default.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 40 +++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c7334cc65bb2..a7a0962ed8a8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -33,6 +33,10 @@
 #define DRV_DESC     "vDPA Device Simulator"
 #define DRV_LICENSE  "GPL v2"
 
+static int batch_mapping = 1;
+module_param(batch_mapping, int, 0444);
+MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
+
 struct vdpasim_virtqueue {
 	struct vringh vring;
 	struct vringh_kiov iov;
@@ -303,16 +307,22 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 };
 
 static const struct vdpa_config_ops vdpasim_net_config_ops;
+static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
 
 static struct vdpasim *vdpasim_create(void)
 {
+	const struct vdpa_config_ops *ops;
 	struct virtio_net_config *config;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int ret = -ENOMEM;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL,
-				    &vdpasim_net_config_ops);
+	if (batch_mapping)
+		ops = &vdpasim_net_batch_config_ops;
+	else
+		ops = &vdpasim_net_config_ops;
+
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -597,12 +607,36 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
-	.set_map                = vdpasim_set_map,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
 	.free                   = vdpasim_free,
 };
 
+static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
+	.set_vq_address         = vdpasim_set_vq_address,
+	.set_vq_num             = vdpasim_set_vq_num,
+	.kick_vq                = vdpasim_kick_vq,
+	.set_vq_cb              = vdpasim_set_vq_cb,
+	.set_vq_ready           = vdpasim_set_vq_ready,
+	.get_vq_ready           = vdpasim_get_vq_ready,
+	.set_vq_state           = vdpasim_set_vq_state,
+	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vq_align           = vdpasim_get_vq_align,
+	.get_features           = vdpasim_get_features,
+	.set_features           = vdpasim_set_features,
+	.set_config_cb          = vdpasim_set_config_cb,
+	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_device_id          = vdpasim_get_device_id,
+	.get_vendor_id          = vdpasim_get_vendor_id,
+	.get_status             = vdpasim_get_status,
+	.set_status             = vdpasim_set_status,
+	.get_config             = vdpasim_get_config,
+	.set_config             = vdpasim_set_config,
+	.get_generation         = vdpasim_get_generation,
+	.set_map                = vdpasim_set_map,
+	.free                   = vdpasim_free,
+};
+
 static int __init vdpasim_dev_init(void)
 {
 	vdpasim_dev = vdpasim_create();
-- 
2.20.1

