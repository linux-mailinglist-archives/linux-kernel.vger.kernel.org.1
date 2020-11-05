Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D32A8197
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgKEOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbgKEOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B43C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:19 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so1864928wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PcLLONpboZvUTN2aQG6zfp2ux20ADiydIBkQhnQ1U2o=;
        b=TPoS4HuPdYH3c9MkIFPPhTWS3RWJ96JxCEE54GBANaYyXJMNJ57387nPrvwHRDaSNm
         nHeUY9/F6E6+1ajLkqOBdOwSz5wlN0DSW7bnb1kM0wXtle/sPy0+QyzhHL2HmYDskP0v
         5a4eQrJJ0W/tyvnCITfTXUTSFkYNhAXh+AqVcy9u1VbHeLO0Fq9Bzo0EvGqSkLe1zH+B
         Hsy14wy/MXLN+cEeGwCc0fsMQzhwOZlaUnyojp+zFzAx1gfvzRv+/sU1YkCrjUbRFHGj
         nqjP0GLiBveDIZrB3bqZAv6TFLiFeKVtaym1w8d+0ijahi4yfUnW+DsvZlU60sUcORea
         pq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcLLONpboZvUTN2aQG6zfp2ux20ADiydIBkQhnQ1U2o=;
        b=QDChboNIAlak11BzrOxAOkthJrfTyPWEz6ITuNOb8xQgrlL1vQOmhbyUgzJnM5Xh/o
         K0LqTEVo8U7LzO8wWbBSr/rWPrMGNJKJhhcaAcGZoVuoqJ8mI3GGY6pSKAS6lMzCeeFY
         dcFatKFjppBa5AxN+EKjHT4a3q0aEY37o2HCnmUB42eCE/xiek/cjYd2IqMYwKQBHs9u
         BXz2KLBevtsz2T1q+8VumECGOlEgpZIvXo7LuZjqxc0nk184z/lC8qsEjxvjs1avtXyA
         zIEoCKu44llSrBpVHmGEtumPF5vAHOG0faRph6KqOIdl8W1VLmBXN7o4JEjTizGIpkAJ
         x0aw==
X-Gm-Message-State: AOAM532jaELOjl7R+Ar7fRRcp1QRp6a1iPGVDjroEqeojufJIj4VUP1a
        imXDYjOdnJ+X+ocv+FrjJoqF2A==
X-Google-Smtp-Source: ABdhPJx1nScLQJ8+/5pp9aKW+CIR313HsjM2GzYFhafeQ2i1VZRBFeJhdHevY5Gcwa6RoHinYaOFfg==
X-Received: by 2002:a1c:a7ce:: with SMTP id q197mr3190860wme.138.1604587938324;
        Thu, 05 Nov 2020 06:52:18 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/19] gpu: drm: imx: ipuv3-plane: Mark 'crtc_state' as __always_unused
Date:   Thu,  5 Nov 2020 14:45:01 +0000
Message-Id: <20201105144517.1826692-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
as a container for state->crtcs[i].new_state, but is not utilised in
this use-case.  We cannot simply delete the variable, so here we tell
the compiler that we're intentionally discarding the read value.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/imx/ipuv3-plane.c: In function ‘ipu_planes_assign_pre’:
 drivers/gpu/drm/imx/ipuv3-plane.c:746:42: warning: variable ‘crtc_state’ set but not used [-Wunused-but-set-variable]

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/imx/ipuv3-plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
index 8a4235d9d9f1e..acc0a3ce4992f 100644
--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -743,7 +743,7 @@ bool ipu_plane_atomic_update_pending(struct drm_plane *plane)
 int ipu_planes_assign_pre(struct drm_device *dev,
 			  struct drm_atomic_state *state)
 {
-	struct drm_crtc_state *old_crtc_state, *crtc_state;
+	struct drm_crtc_state *old_crtc_state, __always_unused *crtc_state;
 	struct drm_plane_state *plane_state;
 	struct ipu_plane_state *ipu_state;
 	struct ipu_plane *ipu_plane;
-- 
2.25.1

