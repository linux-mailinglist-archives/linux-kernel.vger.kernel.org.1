Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907832EF8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbhAHUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbhAHUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:52 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F547C061249
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n16so7358975wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIhMmTlrgLqGKZHl8cf8zzphKFqEw09UTmu2NuirXK8=;
        b=i15bgqSq9ykGyz3gETyCT7w+EtHlx00MftV3j03IlIh377fbzIy+8wNbC6kfg0Txi6
         MVyYPJhXGEOWYgkShWn/U2+kiLs9a1CXSRknF3aZeUg6F2AJI7WFtapb4NoNF59k3+IY
         pHJ3u7G9Ytbq7xjqL80iGO2CxSF6zikmkWHaZhwnsMdPwp+4hHUj8dJe84C3u9XjsSqI
         zVBLkvbRa/EBuAsT4KBWrk/fL2Fupd7vj9HgeeoC0KYkR+hZQWvmq1hDw/U9JY6IS6pG
         IbRGIRUn+cTUiwoT/c9lNtoqm7qDm9V2gkvsUS5Qy4CfKVfoH/z+X0pKBz4xwGHzOUXo
         +kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIhMmTlrgLqGKZHl8cf8zzphKFqEw09UTmu2NuirXK8=;
        b=jl/393oZV5oBiIuM2pMXns3hGVnqvC2OUkqrGyMRMP4cLu/LC+FDM6DjeIzHlZBiFA
         gX1cqVMzQUQnILCHtptJgCTKVGJYZzyJHFqzUKAwmCzUA11x0F4/5QD5fQwaHaaaPUOQ
         vxu5+pgCn9RG/a9fkcgECTL6obEt7Hfvf0Y9nd8m0Kd02Ua1yK+ncxt6xP+/i3y0Rvqo
         ZaxNQEK3v1ZHrwzz+kjo3L03PLrJORZgBHeFmFYiwBihJgAnN7ku4Bccv44o6Ke4zLzM
         I5DIibhB/b6QtqGPtWm8tZQw5SR8XgKaY9trPHoXnpjTxTXIVthAg31mrz2AB4gUBckO
         293Q==
X-Gm-Message-State: AOAM531fE5XbshvaUXC7imT+JOAu9TzvM3GBSFSDXyOiYiA3chobWMKF
        V+gLtitVgU44KIPjKK1m8izU0Q==
X-Google-Smtp-Source: ABdhPJxmWksPcclm4wz0bxTyjDV49a125dTEZ+hkFdDIjT796ez7ZjUCcvThJZrXg4TXponqtUxAIg==
X-Received: by 2002:a1c:61c3:: with SMTP id v186mr4496283wmb.146.1610136954798;
        Fri, 08 Jan 2021 12:15:54 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:54 -0800 (PST)
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
Subject: [PATCH 35/40] drm/amd/display/dc/bios/command_table: Remove unused variable and associated comment
Date:   Fri,  8 Jan 2021 20:14:52 +0000
Message-Id: <20210108201457.3078600-36-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In function ‘adjust_display_pll_v2’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1462:11: warning: unused variable ‘pixel_clock_10KHz_in’ [-Wunused-variable]

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
 drivers/gpu/drm/amd/display/dc/bios/command_table.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index dd893a1176979..66fe1d1810789 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1457,10 +1457,6 @@ static enum bp_result adjust_display_pll_v2(
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 
-	/* We need to convert from KHz units into 10KHz units and then convert
-	 * output pixel clock back 10KHz-->KHz */
-	uint32_t pixel_clock_10KHz_in = bp_params->pixel_clock / 10;
-
 	bp->cmd_helper->encoder_id_to_atom(
 		dal_graphics_object_id_get_encoder_id(bp_params->encoder_object_id));
 	bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, false);
-- 
2.25.1

