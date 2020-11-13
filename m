Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553D2B1C79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgKMNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgKMNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:35 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3697CC061A49
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so10001213wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9ZMy9yV2j61eWz6SjAdF0UqQLfaNl51XLKZiRseNxA=;
        b=XgoN5UROCU74VPm0D6Gls7Y1ukWa5LQzEWehKotsuQV5kktrJh+HttfN1sHyw4l5/g
         07v8zOyhGYA21GAy3RlWbSHEisIPtE2LF/+VLLhtjSmvQb9dsNSMY8L2xN66Zlf1K7d8
         6RF4WZoD0y0TB3RoLJURUnsMHyS2azk2aYXQZxPAquIrGnFIviJ3lIttEqdiQpCFFgRM
         lWoNVox2yrau1SurBJYU+y2EscCGmhnVbuO15ymULXP0EtxutOTj1R90QiCX96UWYX1g
         32HpSCBEM3I6h15HD6MxmSj/7jJP+vEtL6UHjfQKpbWwHuzPJrvM59B9DjLlElzF+Wim
         CX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9ZMy9yV2j61eWz6SjAdF0UqQLfaNl51XLKZiRseNxA=;
        b=GInrPo1Yhc+D9JYS3Zx8l+t4vHHy3HyP5LTA4/q7htV8mlMNz1JL/LeDXWcTWgICx0
         rj69Xf9pqmlgm4LdKbY6VRgpgvr2wbmvXkcCgk4eQzfU9wNNhW23yB/1hpCnEV8iDxzu
         Ubyy3BL7Hp39sIH33Sjh1Brb7MRIl8sK/e0zZUV2CmF6JGCP/4hJJLyHx7Bo0FQAWP1l
         1vl7+uCFTNzVw/psZhl9FIOitwZrRKk4fSEIG0LyQ1LiyTp1J2uXC8rJVCalhVREQaTl
         8pC43hxkT7GdPlZRO3JPPQjEd/xquPcdsdPRkSFY0+3AYdi5YJ/wjpD47KRFfYpqpQ9N
         pQdQ==
X-Gm-Message-State: AOAM531qc1/z+Xm3q1T/A4wCzoi5See0IvarSs9CO7X2XgmtQ/dzluWh
        OJ/b3gYrXmraUFwS2ITVczeVvQ==
X-Google-Smtp-Source: ABdhPJyt3UaqN0DY3PXZIq/9W20F0CsxHUADWPQiQ1mTODJ4G8vQQUO48TILVZYfO5zUlhQ++MrN6Q==
X-Received: by 2002:adf:e945:: with SMTP id m5mr3445312wrn.98.1605275414993;
        Fri, 13 Nov 2020 05:50:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amd/amdgpu/amdgpu_ras: Remove unused function 'amdgpu_ras_error_cure'
Date:   Fri, 13 Nov 2020 13:49:25 +0000
Message-Id: <20201113134938.4004947-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:908:5: warning: no previous prototype for ‘amdgpu_ras_error_cure’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b96267068a72d..f89a991999428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -905,13 +905,6 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_ras_error_cure(struct amdgpu_device *adev,
-		struct ras_cure_if *info)
-{
-	/* psp fw has no cure interface for now. */
-	return 0;
-}
-
 /* get the total error counts on all IPs */
 unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		bool is_ce)
-- 
2.25.1

