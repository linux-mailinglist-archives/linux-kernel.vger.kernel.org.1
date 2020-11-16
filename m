Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB122B4E52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgKPRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbgKPRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:45 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF75C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so19627475wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yKXccTq4RQml8AaT9zp7DsIehEAA7Cw2xDOtV48iYo=;
        b=Z4HwkZNcwa5jwVBqtO868Oti/4mRDTj3PsEnbA681wpGYPCwsRjObQJnxRfXliZQaY
         vc7oFU5DAWujWdiXZ0C6rumJoAbS3YkpNzFM1QXAfG42OAZqPv85T0Plwmja14RlZ3al
         xD0uxE2BO4c4ocCIddXqvFeUFEcqfAkMSoSUf9IqsUs3p/ajB0iKERvvf49d380U2qHa
         tFdccMpqSYgrd8IKH4FrZ/Jd/wAXTwCB9inNdXVt0wCoLJ3/PhKfnuaVsvmjieBGmzPI
         TQbg8r+l+jHh1OuelXM+aj9qw11AKj3oFJjDyxwz3Jr0DsJNbd5w3Ru0OHUWBQ/dMGtF
         rcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3yKXccTq4RQml8AaT9zp7DsIehEAA7Cw2xDOtV48iYo=;
        b=WIQGFhJnJ75wGHadkQmQNPrAiI92xM4f5D0rz4ssbo4cvfiAEROeveCuparzyyTPhW
         To+SjlR/l7wfUgSwkunAib/FO1IWdy02uSskQpm/ywaSateCW2TSgOTXnTO90u0fsLQ4
         cNn6YUNwrsO3EahHjsVFE4O/uGLOkQbURKHAGQaA8ahEHwYfeEDummVRMERIHnvve0TX
         NcUB9mLQJ29NqVLCOnoHDfb6Q2SFneizy77nBlCjUzoEQjIN0M8km1EDlh8GCZqVdC3J
         sCMhBQcdHwA/k0jHbIMtGzN0x1qzqT83o7AUiKX0PyOr0TPrmwIV6FAQ5HpydRKYS7Lb
         hhbg==
X-Gm-Message-State: AOAM532pL+UWEEJX1tZE5EgqXuLgq5ikXof01OYXaFsOcmFAz7KImhYh
        a/9l/aQczQ0PibKvvtTUDr/fjA==
X-Google-Smtp-Source: ABdhPJwINg/ac/HzXNmMAXKy2lkQiCTdKUFax/vtf42+MajVaIC/uOHsaxPcQHd5B36XPKPbQ/fE2Q==
X-Received: by 2002:adf:a3d1:: with SMTP id m17mr19678094wrb.289.1605548502077;
        Mon, 16 Nov 2020 09:41:42 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <abhinavk@codeaurora.org>
Subject: [PATCH 16/42] drm/msm/disp/mdp5/mdp5_crtc: Make local function 'mdp5_crtc_setup_pipeline()' static
Date:   Mon, 16 Nov 2020 17:40:46 +0000
Message-Id: <20201116174112.1833368-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
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

