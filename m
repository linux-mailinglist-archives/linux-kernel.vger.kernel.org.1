Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F6247F56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHRHZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:25:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26535 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgHRHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597735519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=0vv+u3cMyAAlZzp0oz83EPljxFFgUqvzBIrtYyl8jSU=;
        b=IItI9WWA/QZlE6kxDzgUjFa9zYiNtK20Pm+4gNoW+wk8RFiJwJSbhy2oTN8/Ht7E2C+dqy
        IWJaOnwQ9gu4hf7rAD8OMdQ9lwc6UeJxdYHaT0+OTBWc2f+ja2DqjDuiMPS/jceQYogH9U
        xJOexB60XKdIG3RAN/AXr0tedP2gxxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-U_VBu19XPyyANcL089bpwA-1; Tue, 18 Aug 2020 03:25:17 -0400
X-MC-Unique: U_VBu19XPyyANcL089bpwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51CAF100CF74;
        Tue, 18 Aug 2020 07:25:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 222A8BA63;
        Tue, 18 Aug 2020 07:25:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5B5819D74; Tue, 18 Aug 2020 09:25:12 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/virtio: drop virtio_gpu_output->enabled
Date:   Tue, 18 Aug 2020 09:25:11 +0200
Message-Id: <20200818072511.6745-3-kraxel@redhat.com>
In-Reply-To: <20200818072511.6745-1-kraxel@redhat.com>
References: <20200818072511.6745-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed, already tracked by drm_crtc_state->active.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 -
 drivers/gpu/drm/virtio/virtgpu_display.c | 4 ----
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 4ab1b0ba2925..fbc04272db4f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -137,7 +137,6 @@ struct virtio_gpu_output {
 	struct edid *edid;
 	int cur_x;
 	int cur_y;
-	bool enabled;
 	bool needs_modeset;
 };
 #define drm_crtc_to_virtio_gpu_output(x) \
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 6c26b41f4e0d..86a3a800d12e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -97,9 +97,6 @@ static void virtio_gpu_crtc_mode_set_nofb(struct drm_crtc *crtc)
 static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
 					  struct drm_crtc_state *old_state)
 {
-	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
-
-	output->enabled = true;
 }
 
 static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -111,7 +108,6 @@ static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	virtio_gpu_cmd_set_scanout(vgdev, output->index, 0, 0, 0, 0, 0);
 	virtio_gpu_notify(vgdev);
-	output->enabled = false;
 }
 
 static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 65757409d9ed..6a311cd93440 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -142,7 +142,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	if (WARN_ON(!output))
 		return;
 
-	if (!plane->state->fb || !output->enabled) {
+	if (!plane->state->fb || !output->crtc.state->active) {
 		DRM_DEBUG("nofb\n");
 		virtio_gpu_cmd_set_scanout(vgdev, output->index, 0,
 					   plane->state->src_w >> 16,
-- 
2.18.4

