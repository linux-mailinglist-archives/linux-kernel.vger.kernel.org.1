Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3A303166
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbhAZBmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbhAZBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611624961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKm0Ja8X4Ojgn+JREDsvj+rdNkNRQb5M2c2kSDsJ3+k=;
        b=Z5czwtJ05uSl69BbcYXcOGmBn/OyWgAoMRyDS8jvzMG0PjD2HGG3Un7l1ggghBXGqVPYiH
        o0Pi2YzdnOmNsDnjVAYQkvSMzh5Uf0kBQ0s1Ljvlw/n0RXPmo4QE2f2mnSgJ8CfkVkIE1a
        CddfglBOP13VVAYibgmKlDzUtWchSUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-wNEaR2FzN823zaodbI2_Gw-1; Mon, 25 Jan 2021 19:10:41 -0500
X-MC-Unique: wNEaR2FzN823zaodbI2_Gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD50D180A096;
        Tue, 26 Jan 2021 00:10:38 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-118-245.rdu2.redhat.com [10.10.118.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9548360938;
        Tue, 26 Jan 2021 00:10:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@gmail.com>, greg.depoire@gmail.com,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 1/5] drm/nouveau/kms/nv40-/backlight: Assign prop type once
Date:   Mon, 25 Jan 2021 19:10:27 -0500
Message-Id: <20210126001031.881048-2-lyude@redhat.com>
In-Reply-To: <20210126001031.881048-1-lyude@redhat.com>
References: <20210126001031.881048-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: greg.depoire@gmail.com
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 72f35a2babcb..42b498e7e2bf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -106,7 +106,6 @@ nv40_backlight_init(struct nouveau_encoder *encoder,
 	if (!(nvif_rd32(device, NV40_PMC_BACKLIGHT) & NV40_PMC_BACKLIGHT_MASK))
 		return -ENODEV;
 
-	props->type = BACKLIGHT_RAW;
 	props->max_brightness = 31;
 	*ops = &nv40_bl_ops;
 	return 0;
@@ -212,7 +211,6 @@ nv50_backlight_init(struct nouveau_encoder *nv_encoder,
 	else
 		*ops = &nva3_bl_ops;
 
-	props->type = BACKLIGHT_RAW;
 	props->max_brightness = 100;
 
 	return 0;
@@ -226,7 +224,7 @@ nouveau_backlight_init(struct drm_connector *connector)
 	struct nouveau_encoder *nv_encoder = NULL;
 	struct nvif_device *device = &drm->client.device;
 	char backlight_name[BL_NAME_SIZE];
-	struct backlight_properties props = {0};
+	struct backlight_properties props = { .type = BACKLIGHT_RAW, 0 };
 	const struct backlight_ops *ops;
 	int ret;
 
-- 
2.29.2

