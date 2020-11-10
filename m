Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F157B2ADF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgKJTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbgKJTb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:27 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8812C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so4341782wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSjLdlLWJSq+5kS7GDyIv4rvxAPSqu/8nkKg/bHUTUY=;
        b=wZeGjKIorbPA0c0PrlnhLlnJk1itC4n0nTzOcbguHLU7XW0VZKuUzrj6ysHsa+HgNf
         w80Z4ZeECtO1M3dSL3w3Km0+DR8inGbS+ShcfNMffu1CCsTlpt6i1jnIPaOWiagzdSsF
         KB/Qkz60IzImuWaMW9jQO2moRwFqPcXUHZALrSO8+nwWhPW4OLj9h32zxfuCObMGF9Y9
         BSaHqq6YxNO/GPXJY9vH4OokQ4Tsg4I5CXONrwyGmojixpVvyZaWI1FfECBoomawAlB3
         ERQO8NE4MsR79/f7r0YqSxeqgu1rnXeqaWlkb7gxWwisrbJppmH2hD7OItJ6C9wbbQk0
         QpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSjLdlLWJSq+5kS7GDyIv4rvxAPSqu/8nkKg/bHUTUY=;
        b=BKaUi8De9g9zjUUF6VtKfu5A1dbrOdRI7abHR6Gqndx9Up9dAYkeE9ydQ4Bysxqqq7
         U8jerSSDChcXmRjd1PMb5LusF2iZHE0QyTM0OC1cZNjDfT58TjPz72t07oss8i29J1cN
         jANTd+ypldUPy4IB7mtfg3D3BFs5UXGltWwxzSpBs0aSJmTHfHa0OO7IFWiHn6R5AGkA
         IMCRtlkzeQKuyVskm/zN6zLQ8d0BHdOEPVS5Ep1Gvt+3UKD+bsaD/+Ao2U6xT5/piY/V
         DiIISz4ZQsuu0dPROeU66d41MkQfCJH+BqJudeXUIBvpLC0WwVHMkGuKqIuI43Oxm1o2
         nBrg==
X-Gm-Message-State: AOAM533ygbQVqH7JdXhLoJckzJICYv9KGYPj0iRE7kLHfCHNH81+t+ys
        Xy5NItB3caWJqbrnyy9d9RrNWA==
X-Google-Smtp-Source: ABdhPJy8WfbcOgUKu6Mr5z7B464nWgTV0uVrAjvMbugVW8Im4qbasXQpfUC+3jFMjGemwfCn1sfFyw==
X-Received: by 2002:a1c:448:: with SMTP id 69mr736733wme.12.1605036686390;
        Tue, 10 Nov 2020 11:31:26 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/30] drm/radeon/ci_dpm: Remove set but unused variable 'dpm_event_src'
Date:   Tue, 10 Nov 2020 19:30:50 +0000
Message-Id: <20201110193112.988999-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And the piece of code that has never been executed.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/ci_dpm.c: In function ‘ci_set_dpm_event_sources’:
 drivers/gpu/drm/radeon/ci_dpm.c:1369:28: warning: variable ‘dpm_event_src’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 886e9959496fe..8324aca5fd006 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -1366,7 +1366,6 @@ static void ci_set_dpm_event_sources(struct radeon_device *rdev, u32 sources)
 {
 	struct ci_power_info *pi = ci_get_pi(rdev);
 	bool want_thermal_protection;
-	enum radeon_dpm_event_src dpm_event_src;
 	u32 tmp;
 
 	switch (sources) {
@@ -1376,28 +1375,17 @@ static void ci_set_dpm_event_sources(struct radeon_device *rdev, u32 sources)
 		break;
 	case (1 << RADEON_DPM_AUTO_THROTTLE_SRC_THERMAL):
 		want_thermal_protection = true;
-		dpm_event_src = RADEON_DPM_EVENT_SRC_DIGITAL;
 		break;
 	case (1 << RADEON_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
 		want_thermal_protection = true;
-		dpm_event_src = RADEON_DPM_EVENT_SRC_EXTERNAL;
 		break;
 	case ((1 << RADEON_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
 	      (1 << RADEON_DPM_AUTO_THROTTLE_SRC_THERMAL)):
 		want_thermal_protection = true;
-		dpm_event_src = RADEON_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
 		break;
 	}
 
 	if (want_thermal_protection) {
-#if 0
-		/* XXX: need to figure out how to handle this properly */
-		tmp = RREG32_SMC(CG_THERMAL_CTRL);
-		tmp &= DPM_EVENT_SRC_MASK;
-		tmp |= DPM_EVENT_SRC(dpm_event_src);
-		WREG32_SMC(CG_THERMAL_CTRL, tmp);
-#endif
-
 		tmp = RREG32_SMC(GENERAL_PWRMGT);
 		if (pi->thermal_protection)
 			tmp &= ~THERMAL_PROTECTION_DIS;
-- 
2.25.1

