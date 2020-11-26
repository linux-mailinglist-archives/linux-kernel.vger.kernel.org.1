Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043FF2C5634
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbgKZNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390740AbgKZNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:49 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF32C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:49 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so2447631wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9lgGUDlM7py1bAmh0K2ReeB9Skou96C92LhLu83qxQ=;
        b=DCQv/x0DIszjvscBb36cxqtG1a0DErbfJW+KXTrIqfTU1euX2kddV9clliTxjLQ4QX
         CD9TG8I+DosTGJG8D8N6ITX1PgUIu1NNdKrtsutaSvoyePqg8JbRQtVEY/dT/ovpu65t
         m6Wn/oUGmKqJn4umqIpSlSHZNCi07Aw+LXEtTQ0R/XvZGz+K80m0H6JehoZQ7H3Ucckl
         FT3aGJnooxLNS+dmiqnxCC9awsK0OogkN/9pXro1UI8E6Pn7I/o4YH9Iy3wDxEApnVcF
         5tCKExUMh1kXY3VsC5me7/hwHWsKOBNMPrbQVb25mW4mrCOcKmyvOHf9poBgNzBY0Orr
         HE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9lgGUDlM7py1bAmh0K2ReeB9Skou96C92LhLu83qxQ=;
        b=Qa/cADkpfucNBwtp0c4Tkjtvlg+CUdolrcsQY3+cOV0VeXR3i3P/Eo1RsejiwGvOVg
         fgY2mGcEiOAWOPAAelvgO1XGBoYS/t9juTk67C30uptI2pTU29xBvxLZFt3B+NWBOgG3
         Y06mY0Ib/fAzyfbJO0hpGGA9fO9LCtEZvwmvf9bhxnNnkkd+jWWAymPrrxgaMxEiDjRK
         ohvouPkxJTGR7+OSxwUczzzF8toOkOuvZs6R0g836LhvwoP6CxmPsSlUoi2hu3gq8tf2
         eVOJn5KNBP7yQ5thyuXjYPXF0yD7opzYKQRbQ4fnT3upUyJ6mpSw57eZ3RrXvgQces8v
         EDYQ==
X-Gm-Message-State: AOAM530+DoloT7LtLstYNerDWW1Q2jHM3ehrQffoUWmAetiJLJhCstCb
        SbnVXX0Nkd8s2+HxVZJ3XEKU+Q==
X-Google-Smtp-Source: ABdhPJzvwkDW0s2vxiNf5+aK/oS+gcALiJrv7eq8sae3U4oQh/q0CF/GyjEm5e+T0OwBp2um+s9Ugg==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr3526378wmj.69.1606398168126;
        Thu, 26 Nov 2020 05:42:48 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/40] drm/amd/pm/powerplay/smumgr/ci_smumgr: Remove set but unused variable 'res'
Date:   Thu, 26 Nov 2020 13:42:03 +0000
Message-Id: <20201126134240.3214176-4-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/ci_smumgr.c: In function ‘ci_thermal_setup_fan_table’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/ci_smumgr.c:2132:6: warning: variable ‘res’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 329bf4d44bbce..c1d869b4c7a42 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2129,7 +2129,6 @@ static int ci_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 	uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
 	uint16_t fdo_min, slope1, slope2;
 	uint32_t reference_clock;
-	int res;
 	uint64_t tmp64;
 
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_MicrocodeFanControl))
@@ -2191,7 +2190,7 @@ static int ci_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 
 	fan_table.TempSrc = (uint8_t)PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_MULT_THERMAL_CTRL, TEMP_SEL);
 
-	res = ci_copy_bytes_to_smc(hwmgr, ci_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
+	ci_copy_bytes_to_smc(hwmgr, ci_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
 
 	return 0;
 }
-- 
2.25.1

