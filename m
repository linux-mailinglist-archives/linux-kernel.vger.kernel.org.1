Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389EE2F1F06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbhAKTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390927AbhAKTUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA934C0617BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 3so284923wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygXlsea1j1ghgNQFnw1H978M537fO8hMkf4tF7c92PM=;
        b=l0mLo+tzQpWlBoBKL8Z4VS6/DvkWb/hffm4vC/r93BqpOCEZdmRsBfHgyK8eshU4Bl
         TRdKZu029FApVLQljGUcOiDQZOf2MNdy6xwE4jnB/A52Uhh12zl2WmZM8Z8FPQOPL2i4
         KZyFU89I2pMZkvclUC3cykkzxTJfVOawLn2G7MsvDRx5Lma4fT9Fa6NFfC7edyK+/Q/J
         DhA7oShBVnCM7dVCk09xik4NVAdIVAeLquxLdHHGFhfXjKhDoC5Nil5a4LWPhKYcAEuW
         Q5HlB32YtHtiUAAtlyA4pbNyBcRwRO7A2gXKyB7OAaTUvFW5vr/8nj7aBHHatEEvWhkQ
         brwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygXlsea1j1ghgNQFnw1H978M537fO8hMkf4tF7c92PM=;
        b=RAGMtjWwq6xLTARpZw/AvdDf/DBZap+FBUKLEGMEl/qVHmZR02uR9yBkwCmO+8EIhj
         OW+lVvR6bt4iqqLI5/Ygm47Dxkz/KhuAXdvlRYjGUTKOmbqPl7ial41CVr8TX2xQtVHG
         hXeFQTObyInaw7x1BL2VacXt/uhRZATKRlkHF8BlJrxT+RLIaAXw/6yO6Aax+T+SirFk
         S51jKU2DAxm+VxIw0cNtYqDAwRI2iMJ8zW8mFrlrujmymlMLfyRyv7P76vtjAxW0R6Nk
         +61oTxIw6Klz0ztv8h0HKNXCkSgaEMxcacR1aU9fh6Jtd463MLdEGbVS3ebIIOK7xRHA
         5jPQ==
X-Gm-Message-State: AOAM530UHK95PgJCs3sh/N7JMg4kxUs+wsR5FyEMBTQDk/56US7e7LIE
        BF0qBSEzR1PGZPvLL3tcZOaRXg==
X-Google-Smtp-Source: ABdhPJzrrPnEkqyVVOgksMUOoP+NL4WzUV16TJPxHXMKFD4NTKigi8F1CQ0Gu+lQN3c09XAbusBcYw==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr281642wmb.144.1610392791539;
        Mon, 11 Jan 2021 11:19:51 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:50 -0800 (PST)
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
Subject: [PATCH 16/40] drm/amd/display/dc/dce120/dce120_timing_generator: Demote non-kerneldoc headers
Date:   Mon, 11 Jan 2021 19:19:02 +0000
Message-Id: <20210111191926.3688443-17-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:602:13: warning: ‘dce120_timing_generator_get_position’ defined but not used [-Wunused-function]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:73: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:593: warning: Cannot understand  *****************************************************************************

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
 .../gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index ebc7d61e8bf36..d02ecb983c9cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -69,7 +69,7 @@
 #define CRTC_REG_SET_3(reg, field1, val1, field2, val2, field3, val3)	\
 		CRTC_REG_SET_N(reg, 3, FD(reg##__##field1), val1, FD(reg##__##field2), val2, FD(reg##__##field3), val3)
 
-/**
+/*
  *****************************************************************************
  *  Function: is_in_vertical_blank
  *
@@ -589,7 +589,7 @@ static void dce120_timing_generator_set_drr(
 	}
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: dce120_timing_generator_get_position
  *
-- 
2.25.1

