Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BBF2F1EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbhAKTUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390794AbhAKTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB05C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a6so246534wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deJgdJaEuReRAIxBvvkhhG4KqxPwTjkmLcBm6GGwPgM=;
        b=o1zswORDqJkgQ6gNl7NERNf4reA60BdU2ZMYXgFJFyEsZoX/97G3rNIhIAaBbqA7BW
         wAQihcz7N/lJ858SgzhqbfScg5rKcbAA/eIzLvb5dRZrI5oWl9oyx121Bo6pwxo3zEM8
         D365DRl87k9MBs3ir5b92oiNs+I7Aav0Zo5MWYC3Y/pQ9f3haEh5qjqvyF9PM/vQ5JJ2
         PwIP2HHcyxXUVnX/A9LIda9ej59Za2lBtPLW66k2Eoadbdw1cvSoM2LW3shjsvJup5Ah
         mNuMWNpCTVlLvSYtOynDvicygepHxRd32z39JWjhFv8Ra6ObdMdpgpcAhQNF5mN6Xv2D
         fN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deJgdJaEuReRAIxBvvkhhG4KqxPwTjkmLcBm6GGwPgM=;
        b=tcPQCF3hXScMhimKKtjlYaBb6aiKJevL0PkQ+qUTxRS2G0TDCGx/Jx35Bu/ov4XLyu
         ECJTIpldveIxSY62ffGjEh+8hDoNWRexGy4l0lkZqxZ1cJFHjf2pwqG1HG2/buNNG6LO
         FX+MsEA2BwbmBo5oRyqyANRrkRhX16fwQNZfiSUmJm2udIH8+iaGAEszOJLttwPP5EUg
         8U7FF5g8hStsRT3d1nCIhWimMmv7EkRJCuh7JzmFB3Y2DBS3r3L5LTl0cBm4kFtQTyCj
         PQCFELUXLM9koaz39MJvzJgoHN5d+ZvNfl6zxshjhKl08cxNnds/a/Rd7uBUdbMWlaWT
         fO9A==
X-Gm-Message-State: AOAM532dg0aM69iLcgtIqbOrxVH3PRHvOX9I05BOQIbZV0oO1sHVUYSk
        kWmAps328lUlqvQu11cpO4TRtw==
X-Google-Smtp-Source: ABdhPJw6Hy4OeG8axIi3/IOG+PL8vkZ/xZ0G/0YFDEQt7hRGcTtISU1wy3hTTbdLWu/pHyITbgpzQQ==
X-Received: by 2002:a1c:b4c4:: with SMTP id d187mr295556wmf.38.1610392774477;
        Mon, 11 Jan 2021 11:19:34 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/40] drm/amd/display/dc/gpio/hw_ddc: Remove unused variable 'reg2'
Date:   Mon, 11 Jan 2021 19:18:49 +0000
Message-Id: <20210111191926.3688443-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_ddc.c: In function ‘set_config’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_ddc.c:110:13: warning: variable ‘reg2’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
index 1ae153eab31d7..7a8cec2d7a902 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
@@ -107,13 +107,12 @@ static enum gpio_result set_config(
 					msleep(3);
 			}
 		} else {
-			uint32_t reg2;
 			uint32_t sda_pd_dis = 0;
 			uint32_t scl_pd_dis = 0;
 
-			reg2 = REG_GET_2(gpio.MASK_reg,
-					DC_GPIO_SDA_PD_DIS, &sda_pd_dis,
-					DC_GPIO_SCL_PD_DIS, &scl_pd_dis);
+			REG_GET_2(gpio.MASK_reg,
+				  DC_GPIO_SDA_PD_DIS, &sda_pd_dis,
+				  DC_GPIO_SCL_PD_DIS, &scl_pd_dis);
 
 			if (sda_pd_dis) {
 				REG_SET(gpio.MASK_reg, regval,
-- 
2.25.1

