Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63961E48CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbgE0P4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 11:56:01 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57075 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730620AbgE0Puy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F21DE5820CD;
        Wed, 27 May 2020 11:50:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=IxL7aM4/cF0Eq
        P+78A1SAtbW8PYoMF3heOq6qhP5SA0=; b=Jyt+CZeKZ4VnXxPavwkER2FRucBtS
        8qClaKNzX0NqwNi1he1lRO1gUCgLv5DfJxfehEo7e9bLV2Gpvq9TG3Yfjlw/RuDA
        Xhfd5TcX1nAYyw8cdhUQUZCIyBfgUJ+39GhlkgEDQi+DSRWkbp4WCQQWU5el3l5o
        ++pTDxZNXNVIOB36MT3WhOuFjBuZHmaChIqBFRstoOzvSfNf8vSLH4H8SvaY3eD6
        Kd3mx7LFqUn5u9IhbSO4uKJVjcNKgn1xi1yR0VsAAZxwBeWnnefn/oDPYeel2tiH
        d5HvhXXuFwtHv88jKBWw0p0dwK0sh19BvX1G8iNq/AMcDf8KaldDrcMbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=IxL7aM4/cF0EqP+78A1SAtbW8PYoMF3heOq6qhP5SA0=; b=E3yqKKg+
        G7y00T9pCmq8/AyCY9xWAPAAd0Dfmi8TSynbCuMAeFbfrvkUm3OjbbUpA4We/EVz
        zHKrWsbyTkw9XjRiPPY4nI9+9m9mhtopLqmvrmW2KB29XxHi2MLUPO2bw/o02gmg
        0gDwFj7e9TV02NjuMzS2IW3ubYsKCXVS9ydV4cUkM6ja0lhWlYLSnYAJxgkCdDly
        eXlQaATyiPRf3fnphL/NWdtbpRNd3K1/8fdFG5Ubhc7L19oQegRYsF4cASJp8Qpd
        yNR5BDw8fyyVY5McDp5+PO7yK3D+5qcyFN7bde2kwrFRPDMHKfNLWn8ABb7IxXHe
        zuL0ZntINGFMag==
X-ME-Sender: <xms:XIzOXo8j2tr2e5rezCqTgMpC8_GL5U7ytuQydgAj6mbU6dslZc5Rig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XIzOXgu6nTwH7PJDXdPUVUzjbCBllBvlq7eq9VDIzED8JNVsDpJm0Q>
    <xmx:XIzOXuBw0ocyDb2szbE9B3ytAkIG7_DwNYA6Amu7Albhy3rfYev1wg>
    <xmx:XIzOXoe7Znn46joZqlxYtyww0-ptse7AW1IvSfPAFQk_fHoY23_h8A>
    <xmx:XIzOXgfd5f4_85QcN2AnrXonphH_k0dGIAqLU00kwAPCl_87n8z_bQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 945653280067;
        Wed, 27 May 2020 11:50:52 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 060/105] drm/vc4: crtc: Make state functions public
Date:   Wed, 27 May 2020 17:48:30 +0200
Message-Id: <8d86964fb69d9d2d681dd3cab914bedd4e24b728.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need the CRTC state related functions to be exported so that we can
reuse them for the TXP.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 21 ++++++++++-----------
 drivers/gpu/drm/vc4/vc4_drv.h  | 10 ++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index a577ed8f929f..4df8cc5387a0 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -201,7 +201,7 @@ static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 	return ret;
 }
 
-static void vc4_crtc_destroy(struct drm_crtc *crtc)
+void vc4_crtc_destroy(struct drm_crtc *crtc)
 {
 	drm_crtc_cleanup(crtc);
 }
@@ -803,11 +803,11 @@ static int vc4_async_page_flip(struct drm_crtc *crtc,
 	return 0;
 }
 
-static int vc4_page_flip(struct drm_crtc *crtc,
-			 struct drm_framebuffer *fb,
-			 struct drm_pending_vblank_event *event,
-			 uint32_t flags,
-			 struct drm_modeset_acquire_ctx *ctx)
+int vc4_page_flip(struct drm_crtc *crtc,
+		  struct drm_framebuffer *fb,
+		  struct drm_pending_vblank_event *event,
+		  uint32_t flags,
+		  struct drm_modeset_acquire_ctx *ctx)
 {
 	if (flags & DRM_MODE_PAGE_FLIP_ASYNC)
 		return vc4_async_page_flip(crtc, fb, event, flags);
@@ -815,7 +815,7 @@ static int vc4_page_flip(struct drm_crtc *crtc,
 		return drm_atomic_helper_page_flip(crtc, fb, event, flags, ctx);
 }
 
-static struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc)
+struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct vc4_crtc_state *vc4_state, *old_vc4_state;
 
@@ -832,8 +832,8 @@ static struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc)
 	return &vc4_state->base;
 }
 
-static void vc4_crtc_destroy_state(struct drm_crtc *crtc,
-				   struct drm_crtc_state *state)
+void vc4_crtc_destroy_state(struct drm_crtc *crtc,
+			    struct drm_crtc_state *state)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(crtc->dev);
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(state);
@@ -850,8 +850,7 @@ static void vc4_crtc_destroy_state(struct drm_crtc *crtc,
 	drm_atomic_helper_crtc_destroy_state(crtc, state);
 }
 
-static void
-vc4_crtc_reset(struct drm_crtc *crtc)
+void vc4_crtc_reset(struct drm_crtc *crtc)
 {
 	if (crtc->state)
 		vc4_crtc_destroy_state(crtc, crtc->state);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 32e9de15262a..da4d2391a4ba 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -798,6 +798,16 @@ void vc4_bo_remove_from_purgeable_pool(struct vc4_bo *bo);
 /* vc4_crtc.c */
 extern struct platform_driver vc4_crtc_driver;
 int vc4_crtc_disable_at_boot(struct drm_crtc *crtc);
+void vc4_crtc_destroy(struct drm_crtc *crtc);
+int vc4_page_flip(struct drm_crtc *crtc,
+		  struct drm_framebuffer *fb,
+		  struct drm_pending_vblank_event *event,
+		  uint32_t flags,
+		  struct drm_modeset_acquire_ctx *ctx);
+struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc);
+void vc4_crtc_destroy_state(struct drm_crtc *crtc,
+			    struct drm_crtc_state *state);
+void vc4_crtc_reset(struct drm_crtc *crtc);
 void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
 void vc4_crtc_txp_armed(struct drm_crtc_state *state);
 void vc4_crtc_get_margins(struct drm_crtc_state *state,
-- 
git-series 0.9.1
