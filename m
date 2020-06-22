Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D8202F83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgFVFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 01:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgFVFck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:32:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BFCC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 22:32:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so7101440plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 22:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOs8/vOcSTNojAnkjIJLl6Zwh7pEFROh/lHqucoCGw4=;
        b=dPCYMgxwutm6jIq2Wj18eM2TXJW8xWvR97Y37deovDDlPXTd+KGT1+Ju9/iINFjIht
         NCUTlZdh+IITFYHEEyBkDxE4y2z67kqprIsFDboISSXR+1vtlhazfUh8hCWCDTSOUdaT
         StTuEMbg+XmgJ+ClOhdbG3/p4rJCeIwGLQDdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOs8/vOcSTNojAnkjIJLl6Zwh7pEFROh/lHqucoCGw4=;
        b=SHMx9RROI7kV/XefciQFytr0wmg+Dh06gHmpHSOP71CdtZpWvRax0vBIi4O5R5780u
         42PCgFbch8zKDycaAJsAK0vnhz3m1dFn/93sIPwMYUrcpiKcecuB/1hqZjNkRq/7gkcd
         YWI51klpkt/nz9I3+widQmxmHYqEAc35CxBWuHoIw0SOzguum2XIZecBagiqgNX+t7+I
         SSy/6OmJswfPCUG4h7OLnXNnkL9/McdETBVn+CyOyxgEVGnbLAmAVhiCmUxKxGEkPJ0c
         /8/2vDozdTXXPvJQQ0BD9Fziiim/Aj6Aaprac6klnhRG7wVzeBYdgXTck3klu2IMXPBf
         PcXA==
X-Gm-Message-State: AOAM531mWrJSo+s53z0oI+uloqim+jJNf1CUHFg918BkJ1lvvrThzFx3
        0DVg/NsywszwPh7kyhM105f8pg==
X-Google-Smtp-Source: ABdhPJyZmlvjgo1vg45lGnOaXcMAlL6/gigFUFN6X5r+Q50PTwVNyET7M9/6fIkpx0Z3VHooFu3v5w==
X-Received: by 2002:a17:90a:1a17:: with SMTP id 23mr16362040pjk.231.1592803959593;
        Sun, 21 Jun 2020 22:32:39 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id b1sm12240078pjc.33.2020.06.21.22.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 22:32:39 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yongqiang.niu@mediatek.com, tfiga@chromium.org
Subject: [PATCH] drm/mediatek: check plane visibility in atomic_update
Date:   Mon, 22 Jun 2020 13:32:34 +0800
Message-Id: <20200622053234.122120-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
would proceed with invalid plane and we may see vblank timeout.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index c2bd683a87c8..74dc71c7f3b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -164,6 +164,16 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
 						   true, true);
 }
 
+static void mtk_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+	struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
+
+	state->pending.enable = false;
+	wmb(); /* Make sure the above parameter is set before update */
+	state->pending.dirty = true;
+}
+
 static void mtk_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_plane_state *old_state)
 {
@@ -178,6 +188,9 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	if (!crtc || WARN_ON(!fb))
 		return;
 
+	if (!plane->state->visible)
+		return mtk_plane_atomic_disable(plane, old_state);
+
 	gem = fb->obj[0];
 	mtk_gem = to_mtk_gem_obj(gem);
 	addr = mtk_gem->dma_addr;
@@ -200,16 +213,6 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	state->pending.dirty = true;
 }
 
-static void mtk_plane_atomic_disable(struct drm_plane *plane,
-				     struct drm_plane_state *old_state)
-{
-	struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
-
-	state->pending.enable = false;
-	wmb(); /* Make sure the above parameter is set before update */
-	state->pending.dirty = true;
-}
-
 static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 	.prepare_fb = drm_gem_fb_prepare_fb,
 	.atomic_check = mtk_plane_atomic_check,
-- 
2.27.0.111.gc72c7da667-goog

