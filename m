Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4C2EF8D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbhAHUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbhAHUQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC581C06124B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d13so10098099wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tI0M520Tgf6Y/taglfeuNx5F4TLLe4OwvIOR0TyXZnU=;
        b=xw+bWeaEAWYrLVo8JxLnuBuwmxbi1iNsGy74mXZlvGNQ6Azts3YZMI9w5upfCOF1Tv
         ueejiFcYOTXV6jCZekcU8peSlcaVLVQR40i6N5WOK9qCJDOKgh6i5k+Ga3zjF4FmDOh7
         YJT9ZbCtfyjv1dNcHC3TxSyqBmoN65o2gglwSmZAUODShuenX/YQTTDETct5ct6hQf2h
         5YqNt9G1X9GUf8AmiY5eYEEW2GiZcPuiwUDJFHVOS6tCpZoWjAOOOHanmL9q2j2LyUGD
         R/vhENw9F8tYjeE7VhfKmnFgFBaK1ft6esGzXdO3uvtaj2eBjk6SEYx4KZc3erYgr6nd
         c4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tI0M520Tgf6Y/taglfeuNx5F4TLLe4OwvIOR0TyXZnU=;
        b=ZbCd0A+IS70ucbkauQWlrRw53iKTqOUUsYnBKLoQU7j+9vB5bbyJ7qQaSaIGrlgrnr
         aS3UUNgFjrn7JlQqSAhDsQ0+ZmVY/l3imDEbZOkQTJoJqAlTQXtqDM02Ef4NJFF7F08W
         niVfNmn3M7gwNvemXeYdurko24DoUFG07rIo3FkeA3VxH18Z+cpFPBn81feH9+eyO9V2
         +MoqYdWXqP0XCKSVxS/aT/LaaDwZQAXvXPsbiMeYpu7yn2dEC3xwWISCxP05jabkd6VJ
         XJ/Ub8vzjAcFKy43iZsICJwMRPH6XLW6+9qrbFLxxoN16+JzwJAdS331DnrMx2lpEQdY
         kTag==
X-Gm-Message-State: AOAM532BzELYXWOjsbSo/zFiQco76rQGY0MZxNWaOpXS6iBbqdfOY+dw
        5iFvPy6h3b7PxNyyQBYX7kabvw==
X-Google-Smtp-Source: ABdhPJxCcw9Go7KcofC8FWaXvzbEXL0ut2OABm6WXFyyinCLRrroiqPvn7NOS8nrmWo89ywhbppXag==
X-Received: by 2002:adf:e590:: with SMTP id l16mr5282481wrm.294.1610136956461;
        Fri, 08 Jan 2021 12:15:56 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lewis Huang <Lewis.Huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 36/40] drm/amd/display/dc/dce/dce_i2c_hw: Make functions called by reference static
Date:   Fri,  8 Jan 2021 20:14:53 +0000
Message-Id: <20210108201457.3078600-37-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:438:35: warning: no previous prototype for ‘dce_i2c_hw_engine_wait_on_operation_result’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:505:6: warning: no previous prototype for ‘dce_i2c_hw_engine_submit_payload’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lewis Huang <Lewis.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 7fbd92fbc63a9..a524f471e0d75 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -435,7 +435,7 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 	return dce_i2c_hw;
 }
 
-enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_operation_result(
+static enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_operation_result(
 	struct dce_i2c_hw *dce_i2c_hw,
 	uint32_t timeout,
 	enum i2c_channel_operation_result expected_result)
@@ -502,7 +502,7 @@ static uint32_t get_transaction_timeout_hw(
 	return period_timeout * num_of_clock_stretches;
 }
 
-bool dce_i2c_hw_engine_submit_payload(
+static bool dce_i2c_hw_engine_submit_payload(
 	struct dce_i2c_hw *dce_i2c_hw,
 	struct i2c_payload *payload,
 	bool middle_of_transaction,
-- 
2.25.1

