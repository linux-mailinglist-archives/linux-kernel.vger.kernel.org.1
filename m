Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C419B2F1F14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbhAKTVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403987AbhAKTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30773C061389
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y23so302936wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hv513vsZp6qynCGWUcfJy9FTxPQ6BFzk4Chw3OuBy8=;
        b=WAkCuQk0F0cFNo2i2icjnLHXZu6/AtR/W+lQYDsOEbh2dKMoKQrzIMKdNt4VhY3I8Y
         R7e8CPOiIwI1Blfe6yTx5CcZogAjcn0npxVrz1LIUpZVhztWnk09z/9ZGBwCsz2wLe3R
         W0UKrpG+CLWR2APa+jbQiW/J8+CgYCMEbi+B4nr0aJ7sBsBZc/ghuhQi3RzgSO/XbQBm
         8r42F/3sR+27TWQfYPVmX5NQOivmsE//6b5cgPevI7/fG3lWh0kMam3j48SGrDPnahAp
         1zO1Tmsr1I1pCn/MxY0knai5Jtg6Uy0w3RK+BldmZngTlYdEbSPsEEINRZAfe81GyJ9V
         4kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hv513vsZp6qynCGWUcfJy9FTxPQ6BFzk4Chw3OuBy8=;
        b=GIijncVZy0aDVC2BZY2mfT6uPlF80v++JidBLa3qjaFKDnceLOtE5J0xmb2HsiPuNs
         e3JyzVIgQgKobvPCWUijaFmMqDIs2538ix31uE5QbwlYuNqiGhUIfsdU5LyZCTGHxgEz
         2BkPRrdfjdQWM0SjxKacGxj7utAwABYv0vMXboAphwD8NX4mTAypsFp0EJ2+HxcFprp8
         07oWX1bEOn1une71EFGv6RO4N3hJKHEOuRHQdzUD8CAofNZOzZgnIjjYJN76y1wKmUa3
         2SDVxOx+5Elb/WuO5i+sbthx+TN8gtbf05RuBig5DLD6Zh2gj0oog915TDO9WWUn9ADU
         Rc9Q==
X-Gm-Message-State: AOAM533hwZkleQzEozRouxUXXeVDvxmFaX/kBO9wdEgu5utWqGZVPhPZ
        WxGGZR1KgeufUnwHGAOL3egSZA==
X-Google-Smtp-Source: ABdhPJzFTT/KFmCGP/Vg84ProquKzYOmuLbrbBbxtcj51mQ9tF0x9wKBH+XCb8kwArWwtqfL05yyyQ==
X-Received: by 2002:a1c:bd87:: with SMTP id n129mr304132wmf.32.1610392806958;
        Mon, 11 Jan 2021 11:20:06 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:06 -0800 (PST)
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
Subject: [PATCH 28/40] drm/amd/display/dc/calcs/dce_calcs: Demote non-conformant kernel-doc function headers
Date:   Mon, 11 Jan 2021 19:19:14 +0000
Message-Id: <20210111191926.3688443-29-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2753: warning: Function parameter or member 'vbios' not described in 'is_display_configuration_supported'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2753: warning: Function parameter or member 'calcs_output' not described in 'is_display_configuration_supported'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning: Function parameter or member 'ctx' not described in 'bw_calcs'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning: Function parameter or member 'dceip' not described in 'bw_calcs'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning: Function parameter or member 'vbios' not described in 'bw_calcs'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning: Function parameter or member 'pipe' not described in 'bw_calcs'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning: Function parameter or member 'pipe_count' not described in 'bw_calcs'
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning: Function parameter or member 'calcs_output' not described in 'bw_calcs'

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
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index f69c2b84d432b..967d6d80bd38e 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2743,7 +2743,7 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
 	kfree(vbios);
 }
 
-/**
+/*
  * Compare calculated (required) clocks against the clocks available at
  * maximum voltage (max Performance Level).
  */
@@ -3014,13 +3014,12 @@ static bool all_displays_in_sync(const struct pipe_ctx pipe[],
 	return true;
 }
 
-/**
+/*
  * Return:
  *	true -	Display(s) configuration supported.
  *		In this case 'calcs_output' contains data for HW programming
  *	false - Display(s) configuration not supported (not enough bandwidth).
  */
-
 bool bw_calcs(struct dc_context *ctx,
 	const struct bw_calcs_dceip *dceip,
 	const struct bw_calcs_vbios *vbios,
-- 
2.25.1

