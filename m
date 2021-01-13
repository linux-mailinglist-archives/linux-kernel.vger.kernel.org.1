Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A712F4600
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbhAMIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbhAMIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF6C061387
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y187so712963wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePSRgs/Oht29QZLcRjU0xPTTc8gUIb5jIpmVTTqKzN0=;
        b=tgoX12VNW482sdZIyhl4ORWffsWRGDAF8WKOquXRllWLqJQJ78J3p7CT3/31OGzuoE
         LoI2e+hpCagmbWE7g9VZMY5FqXOO68yRFfHKZapDdAVFihCP92NcdYdcmXg8mnx7fzFP
         ArXKyu3k0AqXcnnif2fMoO+PBfwaWpllqLkI//UH1JpLZwzAtYmLYTOw+gfDcLaaGcBS
         fCRbKczPAoKW3pT+QpCDo3depBAbo6gTUMW07IbdTpiamAxRYaPZ31vaIOTZC8v4Alcb
         jM86MNad9CjDADKOq6ByP6Bbo8HioNGIbOn4ErP6CYSdC2bD9M+t9qlkOdo2XYMLU9IV
         OS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePSRgs/Oht29QZLcRjU0xPTTc8gUIb5jIpmVTTqKzN0=;
        b=BEjEFoHhclnel8Y/RjBXExdr4hJrsTP7vW2XSAlqhAN6u4Y9AcXsTD9ydDFyHFVhQe
         AvzrudLefxP+uSc+RFdCyPr3tUylVblpLTx703ygSKO6PiJDF4FTju0IjSjqBPCzyZRj
         T6og0RnwpoSWaFsjf+VSdVcHYiLT8fEjIYPjh7z1kbip5nvMMef8Y1nEUBqurowl3QSY
         k9KTUJgo+IvBq7ixmvKulerLXjpiu01C7fuQ3ZLKYb/kDTqbu8W6+rtlq1Fsb6O2bK2d
         bq1XXR9I6LaAl7dzSBSzUPoBOG3FJ6F7GPwcwCg2aV2wVOB4tJb9KuzLjmwQYMhw2vaH
         r53w==
X-Gm-Message-State: AOAM530kaqlCqGF39NmeWtqwMn7fZuCDK7dNvE915whr0zBxQFkpSpMA
        2ES5eXYIyjZ3vA0by5l3l4qN9Q==
X-Google-Smtp-Source: ABdhPJyGrLDO2UBG/M9dHT/9jSVj5NOQokJsf/gYMTBymO5DcW7KnV5p+/waaOPM2apiLlu6Eeyq4w==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr929325wmo.172.1610525306810;
        Wed, 13 Jan 2021 00:08:26 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 25/30] drm/nouveau/nouveau_display: Remove set but unused variable 'width'
Date:   Wed, 13 Jan 2021 08:07:47 +0000
Message-Id: <20210113080752.1003793-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_display.c: In function ‘nouveau_framebuffer_new’:
 drivers/gpu/drm/nouveau/nouveau_display.c:309:15: warning: variable ‘width’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index bceb48a2dfca6..b76bba4ca0856 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -306,7 +306,7 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct drm_framebuffer *fb;
 	const struct drm_format_info *info;
-	unsigned int width, height, i;
+	unsigned int height, i;
 	uint32_t tile_mode;
 	uint8_t kind;
 	int ret;
@@ -346,9 +346,9 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	info = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < info->num_planes; i++) {
-		width = drm_format_info_plane_width(info,
-						    mode_cmd->width,
-						    i);
+		drm_format_info_plane_width(info,
+					    mode_cmd->width,
+					    i);
 		height = drm_format_info_plane_height(info,
 						      mode_cmd->height,
 						      i);
-- 
2.25.1

