Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6892C5643
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbgKZNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbgKZNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:24 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05778C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so2460358wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4u/cyGzH+u9QQSq+abd2+vyaNq4rk53k+eLSNkiBjf0=;
        b=ALUCxbMFgNl6Y+EGHLaMLveA4sRcf9yCJbgqBxya1G860rH7lp/E4PAVEFWm3w5icv
         9G24r0Oq157EV/uUl3o8/Lxg/+i3kM1QXvSGpEkwSr2dNxQDTLMenKc0UCsAzx+wQh2C
         EksXweKKsnY37CHf/m+bXwaoBiak2cE5b4nkMfVCuHQhcPinfwjMspCz/z2wLWfXt4+3
         Gifj73DXGNlj/XJseSfcCL9KjCYva6s6+/gsp2FnrpLQ303wLU7jTLG60GVLQ/EZKVD+
         5GBSJPY4QXHLwNNk5SJYvQk1jS/Z9KPf+uA7JutzXP3S1EXjYV2Mfmcc7K3PVDo+Vipg
         iLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4u/cyGzH+u9QQSq+abd2+vyaNq4rk53k+eLSNkiBjf0=;
        b=ndiIRDkUs6vm+ZifqVB1o7uY+wAIsryDbNmjQJKOWgOFXNd5H2QpBFcgekQPg0z7FP
         8zTnK5Zok6cKTMB/c7qz2mgrlegvn3x8kagnP0gnT9tegknEp94XjBbDVaTsi1swxUUl
         dJcPaFr2nENwy0PnSJgdrvH5dNflSCYKahT4XKhgnNeiM7/x+PDeSxdWenQ2MKdi/1P+
         dEhOcfl6h3QOhJf1sIWCRuDbQ8+S+/JluFZ1GyN1u0G6gCwOft+bl/rdMWArhyqyWPJ8
         ye0pfNpdwX7Qri++1sC5BF6QE+3tsJdG8stNZ04I9ddAd91o8qNVVUTllLmtXzQERHfd
         Gq4A==
X-Gm-Message-State: AOAM532rTeqytKnpHJ3bWtavap6V9zGmOjTDYc4lWzfIglp0oKqThwZu
        zFOdhYUyoz8E6IAxMAH2Bsz0OQ==
X-Google-Smtp-Source: ABdhPJyW57/UeqmUPAfhyPljCPknm7hrzUdaluG5uYdqwUv6eoo92u8Px9GFloGreOGNcCSIHK3DTg==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr3486592wma.92.1606398202703;
        Thu, 26 Nov 2020 05:43:22 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/40] drm/amd/pm/powerplay/hwmgr/pp_psm: Remove unused variable 'result'
Date:   Thu, 26 Nov 2020 13:42:25 +0000
Message-Id: <20201126134240.3214176-26-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/pp_psm.c: In function ‘psm_init_power_state_table’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/pp_psm.c:31:6: warning: variable ‘result’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 31a32a79cfc20..328e87f6c9bcd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -28,7 +28,6 @@
 
 int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
-	int result;
 	unsigned int i;
 	unsigned int table_entries;
 	struct pp_power_state *state;
@@ -73,7 +72,7 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	state = hwmgr->ps;
 
 	for (i = 0; i < table_entries; i++) {
-		result = hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, state);
+		hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, state);
 
 		if (state->classification.flags & PP_StateClassificationFlag_Boot) {
 			hwmgr->boot_ps = state;
-- 
2.25.1

