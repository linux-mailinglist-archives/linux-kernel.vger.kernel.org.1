Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF66B2F4608
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbhAMILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbhAMIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1659C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c5so1066450wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2j2xvlvTKeMvAjdQ03/GzFSNxUFT495xm2EMvSlOnPM=;
        b=fQ5NcLvVmka8WVFVF8DEXHGDlkPDS55e/BwTL1KBk+7FfqF86JcS8D68hU+6tmFN1n
         Gsg9PcDpf7B3zPVrHJ7PVzXs6hq3ruq7R4is9h7lIyQSKqWfBHWm1sVX6EGp3842webt
         ZYyEKUVsd/NOnCsePUQOE6aD5Z9dW2fgHnDK5Nt0q+navMgiIvEF3UWIFnYrFo0jPINu
         qbxP5oOJiTc620W0S2DxUiF7zeCfYNC2M8+8b6qlpWz+Cxtqr1O9N4jrV6Z9p96uF5u0
         YJEWADvfeJ81IfirIzAKTthEivnS04jr68iT2p1Mw5TpoTV2uMiE6b/xPghq/BdJGWQ8
         u1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2j2xvlvTKeMvAjdQ03/GzFSNxUFT495xm2EMvSlOnPM=;
        b=cRzIzhCI6nMH+EE03rSVf63DBMMZzDu542QZh+NYtI8RijskXLjVh1NXT9fdkC4jzA
         rdcitLDcYlvkF6/lKDG1aDOBQiEkYywHEye2LRjm8J3bP7Odn5wKKx41LdQZ3j+B+R6T
         98FcPpPexampGLNKV8wnND003oBZo4Hq/A41jXLeQg9TBZWbc77/r9rTtEGONxC9oCzp
         K3ugTPqdSNStgKSWjW/U2yg9NT0075koZf5kplqX+iIYUT2Dl/Y3Hn02RkwN1Z+dmYcp
         bhXhZhfE+2cWAhIoHkhWliZ8sEhpk4Z913Y09zHUDIR12AVdnarui2laxWvYBv1oRfkk
         Aofw==
X-Gm-Message-State: AOAM531EFJULTL5NZPsIRsbyC0qCbdQRsaPf0VMeM7P2RsJxwzY60j4J
        g0xkw/4ICYbYZmxq9YOaLa20Gw==
X-Google-Smtp-Source: ABdhPJxnX4w3sgt74f0E69wB49NZREq27p9CdFTOlVg+5VdGuDs9Cn7/6qCnQb9gbEPh2ZGzoJJauA==
X-Received: by 2002:adf:a441:: with SMTP id e1mr1151919wra.385.1610525287440;
        Wed, 13 Jan 2021 00:08:07 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 09/30] drm/amd/display/dc/dce112/dce112_resource: Include our own header file containing prototypes
Date:   Wed, 13 Jan 2021 08:07:31 +0000
Message-Id: <20210113080752.1003793-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:883:6: warning: no previous prototype for ‘dce112_validate_bandwidth’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1008:16: warning: no previous prototype for ‘dce112_add_stream_to_ctx’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1407:23: warning: no previous prototype for ‘dce112_create_resource_pool’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index c68e576a21990..ee55cda854bf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -59,7 +59,9 @@
 #include "dce/dce_11_2_sh_mask.h"
 
 #include "dce100/dce100_resource.h"
-#define DC_LOGGER \
+#include "dce112_resource.h"
+
+#define DC_LOGGER				\
 		dc->ctx->logger
 
 #ifndef mmDP_DPHY_INTERNAL_CTRL
-- 
2.25.1

