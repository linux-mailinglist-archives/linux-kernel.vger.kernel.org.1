Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0466F2A9F60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgKFVuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgKFVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA300C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:49:59 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so162529wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ue3FoQJoMgBlIukOkf8MbD26USrDaAOvZdGWpXVWbrY=;
        b=M9M573Ul/P22elihygTSgOrYwuABiN98HcCxBcTWjwtR/8XWlIeqsnJqVrqplr+Hbg
         GxfTPhYgAI24Bg2FrOkqrWiJyxdQSNoW9Zs5VayctWxJnd/T+j87Q/fxsK8UbQP1P/Bq
         TZq1XFZ7jWuuaX4IYcHZ54/M2M9toRE3AVLih/FcyQV/FIjNj9473s2waCQlrFrvFeID
         WgLqtNbMWWQ8gYQjgfpQDsvRtohrRa812F4p0/ahW0/ySpdooIQAwRHlOcslW4PwDPb3
         PSHC43NNEID/ErdejNgSQtwoCLol9B+ChkkArGESsdmRpq9LdGUO1TBYtSMrIaY4vmlf
         KhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ue3FoQJoMgBlIukOkf8MbD26USrDaAOvZdGWpXVWbrY=;
        b=Ka6xrPgP/CjYUnhHkz4xn4/BVmReJu35Q5dVlm7OzwDZ5v554Z2Ip64ZEc4aNpT9os
         FRWu9eMly+Hnfe8oM2q5hRKakTOM4Jk3F8nLMQsEOC3SA72rpWPmiyl7L9By0dCw7Ndl
         P5XjKH/TH5DT9XIVxSY0+71rtygfTrS6luAjkBwk3KHXt79I2vyNUC/WhsMPsNPCzPGQ
         WuNAhMGJv+2D4Slpl0/Rm3GuPvTNxVV2uXlOQj/nnNwrbRFEUh3vfEY1MskBDm1WQp6n
         oJzcTCPnFw9X+DLX921DXrCS+PUbazQy7Fd9h2xPR2aasBcf2tVAHnO8uvpuKBObmg8o
         n7bw==
X-Gm-Message-State: AOAM5324k8q5mUoIlZBw3oJxKCNRYZvw9a7CZRsTRBnaqP67vnNWdf+X
        yAtWf1B7map72GrAm8ugAPvoIQ==
X-Google-Smtp-Source: ABdhPJy9cqifVe8QK/a7GE5NrzCUlrwh+BOYIv2oVWVg9TnOBCYHbcxD64T7Hz9gmZyKiCsN2pUXKg==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr1718240wmc.156.1604699398532;
        Fri, 06 Nov 2020 13:49:58 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:49:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        by <jhartmann@precisioninsight.com>, Faith <faith@valinux.com>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Keith Whitwell <keith@tungstengraphics.com>,
        Gareth Hughes <gareth@valinux.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/19] drm/mga/mga_dma: Demote kernel-doc abusers to standard comment blocks
Date:   Fri,  6 Nov 2020 21:49:34 +0000
Message-Id: <20201106214949.2042120-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mga/mga_dma.c:29: warning: Cannot understand  * file mga_dma.c
 drivers/gpu/drm/mga/mga_dma.c:455: warning: Function parameter or member 'dev' not described in 'mga_do_agp_dma_bootstrap'
 drivers/gpu/drm/mga/mga_dma.c:455: warning: Function parameter or member 'dma_bs' not described in 'mga_do_agp_dma_bootstrap'
 drivers/gpu/drm/mga/mga_dma.c:629: warning: Function parameter or member 'dev' not described in 'mga_do_pci_dma_bootstrap'
 drivers/gpu/drm/mga/mga_dma.c:629: warning: Function parameter or member 'dma_bs' not described in 'mga_do_pci_dma_bootstrap'
 drivers/gpu/drm/mga/mga_dma.c:1150: warning: Function parameter or member 'dev' not described in 'mga_driver_unload'
 drivers/gpu/drm/mga/mga_dma.c:1159: warning: Function parameter or member 'dev' not described in 'mga_driver_lastclose'

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: by <jhartmann@precisioninsight.com>
Cc: Faith <faith@valinux.com>
Cc: Jeff Hartmann <jhartmann@valinux.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mga/mga_dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mga/mga_dma.c b/drivers/gpu/drm/mga/mga_dma.c
index 85c74364ce24c..1cb7d120d18fe 100644
--- a/drivers/gpu/drm/mga/mga_dma.c
+++ b/drivers/gpu/drm/mga/mga_dma.c
@@ -25,7 +25,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
-/**
+/*
  * \file mga_dma.c
  * DMA support for MGA G200 / G400.
  *
@@ -435,7 +435,7 @@ int mga_driver_load(struct drm_device *dev, unsigned long flags)
 }
 
 #if IS_ENABLED(CONFIG_AGP)
-/**
+/*
  * Bootstrap the driver for AGP DMA.
  *
  * \todo
@@ -610,7 +610,7 @@ static int mga_do_agp_dma_bootstrap(struct drm_device *dev,
 }
 #endif
 
-/**
+/*
  * Bootstrap the driver for PCI DMA.
  *
  * \todo
@@ -1143,7 +1143,7 @@ int mga_dma_buffers(struct drm_device *dev, void *data,
 	return ret;
 }
 
-/**
+/*
  * Called just before the module is unloaded.
  */
 void mga_driver_unload(struct drm_device *dev)
@@ -1152,7 +1152,7 @@ void mga_driver_unload(struct drm_device *dev)
 	dev->dev_private = NULL;
 }
 
-/**
+/*
  * Called when the last opener of the device is closed.
  */
 void mga_driver_lastclose(struct drm_device *dev)
-- 
2.25.1

