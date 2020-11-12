Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99B2B0D46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgKLTBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKLTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:22 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B7C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so7127059wrf.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNH9kt00Ytktj23I8cCOxWaGTDw/PvYngQ1rA6iE+q8=;
        b=ftVe61vl1qHazPhsUFSHiMVrrXrdpSLAdqtZdV0KiAUu+I4967UqclrYIfnxHdS7BZ
         2M4+lPokvvsQdoh076IAg87Fh4Au+4HCycCxdH5pGzeluuftd3dUU1nlPgDwd6LMyKYL
         xe7jQ7PoAxwZC9EhN07fdr3LK5zOfKcrwtm9Uy7F38YFFGOh6l9+VjlF/Kpf+UPDKjXC
         vicRjcjjFMRlKxs8elyYuEe6n/jfOjhShF758j3BDkXeK7KHR7cEfufg0/OFJMISlzkX
         25dpMFYDpFFpS5MSug+pRZu4qsFPPkhrDjN91h9/CvCk7X1O75dOXDvK4boMGEJFXW9Q
         KskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNH9kt00Ytktj23I8cCOxWaGTDw/PvYngQ1rA6iE+q8=;
        b=AL1wLOF3v9Aw3jDOAfgsdGRGVFrqolR7tIxML6DcHz+B01KD3UMMl/CwrVwHcLJKSe
         awZyuDxm37gYM+DhSz93H8C8Bfn3ETfsC9xhAiP/zy405lDYwmU2gHdR5sjLc699Ld1y
         H/QX5oq2PNPpCqC5OEyqD9GqqJTv0RSOuzWUX5ccAA+YEvcWPuOe2RO7vP6b59+Y3se2
         r13YASZgaQqQu3w4fN+9snazq5RArQyrQZN7nTqWtmOjGTuSDr/0/3Lb5rGdgq5R2/j/
         o2fvdKryrcbTPRbttbA7DYig8xHSGaPGVoqMeFl7q+FYjVuSbMa+mpSjiDWwwxiw5bYG
         jsug==
X-Gm-Message-State: AOAM533qnjtdbxwsM8zlXVGgIGYR2wCIQAOg3snTrKCSmHfYdtlGEB86
        /9Ja4GKOVMlYzpICjk/g20DvWA==
X-Google-Smtp-Source: ABdhPJxqE+Vnjbqg3AQ2n83jBzCYDEN+itVbbaY8NSM3c51Pltt0EeCp3GT9E4rYzQ7RuFtH8dmpbQ==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr1076296wrw.43.1605207680754;
        Thu, 12 Nov 2020 11:01:20 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:20 -0800 (PST)
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
Subject: [PATCH 17/30] drm/atmel-hlcdc/atmel_hlcdc_plane: Fix documentation formatting and add missing description
Date:   Thu, 12 Nov 2020 19:00:26 +0000
Message-Id: <20201112190039.2785914-18-lee.jones@linaro.org>
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:44: warning: cannot understand function prototype: 'struct atmel_hlcdc_plane_state '

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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 2d502d23ab12d..15bc93163833b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -19,7 +19,7 @@
 #include "atmel_hlcdc_dc.h"
 
 /**
- * Atmel HLCDC Plane state structure.
+ * struct atmel_hlcdc_plane_state - Atmel HLCDC Plane state structure.
  *
  * @base: DRM plane state
  * @crtc_x: x position of the plane relative to the CRTC
@@ -34,6 +34,7 @@
  * @disc_y: y discard position
  * @disc_w: discard width
  * @disc_h: discard height
+ * @ahb_id: AHB identification number
  * @bpp: bytes per pixel deduced from pixel_format
  * @offsets: offsets to apply to the GEM buffers
  * @xstride: value to add to the pixel pointer between each line
-- 
2.25.1

