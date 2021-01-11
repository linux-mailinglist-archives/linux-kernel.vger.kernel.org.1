Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA62F1F27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbhAKTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391003AbhAKTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAEC061388
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a6so247595wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XglR2B7+pPX3eYsluIvPfl6OG4j36ADswhuMOYNo3hg=;
        b=v0kjp3b9BaCSWh+eLTY3X+pT+IYILY46vX6ifaGyGDT4awOaro0c1mcQedYno+827R
         h2JPqlkQdJOPKtsGqOoglgZOGPuy30u57Cqrb+yeSlnNpGlAHVF8hWryXYe++utM/zuB
         oYiWKcEfOaXyiPPEVAVAFQNkBFiFOIZ75IZn6vjnKgTrY1R1vhUrIMfq33GPHSW3keAs
         mOXBVzx5IwmblOpa4CkOoHe/FchcKQuDsp4rN77Duvj4fUia2n5Op5mvjzayQYLh1B5V
         deS7OhtDpRCIyFCXJWMDePGeNg4xcOWPGrdkECr9T0ED9vbDU+yEOTk49KT8TDfvmG7a
         A0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XglR2B7+pPX3eYsluIvPfl6OG4j36ADswhuMOYNo3hg=;
        b=czTIF/nebrw7/enq6oWYYHcg71I/0MUyE1VqkR/lVcLL9Q+yFxEVDaH1DXfcjEAnDJ
         6Wv1QdHVHdCPb09imPAj5PWrp4DboS/s5zrsnwWonVpmVj1MSav9WMjkVpNcn2olFNOz
         O22j2DRZLko1hi47D+/NQTYpF2m9B6XYvloI7VhQnlzESkdrSAs5q6rk0FqtiXD/YUzZ
         NL9Yz08FvLqyZioZn7uzDJrnmRdPMT5KQnJxlmUiZz+Kp5v3o39eBppLMdVezy+7mRDG
         b6zrUtW/OlFxgjPOk+9l0ki+DdciKzkEQIP6bFUQ4oONoaG3zyh94zJk9N3fi3qqCMc5
         mQnA==
X-Gm-Message-State: AOAM5317A8i+n3GacPtl/KbNRi3Z86qM07F7k2FvdbQgtcuzR07qeXsr
        EzSfmFKqUzfQXXL++7RtbSLRwg==
X-Google-Smtp-Source: ABdhPJza+Bt3p7uNeVue52RL0qVon565iY4wsEi+8Ie6KVINUcSkhJMOD7w5N8y2JD9mFZI3mRu2hA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr294573wmj.52.1610392805783;
        Mon, 11 Jan 2021 11:20:05 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:05 -0800 (PST)
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
Subject: [PATCH 27/40] drm/amd/display/dc/dce110/dce110_compressor: Strip out unused function 'controller_id_to_index'
Date:   Mon, 11 Jan 2021 19:19:13 +0000
Message-Id: <20210111191926.3688443-28-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.c:429:14: warning: no previous prototype for ‘controller_id_to_index’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../amd/display/dc/dce110/dce110_compressor.c | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index 18b0a69b0b1e8..44564a4742b52 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -425,31 +425,6 @@ void get_max_support_fbc_buffersize(unsigned int *max_x, unsigned int *max_y)
 	 */
 }
 
-
-unsigned int controller_id_to_index(enum controller_id controller_id)
-{
-	unsigned int index = 0;
-
-	switch (controller_id) {
-	case CONTROLLER_ID_D0:
-		index = 0;
-		break;
-	case CONTROLLER_ID_D1:
-		index = 1;
-		break;
-	case CONTROLLER_ID_D2:
-		index = 2;
-		break;
-	case CONTROLLER_ID_D3:
-		index = 3;
-		break;
-	default:
-		break;
-	}
-	return index;
-}
-
-
 static const struct compressor_funcs dce110_compressor_funcs = {
 	.power_up_fbc = dce110_compressor_power_up_fbc,
 	.enable_fbc = dce110_compressor_enable_fbc,
-- 
2.25.1

