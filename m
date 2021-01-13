Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6012F45E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbhAMIJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAMIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCDC0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so713740wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaJ+xpBDvvYC3lW5kV2UczyJUDW/j4U+lHIq9z+JvDw=;
        b=WsQms4zJiYtT5LVKrCDvJqTzyauR1L7ZrV/ErDeTxtpEOnQQJzux+BCYQydoZtAyo0
         EPxFeb095dvlkwDkYDE+e60fyWPr+ZnRC2hcA18fuSphilINabII+6TeyMwbwOaOiKfw
         OC/UxR/UuA7wsll84KPXCHnkzQP08OFr9F63whp9Rp5wAJsdytx4qsc8Ni8DmlLarXxR
         D5uVCKUaa0MHoo3TVb+28cdBVCnJcJi4RNixwFuvmuKR2hu8JuDCAp8E2MNZJfjLlv5t
         I34lrVKBpNGDaX9HZFr9LoLI+yLNoiMmSbPAIWwe6PAQRCnK7OFFkIvT37B5tFz8CsXl
         axIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaJ+xpBDvvYC3lW5kV2UczyJUDW/j4U+lHIq9z+JvDw=;
        b=s6qDuqD8Z802x3Ow3eaw6BdLB7+EYnn0/WXp+FHkfJFpzyQM0yNyKHT4fZYQOh3AvB
         rPAYpV23GG8SlGE5DiUG+o887Kqvjrt33Nqaisol0RlsaCitDXFe3B3R8tdJGBhMryqa
         dXyotygnbBZ93eE24d1u/MvSBufJOsky4guqmK8g+rNyjCxxCxGlGH1b+2gxu0l5cdOB
         0gHSlhutw2oiVM3qsW6daUFNrE3Anzsph6PuTZhFVwm2t1BrXaZrsWgRenKHINYLL2fE
         O9eHnqMKJyRkLpYXmIqNe1UbBM3DLT4ge3XETUUsfi6PQlU9i9pT8r4599guNVAaaCQb
         4zAA==
X-Gm-Message-State: AOAM533B+aZY78AanSv0aoyZIy5QLP6SXrQGmhPZtZ38yYo3pFPpiJWQ
        SvVA/iOhbPDcHNaUZCbdrsDwEA==
X-Google-Smtp-Source: ABdhPJzYql5/UWMI/LumOt2JvYksf/Z9CIRastCwWreEyNI3i2UayobU2A3/YhQZL+8jW8Jyw8t5mw==
X-Received: by 2002:a7b:cc87:: with SMTP id p7mr991968wma.112.1610525281314;
        Wed, 13 Jan 2021 00:08:01 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 04/30] drm/amd/display/modules/power/power_helpers: Staticify local functions
Date:   Wed, 13 Jan 2021 08:07:26 +0000
Message-Id: <20210113080752.1003793-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:281:6: warning: no previous prototype for ‘fill_iram_v_2’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:455:6: warning: no previous prototype for ‘fill_iram_v_2_2’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:601:6: warning: no previous prototype for ‘fill_iram_v_2_3’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 4fd8bce95d843..3d4c66933f518 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -278,7 +278,7 @@ static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
 	}
 }
 
-void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters params)
+static void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters params)
 {
 	unsigned int set = params.set;
 
@@ -452,7 +452,7 @@ void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters
 			params, ram_table);
 }
 
-void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params)
+static void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params)
 {
 	unsigned int set = params.set;
 
@@ -598,7 +598,7 @@ void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 			params, ram_table, true);
 }
 
-void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params, bool big_endian)
+static void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params, bool big_endian)
 {
 	unsigned int i, j;
 	unsigned int set = params.set;
-- 
2.25.1

