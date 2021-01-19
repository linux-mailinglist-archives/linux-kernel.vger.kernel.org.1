Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8202FAE83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404673AbhASB4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387976AbhASB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611021274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmmNLQII/VTGD+Hl4KTh1b+UNemQGtBowv/k6ZSjHEQ=;
        b=SdYsOiCYpy6py23IhWEoec8cI4X0yyE6NPpn8FmBYNDeTKehYfZ3aXpivQQFXR6GCDYBoq
        BjB85tszmXt/KuPNgijGkBL3/9PbmizJRJ4RJExPGvQkDc967X46QYrhamZkTV0KQvvLHN
        E+JgbpDKy6UMs7GxNY468ADdwjw7zwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-hHipVC6QNWa0t7Qu1QnW7A-1; Mon, 18 Jan 2021 20:54:33 -0500
X-MC-Unique: hHipVC6QNWa0t7Qu1QnW7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54372180A095;
        Tue, 19 Jan 2021 01:54:31 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-113-206.rdu2.redhat.com [10.10.113.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E47475D9CD;
        Tue, 19 Jan 2021 01:54:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to userspace
Date:   Mon, 18 Jan 2021 20:54:13 -0500
Message-Id: <20210119015415.2511028-2-lyude@redhat.com>
In-Reply-To: <20210119015415.2511028-1-lyude@redhat.com>
References: <20210119015415.2511028-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Martin Peres <martin.peres@free.fr>
Cc: Jeremy Cline <jcline@redhat.com>
Cc: Simon Ser <contact@emersion.fr>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index c6367035970e..5f4f09a601d4 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2663,6 +2663,14 @@ nv50_display_create(struct drm_device *dev)
 	else
 		nouveau_display(dev)->format_modifiers = disp50xx_modifiers;
 
+	if (disp->disp->object.oclass >= GK104_DISP) {
+		dev->mode_config.cursor_width = 256;
+		dev->mode_config.cursor_height = 256;
+	} else {
+		dev->mode_config.cursor_width = 64;
+		dev->mode_config.cursor_height = 64;
+	}
+
 	/* create crtc objects to represent the hw heads */
 	if (disp->disp->object.oclass >= GV100_DISP)
 		crtcs = nvif_rd32(&device->object, 0x610060) & 0xff;
-- 
2.29.2

