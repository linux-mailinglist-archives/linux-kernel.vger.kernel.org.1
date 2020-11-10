Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0872ADFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgKJTba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbgKJTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F85C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so4309643wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xcbh8O+/omHL2VrpacAkpBtVFmAXD+djrz0urDPaJVQ=;
        b=kLlPJRNgN1F9oKbujE00llAPCqrZ6ps66Ok/S6/KvHh1EKNq12UMi2auweIku5QZ+d
         kHgomKu/9dundePmvfQOGcT3iLzJpwwonRbLSzxLYarevW+J9jAwUduNxg5s+KKMBtIs
         zcB01rcJI9EQSfNlkP7Kz+lx5eGQyi7U35uMuSzgK4juZGPgYBVkN083Z3gQ4bksEj83
         MgScucPUFTtvTp6/SqtM/6ITyUMzS7vQsX78dK9WlKYUcs3TF+DG0c8eZ7hrua/sAJo9
         VGaE8FoAHbQc0tOPZbBtQxjA+q4Z91crPXwSM7Sol4f4JqTBUOx6t7l+5es/l4561Q/S
         pWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xcbh8O+/omHL2VrpacAkpBtVFmAXD+djrz0urDPaJVQ=;
        b=Rzyl+jEuc6E17BvVJm1fiAtkBU0mg7uBdVIgrjot8iPWGqJdL+nAwHSLOhbCBRNSXP
         fktAzfQhEvejFik/RbcZQoH//z9u0eort1zi4HmN2EDybv5pLcWfpYwqeZkG35atbJ87
         QlViqQfp7tbnqFNnpNRpgY0nWR+a6KqWFntCeAMgFbd8cd5g3o7szEHzojXGFj1NFQfu
         ftnzrpENo9lWh2/7jRELfT7hZBUUiX93w4b24DcJDRUIsRTLfsALM6FS8Z5SzBImaK7g
         KVH5SPXYMEn4olYoFGJwfsN8C87MzTVS1gMbjSrzdE+QDqQDQAlsmqmn8IxravgjDc/V
         e8HA==
X-Gm-Message-State: AOAM531tRtRTdy4wa4rl+8EEqWiq+9UVCI78Bn/KjMiU7BxYdA0s1GId
        o8ikd8+ZC62peZXC3zYFy16lzg==
X-Google-Smtp-Source: ABdhPJySXqkInVonwaPMkRY18+5DoFvbk2WPycPngEhk3/UG/GnAcOrJjZVRxfz5s/HZF8WgP6SU7A==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr669038wmd.129.1605036683897;
        Tue, 10 Nov 2020 11:31:23 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/30] drm/radeon/trinity_dpm: Remove some defined but never used arrays
Date:   Tue, 10 Nov 2020 19:30:48 +0000
Message-Id: <20201110193112.988999-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/trinity_dpm.c:146:18: warning: ‘trinity_sysls_default’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/trinity_dpm.c:131:18: warning: ‘trinity_mgcg_shls_disable’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/trinity_dpm.c:120:18: warning: ‘trinity_mgcg_shls_enable’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/trinity_dpm.c | 44 ----------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeon/trinity_dpm.c
index 4d93b84aa7397..e005c18aac00e 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.c
+++ b/drivers/gpu/drm/radeon/trinity_dpm.c
@@ -116,55 +116,11 @@ static const u32 trinity_mgcg_shls_default[] =
 	0x00009220, 0x00090008, 0xffffffff,
 	0x00009294, 0x00000000, 0xffffffff
 };
-
-static const u32 trinity_mgcg_shls_enable[] =
-{
-	/* Register, Value, Mask */
-	0x0000802c, 0xc0000000, 0xffffffff,
-	0x000008f8, 0x00000000, 0xffffffff,
-	0x000008fc, 0x00000000, 0x000133FF,
-	0x000008f8, 0x00000001, 0xffffffff,
-	0x000008fc, 0x00000000, 0xE00B03FC,
-	0x00009150, 0x96944200, 0xffffffff
-};
-
-static const u32 trinity_mgcg_shls_disable[] =
-{
-	/* Register, Value, Mask */
-	0x0000802c, 0xc0000000, 0xffffffff,
-	0x00009150, 0x00600000, 0xffffffff,
-	0x000008f8, 0x00000000, 0xffffffff,
-	0x000008fc, 0xffffffff, 0x000133FF,
-	0x000008f8, 0x00000001, 0xffffffff,
-	0x000008fc, 0xffffffff, 0xE00B03FC
-};
 #endif
 
 #ifndef TRINITY_SYSLS_SEQUENCE
 #define TRINITY_SYSLS_SEQUENCE  100
 
-static const u32 trinity_sysls_default[] =
-{
-	/* Register, Value, Mask */
-	0x000055e8, 0x00000000, 0xffffffff,
-	0x0000d0bc, 0x00000000, 0xffffffff,
-	0x0000d8bc, 0x00000000, 0xffffffff,
-	0x000015c0, 0x000c1401, 0xffffffff,
-	0x0000264c, 0x000c0400, 0xffffffff,
-	0x00002648, 0x000c0400, 0xffffffff,
-	0x00002650, 0x000c0400, 0xffffffff,
-	0x000020b8, 0x000c0400, 0xffffffff,
-	0x000020bc, 0x000c0400, 0xffffffff,
-	0x000020c0, 0x000c0c80, 0xffffffff,
-	0x0000f4a0, 0x000000c0, 0xffffffff,
-	0x0000f4a4, 0x00680fff, 0xffffffff,
-	0x00002f50, 0x00000404, 0xffffffff,
-	0x000004c8, 0x00000001, 0xffffffff,
-	0x0000641c, 0x00000000, 0xffffffff,
-	0x00000c7c, 0x00000000, 0xffffffff,
-	0x00006dfc, 0x00000000, 0xffffffff
-};
-
 static const u32 trinity_sysls_disable[] =
 {
 	/* Register, Value, Mask */
-- 
2.25.1

