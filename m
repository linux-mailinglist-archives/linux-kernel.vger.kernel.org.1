Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C402B4E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgKPRls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbgKPRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:41 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A7C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so19672664wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTwQDvBtnpWbM0srw/EUqdspNhCuLlcukla9ix/INuQ=;
        b=g4UiDscwY/1oIPlgmGmNSmsyprgvCPP0mfkN+jRO3SE5cBqae6RaGAR9IUaPSZUxof
         j13OCWwzarpHIiVkv/lCvijBftpfBu3CfwV0uAjtOACmRqUmmVRJlu1hHjjaEbDQlhau
         I3K2FUugZPw1tr7zsOT1+KjOpoBTufXi3dq7ToTrVwC/NOrUntqtEDSpKQ+AMfuu02b+
         IHC2wQjp7Zo7nwOPGEe5P34uAZNk9FrdMb1xYPUHtFbeTil2AN3lzicyIi1JXHzEphOm
         MHsyCNW6VNsOf4OCewOVHOGuHu2VVqA3RsBCJbEMA5lv0zhTazg/R/MSD/z2Av9RU94p
         3YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTwQDvBtnpWbM0srw/EUqdspNhCuLlcukla9ix/INuQ=;
        b=SSwiSVS7cWulsNg8fDQLicFxNijlF8O+NYzmzDjOyDk0vMPfN5TLCGrJBvmf4glnav
         1GpxgmRnrYsgc+O+nIracgN13FM0YBq4I9mSqk7s+cutWAfem/tphQIMIYdTGXzhYom5
         gcY9076JeecWFvo6rLSNCZE8dQ/HRKhH+ZjaZP0GOFttZIIQdoH2Kze7784KMBq59T4C
         OD5o5qkUSS3UshQ6r+OF/SNG/zX62IZlB1d8sXJUwAYCJx62kJeGWrQkz0khR2iE5jgn
         rHZDpZ+BTBVY97Rr8flevKHBu/Rh1FN8eOp+h4EebZH9xryo+4oaEPrGGeG5116wTh7c
         Ej0A==
X-Gm-Message-State: AOAM533UnmJ/rDchmiQSnOcNFrZ6Iebt0dF/lE3PtBQiCFDRo5JtMXV+
        6LZUlWFHv+l28vINZUV/qF8RUQ==
X-Google-Smtp-Source: ABdhPJyNP2NVhgTiLMxWbWxmQP47XGLeaZhP7nL1I8MHMwAmQ8wJVsvtnCWCCTWN8bCCxgCJTJY0tw==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr20442206wrv.258.1605548500288;
        Mon, 16 Nov 2020 09:41:40 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 15/42] drm/msm/adreno/a6xx_gpu: Staticise local function 'a6xx_idle'
Date:   Mon, 16 Nov 2020 17:40:45 +0000
Message-Id: <20201116174112.1833368-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c:33:6: warning: no previous prototype for ‘a6xx_idle’ [-Wmissing-prototypes]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index fcb0aabbc9852..03c2f7e0c9497 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -30,7 +30,7 @@ static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
 		A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT);
 }
 
-bool a6xx_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+static bool a6xx_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	/* wait for CP to drain ringbuffer: */
 	if (!adreno_idle(gpu, ring))
-- 
2.25.1

