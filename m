Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF18B2C310D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKXTol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgKXTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A3C061A51
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so23519494wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgOzBuuv3Jikb13WPcU5VqKxn6O8S32Q4jFud76gOBY=;
        b=C31HmePJH9fwXRu4PMXkQBi28Jm+EKtUPkBVoGtuKmPZrUEHdvfFA0SNuyZoJEhWJf
         ukx/7EzIYQOSqR7rx2lI5u8Toe2HjUOEgdoBxZUyR9JFURHqPSnoZC/xx9Td0wALFPzL
         tmm9UDtZ4D05b09ML14NjkYX+RID1E5nYnkvDT0BUAsdgRc0pM0BtxQyC03dXygKVNuX
         5ZmC9uYoEgbvEZgsbKPDI5RaW4JPrK41NUULVKZkmP8/KHLZORfZMJABVk4AwN0Y6RJU
         vDUXFWM1NpwnXd9g4ObU5wJEEO5ZsOSF+GOSbSkCCuD3w7fjyPftIR7Sh7dDkvSsBrCA
         7DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgOzBuuv3Jikb13WPcU5VqKxn6O8S32Q4jFud76gOBY=;
        b=dPr1XxRsI6FEU98eErWwCAXnde3Jq5VEY6ZnsbvSto6kuUhlE2+c2kooAFWoNTSTWK
         ba1FgrRsCkb+CAujRKYdPBPwFm9032vvY4CW0mJJv+1pxCNlN+uLoy7XMiWa/Tah6WbE
         ZxFoBlz12jdyElicHCQJGC5hJGXqJm8nu70+nMXNLVrO700zzrUA2lg+qNMngXPo7lrl
         9+8aV/GjcSZ4zS8DgkTyFLkbUo22mVWQnlZB3C8Lx+yOq8Uvj2cT8FJMIhg9IlbTeJJr
         wttwlZu3MGcwsP2x4Zj3VA0Q2ZRUZDu6rG9l3/QI+i55w+VTbMGWP4NgM44H3Jj1YMLy
         RK7Q==
X-Gm-Message-State: AOAM530Ex/BoVrOJjOHEMQQ8/N1Ajdp62LEPFMFxsUmEickuAgTTbo7k
        IonvrZbRMo1wdETttfSiAz8P/Q==
X-Google-Smtp-Source: ABdhPJxd3sekPz4U3A7PJpsQZ6XE0HNuR1u217eWTC8yIwc6lnsUUeCB6tS1yBief0VV60JVv8gEqQ==
X-Received: by 2002:a5d:698c:: with SMTP id g12mr117320wru.36.1606247064149;
        Tue, 24 Nov 2020 11:44:24 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/40] drm/amd/amdgpu/uvd_v5_0: Fix a bunch of kernel-doc function documentation issues
Date:   Tue, 24 Nov 2020 19:38:04 +0000
Message-Id: <20201124193824.1118741-21-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:153: warning: Function parameter or member 'handle' not described in 'uvd_v5_0_hw_init'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:153: warning: Excess function parameter 'adev' description in 'uvd_v5_0_hw_init'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:210: warning: Function parameter or member 'handle' not described in 'uvd_v5_0_hw_fini'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:210: warning: Excess function parameter 'adev' description in 'uvd_v5_0_hw_fini'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Function parameter or member 'addr' not described in 'uvd_v5_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Function parameter or member 'seq' not described in 'uvd_v5_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Function parameter or member 'flags' not described in 'uvd_v5_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Excess function parameter 'fence' description in 'uvd_v5_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:529: warning: Function parameter or member 'job' not described in 'uvd_v5_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:529: warning: Function parameter or member 'flags' not described in 'uvd_v5_0_ring_emit_ib'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Nirmoy Das <nirmoy.das@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 6e57001f6d0ac..3a748ec58bec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -145,7 +145,7 @@ static int uvd_v5_0_sw_fini(void *handle)
 /**
  * uvd_v5_0_hw_init - start and test UVD block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  * Initialize the hardware, boot up the VCPU and do some testing
  */
@@ -202,7 +202,7 @@ static int uvd_v5_0_hw_init(void *handle)
 /**
  * uvd_v5_0_hw_fini - stop the hardware block
  *
- * @adev: amdgpu_device pointer
+ * @handle: handle used to pass amdgpu_device pointer
  *
  * Stop the UVD block, mark ring as not ready any more
  */
@@ -454,7 +454,9 @@ static void uvd_v5_0_stop(struct amdgpu_device *adev)
  * uvd_v5_0_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
@@ -518,7 +520,9 @@ static int uvd_v5_0_ring_test_ring(struct amdgpu_ring *ring)
  * uvd_v5_0_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: job to retrive vmid from
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer
  */
-- 
2.25.1

