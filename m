Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3C2C564A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390706AbgKZNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390631AbgKZNnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:37 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F00C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:36 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so2466394wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHyKENW6Yz4oTye/FJPzNNjmGfv58ayjrIYPkA+7OU0=;
        b=ueetS8dxpG4eO8faloDa33OmDRYWKDXfGJ/MOesO0sVWIxlbnNg1acnUmuk2/IwmSf
         ynWcfu3xKgFrRhph301W/t3OPcXaCv0WmUd0j5/ucJuRUAOZbxw9vKgw9JQWG+J73gYN
         dzlwXWkZpqM7LOU60AzvhK5fYOoKjn8aBJ0By8qseo1RiV+Pn+RcSG8nAHQBVYeJAlE0
         R6/K5j0Q03t+8e/0vdaMYHRUH2q4nfbUwpSJU9mS9SfRbIikwWIlUa3yc5tvBbjUPxqz
         V0323xh/2ZuoVA0U8/JRnXY/0a0M097+5zsUWW5yfK/gEEyacVeFwDldJ8Hay3MhqIUT
         ytSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHyKENW6Yz4oTye/FJPzNNjmGfv58ayjrIYPkA+7OU0=;
        b=YSKTtxIF4uxQyyQ0CDsj08u/+WfFbfl3FJiYgQUijAantB2x6gIE8Twkv5nli7fN/p
         +KvPSG+WYKdab5G8fJzt/z1SugFKJREw6FCMFOof/Bqu5KupqF5UP2OT/Zgxpd4k9Zx2
         dYBSHxb3QzfniI6JdSAyWXCQ9nHNDtRidhTEDRakvVSC65NJJ6Zb2kUfW4WZVNcyyJNR
         HWTsUIkmoL+aaUyiNwwXtz7HDhRHCy4OJdB0biCuDo5/KoSNAaRgfpfkM55exaX0BOfI
         oT0UUv9/taKmYWvr/kEutJA5ZNsZR+mV8+dgah1w5V4TVji/oV61z926OIVY0c6YGsZC
         WEkg==
X-Gm-Message-State: AOAM531OOv3zjwyXFjoQv+qAf0I1egp3DkCE2Xh79qxg6fNEkXYjtlZF
        kILHI71/57JXDy1oUp3+lbw52RlejSClDhU1
X-Google-Smtp-Source: ABdhPJyQXsU5/AEeoFFjY7XHZxkueaCPYvuChFDxVYSEAIRAWOqSivqDUyYaPfLnYEj+pww8vgdxcg==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr3499582wmf.139.1606398215596;
        Thu, 26 Nov 2020 05:43:35 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:34 -0800 (PST)
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
Subject: [PATCH 34/40] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Use 'gnu_printf' format notation
Date:   Thu, 26 Nov 2020 13:42:34 +0000
Message-Id: <20201126134240.3214176-35-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: In function ‘dm_dtn_log_append_v’:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:345:2: warning: function ‘dm_dtn_log_append_v’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:375:3: warning: function ‘dm_dtn_log_append_v’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b7d7ec3ba00d7..24a81642baa26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -318,6 +318,7 @@ void dm_dtn_log_begin(struct dc_context *ctx,
 	dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
 }
 
+__printf(3, 4)
 void dm_dtn_log_append_v(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx,
 	const char *msg, ...)
-- 
2.25.1

