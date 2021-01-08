Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3A2EF8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbhAHUSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbhAHUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478CC061251
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:16:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a6so8732703wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsGB1GbRM0lE0DyQTr0kdLB4zVZuV/mNjcQ+anLlZ8k=;
        b=G8ruob3uLWUoFGkXg2GA/wzh7YN3To9pFFqngX5lh6jb6ZP9fzcDMAWNtCSRMw0EJI
         ohAQAqhBbi7T7wkgQHXylQTgplUVDEbTlp08mvRxQzKt1Wv27/kJ12a0pJoYJYGYGUIH
         Vxd1p29aXq8Eo8L7IZ8M8Aa5x2upHls1cXhgf7hp67wDXkwFgiTd4GSceUNYdVJLGKEJ
         Gv+ZJB4i/GW//bkLwhkEQ87maDacEv19mt7dOsic8lCQnPaiqcDa+OwmNOYcm4iEk0AS
         Un+AiOhhi7OBWMPkB0i6OXUtl+noOlMnqhpL2mtwAuC1J2158geqv+1Lbns0tTZhK0Q8
         mVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsGB1GbRM0lE0DyQTr0kdLB4zVZuV/mNjcQ+anLlZ8k=;
        b=PixIgfGkLzGuw8BqZVHYFOjpGn7V3idKYglZE6Hiwofq7DJMkV9f9SivBvB9PcFFHs
         R/qlN/3sVrkE5QlV7Ox4PH8oYEI2nntz0WtXDrnfPXbUSZLTKq/0RO6VBXI2IDWyb+0z
         TYgrgm44aivYrSjwdaWJTuyai6ecj9LN7w3NSDRrHnUJ77Qqc5sHq7SHrxdIxh4ii3do
         PS0Uy2Jbop3bxI4fDxSW1gelbDT11HKwGe99pMIjna9DzD+FIdkyXNj8yzQAoXs9ebW4
         f0bYHUBHJdVZVvomEGXXuTBsGaBuZWhHgBADvLLuNmkocr7O15zomXuStS6mQBMfieOL
         TO1Q==
X-Gm-Message-State: AOAM532ZtoLSml9xJvhNi72E43rMJAwL5lxUxZP0L/UXSbMyan7fdmQf
        +mJnlgF482QiQub89WyRR38jRw==
X-Google-Smtp-Source: ABdhPJwwPGHcY+vfmrr91v+jp+f/K5LWjnXGsz3D0XwUCn+P1mL7BB+7RYk/8up01Y82mjEoOAJB1A==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr4492260wmg.125.1610136959036;
        Fri, 08 Jan 2021 12:15:59 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 38/40] drm/amd/display/dc/dce/dce_panel_cntl: Remove unused variables 'bl_pwm_cntl' and 'pwm_period_cntl'
Date:   Fri,  8 Jan 2021 20:14:55 +0000
Message-Id: <20210108201457.3078600-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_panel_cntl.c: In function ‘dce_get_16_bit_backlight_from_pwm’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_panel_cntl.c:54:11: warning: variable ‘bl_pwm_cntl’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_panel_cntl.c:53:11: warning: variable ‘pwm_period_cntl’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index 761fdfc1f5bd0..e923392358631 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -50,16 +50,16 @@ static unsigned int dce_get_16_bit_backlight_from_pwm(struct panel_cntl *panel_c
 {
 	uint64_t current_backlight;
 	uint32_t round_result;
-	uint32_t pwm_period_cntl, bl_period, bl_int_count;
-	uint32_t bl_pwm_cntl, bl_pwm, fractional_duty_cycle_en;
+	uint32_t bl_period, bl_int_count;
+	uint32_t bl_pwm, fractional_duty_cycle_en;
 	uint32_t bl_period_mask, bl_pwm_mask;
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 
-	pwm_period_cntl = REG_READ(BL_PWM_PERIOD_CNTL);
+	REG_READ(BL_PWM_PERIOD_CNTL);
 	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
 	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, &bl_int_count);
 
-	bl_pwm_cntl = REG_READ(BL_PWM_CNTL);
+	REG_READ(BL_PWM_CNTL);
 	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, (uint32_t *)(&bl_pwm));
 	REG_GET(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, &fractional_duty_cycle_en);
 
-- 
2.25.1

