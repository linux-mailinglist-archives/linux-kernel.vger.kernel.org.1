Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D372A8180
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgKEOwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbgKEOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312DFC0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so1873589wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Xt9NPmWITpKLKGlbBp65KNc5QWwZDBhANixt0RAfzs=;
        b=CUpGQdFe0Fpy8mF0smnsFvAhA8XeNwRgzON8Ouemw6fHxmx52YrEcZAMwdSABsRq/7
         Lxy+ostf7rA/tdZRM7TSq0bo2YvzW5haVIiyQUoFDcaYBJtIcuzThdWaW98Rt/uf8hvR
         Yessl9lyLwVOyxg+4AEZljm+9pyh+9RuR49gHLGu4bQ+JI1lJesriHB1MV4d2kRG1j3P
         TIlRa/EgbhDezoFvNOXhtPQsF5zeJmrssB5jRQCoZyr63oGYwhQMu6w5h3uRW6a3fAba
         HW1hSPLM89nmRzJCEJlwbC+/dBHrd4TqiaEeCIChBj7BD98hF67RBzDmT4LCIdbTjJ7e
         r4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Xt9NPmWITpKLKGlbBp65KNc5QWwZDBhANixt0RAfzs=;
        b=NW7Nq3W80sowcPUGhWt55C7jGAIqD0/FUiftIkKms7mu8QY2DbVyixFefDbez8hfcm
         GtBJsReG6EUq/TollVabd5W2kvpam08y19Sh3DkNTVOpAkxDyiRYzHWEGs1xnfYhurZD
         CLycOdXuIfTjylvxuukG4NhnzumT37jjRWus4kdivAGLwpAJ/kePtcijcOR6KUPeNKdj
         w3nUCnItC1Fz7OIxCuDXhicdFHpBRtfZGiQSPoLh9uBjN34a39ctkNx6KTsvQl1LYDGL
         RnJ9SfJ86GE6qGzq3djn5iCHvcZO4cmavct/rOu13aJsQ0DVzHZHoSS8ZtjVMEy2pu2F
         TfhA==
X-Gm-Message-State: AOAM5333wX8zt4Qlr2Rr+EpQwsNASfnHw/NBHSBYEIAsNSJSGZEqMWN3
        YNmINje1dRQcK717Oqh1Pylo9u8NYRWYBKvv
X-Google-Smtp-Source: ABdhPJx4o/ngA4xvA0+rv6p3i9fdDVG+or+aahOHyJb8+xTTqmrY/O+FOfhIhBwkLVbCJU8toTdOCQ==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr3018917wmo.97.1604587944829;
        Thu, 05 Nov 2020 06:52:24 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/19] gpu: drm: omapdrm: dss: dsi: Rework and remove a few unused variables
Date:   Thu,  5 Nov 2020 14:45:06 +0000
Message-Id: <20201105144517.1826692-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘_dsi_print_reset_status’:
 drivers/gpu/drm/omapdrm/dss/dsi.c:1131:6: warning: variable ‘l’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘dsi_update’:
 drivers/gpu/drm/omapdrm/dss/dsi.c:3943:10: warning: variable ‘dh’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/omapdrm/dss/dsi.c:3943:6: warning: variable ‘dw’ set but not used [-Wunused-but-set-variable]

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index eeccf40bae416..5929b320b3cfa 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -1128,13 +1128,12 @@ static void dsi_runtime_put(struct dsi_data *dsi)
 
 static void _dsi_print_reset_status(struct dsi_data *dsi)
 {
-	u32 l;
 	int b0, b1, b2;
 
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
-	l = dsi_read_reg(dsi, DSI_DSIPHY_CFG5);
+	dsi_read_reg(dsi, DSI_DSIPHY_CFG5);
 
 	if (dsi->data->quirks & DSI_QUIRK_REVERSE_TXCLKESC) {
 		b0 = 28;
@@ -3940,7 +3939,6 @@ static int dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data)
 {
 	struct dsi_data *dsi = to_dsi_data(dssdev);
-	u16 dw, dh;
 
 	dsi_perf_mark_setup(dsi);
 
@@ -3949,11 +3947,8 @@ static int dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->framedone_callback = callback;
 	dsi->framedone_data = data;
 
-	dw = dsi->vm.hactive;
-	dh = dsi->vm.vactive;
-
 #ifdef DSI_PERF_MEASURE
-	dsi->update_bytes = dw * dh *
+	dsi->update_bytes = dsi->vm.hactive * dsi->vm.vactive *
 		dsi_get_pixel_size(dsi->pix_fmt) / 8;
 #endif
 	dsi_update_screen_dispc(dsi);
-- 
2.25.1

