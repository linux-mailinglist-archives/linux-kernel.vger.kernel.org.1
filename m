Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4782B0D31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgKLTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgKLTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:16 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80442C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:16 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so6181478wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tJhB0Hg6HAWYXnosRdlVU8vKZOSyhLIYiRgTEXQL+8=;
        b=eFZ0nyMEgcF3m/AhK2jWUr98teTvtyaCoUBu+csBEw/gH1A2K8TWUlHFEXj1H91Dhn
         zPTWKrK/hpTxawzZz18YGICA+DOS7OBbLkgfxRLIi164sk5OCFhSHC0gKW8nKeJ2yYFX
         zxcyMqavnIwUKukY51JfOoe/m9NGE8DjSAutaGM3HWFbEshT2qAqyB6d/qAcohmVZAZ+
         Q98TrI7uBD23HyyG5tmr481OLoDvvqDo/wIhi5G0bR+C9ChfGJ4LThfR/tcrBrtHKsGz
         ptHhlRvurdkrblutEcv7VJ6CIt7MB2tocfQ+Ofw7vPVJiEKl4z/5fGc0Yo7i1ICnKLuW
         /CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tJhB0Hg6HAWYXnosRdlVU8vKZOSyhLIYiRgTEXQL+8=;
        b=DnN9kDivx37zmnNWeexjM7oGbfAJ5Pk8HassUT6aaJ4mkMU4JVAsXZVrAPfYa7gifa
         iB+Q5Ul69dOc5XPnnq94iVNRU5cmBhZBOLZQ8/l8wApaLYirTveC9ORQYMJYDTOZPNmR
         HD9Zr04NubfiOch/kzK7Hur0i1IeKbJnyckHEvs9mQElDChBd+Tsu6zij56ZHjxkNzAA
         pR/MMj9BbqOmwgrzX+ZWr4Q7XPcIzxTdvpPFUzeN+yUVz+mkJw3T7CYRwfOPMwH1ddIX
         dq3UH6ydrDEnr9YInpoKgEcsjHAEaqEv/t+GiJPBIPEU8nfnls3mK8lNfNF0v/s0FdiE
         iHvg==
X-Gm-Message-State: AOAM530NVCF1OUUYHhI/dk0/hWOHBGAC6Tx4zUNoklkvklI6bfZBp+qu
        Ij+0MOYz4KpJ2cPNt9UNhCnudg==
X-Google-Smtp-Source: ABdhPJyYloRTMiYF0nhZqEBftHyP2DamMNba6JvD6twKnF8vw60286TxWnCuWt58PP87X7470thDow==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr1088162wmc.36.1605207673415;
        Thu, 12 Nov 2020 11:01:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/30] drm/atmel-hlcdc/atmel_hlcdc_crtc: Apply correct formatting to struct docs
Date:   Thu, 12 Nov 2020 19:00:22 +0000
Message-Id: <20201112190039.2785914-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And fix-up a misnamed member description.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c:33: warning: cannot understand function prototype: 'struct atmel_hlcdc_crtc_state '
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c:52: warning: cannot understand function prototype: 'struct atmel_hlcdc_crtc '

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index c17571a3cc2bf..c58fa00b4848c 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -25,7 +25,7 @@
 #include "atmel_hlcdc_dc.h"
 
 /**
- * Atmel HLCDC CRTC state structure
+ * struct atmel_hlcdc_crtc_state - Atmel HLCDC CRTC state structure
  *
  * @base: base CRTC state
  * @output_mode: RGBXXX output mode
@@ -42,10 +42,10 @@ drm_crtc_state_to_atmel_hlcdc_crtc_state(struct drm_crtc_state *state)
 }
 
 /**
- * Atmel HLCDC CRTC structure
+ * struct atmel_hlcdc_crtc - Atmel HLCDC CRTC structure
  *
  * @base: base DRM CRTC structure
- * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
+ * @dc: pointer to the atmel_hlcdc structure provided by the MFD device
  * @event: pointer to the current page flip event
  * @id: CRTC id (returned by drm_crtc_index)
  */
-- 
2.25.1

