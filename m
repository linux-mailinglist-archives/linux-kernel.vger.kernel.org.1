Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DBF2F83EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbhAOSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388603AbhAOSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B1C0617A4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 91so10219562wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xr/TlOQIPbbJBH63luKhm4AYMPttpvHdoQcinOdIcB8=;
        b=r665qRD55DKCi1zOw3JQLyj/yuHDdy5XWz6+iov23eG6Qdd3Ou2RgZPr/83oBEf2o+
         4rzUXjDIJxFS91pJSuuKjbW3s8HaVx7Rm7QAL36NI6gpE57a3p+CzU3uy/VluPW+jNae
         7sdZBLdjkddIouTVDXdfOwsZNF0OMBP6hBc8LsBvQWXEs7N1fAIm4v+7PIh7mxJA0dlC
         bIvK8IuLS4SP4v22vCIP6O9Tcd20ZKsll1HRj2WQ/hLaTd1Dg1lLMdhChmBX3WDb0fet
         gks7rRepkkmjmWL7+nb9agT5oHUc1rmfUwwwHuI7qpJp+WGbv5Yvdd7o7gOoFeIMoiQg
         1d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xr/TlOQIPbbJBH63luKhm4AYMPttpvHdoQcinOdIcB8=;
        b=b1dnzQxfU66FuNh2suuSIBUm5Ekg73KXMAXKD5DgFJqJWJbg9E/9x7696MuWSLTdhx
         D577lk5dLPuqerTOXf04/5pvrIQw3sEHeSRc6rfFhlLjwmGy7DRRW780GzpHH20jXwdm
         6pg6qCnfiW/Yxx6oWgDhhCErJFwTjHa/0T8RPXhA5UpQmfdmC/txKwdm05tQxDkWFtCo
         ZkOQm5QSkTfkrgcnahqU7fZP3QHdic1G7E8CVSEUxtLcR7OzkZquyMSgT0t5uYL79eaV
         OzgDbDnutW6zWeE1GrDk+VJp+4cCvhgYajdo9KBHAMWeW1xi9as6E5o8cO8PqoBz8PTh
         dEew==
X-Gm-Message-State: AOAM532M7Ib0wgZciRsasqXGZH+Cenvs4OqK9MamM4JDmHdzIDw9Q8Bx
        kz5oHwdrsZO9FsSi0uLOzLyVtw==
X-Google-Smtp-Source: ABdhPJyIqUDGRo287c/CoRsZQdx8gY8wQTE3x1mFLo+LVmJ8x8IULoKSWDYTOu8x3lcS8yBMhkv1Wg==
X-Received: by 2002:adf:b359:: with SMTP id k25mr14766514wrd.98.1610734584764;
        Fri, 15 Jan 2021 10:16:24 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/29] drm/drm_dp_helper: Fix spelling issue and add missing description for 'enable_frl_ready_hpd'
Date:   Fri, 15 Jan 2021 18:15:45 +0000
Message-Id: <20210115181601.3432599-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/drm_dp_helper.c:965: warning: Function parameter or member 'color_spc' not described in 'drm_dp_downstream_rgb_to_ycbcr_conversion'
 drivers/gpu/drm/drm_dp_helper.c:965: warning: Excess function parameter 'colorspc' description in 'drm_dp_downstream_rgb_to_ycbcr_conversion'
 drivers/gpu/drm/drm_dp_helper.c:2678: warning: Function parameter or member 'enable_frl_ready_hpd' not described in 'drm_dp_pcon_frl_prepare'

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 3ecde451f5231..3c5b04abb66f1 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -954,7 +954,7 @@ EXPORT_SYMBOL(drm_dp_downstream_444_to_420_conversion);
  *                                               RGB->YCbCr conversion capability
  * @dpcd: DisplayPort configuration data
  * @port_cap: downstream facing port capabilities
- * @colorspc: Colorspace for which conversion cap is sought
+ * @color_spc: Colorspace for which conversion cap is sought
  *
  * Returns: whether the downstream facing port can convert RGB->YCbCr for a given
  * colorspace.
@@ -2671,6 +2671,7 @@ EXPORT_SYMBOL(drm_dp_get_pcon_max_frl_bw);
 /**
  * drm_dp_pcon_frl_prepare() - Prepare PCON for FRL.
  * @aux: DisplayPort AUX channel
+ * @enable_frl_ready_hpd: Configure DP_PCON_ENABLE_HPD_READY.
  *
  * Returns 0 if success, else returns negative error code.
  */
-- 
2.25.1

