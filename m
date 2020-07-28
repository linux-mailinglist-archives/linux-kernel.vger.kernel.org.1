Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C94230D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgG1PQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:16:58 -0400
Received: from crapouillou.net ([89.234.176.41]:38778 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgG1PQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595949409; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5H/q18tgDo28MY8nE273GGLyuFx/gqWCWD9iMf0JujQ=;
        b=vU0Bk9vUzSHgl2tFFtaYIhbYSIV/kTIRr1bJTo2Ne3WsXSBS6g4T3DB9B584DfEExtwI5F
        XB0EpveIsi6UycCyqXAMdXvj2gjIj9+OT/LwBLv5nq//997U+SKdGMHrU5MJL9XS9qViM1
        ETvi54X38bnEI+ZuwGgzHd+tfls8xxc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] drm/ingenic: Handle errors of drm_atomic_get_plane_state
Date:   Tue, 28 Jul 2020 17:16:40 +0200
Message-Id: <20200728151641.26124-2-paul@crapouillou.net>
In-Reply-To: <20200728151641.26124-1-paul@crapouillou.net>
References: <20200728151641.26124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_atomic_get_plane_state() can return errors, so we need to handle
these.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index ada990a7f911..64eabab3ef69 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -215,10 +215,17 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 
 	if (priv->soc_info->has_osd) {
 		f1_state = drm_atomic_get_plane_state(state->state, &priv->f1);
+		if (IS_ERR(f1_state))
+			return PTR_ERR(f1_state);
+
 		f0_state = drm_atomic_get_plane_state(state->state, &priv->f0);
+		if (IS_ERR(f0_state))
+			return PTR_ERR(f0_state);
 
 		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && priv->ipu_plane) {
 			ipu_state = drm_atomic_get_plane_state(state->state, priv->ipu_plane);
+			if (IS_ERR(ipu_state))
+				return PTR_ERR(ipu_state);
 
 			/* IPU and F1 planes cannot be enabled at the same time. */
 			if (f1_state->fb && ipu_state->fb) {
-- 
2.27.0

