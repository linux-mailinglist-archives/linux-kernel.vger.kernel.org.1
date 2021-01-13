Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE172F45E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbhAMIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhAMIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF046C0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y17so1048568wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrAn4+wDZmlfBR1rfJlysK73SQhLsoiqGo2tEfZCQmE=;
        b=Fo+5d2Qnx2ZvhIHxnePiJy2uCwG4UXEV5E/LYfLTG9faOdpCrAgX53+BN3qhjYq5Sl
         QoB3qT4vetWNija2BRSuV6oX/i34XcXmWM2HoW4GhBALPhJufGAJaSO/FnyqH4aEy/rF
         Z6vNyDetyvcM+d/27rEbP8ELQC/u9o83z332ZErtvVLwkO7g5/X7jAz8l7nXnswWLXqp
         kwG01D5PsS4Ynw043ZtAJPxL/7NC2Gx5c6xgx2g6EeBCi9g8xTmIRf2aXnyu7nVU58Ah
         r3v+to2Wgki43+IoH5+CD4s30vkAjvnZ/otXZ9piwHvfebS3bvaFp8JDos+MxPC4R7eD
         NROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrAn4+wDZmlfBR1rfJlysK73SQhLsoiqGo2tEfZCQmE=;
        b=f4MTqCZouTz34JNuP/jnXWZyt3XIgOC+nyphwgvl0nMdiakg9dPz8t9skRqOZvMSvo
         coqN8e5I7ad2nUB7ilPr7k+3LkNFlmqUzu4nulDIpsLcMEesTYuAZYCwAINI5kRF+pCJ
         TJu8Kdg4EVU2+N9HgyTGPTQnjkPem7yWcDkXa8gac3YlD72oWR+0EPFwPf0tZK0OLMMn
         nhaCnGX6+w8C6sa7az3ODutrd7pdwo7eZtvuizA5/aAEETEqbYHgdeZKZePRXel9khRu
         Rvcw5Siqn0GPNTWRCNc8CeG9PTquOS5N7sAiNiYaiv71PfmHCnyBDvgQmAv5peT2d7hE
         FIwQ==
X-Gm-Message-State: AOAM530uGBLJkfZy6B7YbL602Ab6MrDfSrFdVKPkv5M384fPGzHsYCHK
        /LqW97NI8E9eDapsx218E9q2hQ==
X-Google-Smtp-Source: ABdhPJyy8/ZuVen3JuzvSrrWvtQxDzlo06ukQJLOMU/yOXtlOltivIzBh7Y5Cz6RQHwaKXLXvlrgKg==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr1191861wrx.34.1610525283553;
        Wed, 13 Jan 2021 00:08:03 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:02 -0800 (PST)
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
Subject: [PATCH 06/30] drm/amd/display/dc/core/dc_resource: Staticify local functions
Date:   Wed, 13 Jan 2021 08:07:28 +0000
Message-Id: <20210113080752.1003793-7-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1120:5: warning: no previous prototype for ‘shift_border_left_to_dst’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1131:6: warning: no previous prototype for ‘restore_border_left_from_dst’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 07c22556480be..d423092c45dcd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1117,7 +1117,7 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
  * We also need to make sure pipe_ctx->plane_res.scl_data.h_active uses the
  * original h_border_left value in its calculation.
  */
-int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
+static int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
 {
 	int store_h_border_left = pipe_ctx->stream->timing.h_border_left;
 
@@ -1128,8 +1128,8 @@ int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
 	return store_h_border_left;
 }
 
-void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
-                                  int store_h_border_left)
+static void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
+					 int store_h_border_left)
 {
 	pipe_ctx->stream->dst.x -= store_h_border_left;
 	pipe_ctx->stream->timing.h_border_left = store_h_border_left;
-- 
2.25.1

