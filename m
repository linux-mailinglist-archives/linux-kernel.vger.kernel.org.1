Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B022F83C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbhAOSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbhAOSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7EC0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id h17so8029278wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dP3O8GvG4KjVneRsCzuySK+Xofh1JQYhFAzp9Cmygd0=;
        b=NvYZ7daMri4pWwZQmsX5ru4VU0SpWalBIl53yLzN3/Cv4z4K9Il8axaTUtk/Mlvcau
         +1zefGgSce+JpOwuRVKR3bjhjjlic21dn6xpsJbCJKdmtIUTgynojMfsyD1RiRLzRcOS
         BUazqGqqSbbAxNfZw4rLZ1d+zkIPJuftk5Y/Van2ipPmeFYkmxf5jYJHtfiDr2togNJ5
         busT5EsVamr7PP37HD9pDJ//Ea6+P+0UPXBKsSTwXk304J/xX2a3ngh/9eaGz9wRpcMu
         MW83FaYOeNLaGah3GsQPDVsikgx72qqFoQ4+YNRiBI3lwcFC9yojl5gaQtTx6w54zp3P
         Vy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dP3O8GvG4KjVneRsCzuySK+Xofh1JQYhFAzp9Cmygd0=;
        b=IcQ3buRb27muR/iN253V6ptg88Y4Lv14/p6Jq5Tdr7dA6jzQc1sW50CDy+Ub7VWcmF
         28YczxcQaFVdI0MFOT0nLKCXQmO4r2x4JHLL8XjEqj2vZSYypRQZZC4fKS6+a4x46Ue6
         V6oAJ7dBvVAj+8kcup97Pdg6nY/i4RXJtOsoM1sNi1tHJwr3G502X6E7EfqZyEQa4yj+
         tVBntlVcd1HjQPMxN6R7XwJAKuEhA8nhC1XNc8PC4wSa/b9k2WVCdIqKfgMmjEtz8Ejn
         X5vtDnNDkpvAou+7/hLgyW4i2Irc7dhAIMq8QZcIDZq6deCgPZAVK76PnMXDO3IaXd42
         k9MA==
X-Gm-Message-State: AOAM532FSeQmsXWuZ3uOcuBLpGdGE8ld8H6IYwyDyzPHgusZTODhq3TP
        sY2yuh1Xtnz+94Lho+6IXRhEgw==
X-Google-Smtp-Source: ABdhPJylLVYhZtPQf2lvdbnpBfE2TpTiOfADIk0wEfZBOn1gHRWMAPa8rKFyyYAyBG8ecnMgxD3D8g==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr9873876wmj.170.1610734429439;
        Fri, 15 Jan 2021 10:13:49 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/40] drm/gma500/gma_display: Demote kernel-doc abuses to standard comment blocks
Date:   Fri, 15 Jan 2021 18:12:54 +0000
Message-Id: <20210115181313.3431493-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/gma_display.c:27: warning: Function parameter or member 'crtc' not described in 'gma_pipe_has_type'
 drivers/gpu/drm/gma500/gma_display.c:27: warning: Function parameter or member 'type' not described in 'gma_pipe_has_type'
 drivers/gpu/drm/gma500/gma_display.c:190: warning: Function parameter or member 'crtc' not described in 'gma_crtc_dpms'
 drivers/gpu/drm/gma500/gma_display.c:190: warning: Function parameter or member 'mode' not described in 'gma_crtc_dpms'
 drivers/gpu/drm/gma500/gma_display.c:573: warning: Function parameter or member 'crtc' not described in 'gma_crtc_save'
 drivers/gpu/drm/gma500/gma_display.c:616: warning: Function parameter or member 'crtc' not described in 'gma_crtc_restore'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/gma_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index cadae842a0e9e..b03f7b8241f2b 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -20,7 +20,7 @@
 #include "psb_intel_drv.h"
 #include "psb_intel_reg.h"
 
-/**
+/*
  * Returns whether any output on the specified pipe is of the specified type
  */
 bool gma_pipe_has_type(struct drm_crtc *crtc, int type)
@@ -180,7 +180,7 @@ int gma_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green, u16 *blue,
 	return 0;
 }
 
-/**
+/*
  * Sets the power management mode of the pipe and plane.
  *
  * This code should probably grow support for turning the cursor off and back
@@ -566,7 +566,7 @@ int gma_crtc_set_config(struct drm_mode_set *set,
 	return ret;
 }
 
-/**
+/*
  * Save HW states of given crtc
  */
 void gma_crtc_save(struct drm_crtc *crtc)
@@ -609,7 +609,7 @@ void gma_crtc_save(struct drm_crtc *crtc)
 		crtc_state->savePalette[i] = REG_READ(palette_reg + (i << 2));
 }
 
-/**
+/*
  * Restore HW states of given crtc
  */
 void gma_crtc_restore(struct drm_crtc *crtc)
-- 
2.25.1

