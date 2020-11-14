Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37B2B29A3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKNAOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgKNAOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605312883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6s1TC71DL1xDZonclhg9sXnTjrfTeH4/kmIsBa3yVE=;
        b=OiduScPcMs7vZG43Qr4Cu/qX7atwrnoSihNMKw31wtt8aPh5FrFIBeB9ICJjjWJEsDyRC5
        4mK4PC27CUuThO8oU9lQDD9LhqNiEseES5a6vl/9tCvd5Tm/i/mCvqZYVgfuDT/PqSVaIk
        ro3O+nCH3CQSeN6+GeC+xFp19tXClo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Y-1_SB6xMTuSXBECTyQMUw-1; Fri, 13 Nov 2020 19:14:42 -0500
X-MC-Unique: Y-1_SB6xMTuSXBECTyQMUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47FF1868401;
        Sat, 14 Nov 2020 00:14:39 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-115-66.rdu2.redhat.com [10.10.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04E7A60C15;
        Sat, 14 Nov 2020 00:14:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] drm/nouveau/kms/nv50-: Use atomic encoder callbacks everywhere
Date:   Fri, 13 Nov 2020 19:14:10 -0500
Message-Id: <20201114001417.155093-2-lyude@redhat.com>
In-Reply-To: <20201114001417.155093-1-lyude@redhat.com>
References: <20201114001417.155093-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that I forgot to go through and make sure that I converted all
encoder callbacks to use atomic_enable/atomic_disable(), so let's go and
actually do that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Fixes: 09838c4efe9a ("drm/nouveau/kms: Search for encoders' connectors properly")
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 29 ++++++++++++-------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index b111fe24a06b..36d6b6093d16 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -455,7 +455,7 @@ nv50_outp_get_old_connector(struct nouveau_encoder *outp,
  * DAC
  *****************************************************************************/
 static void
-nv50_dac_disable(struct drm_encoder *encoder)
+nv50_dac_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nv50_core *core = nv50_disp(encoder->dev)->core;
@@ -467,7 +467,7 @@ nv50_dac_disable(struct drm_encoder *encoder)
 }
 
 static void
-nv50_dac_enable(struct drm_encoder *encoder)
+nv50_dac_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(encoder->crtc);
@@ -525,8 +525,8 @@ nv50_dac_detect(struct drm_encoder *encoder, struct drm_connector *connector)
 static const struct drm_encoder_helper_funcs
 nv50_dac_help = {
 	.atomic_check = nv50_outp_atomic_check,
-	.enable = nv50_dac_enable,
-	.disable = nv50_dac_disable,
+	.atomic_enable = nv50_dac_enable,
+	.atomic_disable = nv50_dac_disable,
 	.detect = nv50_dac_detect
 };
 
@@ -1055,7 +1055,7 @@ nv50_dp_bpc_to_depth(unsigned int bpc)
 }
 
 static void
-nv50_msto_enable(struct drm_encoder *encoder)
+nv50_msto_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nv50_head *head = nv50_head(encoder->crtc);
 	struct nv50_head_atom *armh = nv50_head_atom(head->base.base.state);
@@ -1101,7 +1101,7 @@ nv50_msto_enable(struct drm_encoder *encoder)
 }
 
 static void
-nv50_msto_disable(struct drm_encoder *encoder)
+nv50_msto_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nv50_msto *msto = nv50_msto(encoder);
 	struct nv50_mstc *mstc = msto->mstc;
@@ -1118,8 +1118,8 @@ nv50_msto_disable(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs
 nv50_msto_help = {
-	.disable = nv50_msto_disable,
-	.enable = nv50_msto_enable,
+	.atomic_disable = nv50_msto_disable,
+	.atomic_enable = nv50_msto_enable,
 	.atomic_check = nv50_msto_atomic_check,
 };
 
@@ -1645,8 +1645,7 @@ nv50_sor_disable(struct drm_encoder *encoder,
 }
 
 static void
-nv50_sor_enable(struct drm_encoder *encoder,
-		struct drm_atomic_state *state)
+nv50_sor_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(encoder->crtc);
@@ -1873,7 +1872,7 @@ nv50_pior_atomic_check(struct drm_encoder *encoder,
 }
 
 static void
-nv50_pior_disable(struct drm_encoder *encoder)
+nv50_pior_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nv50_core *core = nv50_disp(encoder->dev)->core;
@@ -1885,7 +1884,7 @@ nv50_pior_disable(struct drm_encoder *encoder)
 }
 
 static void
-nv50_pior_enable(struct drm_encoder *encoder)
+nv50_pior_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(encoder->crtc);
@@ -1921,14 +1920,14 @@ nv50_pior_enable(struct drm_encoder *encoder)
 	}
 
 	core->func->pior->ctrl(core, nv_encoder->or, ctrl, asyh);
-	nv_encoder->crtc = encoder->crtc;
+	nv_encoder->crtc = &nv_crtc->base;
 }
 
 static const struct drm_encoder_helper_funcs
 nv50_pior_help = {
 	.atomic_check = nv50_pior_atomic_check,
-	.enable = nv50_pior_enable,
-	.disable = nv50_pior_disable,
+	.atomic_enable = nv50_pior_enable,
+	.atomic_disable = nv50_pior_disable,
 };
 
 static void
-- 
2.28.0

