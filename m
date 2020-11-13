Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1122B1C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKMNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKMNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606EFC061A4C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:56 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so8242883wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7u3R7+OjGQISbkuCs2m/TsCWsUoo+j2lw9OomX7FkgE=;
        b=oVPSe3gKajXzmTwgKcAiPMc6n66vSQUTIbxQGrlpz617vtWWaflWGSCujuQ8cnhsl8
         Flp6j1U3fpCW7BBDGzKQP/99ib4s8fxs/3AQJXmBbOgVUYM9cW6lcnZJ6CnLvJKja8Ko
         d8CatTkf5GLBuTFXz+J+cf8WtmeIFmL5KsDnbuSwPcotT3zNcJ6w1GsXt+oCK9Lbw+nZ
         gm0psYuaDRRopbobUkafy6BIEHXJI+i+Eh5apV9e39CP9yF7cHUUGtaYNL6A+xjJB/xM
         6gmjz6brGCBOeN1cuNZFWtroPbG536JOhvA1Fyspe4+AV4ymKme21mmgH9JPXwIC3zjR
         ZyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7u3R7+OjGQISbkuCs2m/TsCWsUoo+j2lw9OomX7FkgE=;
        b=Lsno12WrfS+YZZ1Zy13eD2ZUd0sL9BmRLk8BDNCQJksuktwwgLde9DhR1ZMiHB7DYR
         7tkTyq/392qCEVrfwArriACGTq7caRza/RSl5wgh5yGytvO6JjE+myJrcT6tDRO21NfY
         3QDhA++UjkBzlJnq+9KBCNnJzBqIChwoIIBJKlZZ5jEvRK2Jnl8AYZI7NOVpKR4/SzGx
         qFdlb8g3k2n9EWIP4v5/r7V3RiL1DATZKe90qv6RqPVEs1vRlQFRiGJuMgBwoEOOpmvZ
         YtteRxVVEKPn+a2ZE4GcL0gqmHYoRw4G+77TS2+PmfNh4/d0y5w9RPAsmWDqS/fmqL5w
         l9MA==
X-Gm-Message-State: AOAM533N8N+pCIqE3thHnJEMf140W+RL3Bpj/Kq40X6UmHBWszot84gz
        7jSG7QCoWE4r/1KaFVOzDB0xZw==
X-Google-Smtp-Source: ABdhPJxQxDqy7G7JaMskfG7ggUP9cLK1dW0ajER8rOj49sVwLKSqBc/GlSBicq1fC1nSz6FeOTHKOg==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr2531152wms.182.1605275395681;
        Fri, 13 Nov 2020 05:49:55 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amd/amdgpu/amdgpu_pll: Fix kernel-doc formatting, missing and extra params
Date:   Fri, 13 Nov 2020 13:49:09 +0000
Message-Id: <20201113134938.4004947-12-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter or member 'freq' not described in 'amdgpu_pll_compute'
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter or member 'fb_div_p' not described in 'amdgpu_pll_compute'
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter or member 'frac_fb_div_p' not described in 'amdgpu_pll_compute'
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter or member 'ref_div_p' not described in 'amdgpu_pll_compute'
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter or member 'post_div_p' not described in 'amdgpu_pll_compute'
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:317: warning: Excess function parameter 'encoder' description in 'amdgpu_pll_get_shared_nondp_ppll'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
index 1f2305b7bd135..f2e20666c9c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
@@ -102,11 +102,12 @@ static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_
  * amdgpu_pll_compute - compute PLL paramaters
  *
  * @pll: information about the PLL
+ * @freq: requested frequency
  * @dot_clock_p: resulting pixel clock
- * fb_div_p: resulting feedback divider
- * frac_fb_div_p: fractional part of the feedback divider
- * ref_div_p: resulting reference divider
- * post_div_p: resulting reference divider
+ * @fb_div_p: resulting feedback divider
+ * @frac_fb_div_p: fractional part of the feedback divider
+ * @ref_div_p: resulting reference divider
+ * @post_div_p: resulting reference divider
  *
  * Try to calculate the PLL parameters to generate the given frequency:
  * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
@@ -308,7 +309,6 @@ int amdgpu_pll_get_shared_dp_ppll(struct drm_crtc *crtc)
  * amdgpu_pll_get_shared_nondp_ppll - return the PPLL used by another non-DP crtc
  *
  * @crtc: drm crtc
- * @encoder: drm encoder
  *
  * Returns the PPLL (Pixel PLL) used by another non-DP crtc/encoder which can
  * be shared (i.e., same clock).
-- 
2.25.1

