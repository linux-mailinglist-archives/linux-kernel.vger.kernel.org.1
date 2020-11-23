Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375E2C044E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgKWLTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgKWLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:46 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:45 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so16874883wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1fDlpcchEE8sJt9jBofLY6dgEAvbjxCo2YFiogOR0A=;
        b=pMKJZWqnGQ4EOGsM3m2PkBJTgPkL3qByu1IMOQ0X/arVLPTbGxxWRx1SJeEo/Ph48O
         vVN2QUHMHY9L5b9Rv/C5Ba4yptENb7hnEe1I/jE4i4Cq6aS4NeC8QCpdTbtz9RAC1WPz
         s8FUUBFETfQI9vuV51nSZ69uOd3k1WSU4j338+SMe1Exv4mLTQRtZDisLhXlftvz9ELl
         3nH/hb2pcU/WElO4+fX5n6PwzZP3Tsf+a68dcWx2p5DY+CHRkWvpfRNEOgXXhXCd7UPy
         1UOO0uiqnYk4FYrHawRONEioF2QOYeJpBxWk5AE3zznY6mfgbWWNvjt2+xPWlJ3Tp7Xx
         XEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1fDlpcchEE8sJt9jBofLY6dgEAvbjxCo2YFiogOR0A=;
        b=CA6itsBY4k4INejP6rkImROdQAWEXFfkb1R0bA6V6O4MlJ9OUzKBSSuQjRCyCqrwYw
         uwofqjVfLsObIND09gbmFt6FafKv52MMBSdmD+qvNTOiYBPIm+98lVj2RLVid9ajX4R7
         Jz93Bylh7PIVbcdlFKrV0KamlyXKZoV7b494UgawVea279RAjeYsWN4zWkd7km1x6F7f
         +74bhGufwzBMwmLiTpTHQBXDEXmUH7G8qw4XeFxx3SQMybE+gKhwuv7ms68k3kvprfsQ
         syh7+MWhD4tV5zl47KXfS+hCyTfim5EGnDVxYpy1IgvFpyx4yCRtd3RASgrlU7Slo7uL
         O73A==
X-Gm-Message-State: AOAM530dxVqiKJNNnw2G5qikLhUwmsMHH3FucomT7e16hHbIhQJ+acQn
        LneC20Zd/twXkPvruP7qFx5Tcw==
X-Google-Smtp-Source: ABdhPJyV/P5H76Wb+5+JAxC5L618gZfe7yTIAvmY7yTdCp7caSJl75guw5MH+E5dslQmHNQXQNPNgg==
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr23088850wmb.39.1606130384390;
        Mon, 23 Nov 2020 03:19:44 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:43 -0800 (PST)
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
Subject: [PATCH 17/40] drm/amd/amdgpu/gfx_v6_0: Supply description for 'gfx_v6_0_ring_test_ib()'s 'timeout' param
Date:   Mon, 23 Nov 2020 11:18:56 +0000
Message-Id: <20201123111919.233376-18-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:1903: warning: Function parameter or member 'timeout' not described in 'gfx_v6_0_ring_test_ib'

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
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 671c46ebeced9..ca74638dec9b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1894,6 +1894,7 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
  * gfx_v6_0_ring_test_ib - basic ring IB test
  *
  * @ring: amdgpu_ring structure holding ring information
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
  *
  * Allocate an IB and execute it on the gfx ring (SI).
  * Provides a basic gfx ring test to verify that IBs are working.
-- 
2.25.1

