Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33E2F1F25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbhAKTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390963AbhAKTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26094C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n16so482078wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwXCd4JlIEnX1jwiKrIwLEF3yNPJI5fsZD+MBCO9rh4=;
        b=xCThQF9j9WJV2twMCSrOJ/K6+x4kw2m8p+kRolat3HFsk9IIsKU92V2z37tcreRYN5
         cq+OspisPoMn+ye9MyIsh5pHmO/2p6FJoYB9Vp1DSQNUV3QeuvOw+R1F0AEHhVbnnCL4
         KodqWMX1zwYtnLkzJ4ZMJ9nVs28AzNo4OivNgf78N/c5eaadRMAJZvB+bctEqz9uM+Ub
         ohIkissSXegqi1Ea+k45F3jPTrz441OhD2QPveyFOBFKEaQe1h/bXzpC1DxGjSClMHh/
         eB8RRuy/ylghzZzZxHsQj2gI4O4aJEuQLADve9/1zaX2T2UZVyVXkmUQeNMUOiM9M1EP
         jU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwXCd4JlIEnX1jwiKrIwLEF3yNPJI5fsZD+MBCO9rh4=;
        b=cd/dDjUX9SetK2TgvujYHpmoLf4TaQ3EW8m6P1kVxA0i8DANNhhlAh6E6XhRhxAlYc
         F3LmOsaHBkQ2yfK0Y6XfpYdSlA4VWprQtsOCbAsEJGN+dZO/K3q+HKUj/Gd6klybYLla
         KEkmX7BYSOgqOAbcyIS3Myo9i3Me9sSRFn+x9tKtdX7Z1xYWpPgcaSadJma4Wdk5lyWq
         rbnHZZTqQmtyzgsPZoYPJen+euOBUjC7hI4646DCsWoUc61euZO690AwAKZz1FdIw/JQ
         Dg6K6hbJQp/A5pw1yhA5mqwSlg+MQO9Kg0Cv+RW4S6xRS30Qz6r+1wqtiVk/K2YfDInW
         ovhw==
X-Gm-Message-State: AOAM530qwjrrWrSH3EISdBksn4HMGcz/qC70cmSmeUy2AX4Q4DyiD9ql
        spKAOFPDXkNPyTU94z4wSDCggQ==
X-Google-Smtp-Source: ABdhPJy1RwDN/m9jg+A9qYwMluwwduJZWzXy3HwBNPXKtLEvWArjFsopb3aGLatZFurJ7dtCzxHQRQ==
X-Received: by 2002:a1c:b4c4:: with SMTP id d187mr297453wmf.38.1610392811841;
        Mon, 11 Jan 2021 11:20:11 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:11 -0800 (PST)
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
Subject: [PATCH 32/40] drm/amd/display/dc/dce110/Makefile: Ignore -Woverride-init warning
Date:   Mon, 11 Jan 2021 19:19:18 +0000
Message-Id: <20210111191926.3688443-33-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:66:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:5936:51: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:116:16: note: in expansion of macro ‘DIG_FE_CNTL__DIG_STEREOSYNC_SELECT__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:306:2: note: in expansion of macro ‘SE_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:5936:51: note: (near initialization for ‘se_shift.DIG_STEREOSYNC_SELECT’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:116:16: note: in expansion of macro ‘DIG_FE_CNTL__DIG_STEREOSYNC_SELECT__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:306:2: note: in expansion of macro ‘SE_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:5938:52: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:116:16: note: in expansion of macro ‘DIG_FE_CNTL__DIG_STEREOSYNC_GATE_EN__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:307:2: note: in expansion of macro ‘SE_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:5938:52: note: (near initialization for ‘se_shift.DIG_STEREOSYNC_GATE_EN’)

 NB: Snipped for brevity

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
 drivers/gpu/drm/amd/display/dc/dce110/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/Makefile b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
index d564c0eb8b045..84ab48df0c261 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
@@ -23,6 +23,8 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
+CFLAGS_$(AMDDALPATH)/dc/dce110/dce110_resource.o = $(call cc-disable-warning, override-init)
+
 DCE110 = dce110_timing_generator.o \
 dce110_compressor.o dce110_hw_sequencer.o dce110_resource.o \
 dce110_opp_regamma_v.o dce110_opp_csc_v.o dce110_timing_generator_v.o \
-- 
2.25.1

