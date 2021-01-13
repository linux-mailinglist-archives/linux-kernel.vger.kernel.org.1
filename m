Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C612F45EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAMIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbhAMIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD88EC0617BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m4so1056069wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8/kdy25+oZx/uNDbhJDkZDT1TyOhQzo6tdoqzLeeYY=;
        b=Ix8nCYPNU/XT2iKvtKsMgQ6u2nvUKoXhtnv93uPzBrkS2d2uGV9+bwSpITZtp9gTQs
         0eqF5B+SFLW4DK9OrR2pzTeYuDKm+kIBaAYJpZjEJ4Y60fTOnEA/W7vsFFF3JmS9GRXz
         A9o9oFjFuWv/yFFb0kdM7jhQQi9YR4MaeugPWUKowTlo0ntyIEa8DV4a1wcRqNptjmHz
         5e2If+kl8VfjN/gxc9yfWSeHE1qug+jcQpHuWcM8USdkbvsDlYIeCK3bKtJgW5/FhYeJ
         HSLlIG1NpoNr7yhYIIrqePDccEjCRRt6lWY86cwGYSf8HUsXUIUxfNsun6Wxtf2b9ShN
         4iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8/kdy25+oZx/uNDbhJDkZDT1TyOhQzo6tdoqzLeeYY=;
        b=rGGHywfxy4+SMPnR1AJerOEUJP6AEO5gAR75pbhNjeYcPP1S9HNnH5ttOWLk5Of6x7
         TIn/c1hPXA6YK5vpU9IAOmUUmHCQEGdBrn7GqKErgRHLzdyx7DHg0LYH3TP2Z+IeCtIt
         mjoGxga1y+IIivgwaJokIvSrctJR/KnvdnarLG5q/wuwCFeOXVsYG6fg7tw/pNpepPGk
         K9wkhHNMnXgHbNpPyQSeVDM0ePfTQYnDQCq/8k056fAZaFuNe+TmI42C4mgMd51Z+IwP
         hSzd/XN7BvUZw40E+vyq0nB9YFERNhketS0W/btPiXnOOXiITbjOkOMF6x6LREAKMoy1
         nooQ==
X-Gm-Message-State: AOAM532VjF7RAH6fUjwQLZ2TMagj+LCu8PVl0c4A+Z9pd9m3tRZNrK9q
        kBwctrVsIM+AuWFXaw111oOLKA==
X-Google-Smtp-Source: ABdhPJyLPmAhEV8RkLWymbYSLvsMBDf3ChVGj/PjJVirElcB8p0dwnq88kAr/EkDEIB0wS4OYtyzDg==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr1178774wrq.75.1610525299664;
        Wed, 13 Jan 2021 00:08:19 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:18 -0800 (PST)
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
Subject: [PATCH 19/30] drm/amd/display/dc/core/dc_link_dp: Mark 'result_write_min_hblank' as __maybe_unused
Date:   Wed, 13 Jan 2021 08:07:41 +0000
Message-Id: <20210113080752.1003793-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like it could be used inside the DC_TRACE_LEVEL_MESSAGE() macro.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function ‘dpcd_set_source_specific_data’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4403:18: warning: variable ‘result_write_min_hblank’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3c33b8fe218e5..b9e5e0eee3d24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4400,7 +4400,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
-		enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
+		enum dc_status __maybe_unused result_write_min_hblank = DC_NOT_SUPPORTED;
 		struct dpcd_amd_signature amd_signature;
 		amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
 		amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
-- 
2.25.1

