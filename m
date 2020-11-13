Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF22B1C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKMNv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgKMNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFAFC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so9973700wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fbIgQuSd7qx2Uw2PNoVR5q/2EBKr9ikJs14+3PNgZs=;
        b=n4DRu6udIoyajnEV5cYhZElN9i8TgkAMzWGe2XXO8ZJAtYQn5MO7IMOTwcJKM7snU9
         JqPnyBnWOlcnU/T21rzOcwxuyqy/YqZQIRnFwrNhrXPMSSPdiF3vagDOA9lzf7m8sCkS
         P6upsPYAj91zk7+AQIlxbK4GxzVVMlYDAmdq7JzKe742gAi6bOyd1aJpogxYwpxPjfam
         6fh/2Jnt7GS3QFBfKuPgxTxVRHEsqcST5Z/5kex7Nd3qOzjB5szFrz1oHxHH1vSwV6nm
         JdwijeFcrJb6v608c3XTw2RKXAfMl3ruV4hyrimERbrJ75RNT8ou4IwZ4nP+zsSXYXX9
         niRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fbIgQuSd7qx2Uw2PNoVR5q/2EBKr9ikJs14+3PNgZs=;
        b=NthrM5e4uyX/qJWREB0KV9pDTPYhjJJtZBOrILeQb4VnfS0w45jTzVhm0WjXIbKEZK
         xBV8//R2+ZCKAsyoqZGPdK8eNzdbJf2NjDkfpVSHFaGXlDf3FmI09r1nhssEnqdkibyt
         +CrgEZdZfMD1ApDbZLJlVfFsEvPc02O3FB60UZzB5zz7HbIMSzYaf90gzpEmhRN6ivwT
         JsKlw5qCumxlZrXfm8WUl6q+WNViHYU/wWpvQAX8caW2ZTfMLp85Dip6F54BtjbAkkgu
         zaiJ7+Bbvbzq7K+9tYAo/gZJPDJ8H7cfZnTYqADlDu0mGSlGM9MHr/0I/gjEhHeEY71c
         XsUg==
X-Gm-Message-State: AOAM530cJGJrajV514kQUwzaL3srjlr1ixKtHyetORRvOpN0XDYE5wQ7
        CBEnjUJ76bqQ6x4nc5KB5sM16w==
X-Google-Smtp-Source: ABdhPJwRAPuVH+2vvmutSjwOa8Cia0gPuinTJS19FPHN1ooaNyDBXHTCw7kmrU3q3Z5aPZKc7t1QmA==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr3518812wre.282.1605275416485;
        Fri, 13 Nov 2020 05:50:16 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amd/amdgpu/amdgpu_ras: Make local function 'amdgpu_ras_error_status_query' static
Date:   Fri, 13 Nov 2020 13:49:26 +0000
Message-Id: <20201113134938.4004947-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1482:6: warning: no previous prototype for ‘amdgpu_ras_error_status_query’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f89a991999428..9d11b847e6efe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1472,8 +1472,8 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 }
 
 /* Parse RdRspStatus and WrRspStatus */
-void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
-		struct ras_query_if *info)
+static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
+					  struct ras_query_if *info)
 {
 	/*
 	 * Only two block need to query read/write
-- 
2.25.1

