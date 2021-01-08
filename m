Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB42EF8E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbhAHUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbhAHUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACBDC06124F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d26so10110690wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0Y2D14a+N1/DuGk1xLenDRRTJldnnwxnydDJYRlWZ0=;
        b=ii7134gA7Vw7PgBW2x9F5/fqdzcg9nwOHhEMgmTAPmloKouSet+Yv0Eh112bhn7tC8
         TsDFdsCmlo+upGbISJMmApS5v1F75lRJVXN/zBKixEhYHpU1ypv6LYXY7uKFXgz4hepX
         7MUTHY7finxZpnnkLpsLtHwGg3W4F5uah003asbdtFKBjR49ndtHUMOaGmzR7WKXkScz
         seeNxJKr3QNgQsJOsLOL+0eQb3NSDpD7LOfZuPb1p/pjFXQOSpGjFbk7/UM4Un6rAmPm
         bmL9pQ+p4ZIPy/wf00QO8fA+JT3rzOpDgjfbOGxNc09wvJJhZVLi7c67wJ80NU3LrqOC
         fqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0Y2D14a+N1/DuGk1xLenDRRTJldnnwxnydDJYRlWZ0=;
        b=udzyKCIb5nl1fKA0FXEX/YhFNFvfHu5UUUhmnNEWpmHOEeXI3dXFAA6ZHvZUXNIQYh
         8H60nJmeDjvMB2DPL9hl+joYDY6/A+p45C2kN5FbLK6R7wn+QMo0R2IZSadF4zIAWtKs
         MeH3pbiZ9ZwAsKG4oywFgQA8A9z5Bl8xmvtIjAkLbH+TSIu5lFcR5pvcLgxKlwh5UMGB
         E8DjwbnRAoFZoTJXSfvvc7nssjv8HUppS35HWSu7DsKAjY4lrFng1/D++qQ7CSzpzcvI
         bLIKa19Lt0IWsrYNzKrapLi/w1vz6xK3B9vfoWE2vDAthdE2dSqs0x6cxvhcCUAsRxpd
         gbAQ==
X-Gm-Message-State: AOAM532PqNiRuj67oD/1g/1DpfV6p8JWM2fe06p4XJzVvvVUQIEdI8TV
        wHBdMXufQfXO1GALMuhrAjZuJg==
X-Google-Smtp-Source: ABdhPJwObQg4aMosXHGQaOTSPoyOU7tGYOlZDfP2HLlLOeKLNOkWLbj09CD2lTH55byrdi5rkELOAQ==
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr5461472wrb.28.1610136957815;
        Fri, 08 Jan 2021 12:15:57 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:57 -0800 (PST)
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
Subject: [PATCH 37/40] drm/amd/display/dc/dce/dce_i2c_sw: Make a bunch of local functions static
Date:   Fri,  8 Jan 2021 20:14:54 +0000
Message-Id: <20210108201457.3078600-38-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:342:6: warning: no previous prototype for ‘dce_i2c_sw_engine_set_speed’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:356:6: warning: no previous prototype for ‘dce_i2c_sw_engine_acquire_engine’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:400:6: warning: no previous prototype for ‘dce_i2c_sw_engine_submit_channel_request’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:443:6: warning: no previous prototype for ‘dce_i2c_sw_engine_submit_payload’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
index 87d8428df6c46..6846afd83701b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
@@ -339,7 +339,7 @@ static bool start_sync_sw(
 	return false;
 }
 
-void dce_i2c_sw_engine_set_speed(
+static void dce_i2c_sw_engine_set_speed(
 	struct dce_i2c_sw *engine,
 	uint32_t speed)
 {
@@ -353,7 +353,7 @@ void dce_i2c_sw_engine_set_speed(
 		engine->clock_delay = 12;
 }
 
-bool dce_i2c_sw_engine_acquire_engine(
+static bool dce_i2c_sw_engine_acquire_engine(
 	struct dce_i2c_sw *engine,
 	struct ddc *ddc)
 {
@@ -397,7 +397,7 @@ bool dce_i2c_engine_acquire_sw(
 
 
 
-void dce_i2c_sw_engine_submit_channel_request(
+static void dce_i2c_sw_engine_submit_channel_request(
 	struct dce_i2c_sw *engine,
 	struct i2c_request_transaction_data *req)
 {
@@ -440,7 +440,8 @@ void dce_i2c_sw_engine_submit_channel_request(
 		I2C_CHANNEL_OPERATION_SUCCEEDED :
 		I2C_CHANNEL_OPERATION_FAILED;
 }
-bool dce_i2c_sw_engine_submit_payload(
+
+static bool dce_i2c_sw_engine_submit_payload(
 	struct dce_i2c_sw *engine,
 	struct i2c_payload *payload,
 	bool middle_of_transaction)
-- 
2.25.1

