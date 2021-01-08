Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD32EF8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbhAHUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbhAHUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08105C0612A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y23so9442165wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ynto/MZpBe5G42s9vReiED0PRGKZttvk/p9R7rGmhMU=;
        b=j5gRi8kb1z9r9v0Wmdcr1/+GgOq0BvFyxJd3BMOSmd4YTFM9odpHw4ntJ7o8srreTK
         S+xjPLLW6HLRvT3SnpwpcsrZ6FjgNgB9VKnHAMH+LkkNEPfWTGHknUnph7WJ+0t402qx
         lZVdInz3sXRPqLHWXmm6oPdMFtEm0C41JiZYtbEdkuSbsa44LvSHR2DR/G5EEKK+Z8nN
         fPmxUsaC/tqeOXjSV9F3HDn81aNwuhIdvjg2dDQM3HQHU+YpmYvr5SbxP0Gjpb5wxsl5
         orEaLRKjsqCfTCOsLh2r/OzNDWUTWM6P63onC+JtQKk2z0ulnnB6/Owyd1hvoNIy6478
         rJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ynto/MZpBe5G42s9vReiED0PRGKZttvk/p9R7rGmhMU=;
        b=NWZ7ni6x7rQwiSL+iauFUbvpiAES19VnoKKsb3ZcNkDIxSr863x0fTOHi3tRHHL4wb
         PK9g96jX2yTS/hdcsIyK7uPOMJdMfNXz3eTN+73lreZkyVYW8A1UwaLUobNRijnkZTLM
         fDgtrxtfccZV64l2xQ6EpUliQhADpoNES8D+duGxYcW54ABcAfWljg2pb7K7gA3NOjgL
         T+LZWROzUq+yP6ikpP2yNw9S6MioLqtnfcESMl+YCtMsW58wEp9hfWQW2fieUIjWSj0R
         gmVjJTZt3Fh7tuSa+WxV82Fgb6lUotEwuMyZWevAun8kLXmxg45lkSbGtXasia/eTtzr
         686g==
X-Gm-Message-State: AOAM533ICfuw5wYDxR8XIY+GmCZE4zMSBA5NlOgv0zkTnuOgT+rPwF09
        56NxuyuzmdREugi9GmJNem77Rg==
X-Google-Smtp-Source: ABdhPJxAsGGcg5ElEg6lbsPL0Qt2RrOVM2OAs+h+KSs4vC433L+e+4yx8PbxvRflV0mz9r7K5QcWjQ==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr4489592wmr.162.1610136913799;
        Fri, 08 Jan 2021 12:15:13 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix documentation for 'mpll_param'
Date:   Fri,  8 Jan 2021 20:14:24 +0000
Message-Id: <20210108201457.3078600-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:290: warning: Function parameter or member 'mpll_param' not described in 'atomctrl_get_memory_pll_dividers_si'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:290: warning: Excess function parameter 'dividers' description in 'atomctrl_get_memory_pll_dividers_si'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:339: warning: Function parameter or member 'mpll_param' not described in 'atomctrl_get_memory_pll_dividers_vi'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:339: warning: Excess function parameter 'dividers' description in 'atomctrl_get_memory_pll_dividers_vi'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 83a6504e093cb..b1038d30c8dcc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -279,7 +279,7 @@ static const ATOM_VOLTAGE_OBJECT_V3 *atomctrl_lookup_voltage_type_v3(
  *
  * @hwmgr:           input parameter: pointer to HwMgr
  * @clock_value:     input parameter: memory clock
- * @dividers:        output parameter: memory PLL dividers
+ * @mpll_param:      output parameter: memory clock parameters
  * @strobe_mode:     input parameter: 1 for strobe mode,  0 for performance mode
  */
 int atomctrl_get_memory_pll_dividers_si(
@@ -332,7 +332,7 @@ int atomctrl_get_memory_pll_dividers_si(
  *
  * @hwmgr:                 input parameter: pointer to HwMgr
  * @clock_value:           input parameter: memory clock
- * @dividers:              output parameter: memory PLL dividers
+ * @mpll_param:            output parameter: memory clock parameters
  */
 int atomctrl_get_memory_pll_dividers_vi(struct pp_hwmgr *hwmgr,
 		uint32_t clock_value, pp_atomctrl_memory_clock_param *mpll_param)
-- 
2.25.1

