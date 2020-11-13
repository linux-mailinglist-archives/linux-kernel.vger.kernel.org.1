Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD722B1C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKMNvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgKMNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:23 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F5C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:23 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so8547307wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6lq2kh1bZp3yhcGfeiEHDwnp2cd/bsKGg4wlUbbQco=;
        b=liXP1wPmh8wR4oCpiWLxjCT2ucLqXmhJW9hBhLmCuS2Dw+DxXfaS3Nhq+rOb69vSw+
         wua+tblw52CIqa1EEgbkMfUTv51OsuRqFGxnMUXf/FVRJ69Fj1YlCvRUwqIrCAeY8SyV
         jGDkpGrlt2UsQKML1I6Ztdj0/Y9sZxdmmU4WiYIcOWDf6w8QYcKvAe3ryVMgC5LhnkXS
         iImRStUf1I50U6tw56MEwasDaAirLNzUTDRUImy927MNB6VA4og5IOp6C8B2QNO6W1df
         H5FEfc9/OqdcuKLM4Q6qAg4JRSq9mPJgH/Utrlt7d48G7wN+snqKZX1pVytc3fzlrp2a
         XFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6lq2kh1bZp3yhcGfeiEHDwnp2cd/bsKGg4wlUbbQco=;
        b=WXi7mMFlVQvszuWIXhJ7Gz/mbTOZf1L/Dnwl5u9qDT1nRkyE//vAnpIdd5svxmeDpr
         dns+RibUMibOf8acNcivU8NEJzjvNXlAbJzkwkl1LicEuv4Wg/gdXOX9Zg+Ew9+G7z/8
         EQsDtVCbO5Gc9PrcgFZ2N3FW3RkQJd6B8zoyfxDITX4JFxS/3bDGfOMmx+W5OhrMlUAi
         7c3mXTCUrQQ0mI+uMS/vM8245Q7MB5CVnn5FJPgAh7G9kyx0IdygB+5bBTAUkdMZEG02
         QwqhMUlLFKhtuUyec4baJpdXLmImIC6EO5Fm5YF3y/lQtZvAk8vgd9fZiN7JKP4XN4ur
         29Sw==
X-Gm-Message-State: AOAM533rpDtNvwPqnydq5xwTdNeQAO6jrU/lgz8ijFv+75x5KCXC7obB
        emXm+Tgyi+8gPdw3sb+Gym1O/A==
X-Google-Smtp-Source: ABdhPJwPa1pit579Xq6kQ/E4Sbx3I4WTKhrO1w9SYQ9TNstqb4RqB6CPSGlqJPfhNK+IoC4qO99TVg==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr2663287wmc.186.1605275421972;
        Fri, 13 Nov 2020 05:50:21 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 32/40] drm/msm/disp/mdp5/mdp5_crtc: Make local function 'mdp5_crtc_setup_pipeline()' static
Date:   Fri, 13 Nov 2020 13:49:30 +0000
Message-Id: <20201113134938.4004947-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c:581:5: warning: no previous prototype for ‘mdp5_crtc_setup_pipeline’ [-Wmissing-prototypes]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 79dd56faf3de0..0c8f9f88301fa 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -578,9 +578,9 @@ static void mdp5_crtc_atomic_enable(struct drm_crtc *crtc,
 	mdp5_crtc->enabled = true;
 }
 
-int mdp5_crtc_setup_pipeline(struct drm_crtc *crtc,
-			     struct drm_crtc_state *new_crtc_state,
-			     bool need_right_mixer)
+static int mdp5_crtc_setup_pipeline(struct drm_crtc *crtc,
+				    struct drm_crtc_state *new_crtc_state,
+				    bool need_right_mixer)
 {
 	struct mdp5_crtc_state *mdp5_cstate =
 			to_mdp5_crtc_state(new_crtc_state);
-- 
2.25.1

