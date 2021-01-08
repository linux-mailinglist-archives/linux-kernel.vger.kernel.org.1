Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6122EF8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbhAHURJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbhAHURC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740FC061258
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:16:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n16so7359142wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rP7mCQegZrZliKSNOE9HhwYeP/t/E6ng+qbUeSsHO9Y=;
        b=homuTJBMLHVxCdzu4xZUN8TgcpEBe07I94kMyeGYMSl7Qgq1qQUc6vh772KKH/7CE4
         jZX7owmzqV8sN9KKvFWA6BrOu0vo3LI9MCr8+l9YCM6aXjuZAs/zkym4Z1S77ihJxS84
         Ly21nzv+rhn4a5PZP837gJI+vKJCphVrU2OMYvLeNravR3zu74QNKK94KT4dLF+W/9dp
         +WBS/y3XlVzEsOYfoAWk69kPFPH+33qM/VxzJsen0OcLde4/9SYtQjKIrV+Ox+nUTgRG
         if8rEJarsSzEx3PAfevqPkBc+Cu5/tDIYkHh7o3JbqTg0vfC5Qqw7CvmQqG98S9qoPKU
         L50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rP7mCQegZrZliKSNOE9HhwYeP/t/E6ng+qbUeSsHO9Y=;
        b=NC+ERzu6e1aK/dMi0hXvvDnu2eeRKq4PfDfuyc+UHZQUNDXVo4ogHmGfXbjQeNr/tT
         eF3wLM+8VjwptYcDd7sG06a2V8uvRFWtI3f5xWDiOMdyDaz729sennuQyN+TajwovrP5
         sToBPv20wrVniDq8/xc7aQiVnOwX+LDyAJk7N0U4u2YZ2O8W3gkkoL8BgP5bWscYX5ke
         doKv/TTvoMcOe7fIUbvKV28LmhuL0Q1TAYgUOMRREG3dFSDJLKFt/z6HZXrEkNdY40uC
         BcJBURz035k+ocns2An9kNxIi7bGpS1RDfPiyPlrcWuaazqOPfdcIajNjC4EwLybWkLZ
         1Wcw==
X-Gm-Message-State: AOAM533Do5lFq5H3C6iwagfPnsWHkMDDuHm/Gd+IJuLriw0HkqnUBDx3
        BYiawDQyMvJY25nu7eHtXUcWqg==
X-Google-Smtp-Source: ABdhPJzStlWtL4Clq/FRpULdR+OZSgHo1I1acWGIRRA/RpNAf6ipLFu7crmMKMXh2Ch4tl65qHs7ZA==
X-Received: by 2002:a1c:bc41:: with SMTP id m62mr4606670wmf.46.1610136962529;
        Fri, 08 Jan 2021 12:16:02 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:16:01 -0800 (PST)
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
Subject: [PATCH 40/40] drm/amd/display/dc/gpio/hw_factory: Delete unused function 'dal_hw_factory_destroy'
Date:   Fri,  8 Jan 2021 20:14:57 +0000
Message-Id: <20210108201457.3078600-41-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_factory.c:123:6: warning: no previous prototype for ‘dal_hw_factory_destroy’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index da73bfb3cacd0..92c65d2fa7d71 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -119,17 +119,3 @@ bool dal_hw_factory_init(
 		return false;
 	}
 }
-
-void dal_hw_factory_destroy(
-	struct dc_context *ctx,
-	struct hw_factory **factory)
-{
-	if (!factory || !*factory) {
-		BREAK_TO_DEBUGGER();
-		return;
-	}
-
-	kfree(*factory);
-
-	*factory = NULL;
-}
-- 
2.25.1

