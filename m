Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4972C3112
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKXTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgKXToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:44 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE91C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so23613306wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKoWa37FzxxsWJDJ0MjgjJtMQHB06cJSx0w1D6sy2RI=;
        b=tdG+cicDEAw8D+/7A8LyoPxQlBhMODERMVzTZCPgy/dm9V6881vT914p6mw6lXskD5
         3ArdWa/noQjV+k4cQYkDPPD8/3gajo2kj0e2GNNtWDOVy2I7bG89rNmzHSU4ZtgoWU+q
         LnWmy27kyREHd/yLaic4WQeUwzBE7q9DRiMrsWgsdjDJDRtYj+Y7N2EbpALNPel9cQly
         2sv6/r2wFhrQMTcol2pmHaDSXwN848CyPzUC2OgzAmqXdXNJdGwCyP1Z6G4HNYheL54h
         a/lyERd/d3ymrIjCN7uGkTGg9s8qVnG//aYFyvz/eGIA9oug2tTU1S5AUQJJd4uvMqs7
         rJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKoWa37FzxxsWJDJ0MjgjJtMQHB06cJSx0w1D6sy2RI=;
        b=m6/9y87sTMyaDsL1tkP1zfdnlDTODrwQfd54gR3gd+tBgZ7O13X+J7HocCfyWpcJ7S
         tpmHvjFd55atWMU2PKQCZod0D14FW+qRM5hSC8DjStrtkAlA3ONWTsB79b8FMFi+Mgbm
         JdU08hUxDN/I4yJRABhGxfJ5LSDCd2CB/qey83gzg9ix3SaBJ09KZDsRjezsdvYal0PE
         vOD3waji7wMbGeLP2UhvXeA35+BvRArA588dwR6fEhXQ7Kt8Myhz51LtAhb8jXgGi443
         N78VJ5nEcQ+biM/XuzQr9DkkiDF5KhbxnCvHTtK5qyn2U/vKejPXFV25QuMOxYCw8EKB
         t1eQ==
X-Gm-Message-State: AOAM531zpGbxj1AGs/xzfj+1yDeY+8j1gAZNULGVeageQttvt9i5bH/M
        RA96rVepfjLjhbOEaVS8+pGOC4M26EPoqIxI
X-Google-Smtp-Source: ABdhPJxEBa3RxG2cITK6ou296ZYyJhuQV6fQvAnP/c0MakF1oMc4IzcvdIwOvtz/0wRETKp74r+fPQ==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr62965wra.247.1606247081538;
        Tue, 24 Nov 2020 11:44:41 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/40] drm/amd/amdgpu/amdgpu_acp: Fix doc-rot issues pertaining to a couple of 'handle' params
Date:   Tue, 24 Nov 2020 19:38:18 +0000
Message-Id: <20201124193824.1118741-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:183: warning: Function parameter or member 'handle' not described in 'acp_hw_init'
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:183: warning: Excess function parameter 'adev' description in 'acp_hw_init'
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:412: warning: Function parameter or member 'handle' not described in 'acp_hw_fini'
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:412: warning: Excess function parameter 'adev' description in 'acp_hw_fini'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 1400957034a12..b8655ff73a658 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -176,7 +176,7 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
 /**
  * acp_hw_init - start and test ACP block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  */
 static int acp_hw_init(void *handle)
@@ -405,7 +405,7 @@ static int acp_hw_init(void *handle)
 /**
  * acp_hw_fini - stop the hardware block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  */
 static int acp_hw_fini(void *handle)
-- 
2.25.1

