Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092042EF8E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbhAHUSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbhAHUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B52C0612FE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n16so7358897wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwsQ4P/R4DdLdAB3mC1JWRMOEYxyTXQ+mvrg/Opzxxc=;
        b=mCIOoMf78yv6vZZRz9P4wRu711vAOmJTwcFZoHf9+OnpmMqUsDtTYQIRLbXprNM/2H
         4UfuwGilLCVSnL0T33A638w9j5Plzpi5879F8q0wGGeRbuXHv0g3Mc5tBd5TyblfbsHZ
         7a0sEXSkfnc2IwoIsWbQgXKSJWupcPEyeD8QaKNxMSonEX6o1yjMoRMbb9DHohKA/wiK
         Bk+bXH5mp0I9WKSr/u7LGmoYrJWvVuUDHMMrEFUPRI2MMhnnJVNzCl4eAAgVZW6f29fu
         M+DxM1w1qHWhwYyNjb7nHLliZ6TWEeRMvqCoMYvv86Z4/hpX2Vj23HE9Ii5cJ+rAcOoO
         9Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwsQ4P/R4DdLdAB3mC1JWRMOEYxyTXQ+mvrg/Opzxxc=;
        b=jRYLPBR6NCA7nW+/hsrx8vCBg4apluYVIFtfbgq7dCrzieGtcovgw6UX+6JWX76NK7
         TLrL13lWxj9R8quVpe1K7fhhCood1lhJnccJ/4MBjiIbIe3lk6P1Jk1x3u1CAF8aln+l
         od3zwN6yz45flhnpSlI7WlCrg6gO4Xx4SBruANX/Li9S8IYjgFxm+zFu9Tpq+l9OqrBF
         uYg0wj9COz0CInVq8k1LQ51nXojNJE+N+Xfxf9pFUQYkP0Sy6O21rA0psq//Z/g3EvJF
         +5s6NmCF75mePIbAiC5BGB6JPxe5kNVJ1GdQlFhRzwftBbHvmqHs5666uMymHbJo4Y7J
         Nwpg==
X-Gm-Message-State: AOAM532pcaLASRZJjpSGn1JwxmhJcQPT96D/BDHSc1xN8Wy8fIFBODRq
        Gua6XFyvG7bTzdiKbdMwZSUIyw==
X-Google-Smtp-Source: ABdhPJy+Lr8kUWX17Jvzqd3IxXYZTLMuFMjKsnONPcmtEtBYoEgAkGevIdlNvhYFsgo0i/Ef03nXvQ==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr4491346wmr.162.1610136950667;
        Fri, 08 Jan 2021 12:15:50 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:50 -0800 (PST)
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
Subject: [PATCH 32/40] drm/amd/display/dc/dce/dce_aux: Remove unused function 'get_engine_type'
Date:   Fri,  8 Jan 2021 20:14:49 +0000
Message-Id: <20210108201457.3078600-33-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:391:25: warning: no previous prototype for ‘get_engine_type’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index cda5fd0464bc5..3204292a5aeae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -388,12 +388,6 @@ static enum aux_channel_operation_result get_channel_status(
 	}
 }
 
-enum i2caux_engine_type get_engine_type(
-		const struct dce_aux *engine)
-{
-	return I2CAUX_ENGINE_TYPE_AUX;
-}
-
 static bool acquire(
 	struct dce_aux *engine,
 	struct ddc *ddc)
-- 
2.25.1

