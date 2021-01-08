Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41D2EF8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbhAHUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbhAHURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820CC0612B0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y17so10129638wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AW/x7qxQXiLCGUIcY4DJLhUKMXcrKT9KQcLhFyNk1w=;
        b=DtMvMixhiP2jW+geu9bD4kDHGmsl5fl9Ja2iKoo/LWSz7Wl951aSjbLSw7RaBTX442
         5F1atJsNaPHQOiYyQ5JoAbxAGynP+OLyjIBw/6HjYyZ18ZGwtucTOW04jU/NV80E5MZC
         +Md0dnOHAWBBWc8NefwjYCKd1nN5gcIgzNwFcAf0yKfQMO2DFkx0n7Lu2dVB+nkuyXMB
         1jK7/AZdcvFiBBMlUUAYoQyJ29i2/apa8PfE2CdkSUDxkV9hBzOzr+rCJ1TQbuasdFnf
         NDDwcxDGe/vPoVSHlox8EURoSw2ntqNRkPsfJVL8IGlGr9+QzLY4xZtjqiMm4bFAN+4m
         p+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AW/x7qxQXiLCGUIcY4DJLhUKMXcrKT9KQcLhFyNk1w=;
        b=bKQ75Wdg6fkTGedYxtw94wCCfRkIvuNOp5vc1/5RMblRzE53Qwlb4Xq0pae9etmzGX
         0XqrJSap5sE1qVHbR8qkf2m4d9Vdes4D8H8r67XuKGk2w9JEYaE4qb3AMpSSv+Q2Hqoy
         vDOBW/nKPDzBVoAhAzV9aoVoCncknlO9j8EDo64pa8cLDqLKHwjZpiXqrJXnNJJDgsfk
         +n1AaoE7+HrLGnksfZrHRkt0fWX/EG8d7Sb+DeVdK7Gk+iqWv/FvHM+H7dPrIy4pYT1b
         /BOapb2J87lqyjUHVoyEBLGa9M7EUVMRS/E6DYCs9i04rymXy7vPCCnmtD9VTCsnrkUR
         1NMA==
X-Gm-Message-State: AOAM532EUieACtc8mSQR9FUMgU5eVJQllHNlyGt7DvJ7/5H9i/qLdsRw
        NmDtHUJ0ZHeZ3YY06KWdh2ZzFRILqPMql14w
X-Google-Smtp-Source: ABdhPJxDPOEakgyITuUIEzaN+h3M2b6ZCVSP76EyI/xJynT2Ubn3eNhdgesxy9B34/UU7F3I43bFVg==
X-Received: by 2002:a5d:6106:: with SMTP id v6mr5129705wrt.173.1610136932414;
        Fri, 08 Jan 2021 12:15:32 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amd/display/dc/bios/command_table: Remove unused variable
Date:   Fri,  8 Jan 2021 20:14:36 +0000
Message-Id: <20210108201457.3078600-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the surrounding code was removed just in case even a small
fraction of it was functional.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In function ‘adjust_display_pll_v2’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1459:35: warning: variable ‘params’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qinglang Miao <miaoqinglang@huawei.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 070459e3e4070..dd893a1176979 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1456,20 +1456,14 @@ static enum bp_result adjust_display_pll_v2(
 	struct bp_adjust_pixel_clock_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	ADJUST_DISPLAY_PLL_PS_ALLOCATION params = { 0 };
 
 	/* We need to convert from KHz units into 10KHz units and then convert
 	 * output pixel clock back 10KHz-->KHz */
 	uint32_t pixel_clock_10KHz_in = bp_params->pixel_clock / 10;
 
-	params.usPixelClock = cpu_to_le16((uint16_t)(pixel_clock_10KHz_in));
-	params.ucTransmitterID =
-			bp->cmd_helper->encoder_id_to_atom(
-					dal_graphics_object_id_get_encoder_id(
-							bp_params->encoder_object_id));
-	params.ucEncodeMode =
-			(uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
-					bp_params->signal_type, false);
+	bp->cmd_helper->encoder_id_to_atom(
+		dal_graphics_object_id_get_encoder_id(bp_params->encoder_object_id));
+	bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, false);
 	return result;
 }
 
-- 
2.25.1

