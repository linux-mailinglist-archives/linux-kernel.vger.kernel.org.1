Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBF2C5659
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391031AbgKZNor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390859AbgKZNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D5C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g14so2161652wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FFGLkzHxg+N+3tJLNsR8x54qcIEfrnjhf2NeR7gfvQ=;
        b=UD3E9VdWiOH8HHc3mcXJWQ6FheicN8TOMXfJTzBr2/uw6O3ZHKp7O+vhFI7xhmTbti
         PnCNSdhJn0Nnc9gsst8K+q9FHVakkCUBsYBTIZDxQI1iRVwNJhMeCqLm7QrAGKIb9fFU
         KrJZopwnbKHCGVB3l7KeG+zh3mX0fEzcPov/agJqwxK1ZEyhvsllFm7vtv/3L9X/vAhh
         U48twSGTnWelRLeaexz1rVrP6PtvVjEH77mOmVuoJTvbqHrK4EUafXvnNmMEPV6hZVoX
         360i4ts/gFwfRc6WawpK3hDLBA6+Ujppx2dH005gklhp6n8F5EIwagA+XJa/SRuGEOQB
         ZSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FFGLkzHxg+N+3tJLNsR8x54qcIEfrnjhf2NeR7gfvQ=;
        b=eQbghu4oKiE3cpxcXsoh3GaBY1pRm3byNdBn+vHfuPrpQ/bFjAjwHc/DiBs2R3NFms
         0N2BUAfhlByJpt+coMnhNQ1wlSI1UzTALFg+mZIFTPUzkNbnzSmyiVBaNW+Af+JT+rLU
         acLgrkAU9QULy3G2nL90RjGSnxtnzaDLRadFkp1uJrzN7ZUr2LS78Q5ZCzX5KhKU1A+g
         tXkT8UrXMsP8H69nVKN7dty12mgsP9W1FR3LKwjMcrZxkUVQqKUvz+VyL5M6bsIawiIU
         iXcAKegbStE7amk/RCTIWvdtFVwPXyFafk85/0o2sg84pgZ4YlY46GMlSGYVjgSzobh4
         grfA==
X-Gm-Message-State: AOAM532VfpGwK+yEq6AQ8d6z5stFXvvIkNMVZ81cABKnlzltvoeQEFDi
        74PhAfU7CCUom+mkWYKxN6TRoA==
X-Google-Smtp-Source: ABdhPJxmNzrDO6hzXvMZHpA3x/Z69w/ChXfMbFEliUMfbYWcnYJafiJAzzWp9J4ygrVBaTt+0igYsQ==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr3883469wru.369.1606398188990;
        Thu, 26 Nov 2020 05:43:08 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 16/40] drm/amd/pm/powerplay/smumgr/iceland_smumgr: Remove unused variable 'res'
Date:   Thu, 26 Nov 2020 13:42:16 +0000
Message-Id: <20201126134240.3214176-17-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c: In function ‘iceland_thermal_setup_fan_table’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c:2093:6: warning: variable ‘res’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Huang Rui <ray.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 6a0f581de999b..2da5225eafbb8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2090,7 +2090,6 @@ static int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 	uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
 	uint16_t fdo_min, slope1, slope2;
 	uint32_t reference_clock;
-	int res;
 	uint64_t tmp64;
 
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_MicrocodeFanControl))
@@ -2154,7 +2153,7 @@ static int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 
 	/* fan_table.FanControl_GL_Flag = 1; */
 
-	res = smu7_copy_bytes_to_smc(hwmgr, smu7_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
+	smu7_copy_bytes_to_smc(hwmgr, smu7_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
 
 	return 0;
 }
-- 
2.25.1

