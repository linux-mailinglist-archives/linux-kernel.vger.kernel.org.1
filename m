Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4519D2C5639
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390839AbgKZNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390825AbgKZNnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:05 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A714C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:05 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so2467998wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnrdHuM/rWXAPsRk8sa0DBTjM6BaG4gFKqaiWF+hjeo=;
        b=jTnOPgnfrpvpHF84PHFE7DnpVaSfxOChEK41IUniXvhcZ/Bb0XWmeAg5q91br7B7BB
         o/mPFf5RNvzDZPdgbCeCfjHkRicpqsHLnv+y5bffqrxZZUdyvGsBtuXCDUP/GEaPUXJu
         NB0dpr8kGWnxtqqWkkLLkCmlMYI+vvkICtDD0gttaL+ml1SalHU5RUNy94tqoBXGVVd5
         RZW+HpeXDAMcMX/2sJMADVt9kHDCsHDT1MRw5caLvQh8xyH6v4PoaM+N8MIBp1YZrVai
         MX/2DnCdkosdZBehROI0YzjK4zwU+GvTCjGRQUboCieyD8LBk/gg7kIGx4v0thQC11sJ
         +yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnrdHuM/rWXAPsRk8sa0DBTjM6BaG4gFKqaiWF+hjeo=;
        b=pJpMs+fDjuV4vGZtvWpUXsxvCjwKL1ucK7FsY2ksCvrUVmXw5cs4jHMC3qMU0/h12P
         k/ekJCvPhDg1ROa6juYvOUIiekyhRsKUzQHgAjRKUbD8Rms0Wwsd+Q/PNXW+o4YNbUEx
         awlekgcF9fBa6zJe9dIADgUERslvXyG+E520So7kfiuWPa3fHHt8wTXFdAKSqupRKQ/A
         8ASObUb5AUJYsor/KHz/o/zMlgNYqHX4gZS2uV7MXSkouzGnGS68a8WlFKMwVU2IHShl
         Gcc/HqNj73RCK1lU6s1XG+8H4yzLML2tl3VNnVMywO+aq1Vf1TiDk2H4oHIoU9FGxoEz
         O/Aw==
X-Gm-Message-State: AOAM532x5sXBqJrygaf05PLrSDqaflgck4LMcMyPeAClFh5QHEiI8iVM
        CCYSG2Z3hU3iJ4UF5b79x2Z2Qg==
X-Google-Smtp-Source: ABdhPJwvSU7aMP2JcJfhyESLr1X97Bf+6EtAKwtTOON35bElepnHYh3nEPpIDcbJPpNwnHssyTnMLA==
X-Received: by 2002:a1c:2001:: with SMTP id g1mr3487005wmg.179.1606398183970;
        Thu, 26 Nov 2020 05:43:03 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Remove unused variable 'fPowerDPMx'
Date:   Thu, 26 Nov 2020 13:42:12 +0000
Message-Id: <20201126134240.3214176-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:31:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c: In function ‘atomctrl_calculate_voltage_evv_on_sclk’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:702:22: warning: variable ‘fPowerDPMx’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index c2fee6796bd93..2cb913ab77f26 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -699,7 +699,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 	fInt fMargin_RO_a, fMargin_RO_b, fMargin_RO_c, fMargin_fixed, fMargin_FMAX_mean, fMargin_Plat_mean, fMargin_FMAX_sigma, fMargin_Plat_sigma, fMargin_DC_sigma;
 	fInt fLkg_FT, repeat;
 	fInt fMicro_FMAX, fMicro_CR, fSigma_FMAX, fSigma_CR, fSigma_DC, fDC_SCLK, fSquared_Sigma_DC, fSquared_Sigma_CR, fSquared_Sigma_FMAX;
-	fInt fRLL_LoadLine, fPowerDPMx, fDerateTDP, fVDDC_base, fA_Term, fC_Term, fB_Term, fRO_DC_margin;
+	fInt fRLL_LoadLine, fDerateTDP, fVDDC_base, fA_Term, fC_Term, fB_Term, fRO_DC_margin;
 	fInt fRO_fused, fCACm_fused, fCACb_fused, fKv_m_fused, fKv_b_fused, fKt_Beta_fused, fFT_Lkg_V0NORM;
 	fInt fSclk_margin, fSclk, fEVV_V;
 	fInt fV_min, fV_max, fT_prod, fLKG_Factor, fT_FT, fV_FT, fV_x, fTDP_Power, fTDP_Power_right, fTDP_Power_left, fTDP_Current, fV_NL;
@@ -731,36 +731,28 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	switch (dpm_level) {
 	case 1:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm1));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM1), 1000);
 		break;
 	case 2:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm2));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM2), 1000);
 		break;
 	case 3:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm3));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM3), 1000);
 		break;
 	case 4:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm4));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM4), 1000);
 		break;
 	case 5:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm5));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM5), 1000);
 		break;
 	case 6:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm6));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM6), 1000);
 		break;
 	case 7:
-		fPowerDPMx = Convert_ULONG_ToFraction(le16_to_cpu(getASICProfilingInfo->usPowerDpm7));
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM7), 1000);
 		break;
 	default:
 		pr_err("DPM Level not supported\n");
-		fPowerDPMx = Convert_ULONG_ToFraction(1);
 		fDerateTDP = GetScaledFraction(le32_to_cpu(getASICProfilingInfo->ulTdpDerateDPM0), 1000);
 	}
 
-- 
2.25.1

