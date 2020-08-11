Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE72420DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHKUGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 16:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbgHKUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597176372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ0tQJUX6FYq8jWBOE7tgCHGh7Nd6zB0Zj920pPZUIo=;
        b=YW9HwqpMDxE0NYJrMFgmm7EIh1OMwxWe/37qfrqASQn9sCByHYx8P+DQcKVduBmGnnabtS
        aCTi2JnR7aIfXhdrSwa08tCuXC7O6r2ezt1e+Y0DgXi2cKuQJ4AQfAuXsbd9NBTXH6w86j
        +7IR5l6uKXxcigUfTEvCKqRk5LSYwOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-o1-FHvEGP3yxigYm9VQVyQ-1; Tue, 11 Aug 2020 16:06:10 -0400
X-MC-Unique: o1-FHvEGP3yxigYm9VQVyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF64E1DE8;
        Tue, 11 Aug 2020 20:06:08 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6995D9DD;
        Tue, 11 Aug 2020 20:06:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 07/20] drm/nouveau/kms/nv50-: Use drm_dp_dpcd_(readb|writeb)() in nv50_sor_disable()
Date:   Tue, 11 Aug 2020 16:04:44 -0400
Message-Id: <20200811200457.134743-8-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-1-lyude@redhat.com>
References: <20200811200457.134743-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use drm_dp_dpcd_(readb|writeb)() so we get automatic DPCD logging

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 71c65f0a68a27..e06e8537f21e1 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1631,19 +1631,22 @@ nv50_sor_disable(struct drm_encoder *encoder,
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
+	struct nouveau_connector *nv_connector =
+		nv50_outp_get_old_connector(nv_encoder, state);
 
 	nv_encoder->crtc = NULL;
 
 	if (nv_crtc) {
-		struct nvkm_i2c_aux *aux = nv_encoder->aux;
+		struct drm_dp_aux *aux = &nv_connector->aux;
 		u8 pwr;
 
-		if (aux) {
-			int ret = nvkm_rdaux(aux, DP_SET_POWER, &pwr, 1);
+		if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
+			int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
+
 			if (ret == 0) {
 				pwr &= ~DP_SET_POWER_MASK;
 				pwr |=  DP_SET_POWER_D3;
-				nvkm_wraux(aux, DP_SET_POWER, &pwr, 1);
+				drm_dp_dpcd_writeb(aux, DP_SET_POWER, pwr);
 			}
 		}
 
-- 
2.26.2

