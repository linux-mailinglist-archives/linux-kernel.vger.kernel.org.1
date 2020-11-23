Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D12C0406
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgKWLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgKWLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF537C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so18210684wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92lYcVhCJmrBtBX57wzHE1WdwDpEBe0J2p2RduAzKmY=;
        b=tyD96b5E1MNVsARdONjKjj8lmiQOPG6HZ3J3yYA1X4O8NytzLWdgQ3BBX81GdNztUl
         MCz53tT3e5DvsGOFVHSrLS+yMgZJbL9BqRG7mblwgYdUSS6grX3F6O5StAdtIkZDKP8g
         he1etgev1uTEcr+qss2qE0ldGmea0gH2u3G5JwBLWNf8NXLw/tJ/8nP63Rji6V42Ddv0
         CTgUcts+FDVic+ESjPSXDj3UbnTuc4NRq5pR/45zmFx0tu3zVBH8WqlUSSLD1qlhvd/F
         78H+/sQ+C4P4NLchyX10tlytKAgUWja4o7e6KZTTF83WvHiKFSBFIoyKHqSvRTD/dNuv
         2dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92lYcVhCJmrBtBX57wzHE1WdwDpEBe0J2p2RduAzKmY=;
        b=JALwmUHB3DZ2l++484zSTSg4wKd4hdKRuvjx1e4to68TpAQiB+hBOJVvM5DLFmkaqH
         GXv1WyxdtMxIzCLMgYWPkkzqAa+DgelW7GjCK4Wt2h49WE/xXXzPdJabJ0gcrDxC1xBr
         +B4QOu+S04izH+aYaj2nYR5zkDNSNgH4byX2U0VI+IOza6FnG4iO+G/b0vYCjIDQ2VYh
         Tx6mGf02czVGBlE5vfIpTu/AwGwfqCCERyvOGXjwQnHv4KChh8kk2LLQX/4YNoIU1kbt
         u096xh8rUSXJ/buy6G5DaxKEvV74L2dne1FzCqfZZGOBKc48YsPpkIUrnabLDBd0yvox
         HyHQ==
X-Gm-Message-State: AOAM532U5BsHVdzY4mFxBOYQlI0SOly8ITnEhhtdv51nXJ0UIaJgyMVH
        1z1CczCofcU+xCCYnFWFN2NmFw==
X-Google-Smtp-Source: ABdhPJxcFX2r+8zpTqB0xgdePYGFbP22M8rI4oqeupSBv1b98mkYBBpmFJ5H9NVGiGoalECnVCPurg==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr30883095wrm.275.1606130370615;
        Mon, 23 Nov 2020 03:19:30 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amd/amdgpu/uvd_v4_2: Fix some kernel-doc misdemeanours
Date:   Mon, 23 Nov 2020 11:18:45 +0000
Message-Id: <20201123111919.233376-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:157: warning: Function parameter or member 'handle' not described in 'uvd_v4_2_hw_init'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:157: warning: Excess function parameter 'adev' description in 'uvd_v4_2_hw_init'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:212: warning: Function parameter or member 'handle' not described in 'uvd_v4_2_hw_fini'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:212: warning: Excess function parameter 'adev' description in 'uvd_v4_2_hw_fini'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Function parameter or member 'addr' not described in 'uvd_v4_2_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Function parameter or member 'seq' not described in 'uvd_v4_2_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Function parameter or member 'flags' not described in 'uvd_v4_2_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Excess function parameter 'fence' description in 'uvd_v4_2_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:513: warning: Function parameter or member 'job' not described in 'uvd_v4_2_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:513: warning: Function parameter or member 'flags' not described in 'uvd_v4_2_ring_emit_ib'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index b0c0c438fc93c..2c8c35c3bca52 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -149,7 +149,7 @@ static void uvd_v4_2_enable_mgcg(struct amdgpu_device *adev,
 /**
  * uvd_v4_2_hw_init - start and test UVD block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  * Initialize the hardware, boot up the VCPU and do some testing
  */
@@ -204,7 +204,7 @@ static int uvd_v4_2_hw_init(void *handle)
 /**
  * uvd_v4_2_hw_fini - stop the hardware block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  * Stop the UVD block, mark ring as not ready any more
  */
@@ -437,6 +437,8 @@ static void uvd_v4_2_stop(struct amdgpu_device *adev)
  * uvd_v4_2_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
+ * @addr: address
+ * @seq: sequence number
  * @fence: fence to emit
  *
  * Write a fence and a trap command to the ring.
@@ -502,7 +504,9 @@ static int uvd_v4_2_ring_test_ring(struct amdgpu_ring *ring)
  * uvd_v4_2_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: unused
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer
  */
-- 
2.25.1

