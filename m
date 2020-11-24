Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6142C3113
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgKXTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgKXTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEECC08C5F2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i2so4502969wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsDkEPnukv2Vdk6eKkCyxgdzq1nylzzKySTODP9qfuE=;
        b=BAzGYM8m8GiMon4ZVqoLqEtdGvasSHBbWulfMGj2/kmgVvLHY2Rhl2KZKgRIERzWE1
         BdXkFVPeLYvZIifdk7PlzvY5sIWsjqU3Lm5Dt70+S0azALV57w7AEZP9vK/R9OQ2Av+0
         6Z3mXbbY2COkJyj1Ps15qLjrSbwM+mX0ffmHMS6/TP4dztACdQQ6w9Vf3HY2UTkokz8E
         +3xH5bu9VkDBLkv3j5W+t0GnC1F+Hb6aYldFKAIklSW/ThL9zmDhagmo5sme/1HEG5km
         E7hqzRbM+uqPILwHWsmZokfHxkKygB+MxUNebCXFX6V9q3d7vFdPNppSGnG+UPjZSwDh
         Hsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsDkEPnukv2Vdk6eKkCyxgdzq1nylzzKySTODP9qfuE=;
        b=IEK3TmbC4+KzyeKtM4wmHb3k/vbQVq7CbR9bFvS1bN/B0RXjzIqivtodppfiDURJ2n
         8aGqmuc2dc8v/S8BFH5QWugMd9nyLZLo/95tyUtlbEWkZwG93nMlVtCSak8QTrDdyh6I
         s1x8d6+IpgEv8ej4k1oYiePdxGxoOmqwJQVUjXya3zJA9w5EUq0F8qOGYo0m+uJyB3cJ
         UtnC7adU8Ei+9iyVL/basVE2D635on+/fqKD8VMI+3efHiixzOCV+yAGxXuZ5dYiSpmU
         wGvSzF2TN8M0302mSiBCxmSbUcHNPMreRS3cp9I4kWkYD2HMg/xOeaecX8N2XmCZlWvn
         +sRw==
X-Gm-Message-State: AOAM532tUrYbGXszkEpjV3d6xh5BTOLHOLiicFf6cSByK+HlKkbE71cD
        692uge3ieYUy6UYH6RqqNxwO8Q==
X-Google-Smtp-Source: ABdhPJz4IuEFWuDWKGOSXiMZv/BwXoAcxqMZeznOdIOMoH7V7z/8W5uykNyAXKnvZNXwFGbkJ9TW4Q==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr127799wrn.56.1606247082781;
        Tue, 24 Nov 2020 11:44:42 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 35/40] drm/amd/pm/swsmu/smu11/vangogh_ppt: Make local function 'vangogh_set_default_dpm_tables()' static
Date:   Tue, 24 Nov 2020 19:38:19 +0000
Message-Id: <20201124193824.1118741-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: At top level:
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:764:5: warning: no previous prototype for ‘vangogh_set_default_dpm_tables’ [-Wmissing-prototypes]
 764 | int vangogh_set_default_dpm_tables(struct smu_context *smu)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 9a2f72f21ed86..05c32be3a7496 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -400,16 +400,13 @@ static int vangogh_get_current_activity_percent(struct smu_context *smu,
 					       enum amd_pp_sensors sensor,
 					       uint32_t *value)
 {
-	int ret = 0;
-
 	if (!value)
 		return -EINVAL;
 
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = vangogh_get_smu_metrics_data(smu,
-						  METRICS_AVERAGE_GFXACTIVITY,
-						  value);
+		vangogh_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXACTIVITY,
+					     value);
 		break;
 	default:
 		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
@@ -761,7 +758,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 	return ret;
 }
 
-int vangogh_set_default_dpm_tables(struct smu_context *smu)
+static int vangogh_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-- 
2.25.1

