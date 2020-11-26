Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8972C5608
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbgKZNmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390730AbgKZNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95515C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:46 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so2455236wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuzX4IvswDkJ8SA2+BkBhvbot5/c2/3wXnFFxZJ8VHQ=;
        b=sRGeaUQGfXY/xtrrAXDFNvJrX3YKVvXloSsB437HHje8kVce4ACPjCwY2I+mqD4Ntn
         R36M0zwVsj+jWH9K0pApQNqSDZXF9SNbtgkJiBPwo3+1Dp3oZew2onO4cF/ygdNH90i8
         vLGPicCNcRFzYM5NkLCrj9rNXGTUnwxHYq+xeG56NMLOUvGZOgFBKSOL9m3DDDgQPQ3L
         zYo+cQnG6BEMvVyiquM9HL9I+WDDvXSJka74EwuqIxRA862k9s377J9nWHyMRAS2Zr+a
         cwVBb8x9aH+3e1v5ss4W8ZsDENgF0tKInWFDh3TT08apWnP+5+hfO3XmYMY/gaefgXdB
         NWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuzX4IvswDkJ8SA2+BkBhvbot5/c2/3wXnFFxZJ8VHQ=;
        b=OnC9gAMsQoI3hAMX3zufVznZsS9qa8cEqXg8QWLi+SWD0mbruQqDxUv/RlN7N7Ll6e
         YIhFcyKn1T7TVg8cnd2nZnb4QUIw3FpbF0RNtstol4Cps7te4rPwmSdfCntmuUqMENC6
         CcEre8VdpSMYzsOl8bfwAhWqw18wnbgZvd16P3aRgTGnKIWNIV0JOEzMTEewZuEHGHlc
         MoSwRKNz7T4E0lrUwHod6VDnzL7HmhJi9fesbmu/y2vltKmovj1auGC7bQHRPbGjemu7
         Ow70+PvqWQQBTjVHOvtufbToqCmZbt6k2YLp39Nm6EItmWTg2NZTDjX/74ShCHxIDUZg
         QYJg==
X-Gm-Message-State: AOAM532QQqd015uqQlFyt+VjX2zkreBIm9BZNH/baZYFG8XNIH9/BDy5
        YPHMLSvno1tlnGewaGaIqzZ0FQ==
X-Google-Smtp-Source: ABdhPJxj15M1SEPtHn27yhWOhuSIur/4laupvsT3VboOtcpMEaD4/YV5Sx+xX9ZrHTm5GaKL0vlzZg==
X-Received: by 2002:a1c:2284:: with SMTP id i126mr3459973wmi.43.1606398165341;
        Thu, 26 Nov 2020 05:42:45 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/40] drm/amd/pm/powerplay/smumgr/tonga_smumgr: Remove set but unused variable 'res'
Date:   Thu, 26 Nov 2020 13:42:01 +0000
Message-Id: <20201126134240.3214176-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/tonga_smumgr.c: In function ‘tonga_thermal_setup_fan_table’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/tonga_smumgr.c:2469:6: warning: variable ‘res’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 4bfadb49521bc..c28f3e1299701 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -2466,7 +2466,6 @@ static int tonga_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 	uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
 	uint16_t fdo_min, slope1, slope2;
 	uint32_t reference_clock;
-	int res;
 	uint64_t tmp64;
 
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
@@ -2539,11 +2538,9 @@ static int tonga_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 
 	fan_table.FanControl_GL_Flag = 1;
 
-	res = smu7_copy_bytes_to_smc(hwmgr,
-					smu_data->smu7_data.fan_table_start,
-					(uint8_t *)&fan_table,
-					(uint32_t)sizeof(fan_table),
-					SMC_RAM_END);
+	smu7_copy_bytes_to_smc(hwmgr, smu_data->smu7_data.fan_table_start,
+			       (uint8_t *)&fan_table,
+			       (uint32_t)sizeof(fan_table), SMC_RAM_END);
 
 	return 0;
 }
-- 
2.25.1

