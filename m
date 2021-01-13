Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833842F4603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbhAMIKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbhAMIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA38C061389
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e25so723010wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gN1pD37GpSZ83lBrPZbFyIukV/8d6W9Y5EyS4/7EyT0=;
        b=inmJeTRl4AVmWMtUkVPGB6U6xWuEnOy3Wwm4sKiHJLQr/ccYwrp4sJFIK+50RReh0+
         hgSuriGNX6dbro0Ugw1yfhjeQI8Jc1zjDXvqu990sAW99mZRA4BfxoGZM5aJaSKiab5y
         LM9dCZizOE5P9N47EzRuqmR/jFzb1jcrdKk/Ys7WM2bgE5w2vr0hvA7v+ASZSQe/hmcT
         kiMYQYgFkZ3e33wu5V+eP3/j3W0nF8lyUJbAgcPaIoeY6Tn6F2ruDrQ7kuslLJSpkv3v
         8idhUwfBq9kNYqLsoiSKrc+ehX2mq2F+mqgESYAiCJNENlcz+7yhexTyyiDG1XRiISBj
         18yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gN1pD37GpSZ83lBrPZbFyIukV/8d6W9Y5EyS4/7EyT0=;
        b=oc9jtIdVPLPoZksnUcGBMNZOEeHhVp7jFrCiJYABss1HkTCqwTmKeBByK9cIKfDZsD
         7aJ5+DojumhswqUzJGrAY3bTyvymXnbdK4cKHcxmLeFM8gQQbIpsBIfJ2iDNfqGJXEmx
         RwqMv4/y++vWg3gG/Jlk10lRpj+a3VatQr3Y/hhv+zVwURMDapWzwyY/xQSGHIr9+gPm
         z25W/aOYRj+sSrLZ6OdRNSnoRs5AOfOpoi+ccR3RULrhhNxFgTaghPQW0j7yiK37+wI4
         bQsG1RbLAEZSRWBUMlKZrpQQ33Vsejgn/jSqClQUrX31PI6DKH023PcgxzOUvI6CX71L
         IN2A==
X-Gm-Message-State: AOAM530/25UuV7ToXiMai+nmH6qads4lpIgv7Q2kEyuCtN4qBxh1gCXn
        5/FpfWNu9RXmZpLzd2lb55MU2Q==
X-Google-Smtp-Source: ABdhPJx+93HfbyhiJTrNv1M8rdT5OtKObgEgorUSuxqO9H+3Jzzjw3dp0ay9rMwIeonHgYOAzhHW2g==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr955899wmb.62.1610525309184;
        Wed, 13 Jan 2021 00:08:29 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 27/30] drm/nouveau/dispnv50/disp: Remove unused variable 'ret' from function returning void
Date:   Wed, 13 Jan 2021 08:07:49 +0000
Message-Id: <20210113080752.1003793-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_mstm_cleanup’:
 drivers/gpu/drm/nouveau/dispnv50/disp.c:1357:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index b615204c2cba6..809a9b20a6899 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1354,12 +1354,11 @@ nv50_mstm_cleanup(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm cleanup\n", mstm->outp->base.base.name);
-	ret = drm_dp_check_act_status(&mstm->mgr);
+	drm_dp_check_act_status(&mstm->mgr);
 
-	ret = drm_dp_update_payload_part2(&mstm->mgr);
+	drm_dp_update_payload_part2(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
-- 
2.25.1

