Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48D2FAE78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392987AbhASBwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392765AbhASBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611021024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xm4VaWlgX93IkYu6cOVbQUmUWgu6MaGKFDLqY8C57ic=;
        b=JPw4PQgGjUsrHG9epnotg3BQseUTsmcDJL1cIy9iBGnDNXQLG6ZzXmlL3q8JQYxGfnFpxq
        kO77wIjc2R+1/uLOeE+CwRaKU6p89krbLOJOJcJxW2BFT0b6KtxX61rUstH1ZUCILq2Ncq
        AbNfaRdfmJ77I2meWi2HLIEX/ByN2RE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-0MMP7VLpMmScxflnKCD5TA-1; Mon, 18 Jan 2021 20:50:23 -0500
X-MC-Unique: 0MMP7VLpMmScxflnKCD5TA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F112C18C8C00;
        Tue, 19 Jan 2021 01:50:21 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-113-206.rdu2.redhat.com [10.10.113.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E1831F471;
        Tue, 19 Jan 2021 01:50:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/nouveau/kms/nv50-: Check vbl count after CRC context flip
Date:   Mon, 18 Jan 2021 20:48:46 -0500
Message-Id: <20210119014849.2509965-3-lyude@redhat.com>
In-Reply-To: <20210119014849.2509965-1-lyude@redhat.com>
References: <20210119014849.2509965-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I haven't seen us take too long in nv50_crc_ctx_flip_work() outside of
users with kernel logging on a serial port, it probably would be a good idea to
check how long we take just in case we need to go faster in the future.

Cc: Martin Peres <martin.peres@free.fr>
Cc: Jeremy Cline <jcline@redhat.com>
Cc: Simon Ser <contact@emersion.fr>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/crc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
index 3c50b29a37ff..ef942248345c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
@@ -86,6 +86,8 @@ static void nv50_crc_ctx_flip_work(struct kthread_work *base)
 	struct drm_crtc *crtc = &head->base.base;
 	struct drm_device *dev = crtc->dev;
 	struct nv50_disp *disp = nv50_disp(dev);
+	const uint64_t start_vbl = drm_crtc_vblank_count(crtc);
+	uint64_t end_vbl;
 	u8 new_idx = crc->ctx_idx ^ 1;
 
 	/*
@@ -94,9 +96,7 @@ static void nv50_crc_ctx_flip_work(struct kthread_work *base)
 	 */
 	if (!mutex_trylock(&disp->mutex)) {
 		drm_dbg_kms(dev, "Lock contended, delaying CRC ctx flip for %s\n", crtc->name);
-		drm_vblank_work_schedule(work,
-					 drm_crtc_vblank_count(crtc) + 1,
-					 true);
+		drm_vblank_work_schedule(work, start_vbl + 1, true);
 		return;
 	}
 
@@ -107,6 +107,12 @@ static void nv50_crc_ctx_flip_work(struct kthread_work *base)
 	nv50_crc_program_ctx(head, &crc->ctx[new_idx]);
 	mutex_unlock(&disp->mutex);
 
+	end_vbl = drm_crtc_vblank_count(crtc);
+	if (unlikely(end_vbl != start_vbl))
+		NV_ERROR(nouveau_drm(dev),
+			 "Failed to flip CRC context on %s on time (%llu > %llu)\n",
+			 crtc->name, end_vbl, start_vbl);
+
 	spin_lock_irq(&crc->lock);
 	crc->ctx_changed = true;
 	spin_unlock_irq(&crc->lock);
-- 
2.29.2

