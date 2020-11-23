Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E412C046C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgKWLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgKWLTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F7C061A52
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so18211684wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wldsqjpaFVDFoYgF4DYJ7wI1w74XU6uKcd1AqstflIg=;
        b=j2lpQSm4QAruRHwdMh9MeGZIC4kPQ82NerLc4fhX1Bf7ALSDHI5+t4h/QNS+ETUlkP
         Oc0ibH/V0O5O1c3FC3j5OXzmPUqRr9hDN829yi5pqtPFDwVbfrnW3SnegJl6K/xqflq/
         7cv3kQf3peWq0HBjW8kRrH1PMz7wRm+kNtLf1Q5A8IDR3OuihiLFyjl2GN7VJraUbohg
         c7Kn0VF2HguehowbndbNIUhMlyJv1A9XAVuBA3ozsUiqXFLfq6qlZr2eFDpFmChxIatw
         WlIJQhIOb2zFNvbP+nwZOsSV6Km0QodzzixeR1P/WvdhBx1dFeoaIIN6HIgM2+vD+p8k
         H+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wldsqjpaFVDFoYgF4DYJ7wI1w74XU6uKcd1AqstflIg=;
        b=on0UWBjM93hKxmNJ0aA4I98Sxpos8X3gvzuMVjX2FKMA71AGbpLSLJ65sqs3ilTb1C
         YDIKvW5iAPXKpr79jeoPRKiAL/FPJ7mHuBOodvUzY7ZcB2h91M+HM2pXcSldeRxQ7ytZ
         g1G8CjBwWUlG+cNwSB3j1XJTcTTuINm2Dbn/SjaVN7cU4JKtvvV/qL0EVI41HmSequft
         b41RkwI+qyyKBAXL54vnbTfGeiM6CB5T756gFr6WByBlR+ftkACcx6bNQZXWmXJ4sQhK
         A1AEgAvvnMQEkWhbYA8BFhER9va4NxcqLvoyjoHEQ/15799DF6HAxowsQXq13jvncaeD
         P9mw==
X-Gm-Message-State: AOAM530kbQ54GqyX1kU978TWWKRNhFTcb3Iatl0KPhglD9NeiTp3MlkC
        SlNp0AOo0iiexcSjOJ35lvm7sw==
X-Google-Smtp-Source: ABdhPJzkQHLFLDVqk8bBYOGQlRNcxZJ2NJUnUeOlCzkzous3GkJECyu4+omxNzV9wQBqsYx2tYgfkA==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr9164383wru.260.1606130389281;
        Mon, 23 Nov 2020 03:19:49 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sonny Jiang <sonny.jiang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 21/40] drm/amd/amdgpu/uvd_v3_1: Fix-up some documentation issues
Date:   Mon, 23 Nov 2020 11:19:00 +0000
Message-Id: <20201123111919.233376-22-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:91: warning: Function parameter or member 'job' not described in 'uvd_v3_1_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:91: warning: Function parameter or member 'flags' not described in 'uvd_v3_1_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Function parameter or member 'addr' not described in 'uvd_v3_1_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Function parameter or member 'seq' not described in 'uvd_v3_1_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Function parameter or member 'flags' not described in 'uvd_v3_1_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Excess function parameter 'fence' description in 'uvd_v3_1_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:625: warning: Function parameter or member 'handle' not described in 'uvd_v3_1_hw_init'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:625: warning: Excess function parameter 'adev' description in 'uvd_v3_1_hw_init'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:692: warning: Function parameter or member 'handle' not described in 'uvd_v3_1_hw_fini'
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:692: warning: Excess function parameter 'adev' description in 'uvd_v3_1_hw_fini'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sonny Jiang <sonny.jiang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 7cf4b11a65c5c..143ba7a41f41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -80,7 +80,9 @@ static void uvd_v3_1_ring_set_wptr(struct amdgpu_ring *ring)
  * uvd_v3_1_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: unused
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer
  */
@@ -99,7 +101,9 @@ static void uvd_v3_1_ring_emit_ib(struct amdgpu_ring *ring,
  * uvd_v3_1_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
@@ -617,7 +621,7 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device *adev,
 /**
  * uvd_v3_1_hw_init - start and test UVD block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  * Initialize the hardware, boot up the VCPU and do some testing
  */
@@ -684,7 +688,7 @@ static int uvd_v3_1_hw_init(void *handle)
 /**
  * uvd_v3_1_hw_fini - stop the hardware block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  * Stop the UVD block, mark ring as not ready any more
  */
-- 
2.25.1

