Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB4247FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHRHsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:48:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33098 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgHRHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597736918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=yo4kEY+qRk9I44ALuDXlR4fywd4izKlmhlTyX/YouR0=;
        b=UgwepVE/MlkygrLtWlGnfZh3L2UOlSOrt5epNTgRQGSgkh2tpLNTq5kF1O1oP4X2f9Uy15
        jUdclC8/CxvCve5mTLCgmrIHP61SeEjqhmpCftnjoQgNJYy5oWRuPv6Sq8v00NcAoCb/W0
        kE2+eiiOsEpGbdn5OD1TQ3UxaT6gyng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-wnVYBnzFPBOs3Ycc8Zs0ow-1; Tue, 18 Aug 2020 03:48:34 -0400
X-MC-Unique: wnVYBnzFPBOs3Ycc8Zs0ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA694185E52C;
        Tue, 18 Aug 2020 07:48:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C615261B7;
        Tue, 18 Aug 2020 07:48:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 76E519CA6; Tue, 18 Aug 2020 09:48:29 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/virtio: set max_segment
Date:   Tue, 18 Aug 2020 09:48:28 +0200
Message-Id: <20200818074828.9509-3-kraxel@redhat.com>
In-Reply-To: <20200818074828.9509-1-kraxel@redhat.com>
References: <20200818074828.9509-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing gem objects call virtio_max_dma_size() to figure the
scatter list limit.  Needed to make virtio-gpu work properly with SEV.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 1359eb8f1a02..26b608e2554e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -214,6 +214,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		goto err_free_gem;
 
 	bo->dumb = params->dumb;
+	shmem_obj->base.max_segment = virtio_max_dma_size(vgdev->vdev);
 
 	if (fence) {
 		ret = -ENOMEM;
-- 
2.18.4

