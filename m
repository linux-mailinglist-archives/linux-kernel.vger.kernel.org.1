Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1C2EF8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbhAHUSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbhAHUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AEFC061246
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r7so10142521wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YbZqZMpXxFWUfLfazawHX6Ul5l98eF2j1+JdfYq+I0=;
        b=LF0DUdkoHdmvzblDhce37V9TWsLDe1dZxIxHP/4mt1D85NHvxbmxWWFNmay9mC0Anm
         +fH5Rwe0O2yf+zgF/VUlOw9Tmo7+cNs1Jtkf0U8SXp1rRQcDCzePm/cF5MzshIn253wB
         D96pZSPhRi7PfxFyz/KxNaBO5MYrKdpX7nWcyOoMC30hZX/Ze71Rm/b2RJfh+nF5/303
         xZz/GpqBv9yIKyYzQUy5PeKKCvNiD4YcxZiGK4DUpi0C0RPPViCNf0nX3haG7pfr5JXh
         W9DcQGuPGcp4MDnI5hxDlQAL0z37BfAcQjLlnLkJHYIf4jEFDypcBec0Xm5SHbJeiqna
         Wypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YbZqZMpXxFWUfLfazawHX6Ul5l98eF2j1+JdfYq+I0=;
        b=B3gs3BIdNsPyABkxDnPz6cLkBUGAjX1MmlE9I7fBjI7MdQ2Mvvri5pmwpLMyLfi/26
         uuLNIivb2skWX5VNfD8wKVX3UsPObHUkfI6xF6DGDDZdZWKOs/0aNgKh9x4BvkF68ZcB
         DJnwI7JI62SGhURsP0eYqPGKEDgLPJMeluNabnUaauJ3aO85WB5fiHK3juidvDREQuPj
         B8Ei2RU7DCCeSEXwC6ShU6VA3Fjf+Ez15fw7wa878X2DEvPeUYp+40jSNnq4ivCm37sj
         EAqtWZC+nDDIc6SC++PrmsRJ0aHWzi22IQ91ZqVLqQIBUkUtcNJQzU50ugKkcIiYtS91
         3CEw==
X-Gm-Message-State: AOAM533GXPIodCs5m8HNM/ES7A7Av4FK0fUXTCO9MCyzYGbxHkgWrBm5
        oj4JUZrf/sQvOnpme+tUdiyNYA==
X-Google-Smtp-Source: ABdhPJzgC4LvXvxvGF/K8p/Oa2lLfZfpv3jMcSFJHPBHPBBQyKiZV78VAghxZYT3hqCUTh2xNKO4ew==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr5165454wre.128.1610136947898;
        Fri, 08 Jan 2021 12:15:47 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:47 -0800 (PST)
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
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/display/dc/dce/dce_dmcu: Move 'abm_gain_stepsize' to only source file it's used in
Date:   Fri,  8 Jan 2021 20:14:47 +0000
Message-Id: <20210108201457.3078600-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And only declare it if it's to be used.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning: ‘abm_gain_stepsize’ defined but not used [-Wunused-const-variable=]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index fa2b47d41ee2f..30264fc151a2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -65,6 +65,10 @@
 //Register access policy version
 #define mmMP0_SMN_C2PMSG_91				0x1609B
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+static const uint32_t abm_gain_stepsize = 0x0060;
+#endif
+
 static bool dce_dmcu_init(struct dmcu *dmcu)
 {
 	// Do nothing
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
index 93e7f34d4775e..cefb7f5bf42cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
@@ -317,6 +317,4 @@ struct dmcu *dcn21_dmcu_create(
 
 void dce_dmcu_destroy(struct dmcu **dmcu);
 
-static const uint32_t abm_gain_stepsize = 0x0060;
-
 #endif /* _DCE_ABM_H_ */
-- 
2.25.1

