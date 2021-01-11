Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560012F1F13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbhAKTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403985AbhAKTVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC94C061386
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r4so278919wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VihTPCTNoey/JKY1Z4Geihy/+CpWTn44EgwyKVU/So4=;
        b=zm4hqUDYRKWhOH93S0m6OzMUm2UG0kbFx1gdPzIUP19LFjdloPHHu0sy2fhop86XTG
         lMCU33kWxfEz2L2MA9+m4H0OjD6rNFqjxqyf+fTeirC+7Y3E2TazSeF3rksQrfnfUJsd
         N87z5kKXvI2t/VK2m80dg7kK4749/ktGuBUBgpxi65KVqgbhjv1q9D2USLW6HEUY56+h
         zr5Md/jQvtZvIJZlamRiRiCxmqZIVxD5XQT/gbHuAi4gvU9+NeyMewqq1vPRXEODaPDt
         yFdthHeJA9zUM2cvKd25q75bYxtpHj8wkDRxbn6o1JPPDZtZmxaiqLbGNJjvJ7SCcGcP
         r44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VihTPCTNoey/JKY1Z4Geihy/+CpWTn44EgwyKVU/So4=;
        b=KndF3wWnpqBW/WrSsX+u0Q1wp6ZoF69bwxkF8ZLJQgyJcmfyjNAs5Gge05ODfhbtHb
         FA1N53iOnt1jiyo+grjDI16yoYz0kMAUB5Fk0BX131wSkgUafVY5wM5t3gVGj65AmdER
         q+bmhkuNtCv5T5KzE2rXwdL98gSivz2xMRIfW7tsBdA9HyCPMaxX+eQ0VzAjDhjOJCFZ
         h88OVMzXr5cAkh3WliOoo3QIL3bsODKOPYg3uArSGs90Hwz03xjOG2HbYdbzkRp8h3Mm
         Lf/IxTh/7oz0g8LTaNaOYRNTeVqVyjeNeG3w9xijNmmUcYuTT0/f8v12qJyNRnleO022
         vTig==
X-Gm-Message-State: AOAM5312crjqk8mkOpFmi2vpDoWOBUJc31r9v1eexVMtSV3LlWdY8e0Q
        3vT3R10cvfbOA+11axTYUzFTug==
X-Google-Smtp-Source: ABdhPJyuY1crJf1/MyIUDIjKfK4vqay/fxwN7aDKwMYf344cjO3m1/QVr+kzefbcgvBB12e1iwilCg==
X-Received: by 2002:a1c:bd56:: with SMTP id n83mr291291wmf.72.1610392802992;
        Mon, 11 Jan 2021 11:20:02 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/40] drm/amd/display/dc/dce120/dce120_timing_generator: Remove unused function 'dce120_timing_generator_get_position'
Date:   Mon, 11 Jan 2021 19:19:11 +0000
Message-Id: <20210111191926.3688443-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:602:13: warning: ‘dce120_timing_generator_get_position’ defined but not used [-Wunused-function]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../dc/dce120/dce120_timing_generator.c       | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index d02ecb983c9cd..b57c466124e76 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -589,49 +589,6 @@ static void dce120_timing_generator_set_drr(
 	}
 }
 
-/*
- *****************************************************************************
- *  Function: dce120_timing_generator_get_position
- *
- *  @brief
- *     Returns CRTC vertical/horizontal counters
- *
- *  @param [out] position
- *****************************************************************************
- */
-static void dce120_timing_generator_get_position(struct timing_generator *tg,
-	struct crtc_position *position)
-{
-	uint32_t value;
-	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
-
-	value = dm_read_reg_soc15(
-			tg->ctx,
-			mmCRTC0_CRTC_STATUS_POSITION,
-			tg110->offsets.crtc);
-
-	position->horizontal_count = get_reg_field_value(
-			value,
-			CRTC0_CRTC_STATUS_POSITION,
-			CRTC_HORZ_COUNT);
-
-	position->vertical_count = get_reg_field_value(
-			value,
-			CRTC0_CRTC_STATUS_POSITION,
-			CRTC_VERT_COUNT);
-
-	value = dm_read_reg_soc15(
-			tg->ctx,
-			mmCRTC0_CRTC_NOM_VERT_POSITION,
-			tg110->offsets.crtc);
-
-	position->nominal_vcount = get_reg_field_value(
-			value,
-			CRTC0_CRTC_NOM_VERT_POSITION,
-			CRTC_VERT_COUNT_NOM);
-}
-
-
 static void dce120_timing_generator_get_crtc_scanoutpos(
 	struct timing_generator *tg,
 	uint32_t *v_blank_start,
-- 
2.25.1

