Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D630E2F45FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhAMIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbhAMIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4116DC0617BC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 3so711255wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTigNPeS/IwSagktS00zXkb22HHBlzIFn5zlD1QSHzM=;
        b=n6S7Vkl2P8d/J1RWp7DDnLNoAWE8q8q/iQ1eFDk78lGCA2jU8tYfFMOj3EK88HD7y+
         atlM/WLoghnXazFqOq193WFu8mWtuGXRtoEHJUsKfpHnXnt1uIpqniOk/8FxNdi/5gVo
         JfuVm9hUCwelRLJgc09OfR0VPt3La+9m3YQy3/jCfh1veevr/12V6HkoeEeBwpTcVj2w
         L0vtwHCJd4SJmYkD0yS0gyBk8farkblBEZV5T2pZIMRXA5iWwwMgnF9yR1ry3KQs/SnG
         GPOkYtgIiY1c8073S6k9lSqsftqIE0H4g95wfNzXFcl/JzXsknpPIflktoXVrbY/lVWD
         4E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTigNPeS/IwSagktS00zXkb22HHBlzIFn5zlD1QSHzM=;
        b=AnkXGKsIYoHRys1acJlNZ0SlmkERLpef98v0BF2cfuM7D55m0y2EEaSBTjG24NDYRy
         4aapcKEhIZEwa0Zk9HUwgDfhmWYHULUsa8L2OAi36UgNGOnRpaiG61LEhAy5cTDk/x8z
         oI4gCbB8XuKyLZHn0p3k7D200M4sb0h9akyvNiSRkbY61c3qAdpBlcuXscJjz5270rYs
         4KFUpvJ64mgc4liHfJ89ly8f2Yewz3MeOfomFkb9m+es4f1uj05LXV8uQf1yIC+1ZnN4
         +T5Hbdo2KG+MAOt64SeAfeY1IU9LsmMINn8ubmooXGACGaEML0qF+bq1EQmFUamkVfTp
         XLFQ==
X-Gm-Message-State: AOAM532mcPNsDaa6CezLNni64jyYfPlMlIJrKmrOxKftdDZm7wd7vpim
        Ivcih6PwEqb3FDTTX0XtTeZgdQ==
X-Google-Smtp-Source: ABdhPJylDCzJwl/UqsQ3oiB+JV6DDLrJvs5CTUzp9kXoDj9Nx/zTSJgxRqWTyfh+ONIxqTPdBwwtdg==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr959231wmb.70.1610525297006;
        Wed, 13 Jan 2021 00:08:17 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:16 -0800 (PST)
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
Subject: [PATCH 17/30] drm/amd/display/dc/dce60/dce60_resource: Include our own header containing prototypes
Date:   Wed, 13 Jan 2021 08:07:39 +0000
Message-Id: <20210113080752.1003793-18-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:1115:23: warning: no previous prototype for ‘dce60_create_resource_pool’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:1312:23: warning: no previous prototype for ‘dce61_create_resource_pool’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:1505:23: warning: no previous prototype for ‘dce64_create_resource_pool’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 64f4a0da146bf..dcfa0a3efa00d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -60,6 +60,8 @@
 #include "dce/dce_i2c.h"
 /* TODO remove this include */
 
+#include "dce60_resource.h"
+
 #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
 #include "gmc/gmc_6_0_d.h"
 #include "gmc/gmc_6_0_sh_mask.h"
-- 
2.25.1

