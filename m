Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466132B0D44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKLTB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKLTBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:21 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9332C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so7134286wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSQeWTdjtKHE/snC/M+vXh/C2LESCnHy86BMb0+s4p4=;
        b=wZ6DK6QT/0jgXl86gYHoNbMa2HFabOJWNjlDe3eubw/4ODuekBAeMhKInFvqDGoeVA
         9GMpX6S8jUDnsdPAmyqUBDezSM3GZecQrtoX28rTAEB59O4wK8at1IfmwWuHOoDor4M0
         HMyq4J4Jh4Qi/F2xnEMmUJa1cB5WVuzgp+dIq00AYW3uz03TwSkMqLb/Xu9CY6aTfKHh
         VJkHxIOKy2+LjQXf+9F35I2U0uPVSRD/8pg33OAk1QvuCLBlk2VxvVp4jBRBk4HNAvGG
         xMPHmsyRLBbEAQUMNVH6Y2Z/M8LKSkU8wv7uaIrjjFsSYzHNCNtYLxWg+iOViFQkQLEx
         jnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSQeWTdjtKHE/snC/M+vXh/C2LESCnHy86BMb0+s4p4=;
        b=EUEA3ByQx+JnuLrUedv4gBPzKA22PxefDnE4ptQrzKolpn6+86ukIGipIxT6FbMTD5
         OVcFpj8kuHzzp+MU0r5SOwsbWdsVwkL4NRsJGPn5D7u3Yo2BF4N3DTTt+ffuLeH9YzvM
         MPlpfDv46RSE8USIliRQDmK+7fvXGYkf4tcD43SLNPmglWmVGEAsJf0b6GuqZol4vFDv
         az+CF750nRR5h0IyQcJZUzLuYC7kHA+Gs/E3QRCYyzWh/BOkG8CkN1B4N6iqcEAauP2w
         BHz+Uy5He8Hd456eBQ4u7ZXFzB9+JpTRdh6SYJaKiKmZAwm6bUSBk7YHDJEPPv0x/gTt
         wfLA==
X-Gm-Message-State: AOAM533JamCf9gZMmgcZLyF9TAFMJ89d+WtvV10AJBtnkgJnnCuilONj
        HhzKznQbP3lVPtggSQFq44FthQ==
X-Google-Smtp-Source: ABdhPJz0SXmRR7WXNORCYuzPoVjb21fRYelsIwYMJmXAYPuhl4rAfkBemy13imRn4RCkwQN9WIwZEw==
X-Received: by 2002:adf:eeca:: with SMTP id a10mr1095430wrp.186.1605207679555;
        Thu, 12 Nov 2020 11:01:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/30] drm/atmel-hlcdc/atmel_hlcdc_plane: Staticise local function 'atmel_hlcdc_plane_setup_scaler()'
Date:   Thu, 12 Nov 2020 19:00:25 +0000
Message-Id: <20201112190039.2785914-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:283:6: warning: no previous prototype for ‘atmel_hlcdc_plane_setup_scaler’ [-Wmissing-prototypes]

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 40800ec5700a8..2d502d23ab12d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -280,8 +280,8 @@ atmel_hlcdc_plane_scaler_set_phicoeff(struct atmel_hlcdc_plane *plane,
 					    coeff_tab[i]);
 }
 
-void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
-				    struct atmel_hlcdc_plane_state *state)
+static void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
+					   struct atmel_hlcdc_plane_state *state)
 {
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
 	u32 xfactor, yfactor;
-- 
2.25.1

