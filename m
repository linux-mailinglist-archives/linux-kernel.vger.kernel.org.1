Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB42F1EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbhAKTUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbhAKTUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:14 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB9C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so255178wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBLSZTPS8qk7rY11VgJobcJSdYVa2Sl7IRQcchF4a+M=;
        b=uEgsGHtL1R1LmYWVtAlgWHzqWKe0ZR0/dvXOMx1Xo/D9OSPyNzU/zd67KNHNnXjLmU
         8O0UZGjC0CM0GHTEdGIku+WcS9c1+U5hUQSbQuQUPCxycEj3Myn+Vs38kxAq1kgCAhiD
         VHVhw7sfXF+XNDVKGVTfRfCJmDgZXho3+G9/t3Z7M4qXJ4jEQ+ubQ/OLOMiwLn9dyARp
         55Q/M5kPLPxlEbf1QZHnHJahZKiI92+p4ljKzbsWOgE4e9Rh2sf9R4dq+1nO/Uoa1zrF
         i6zsr74q+nNxm7ILEhqR/DZrAjHLJXfqnTtzjMiUPSvBGYEUMzxoclZAbim4ZL55781t
         C4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBLSZTPS8qk7rY11VgJobcJSdYVa2Sl7IRQcchF4a+M=;
        b=nw3IYRS0vgeyOF2trHwEccR/H/22v904bGaIuu2sO1atpx66glkQx6zgMmCkyNalxS
         iAZ0OdsIUFTnr91jZoOMMK1nBi3IIw6Do/P3E15el5/I1b67VpG+I1Wn57wKct2uXMbF
         kFd6fsTOpOyfZvsvFnXhgKfdPTx4LWoLFi9SQOFET0j154AV8SwbmTQEIwWP+cf0zcw6
         004hg6FkfXzposailijI+Eu6vMeVOqEbuwnW/i4NtRGjKsulhpOgQ3i/PREqsIhqRMxV
         wr+urU1floV+liC7FEdBXPPqHn9zxHombTQbRLiFx6rWZ0bhw+lOzOcl7OASpb+cSkNI
         K1VQ==
X-Gm-Message-State: AOAM530RzjlFyghZLD9jM9HQ++VSfZeKNYrOZrY+qrFZQPACTprcifKL
        r2/eFOw3iZSxRMvmbyEWr7PUuw==
X-Google-Smtp-Source: ABdhPJwsPIewKRiPHpMKg9Dgwa6FSZEYYHKguRSX5hvl5lz1TB1qAR/0Ay4A53FcH8i1bV5abHPdPQ==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr259768wmh.123.1610392773083;
        Mon, 11 Jan 2021 11:19:33 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:32 -0800 (PST)
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
Subject: [PATCH 02/40] drm/amd/display/dc/dce/dce_link_encoder: Remove unused variable 'value0'
Date:   Mon, 11 Jan 2021 19:18:48 +0000
Message-Id: <20210111191926.3688443-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c: In function ‘dce110_link_encoder_update_mst_stream_allocation_table’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1506:11: warning: variable ‘value0’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 0ef2f4d9d8bf3..1e77ffee71b30 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1503,7 +1503,6 @@ void dce110_link_encoder_update_mst_stream_allocation_table(
 	const struct link_mst_stream_allocation_table *table)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	uint32_t value0 = 0;
 	uint32_t value1 = 0;
 	uint32_t value2 = 0;
 	uint32_t slots = 0;
@@ -1604,7 +1603,7 @@ void dce110_link_encoder_update_mst_stream_allocation_table(
 	do {
 		udelay(10);
 
-		value0 = REG_READ(DP_MSE_SAT_UPDATE);
+		REG_READ(DP_MSE_SAT_UPDATE);
 
 		REG_GET(DP_MSE_SAT_UPDATE,
 				DP_MSE_SAT_UPDATE, &value1);
-- 
2.25.1

