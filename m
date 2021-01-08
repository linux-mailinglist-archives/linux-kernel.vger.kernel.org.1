Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE22EF8D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbhAHURQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbhAHURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84345C061241
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r7so10142223wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9hwKoCUKPkAVEJG7PdvhZlNWecZ9XZq8Q6EZdE3uyc=;
        b=hEJFVXCVtwgK4Ggr5Yq+CnblBWyx906VjOGVxfnc2I9GwMfjxBlYdIufR3N0PgPmBh
         XzeWu1y/95DEw+MOBpoPJmeUkjIhV59SsQ5YxzenvG+XvqtqIm9DYK5uwVwZrkNxwvaZ
         NKLeliZDCZwVeb+sL1YknAuu5Yl58Xur2WNTqAvK9qCl2Ah4T8B89/oNpVFMdiFAjujM
         4NYnKhCsW75iuMfCwW+XALsrF5a2GYVf8fileLh0IXeaofih5iiHhDxa4h9uis5rYEc1
         yloX+0Z9EgB6LqnVve8JF5u9cDXP/Ol28Ax5Xno8C5kNyHSO2N0AzqVZPpSBsMxQ7sGQ
         1YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9hwKoCUKPkAVEJG7PdvhZlNWecZ9XZq8Q6EZdE3uyc=;
        b=twb7iiNO0WuHnpv1jg0gBJsWkXul600pUmWdRlx4wNFf6pkxjnm1O3+Td4fGXjTOvi
         ZE9QXdSfZxAaeCUq4xR5p1eK+bKasV7kdnxO4BD4HrugBZDX8YK3KFpjghy60mgp8kaj
         jDv95weA7ApFBk+onAgBDy/AynZCqHmhwBaehJj5YGR590anJbn0K8AB+ZZgDh+3PDMe
         1k0PeMzeK0Mj32SjsErM964ZTHHb7NQzyRkTL900fbqiNuZgb2A44gin8YrsCvov/eC3
         9PwR1N6p6efRN0W6urvpGFdFnEnNPbLONXDRv6V/ClIjQhD5OrKvr8ootJ41LF7hH2xW
         oMyA==
X-Gm-Message-State: AOAM532gtberlPV0jZwYrMxrptMNEqJH4IZtvYCWC4f3XIwy40kTMYN+
        ClCKtdlBduerwDAnjrVJxBaypw==
X-Google-Smtp-Source: ABdhPJzWWkh1l8v/XVzgOhfkoK44n4cUyCHmhMl1lDPjo2mxR+9aIqk4vVLNoAYoABBXMiS+99NELA==
X-Received: by 2002:adf:dec7:: with SMTP id i7mr5279212wrn.373.1610136938211;
        Fri, 08 Jan 2021 12:15:38 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 23/40] drm/amd/display/dc/dce/dce_audio: Make function invoked by reference static
Date:   Fri,  8 Jan 2021 20:14:40 +0000
Message-Id: <20210108201457.3078600-24-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.c:871:6: warning: no previous prototype for ‘dce60_aud_wall_dto_setup’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: Charlene Liu <Charlene.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 2a2a0fdb92539..7866cf2a668fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -868,7 +868,7 @@ void dce_aud_wall_dto_setup(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-void dce60_aud_wall_dto_setup(
+static void dce60_aud_wall_dto_setup(
 	struct audio *audio,
 	enum signal_type signal,
 	const struct audio_crtc_info *crtc_info,
-- 
2.25.1

