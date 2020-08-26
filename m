Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65692536C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHZSZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:25:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgHZSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wo54Fztl+nW8iXS4XGGsRse4eb/aZW2O/0PU/MC/eQ=;
        b=BdYgeJ1CPurQD1yY5KV3P6jjTWKLjIgoKXGim7Nip9rxMS+kJwYyGtkkPD+MPMIimI9pAV
        6ePyNynWE79NIEPBXqXZfU7uk7ILaMmoQNFFL7hZ212ljVENK9mXX8zHr5gDNon3HYaQOZ
        nV1t5X91xvW7FVkDHaHWxJWtqpR2GgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-AiJmwQihO8yU5cCvcUX-wA-1; Wed, 26 Aug 2020 14:25:17 -0400
X-MC-Unique: AiJmwQihO8yU5cCvcUX-wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98B261015DBE;
        Wed, 26 Aug 2020 18:25:15 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C225F1002382;
        Wed, 26 Aug 2020 18:25:14 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 03/20] drm/nouveau/kms/nv50-: Just use drm_dp_dpcd_read() in nouveau_dp.c
Date:   Wed, 26 Aug 2020 14:24:39 -0400
Message-Id: <20200826182456.322681-4-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this actually logs accesses, we should probably always be using
this imho…

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index c4e9c21d4dd2b..8db9216d52c69 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -42,16 +42,12 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 {
 	struct drm_device *dev = nv_encoder->base.base.dev;
 	struct nouveau_drm *drm = nouveau_drm(dev);
-	struct nvkm_i2c_aux *aux;
-	u8 dpcd[8];
+	struct drm_dp_aux *aux = &nv_connector->aux;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	int ret;
 
-	aux = nv_encoder->aux;
-	if (!aux)
-		return -ENODEV;
-
-	ret = nvkm_rdaux(aux, DP_DPCD_REV, dpcd, sizeof(dpcd));
-	if (ret)
+	ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
+	if (ret != sizeof(dpcd))
 		return ret;
 
 	nv_encoder->dp.link_bw = 27000 * dpcd[1];
-- 
2.26.2

