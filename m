Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4111A2C0446
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgKWLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKWLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so15633762wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KXPNPH8V5VaN08+hIMdkS9m7XFBvKiwB8Jp0+uc0I8=;
        b=Et4Ua0gbI2lsF/nKyKJ08uBA0rrN7fiwXsN2E4qh5zL4954DJ9jwj/4D63PYD3kyUF
         Bae62gQYXsR+eTWN2t3mxb4EfBd5QV/d6BO1QoiX/RSF13p0cROpkYLHPBQISJMIE5Gn
         RMG70h/fOUyWLtkn+Ljl+rwvVL9a4/lsgT8qYyqQ4piHfNihOda4Ptu23rVZnAUUU+wV
         DJauoSYMAZWRDsEoVi+JpxT6I9FCIfpp9NASJs5wsJZX7YZrsATdTWAJYB6uGXW32tPP
         y/A6akMS5XoH2LVSewX+TrlpCBw0lc7BaefRs3LL112L/h1SCCoBKeoDb0e6DS/1Y7LJ
         tTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KXPNPH8V5VaN08+hIMdkS9m7XFBvKiwB8Jp0+uc0I8=;
        b=i6y6OWts7k9GMLGVQcv6cXOKXuQ0yH6r8OKLu2fWLIewsBZLnV0Et9UZtWNj5yRbvq
         Ya1WvdgWKSQHiipbZtNzYrhTq7tcUBH+T7O5eaoDFi/8+dk4FlR4rjuCd/zmJuQb/5NX
         vSQw3Ll3b3z8iCPfNNdaOJaFGT8yeRAdDLwDnegnuhI5iBRTz6LwbbThcqcwAeqCDW6A
         hrAuTYBt6kS0+v5QD8MFpc1rWZ8a1vQRwLZEFD2/qh8HYNWSb4j6JvGJqNphOyIvBANc
         1LJlDCigAM37dJCWPM5z/0WL6+4R637eDLgCSoSqSIvLM4dZglGtPyCEleTRQlkYj5kO
         0JRw==
X-Gm-Message-State: AOAM533c6iJC9SvPuS3Gp77LXzItSuSlpHp0d+rRugpzwZBCSvAYjlW8
        sSmdVEUCQOObLVb1oOd0hXp5IQ==
X-Google-Smtp-Source: ABdhPJzDrFY549gFz29vbpQHsjY5rCKiA9MavwzYO5BpIySio30+OpBgTFEDe/Nci/OxlvfH5/1goA==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr22880615wme.23.1606130375735;
        Mon, 23 Nov 2020 03:19:35 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 10/40] drm/msm/disp/dpu1/dpu_core_perf: Fix kernel-doc formatting issues
Date:   Mon, 23 Nov 2020 11:18:49 +0000
Message-Id: <20201123111919.233376-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:31: warning: Enum value 'DPU_PERF_MODE_MAX' not described in enum 'dpu_perf_mode'
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:34: warning: Cannot understand  * @_dpu_core_perf_calc_bw() - to calculate BW per crtc
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:73: warning: Function parameter or member 'kms' not described in '_dpu_core_perf_calc_clk'
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:73: warning: Function parameter or member 'crtc' not described in '_dpu_core_perf_calc_clk'
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:73: warning: Function parameter or member 'state' not described in '_dpu_core_perf_calc_clk'
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:249: warning: Cannot understand  * @dpu_core_perf_crtc_release_bw() - request zero bandwidth

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kalyan Thota <kalyan_t@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 36927fc04a388..b6b3bbab03336 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -22,6 +22,7 @@
  * @DPU_PERF_MODE_NORMAL: performance controlled by user mode client
  * @DPU_PERF_MODE_MINIMUM: performance bounded by minimum setting
  * @DPU_PERF_MODE_FIXED: performance bounded by fixed setting
+ * @DPU_PERF_MODE_MAX: maximum value, used for error checking
  */
 enum dpu_perf_mode {
 	DPU_PERF_MODE_NORMAL,
@@ -31,9 +32,9 @@ enum dpu_perf_mode {
 };
 
 /**
- * @_dpu_core_perf_calc_bw() - to calculate BW per crtc
- * @kms -  pointer to the dpu_kms
- * @crtc - pointer to a crtc
+ * _dpu_core_perf_calc_bw() - to calculate BW per crtc
+ * @kms:  pointer to the dpu_kms
+ * @crtc: pointer to a crtc
  * Return: returns aggregated BW for all planes in crtc.
  */
 static u64 _dpu_core_perf_calc_bw(struct dpu_kms *kms,
@@ -63,9 +64,9 @@ static u64 _dpu_core_perf_calc_bw(struct dpu_kms *kms,
 
 /**
  * _dpu_core_perf_calc_clk() - to calculate clock per crtc
- * @kms -  pointer to the dpu_kms
- * @crtc - pointer to a crtc
- * @state - pointer to a crtc state
+ * @kms:  pointer to the dpu_kms
+ * @crtc: pointer to a crtc
+ * @state: pointer to a crtc state
  * Return: returns max clk for all planes in crtc.
  */
 static u64 _dpu_core_perf_calc_clk(struct dpu_kms *kms,
@@ -246,8 +247,8 @@ static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,
 }
 
 /**
- * @dpu_core_perf_crtc_release_bw() - request zero bandwidth
- * @crtc - pointer to a crtc
+ * dpu_core_perf_crtc_release_bw() - request zero bandwidth
+ * @crtc: pointer to a crtc
  *
  * Function checks a state variable for the crtc, if all pending commit
  * requests are done, meaning no more bandwidth is needed, release
-- 
2.25.1

