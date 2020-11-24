Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A98A2C313B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgKXTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgKXToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1256C061A51
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i2so4501808wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FuE5YjSJzJI/M1RwfuDXt/n7B1wD8+1e0nH8PA2AEy4=;
        b=Rx9agVcbDlYfV56teggpfSalWJve64s1Kw/hncpiAqgMm+aBS0xzV7FVdksDeDAxMS
         w4qNTgYOtKMbhHzSZf0GbZUvDGQvQDp7kD6qQ4rEemO/k6ZAeeqDYqcnwFXuBwf9PRr5
         cUIn/3NZs26RM98dauvvAMtXZUrwXq0gSo3HwoZgola+LlDzmPIMm7EiDgjUJnn+J27Z
         +GI/Dj19rZ2ok377NBLKf7l1ChRWRIXgaUF3pxHFnpYBAkqqgxxnjPXrwRvW5Nz8nQLN
         YB0Ulv7R5eN07q87F5Bq/AFjwOJGcspCsh6I8HM01549N+/oNeF4yHumttUL5Tzr2YqZ
         N7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuE5YjSJzJI/M1RwfuDXt/n7B1wD8+1e0nH8PA2AEy4=;
        b=VcDGlbUTeAuqOqaaVbDxb6GRh8RzuXQyhRDV4BtK0dFxNjcpM19KvSWjj5BXEJYj4M
         FYkfiZI8H3pakh+iJcCiQ3jZgPRqbisKMF5JmxOG+y0xSm+BuCKxGubM0kp5Qc72ki2x
         dhUYg1TmrOAwB7U2Ggc0U6aHLnCuvH5zintJ3ByDSaYaJAv8yjAlra7bQmN0VoXib1mX
         NyNKsjDmvmMODp94S4wgm/Kqgdh7H24Cx572NM72E4dBgQ0i5lNbYSR5t9+T7BAdNKXB
         XH+zMV4lSrE8vZbYIMLsHaHcvdCHs46cmFn6OvdXBRtGuALLCTo+cZE65zDMQb0Sv4bV
         v8xg==
X-Gm-Message-State: AOAM530cx/e3O9DujAFpdZV/SAlHleq8QQOK40CQ6f+uQUBPJIiT8N8u
        IY2c/2AAbJCgJttHaX6n/tFoCg==
X-Google-Smtp-Source: ABdhPJwDCyWQlpk/Iszt8GAowASRp1u6blUya1UNc8Kau6+NzQpXYMjrYXwTnerj7k4huU/Yw4IQUA==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr65170wrh.205.1606247057491;
        Tue, 24 Nov 2020 11:44:17 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 15/40] drm/amd/amdgpu/gfx_v8_0: Functions must follow directly after their headers
Date:   Tue, 24 Nov 2020 19:37:59 +0000
Message-Id: <20201124193824.1118741-16-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3698: warning: Excess function parameter 'adev' description in 'DEFAULT_SH_MEM_BASES'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5e6d15f44560a..9a905531f8377 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3687,6 +3687,7 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
+#define DEFAULT_SH_MEM_BASES	(0x6000)
 /**
  * gfx_v8_0_init_compute_vmid - gart enable
  *
@@ -3695,7 +3696,6 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
  * Initialize compute vmid sh_mem registers
  *
  */
-#define DEFAULT_SH_MEM_BASES	(0x6000)
 static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 {
 	int i;
-- 
2.25.1

