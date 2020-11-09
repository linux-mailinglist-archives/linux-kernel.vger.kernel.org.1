Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50152AC6F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgKIVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbgKIVTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:30 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:29 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so939812wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hg/I8hWx//QmSj29JDx18mAH+iG9CJqB6Lurd4l5hM4=;
        b=AaQNQ9NIHkRGoTiIRF1aRbT+aRsVQOm3b9utKoz6DPEumCRmo8ulSQC4s6mp+erOM4
         LRXMWkhr0iRHwoQjDKD2CWxMIlFyviTFAewCFYg+m4eNcwLPgs7s7FaXFliAQ1D2LNYV
         KWWf497r8hxqorMREEcQnOEkHSmQ/oOI+acP+sT85BS6Jj9aCQSUZF/n4aBwaS0ouFNB
         dQfab8IsQ1wI4bP4VpeVJXWYH450W4LDxGaHXJSDMkuD5kIIVpdbF/lAMSFhiteMxQTs
         8AaotcYN+NonRvAYcA2ThRjOs5m937qryN9440lKxewZFO8wEihMG2b7zvWDLNIsgBAP
         VvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hg/I8hWx//QmSj29JDx18mAH+iG9CJqB6Lurd4l5hM4=;
        b=B0OCRzwgc8kpHIIlz1TK+VH1hJ2PBQd7hO2wKbgK8HY7cvPwET2EE/AOSBa+6g2PHR
         fNSbl45xLJ6gMSXf034X3uQE2eUHdCEuGPj/slod80gsf1HSE9eO3uRHeX+eMWrB33G+
         M9tNqNg1O/c7izJxUUv+9umkza5PiRBNTZ8K6VFnFZTvMZK/1dDmx4wG4p6ybxZKuS01
         ZlNKyDGoQiM6qK6cDlp2d62JL+HzeMYCMNqa0fel+D+VBosz+qTqgaz0RkYUWAhjpLFF
         qVTCk/PKzE/c64JTvInvdMInAE0QQC1S45Q4bz3Ivz3OmTplLkEik3Xig2NSOPl+BFhx
         /+KA==
X-Gm-Message-State: AOAM533segkQw+KD5RuvZnsiBoA4I+a3pjZjkRNfUGXfprCPuaePCpvG
        hbypFJTwyFQnQeTVBO0jdHrYsw==
X-Google-Smtp-Source: ABdhPJzx9i0REzgr6/gPi12sqOoRtBTxOrqVEou0TYRp87r9nmf4qrJshdrBFXvAP62RNBVn0jBZFA==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr1056495wme.47.1604956768392;
        Mon, 09 Nov 2020 13:19:28 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/20] drm/radeon/radeon_ring: Add missing function parameters 'rdev' and 'data'
Date:   Mon,  9 Nov 2020 21:18:45 +0000
Message-Id: <20201109211855.3340030-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_ring.c:226: warning: Function parameter or member 'rdev' not described in 'radeon_ring_unlock_undo'
 drivers/gpu/drm/radeon/radeon_ring.c:240: warning: Function parameter or member 'rdev' not described in 'radeon_ring_lockup_update'
 drivers/gpu/drm/radeon/radeon_ring.c:283: warning: Function parameter or member 'data' not described in 'radeon_ring_backup'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index 37093cea24c59..c3304c977a0a5 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -218,6 +218,7 @@ void radeon_ring_undo(struct radeon_ring *ring)
 /**
  * radeon_ring_unlock_undo - reset the wptr and unlock the ring
  *
+ * @rdev:       radeon device structure
  * @ring: radeon_ring structure holding ring information
  *
  * Call radeon_ring_undo() then unlock the ring (all asics).
@@ -231,6 +232,7 @@ void radeon_ring_unlock_undo(struct radeon_device *rdev, struct radeon_ring *rin
 /**
  * radeon_ring_lockup_update - update lockup variables
  *
+ * @rdev:       radeon device structure
  * @ring: radeon_ring structure holding ring information
  *
  * Update the last rptr value and timestamp (all asics).
@@ -275,6 +277,7 @@ bool radeon_ring_test_lockup(struct radeon_device *rdev, struct radeon_ring *rin
  *
  * @rdev: radeon_device pointer
  * @ring: the ring we want to back up
+ * @data: placeholder for returned commit data
  *
  * Saves all unprocessed commits from a ring, returns the number of dwords saved.
  */
-- 
2.25.1

