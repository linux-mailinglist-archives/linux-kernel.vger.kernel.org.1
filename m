Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08952F45F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbhAMIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhAMIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A1C0617B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a6so692898wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxvdNrF1R3ytfMPmOtkgE2Af/C+vkAzGpGIm/SfWWGY=;
        b=aM/IyLaQDgZMmI9S/Vft91mXvPtknL7mM075lNY84v6jesMbWuuSZ6ra4spDo4Abh9
         BG7gD8ulNfeh7oDnJONekJD0JKJ/pA5AAfcWA1b0cYkDeFS++d7JlsRrX4zyipcVql51
         AW2BZrl/DU3T0Q0ymCyFSA59pVimVhosCLnqkg7vj9ws6Z/1teE4JLUCCn8m65iz+JIg
         DE//VEp5ySmb4ydjd9f2W/i0FCymeGPPSI0hx1JXBR/5HEHUwt+suVJkBm6AL8Zi/mxl
         e7AOEOL4RsxRRT4pNkECQqoL4LLJGIXe0hMMu+dppVXUZK2NaEowd40E3HTW7kTGuT3p
         x4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxvdNrF1R3ytfMPmOtkgE2Af/C+vkAzGpGIm/SfWWGY=;
        b=iAHdtaugr2W7IorGMVNvBfar5e4lDXPOX3MG8b8Ce58wo/6v8qIuKoLfnywE3NAEOp
         f43Ie0xhVvgJxV+mjWZVBgl6lyWZ9gBL2cGP2+q+DS9x8XIzbURZR5YMQ+z5l2VFqCXg
         /R2HgQx6D3v/loifKhZG+4jJ5n5RcGuDzWAKrEBWi8Cf4PjGoitEAiBia4Mma4PEb1yw
         7+TsvmRg0EoVk4dXjwh/1KziGmgAjmYhuRjBrXjVet/0wAyCJ3NFpPJGhUkWfnQxAccL
         cqXmq5lO3pMnzG4WaamWeXd+gd+CR/60wE524XIOFPxSSyroc1NEfIakpFoAumhMXte+
         NYDg==
X-Gm-Message-State: AOAM530hWzxaVoFpoQos0Zzg0AzULH2csjUlZjP26Y1jziUk/FW1MfMB
        W0rx7ud5U3Ds9efTCn16tBIc9Q==
X-Google-Smtp-Source: ABdhPJwp+34ijPPH0xN65sVQFc0LBa9PN+kz+Uvj3voNtUl/Kgh1bQoAjfkuiMZ3Bumq5jCehUDCcw==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr907233wmc.167.1610525293758;
        Wed, 13 Jan 2021 00:08:13 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:13 -0800 (PST)
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
Subject: [PATCH 14/30] drm/amd/display/dc/dce80/Makefile: Ignore -Woverride-init warning
Date:   Wed, 13 Jan 2021 08:07:36 +0000
Message-Id: <20210113080752.1003793-15-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:29:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_8_0_sh_mask.h:9546:58: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:102:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:305:2: note: in expansion of macro ‘DCE10_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_8_0_sh_mask.h:9546:58: note: (near initialization for ‘aux_shift.AUX_SW_AUTOINCREMENT_DISABLE’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:102:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:305:2: note: in expansion of macro ‘DCE10_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_8_0_sh_mask.h:9545:56: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:102:2: note: in expansion of macro ‘AUX_SF’

NB: Snipped lots for the sake of brevity

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
 drivers/gpu/drm/amd/display/dc/dce80/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/Makefile b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
index 666fcb2bdbba0..0a9d1a350d8bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
@@ -23,6 +23,8 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
+CFLAGS_$(AMDDALPATH)/dc/dce80/dce80_resource.o = $(call cc-disable-warning, override-init)
+
 DCE80 = dce80_timing_generator.o dce80_hw_sequencer.o \
 	dce80_resource.o
 
-- 
2.25.1

