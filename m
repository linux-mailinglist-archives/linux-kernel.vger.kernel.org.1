Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D415A2F1F29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbhAKTVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbhAKTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91585C0617BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so247206wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f0FtZXp9xVs1vBA+TFZeeAO+I8q3YihV8u/Z7zvpoM=;
        b=rjSyoFGbyoA6OFHvEnHL5eOuRnQB8feiOHf2dVoaV0cnhK1LHvbxXhQNf5fpny64TM
         V0BurbwGgCi2pGIl+/muaxAZcbrIOwlZ4JSl5ynfsznPn24tPcngDhW/KzLsgB6AR+Tr
         +TeysSR2e3qbwg+6JD8qJmHkbGLLrMCQkp1szP8svGFRnhZgaV2l3prirUlF1OwKdveK
         0ll2Y080EHI//ECwaQRonRJZQnLWJcPnrXOB3Gz5yunY45AMBo6BgOPiChBAq3aPBADo
         brVG2yU/r7JffymFfbfBhmMFDNZqQEyv4OKTQEnc1kycnmPkosze7rgJ9GIoGb+JCf3S
         qSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f0FtZXp9xVs1vBA+TFZeeAO+I8q3YihV8u/Z7zvpoM=;
        b=SIOnj5MfdafL7YpvsG9veyQ/t6DurQfnPzgSLDUQ+wxIwYmEHSjgL2ZFjR8RPpUGz5
         0k6t/8adCfylIn22Ah+DpngRqHib1OsIdiVh/T/yM2K2s0M2rufGiBKY5j2wg74MnDYM
         mg6SLY1z6JtmqXPhlt5luYuwIMMTQH46c8vYJ0XeHSOu1AxDDV16+lK6ub/ZSA850wwf
         xCSFWZKSLr+YkkzmjwEwy6BptwShnCrBG2JjuMdpJMjOZHwTC+HRBt2bkAaI3trEPgJN
         p2u9cm91tGGig4sgPlU2NI1luR4aHQP9apLBme+YqpvxylyyJLkGFo/TTfkgZt2j9/Vw
         nXOQ==
X-Gm-Message-State: AOAM532w9msjky72eYl0+pFOrl44jhj8P5FsmAYA+uKRxPg6Y4PzKgrh
        sZF99O91BgpOKftnIHa2LDO/iA==
X-Google-Smtp-Source: ABdhPJwsrKKzjTmqVmxK7QvuhGOgor8z+bzcpTnHbAd2oc0w0rYLmJaHlX9mCCYagUchfaHSjV+oPQ==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr255039wmg.145.1610392795315;
        Mon, 11 Jan 2021 11:19:55 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amd/display/dc/dce/dce_opp: Remove duplicate entries causing 'field overwritten' issues
Date:   Mon, 11 Jan 2021 19:19:05 +0000
Message-Id: <20210111191926.3688443-20-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:59:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10480:62: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in expansion of macro ‘FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in expansion of macro ‘OPP_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:321:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_112’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10480:62: note: (near initialization for ‘opp_shift.FMT_TEMPORAL_DITHER_EN’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in expansion of macro ‘FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in expansion of macro ‘OPP_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:321:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_112’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10479:60: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in expansion of macro ‘FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in expansion of macro ‘OPP_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:325:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_112’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10479:60: note: (near initialization for ‘opp_mask.FMT_TEMPORAL_DITHER_EN’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in expansion of macro ‘FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in expansion of macro ‘OPP_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in expansion of macro ‘OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE’

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
index 4d484ef60f357..bf1ffc3629c7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
@@ -111,7 +111,6 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
-	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh),\
@@ -219,7 +218,6 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
-	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh),\
-- 
2.25.1

