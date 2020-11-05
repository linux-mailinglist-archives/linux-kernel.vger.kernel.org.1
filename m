Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E602A8193
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgKEOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKEOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CDBC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so2104790wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoR5nL3y6WX07329sSplpqvqBToYY/Osic4mjE5dOiE=;
        b=nFSE2PNcG7cmh0Bdu/Jxv3NzVCljiKeBffdfQAlnWgNNsWEHnr9anRWAJ8RDFLEViF
         m0Mn8kaHFPW1Qvm0KNQ1w6nKcEMhPhShH8efGb75qFdRJSFfl9QnQFD5zfrdTSPWKw/f
         AaeRuVcKXygPYcs5XA+BR0qs5zM/t4+cXOozmhE0apmnKGGo8ZcGuiZkTxxrh1o4m47f
         2pqNYTJzN6ECwOElr1+JqwmVCMp4ulUNam8H23EbT0bqtmmkz7thIKHWJu2eKGy8swdT
         E0GAEjE/m6rQwpYiiQr5igWxz5V24Oc3ZNM+cNMx4F3a26x/Q0dW1dAy45FVKb/idBCD
         iXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoR5nL3y6WX07329sSplpqvqBToYY/Osic4mjE5dOiE=;
        b=G9qx1zt+NCo0Z1pJpl5p4xOr2creU5TABuB8dSb4g1g0wxV7Tq6u9vuK9KEdQ8G76g
         oZ8LrRIByo+AdlLjDvTsFfoeOuE0hUux3Z2yzayfUGnkY4guVseUrE1jOq+1ItY6lVZv
         vdSTenJ6EqlBN8kEQ9Z0wEyMTDTuYoK03bgxjHxA2EZDTCamyMlR2MbKdPxNUvXVp01E
         Ix/4abUFzKQ7iIYTA2/ZemU3wXU93SWV5IUAnkKjsn4/Zf0AyBI4e2Wb9YdFiYes/g9Q
         xWAAzdmU6YMCWijqUj9YiqPc9varUNNzrQKCQ3HJf1vxY7AxRG+AQP9s+qexvrX2QEt9
         xRzQ==
X-Gm-Message-State: AOAM532Zf2ToSTHRu2v4++B13UlhfSeHdl8Ldh2v6Vgr+NK+gyFFku6S
        qxNiubnDjHSFvNIBF9pBaPLIXA==
X-Google-Smtp-Source: ABdhPJxsDscnN+g4maf2B8aLyv9Aq1bsygHLBACSxivG8ps1ZUJyW6RrJt3fnaohkUk8LbB3V5sZMQ==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr3414398wro.393.1604587939487;
        Thu, 05 Nov 2020 06:52:19 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <rob.clark@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/19] gpu: drm: omapdrm: omap_irq: Fix a couple of doc-rot issues
Date:   Thu,  5 Nov 2020 14:45:02 +0000
Message-Id: <20201105144517.1826692-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The API has been updated, but the header was not.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/omapdrm/omap_irq.c:115: warning: Function parameter or member 'crtc' not described in 'omap_irq_enable_vblank'
 drivers/gpu/drm/omapdrm/omap_irq.c:115: warning: Excess function parameter 'dev' description in 'omap_irq_enable_vblank'
 drivers/gpu/drm/omapdrm/omap_irq.c:115: warning: Excess function parameter 'pipe' description in 'omap_irq_enable_vblank'
 drivers/gpu/drm/omapdrm/omap_irq.c:142: warning: Function parameter or member 'crtc' not described in 'omap_irq_disable_vblank'
 drivers/gpu/drm/omapdrm/omap_irq.c:142: warning: Excess function parameter 'dev' description in 'omap_irq_disable_vblank'
 drivers/gpu/drm/omapdrm/omap_irq.c:142: warning: Excess function parameter 'pipe' description in 'omap_irq_disable_vblank'

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/omapdrm/omap_irq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 382bcdc72ac06..8643871e23a83 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -100,8 +100,7 @@ int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
 
 /**
  * enable_vblank - enable vblank interrupt events
- * @dev: DRM device
- * @pipe: which irq to enable
+ * @crtc: DRM CRTC
  *
  * Enable vblank interrupts for @crtc.  If the device doesn't have
  * a hardware vblank counter, this routine should be a no-op, since
@@ -131,8 +130,7 @@ int omap_irq_enable_vblank(struct drm_crtc *crtc)
 
 /**
  * disable_vblank - disable vblank interrupt events
- * @dev: DRM device
- * @pipe: which irq to enable
+ * @crtc: DRM CRTC
  *
  * Disable vblank interrupts for @crtc.  If the device doesn't have
  * a hardware vblank counter, this routine should be a no-op, since
-- 
2.25.1

