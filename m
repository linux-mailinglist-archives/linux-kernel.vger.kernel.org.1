Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA22B4E11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbgKPRlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387760AbgKPRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:51 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1EEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so56842wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DOFB5vifJrGCOQSMWDE/st4cKx6AKkD/v2b5HFyfb8=;
        b=X+iICUpO07+6FTpBe9dc71KtGg8uVMewqxXw4D54HQsNDi4x7YTQk2GI/vSs8br2zi
         crL563AJExk5eH18GIwjCAD0tshWPsin4COHswwCL/nH8tx33M1PjxIOU3kiTc8Fvs/u
         gSRDchhQJmAEdF9gUpcdoeNucpAXAp8CNKCRwvF3+HVAfYHagK75m6m7RatkRP0atc2m
         9zQwBX4MPKuBogzEL+AppX1vdWxnkxbscsUjUd8g1/tOhIMjquQ7asSMKY52j9Lc9L2n
         TOYOoTdPw779Nlt23XfL9DpCiipWJ7T1NQval3HatqKNeblalmvAiatADjg04bp4H9PL
         Wj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DOFB5vifJrGCOQSMWDE/st4cKx6AKkD/v2b5HFyfb8=;
        b=cKiJpFBCaIEEybvqnm+R5pkd9BSh67fQz22YTa61uGhbh7hi99by1XNTogBtZoVKg2
         ddBalCheSjgTBkVVdCQwTEarOUi50KqHrhIt3VeNRCXPEUK/S2KZ4seTlx0JAQ/MSbNY
         /K801OllBTcRMj+2unKp5VKVFyTVAgV+3C/98mYS8HrsD1HAlfuwxIVqeHbzkIC+zqr+
         wDyuGS1uRhI8Tb2Mg5CJoDRXdCJM4tVN3Ts4/oNUw+QpnRJGu+pOJxBItyoXBHVzeNbP
         W+AGBdzOp8b/wMwC3v1zM/vZ3hsJ2Rw/HwZfTtrGkAKuPsoDRZkEepfh6Y7Tfq1Jxc3y
         RVsQ==
X-Gm-Message-State: AOAM533879Rb8NJJeUOQNilr8eNSooEw8sXhN56KBprLM+w+3fKxfDct
        TOhHOCPNQKFni/mWmn2qlBhvwg==
X-Google-Smtp-Source: ABdhPJzQZhOALgumhAbivo10Vy33TnY2EYrd0cLJQ2AYyUelagMOBvYfUJ3vbWdMCxrsbK35mPWjMw==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr15729wmi.156.1605548508417;
        Mon, 16 Nov 2020 09:41:48 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <abhinavk@codeaurora.org>
Subject: [PATCH 19/42] drm/msm/disp/dpu1/dpu_core_perf: Remove set but unused variable 'dpu_cstate'
Date:   Mon, 16 Nov 2020 17:40:49 +0000
Message-Id: <20201116174112.1833368-20-lee.jones@linaro.org>
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

 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c: In function ‘_dpu_core_perf_calc_crtc’:
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:113:25: warning: variable ‘dpu_cstate’ set but not used [-Wunused-but-set-variable]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kalyan Thota <kalyan_t@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 37c8270681c23..36927fc04a388 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -110,14 +110,11 @@ static void _dpu_core_perf_calc_crtc(struct dpu_kms *kms,
 		struct drm_crtc_state *state,
 		struct dpu_core_perf_params *perf)
 {
-	struct dpu_crtc_state *dpu_cstate;
-
 	if (!kms || !kms->catalog || !crtc || !state || !perf) {
 		DPU_ERROR("invalid parameters\n");
 		return;
 	}
 
-	dpu_cstate = to_dpu_crtc_state(state);
 	memset(perf, 0, sizeof(struct dpu_core_perf_params));
 
 	if (kms->perf.perf_tune.mode == DPU_PERF_MODE_MINIMUM) {
-- 
2.25.1

