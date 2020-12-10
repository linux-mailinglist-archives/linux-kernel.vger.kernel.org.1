Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633C22D504B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 02:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgLJBYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 20:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732182AbgLJBXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 20:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607563323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojN+XeCoiEoB/J+D0kmgirDZ9CDdv4WvqFp0tmu7rNM=;
        b=V8uhFvN5RAT4DY1eDINOhhQuVAaMzI6p9zauCxclqlATi7Aam3qayi4qC+MxmCZPjie9Ow
        JWztktGZKsA1L6vsQ0ZnXqEQqiPWpCAGJ1grTizc5cJivpAy2P85I72qu7NZqhXoZR2SmU
        nObLsKQegsfWVXn/f0AKVcHJy47W9j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-oNmuq1iXMHy-GGuBp3x0KQ-1; Wed, 09 Dec 2020 20:22:02 -0500
X-MC-Unique: oNmuq1iXMHy-GGuBp3x0KQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C62612A2;
        Thu, 10 Dec 2020 01:21:59 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-246.rdu2.redhat.com [10.10.113.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A7510023B6;
        Thu, 10 Dec 2020 01:21:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@gmail.com>, greg.depoire@gmail.com,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 1/5] drm/nouveau/kms/nv40-/backlight: Assign prop type once
Date:   Wed,  9 Dec 2020 20:21:39 -0500
Message-Id: <20201210012143.729402-2-lyude@redhat.com>
In-Reply-To: <20201210012143.729402-1-lyude@redhat.com>
References: <20201210012143.729402-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index c7a94c94dbf3..4acc5be5e9aa 100644
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
2.28.0

