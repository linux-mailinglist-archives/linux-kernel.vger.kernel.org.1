Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE29B2C5636
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390806AbgKZNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390786AbgKZNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:59 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3280EC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:58 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so3692163wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHPe3Mn8cbArsPPQt69rySCnIbjXwyEYsPDbwO3FTTg=;
        b=ZrrrsDoz87EZgy+M2aL51jy5fVNnRT9Ooj/mOazxarq50HhmO8uE9haPCFapX0NTg9
         x6bITVxxMy2ceyMIwwlvVmfWhLohKVIHaifZYvD564ABfgOPiHpkcZAbNCqT3gCiBxRH
         imzJ74y7rbX2hhwcFh9PdH9ckSdhgs9smHWe8Tx/tFs4BfKX7eww65fmFdde3p7JFBTQ
         ry69c8PoPC0zzTqFcvuG7NWha5f4adD59UdUYcyH7Yn6EZ8wG8/T5Smq0V+PfDRSZvlZ
         Z2SczZBNrlqd51wVoJ/qGri9TQGx9wCE+/ihHS3qMxVbsFChNME1JW6ADJCox2oValvD
         4kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHPe3Mn8cbArsPPQt69rySCnIbjXwyEYsPDbwO3FTTg=;
        b=jElebZdVaIJtk12Ut/zyvJ4TzXbWlUtH+JWcZYEZFY2JUR8zH0AkBS2+B3xlrZ0tDZ
         lly1TkYbU8GzHVPr4Qy8a+lpno9kceMJvKsjrgLqFQCen2VgJaf+peOZ17JOJKJ89oku
         mfHSzEqO+f8r7B1SrFEutNWXr0+UP6o/U8+hG7mjvd7asv6gejZmj394B0Mp6LWo+FJQ
         a4jeq39+odpfhTCO8Eix9Ddc567C5+KpQISuoxiIGAL9Zsq1LIfF94IbNvbmJl6eovk6
         xi6BDHcIJ6DMPnC/rotTMLlAJ+SfTGyoCEV5ryyz8xheiWwpogIUkaXi/wzB4dn99laB
         RY6w==
X-Gm-Message-State: AOAM532Q3z1ftG0E2VS3mHndi0+qCUmBrTcVwkF1fcV4TaWCp71nCB1p
        +bZuf4+jzFy8P47y+zily1qK2Q==
X-Google-Smtp-Source: ABdhPJxByRK1Q8cdllulc14iL3DZ69ssy3TPiMpLDs4KGV5DAkCdW1u+aGwsGVDu2jftEfHpDkPoDA==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr3512224wmc.130.1606398176747;
        Thu, 26 Nov 2020 05:42:56 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Remove unused 'phm_set_*()' functions
Date:   Thu, 26 Nov 2020 13:42:08 +0000
Message-Id: <20201126134240.3214176-9-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:518:5: warning: no previous prototype for ‘phm_set_min_deep_sleep_dcefclk’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:528:5: warning: no previous prototype for ‘phm_set_hard_min_dcefclk_by_freq’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:538:5: warning: no previous prototype for ‘phm_set_hard_min_fclk_by_freq’ [-Wmissing-prototypes]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 1f9b9facdf1f4..45dde3e74b578 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -514,34 +514,3 @@ int phm_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t count)
 
 	return hwmgr->hwmgr_func->set_active_display_count(hwmgr, count);
 }
-
-int phm_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t clock)
-{
-	PHM_FUNC_CHECK(hwmgr);
-
-	if (!hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk)
-		return -EINVAL;
-
-	return hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr, clock);
-}
-
-int phm_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t clock)
-{
-	PHM_FUNC_CHECK(hwmgr);
-
-	if (!hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq)
-		return -EINVAL;
-
-	return hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq(hwmgr, clock);
-}
-
-int phm_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t clock)
-{
-	PHM_FUNC_CHECK(hwmgr);
-
-	if (!hwmgr->hwmgr_func->set_hard_min_fclk_by_freq)
-		return -EINVAL;
-
-	return hwmgr->hwmgr_func->set_hard_min_fclk_by_freq(hwmgr, clock);
-}
-
-- 
2.25.1

