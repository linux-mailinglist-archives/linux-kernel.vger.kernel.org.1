Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA952F45F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhAMIKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbhAMIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69437C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a6so693108wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzSVTfnGeF4QxtWxeHYTIcFMIY4s6ebauA3+cdnRC38=;
        b=TY9K9YP3KeN4jJ31pGivkq0dF1YT54ldZJqLn6MYgdukuVkCp1zu+y0mPY6lahL/cy
         1RZcx437IV0+wAEUKVyLgcGDYpTDNEL1Ppn0vXUncrWgNbXQ1NAXE1SAV8ys9N81RnYq
         L80CoeEUDBznRtSXNf5aVJiLBgu/M3NW5YWML2KRwTpalTbHmI2lrvEOUNFIZGcJmyVN
         AN22iAp7L+Z2f5Prz8MYydOsJDYBrFjKJ6ueQI3EeMHXH6x5NltDhYkzPnWAsnjVgG1m
         3f+UnLYOmmG+9ZtdtXLtJus/mi94hGo7N9uqHpmNiDUIXrk0xJ0Ap+OMgc5sowuOA4BC
         Xa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzSVTfnGeF4QxtWxeHYTIcFMIY4s6ebauA3+cdnRC38=;
        b=FX60NHJk0WDpBU0kYgt0aus6rbV3rEDCWW2XTytPjx9JZmYXslTuPUN+W0h1ywXKmA
         spuEoYZ2s7xSPbQGuo2AkE8lA97UydYrGbbp9Ngmi/3KGFgmBib8qSyEwpXsTgKd1cwq
         eDoZ+H0SR262pUNcYcRjf7paQDtPAgTnhKSh692d/xf5bX7qgbp9zYba/+Nnpd4mE7kF
         m/BdWDxvS0VRNKfnMIguxFzYDOkKkPzqlB0i7yP+9Hd4PvN/PjemOH2zwTBfeishv0A1
         hya0+dKlANZn+UmWb3fY9bdy/e8kpJqdsoMCgnfem9JnmB8GLZeRLEtRje+ucLhkkwfl
         yR+A==
X-Gm-Message-State: AOAM530ddDNw0CVg15jQo7YYU2hjWf+ATY5OjnsF6A4aOwpYNnDN049T
        fR7UWEuFyIjJ2eKrv66J3VTLkQ==
X-Google-Smtp-Source: ABdhPJysnmI+q/9hcXh4YnGhQ3w5WlvU1D7CpFhRu8UDUu/rw7x3VueRmXRn3MgpQ7OuewfpCDNVGg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr939751wme.189.1610525298154;
        Wed, 13 Jan 2021 00:08:18 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:17 -0800 (PST)
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
Subject: [PATCH 18/30] drm/amd/display/dc/core/dc_link: Move some local data from the stack to the heap
Date:   Wed, 13 Jan 2021 08:07:40 +0000
Message-Id: <20210113080752.1003793-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function ‘dc_link_construct’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:1588:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]

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
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8ccda8b9ac2eb..3366a49f11dc7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1364,13 +1364,17 @@ static bool dc_link_construct(struct dc_link *link,
 	struct dc_context *dc_ctx = init_params->ctx;
 	struct encoder_init_data enc_init_data = { 0 };
 	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
-	struct integrated_info info = {{{ 0 }}};
+	struct integrated_info *info;
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
+	info = kzalloc(sizeof(info), GFP_KERNEL);
+	if (!info)
+		goto create_fail;
+
 	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
 
@@ -1532,12 +1536,12 @@ static bool dc_link_construct(struct dc_link *link,
 	}
 
 	if (bios->integrated_info)
-		info = *bios->integrated_info;
+		memcpy(info, bios->integrated_info, sizeof(*info));
 
 	/* Look for channel mapping corresponding to connector and device tag */
 	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
 		struct external_display_path *path =
-			&info.ext_disp_conn_info.path[i];
+			&info->ext_disp_conn_info.path[i];
 
 		if (path->device_connector_id.enum_id == link->link_id.enum_id &&
 		    path->device_connector_id.id == link->link_id.id &&
@@ -1584,6 +1588,8 @@ static bool dc_link_construct(struct dc_link *link,
 		link->hpd_gpio = NULL;
 	}
 
+	kfree(info);
+
 	return false;
 }
 
-- 
2.25.1

