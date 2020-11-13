Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611252B1CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKMNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgKMNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20327C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:51 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so8576668wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTwQDvBtnpWbM0srw/EUqdspNhCuLlcukla9ix/INuQ=;
        b=qrvSVoup3n8u8pYQhoQWokhMcBFhpiN8nyF8qI0HnXLJQlB3KuihkzMOb9FuMYyNKC
         Kwj2BDP1Qxst46LBOeu4iGuvzAo6b7i+r6auLDVQmLv5NWVIfKerRhDn/m21fMAn3nmj
         zcBFB3BAmgebJUsvaamTnF/gmJIY7uP3vEWpNG94/YecvIyHFnYNK0fchgmJcb/79T+g
         FABDe/gxMs5OwehhsHSkiX0/0yrHrd23HLfP36heprsQXK4kWsw5Tzviqg0r1Q3iRi0n
         rr3FS4f6gFsuvX+xsiobwmul2yiHCGgjSYXFlt8grMLJoxtiWDWJRAMm/JXjlfWJaD9E
         2ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTwQDvBtnpWbM0srw/EUqdspNhCuLlcukla9ix/INuQ=;
        b=sp7Z67eqInIRjCfTGWHWfPUVzYuyl4b6PHBv3oAgmCVlC5yqwjixIRVnquNL5DNXmS
         XFuNt3+uj9p3QXSGoIcXnT0KSDmgc5yRl50xX/NOEUzZb6JJLtrCLNCbzK5zQA1+Fz8o
         TlNwFwdxWyKAJWlA3GDvxeQ39Z1TF8ujNuq1Mg8TJpKOrtqRUu/jBgzpp0q9T4kUIC6X
         HBOguD0pyG4ZwN3ChSCz5MkBUi1qbF0k9LFF5/r45SpqsW7PWDPSvXcWkFGlOgpADZVj
         Ix3lwhTn/CWlHIYTK80M32xfU1vpw5ZLp/7vQLfjeC+hFylzImFNoT+BnkSpA09IsWeS
         OeVw==
X-Gm-Message-State: AOAM5319nkKKON620g0G+ORKOKlHaXVz357YN1emCrhU0Bx/kaPbSbgL
        B1/hWXrwZEi9Tnwbk3dc338uyw==
X-Google-Smtp-Source: ABdhPJxYu/+Qfz9qKiqyhGPZDZs5SaWMLz8YE94+9v1Zkz2nvsz0yFKLHotBNMpb1aJZChOAMHP7JA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr2620978wmj.76.1605275389843;
        Fri, 13 Nov 2020 05:49:49 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 06/40] drm/msm/adreno/a6xx_gpu: Staticise local function 'a6xx_idle'
Date:   Fri, 13 Nov 2020 13:49:04 +0000
Message-Id: <20201113134938.4004947-7-lee.jones@linaro.org>
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

