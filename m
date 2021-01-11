Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956D22F1F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbhAKTVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390963AbhAKTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE46C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d26so886618wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFjJaIHLraEHMpMPczN8JeHzaX7KeAA32v4O8bA3nIs=;
        b=B81lzbUzyymnyb48hbSnQQI2PtxDs6gsJmfEjcDaH7g9cHki4LflvmO41nwnsg/fUl
         0V0WtXyIZSCNKqRtbDvgDUBpdU679lL6Yw2pgaygMHcluXrxnM65ZzviW6ezl6TMVB+A
         bo8991Bf4Mff2Rfro+9fVbBC7fjvCYPVaJkvd6EcuTkOePXBWVDzotexB50kciYdSelY
         RlgBYLtIqrHaTxZEo65SXoEQy+FzPAMkFvAk2pADCpn8+At8WnnnmqAUf1RZPaBfMuuF
         YkK8RdkeZGvQ1e8DYBlvp2jSl9ckzY9zdNgMKfgIlYg+Tp8Kppz+tgX9tsb5wuAMdleo
         3z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFjJaIHLraEHMpMPczN8JeHzaX7KeAA32v4O8bA3nIs=;
        b=Yei7VeVio584Z8Y6O4lc9WMAS41fZUHiIaMgVrqByRNEumM8UhOY1yhIFUCeTf1dYo
         01d3WdXfoaWq27aN2Ie2mPuLJ8OZtyEmP878UBorCWvIlQv+iSoILb6csEcj7R+F7kNe
         mySER+oSHWYPl0oc4QtJUhMIhvHm7j1DedFxJw6Hk13wRzC2JbMJJq0EnYr+++NX7PP5
         c0qlF5IZ5BcrnZ+PyCwqlSQfyFBF09PcXupTaOQJl8HnmqproQCM1CZWjOgPeyv9i73R
         muVjEZQp6jmZewJp2VwSZsiJxofZfFmALLCdxNX1DVta89kdUzIJz8rvc7bgCT1WA1b8
         sejw==
X-Gm-Message-State: AOAM533w71+2wlGspg11Tkp/D9CciLVH9PRP4Po2YGxYLkTUosSqruJc
        K/rlgad6fc81+KAP6LoAMp82+A==
X-Google-Smtp-Source: ABdhPJx2y/C1Gm7lZtAhN+h6CLxajvnAHhLrj7A8KWiS3YKr9+4FIAbPlnE/ud+bnMAVlg7CPOQZ1A==
X-Received: by 2002:adf:d085:: with SMTP id y5mr605031wrh.41.1610392790177;
        Mon, 11 Jan 2021 11:19:50 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/40] drm/amd/display/dc/dce120/dce120_resource: Staticify local functions
Date:   Mon, 11 Jan 2021 19:19:01 +0000
Message-Id: <20210111191926.3688443-16-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:426:32: warning: no previous prototype for ‘dce120_opp_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:440:17: warning: no previous prototype for ‘dce120_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:478:20: warning: no previous prototype for ‘dce120_i2c_hw_create’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index f1e3d2888eacc..c65e4d125c8e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -423,7 +423,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 		CS_COMMON_MASK_SH_LIST_DCE_112(_MASK)
 };
 
-struct output_pixel_processor *dce120_opp_create(
+static struct output_pixel_processor *dce120_opp_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -437,7 +437,7 @@ struct output_pixel_processor *dce120_opp_create(
 			     ctx, inst, &opp_regs[inst], &opp_shift, &opp_mask);
 	return &opp->base;
 }
-struct dce_aux *dce120_aux_engine_create(
+static struct dce_aux *dce120_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -475,7 +475,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
 };
 
-struct dce_i2c_hw *dce120_i2c_hw_create(
+static struct dce_i2c_hw *dce120_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
-- 
2.25.1

