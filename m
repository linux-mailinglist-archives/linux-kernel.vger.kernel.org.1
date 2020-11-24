Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586E02C311D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKXTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgKXTok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9591DC061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:40 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so23531055wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6u+an5wg59Ub2sA6cm8lJFBFNrxCPWC3h0dHv9agJ0=;
        b=qaBWT/Q6pz1M3PpcFDRhQIo4cEBtP7U3p6y0c3+5YoHb62+wyYRFYSV0D8tSWEnaAY
         bg6H+JIVfADrkVr7VEK82A4v0DnZDSyGKYMptp1H90hMwtcrxSM9i7zG+Pscp00yT1Wx
         hkdpIf+rdv5UOWm4bUVkLgQBoosj6pd+Jx9b4gqrGcQOQrl7qK/cCtQ3OOQs9kHkOk+z
         1vwJzHtce24IVBXYFUm+mfHLiy0XZO4yuhEP+FcJi2i6HQzV+lgVrrx8p11vRNZbqHnD
         tiSvV5CKnTRS1tM8NfZP+DdOJS0Ckdjev9rJK38fsOWR4GGT1dQx1IeJT9I++FVEEULc
         AV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6u+an5wg59Ub2sA6cm8lJFBFNrxCPWC3h0dHv9agJ0=;
        b=YvpJb4iReCAPQG+B3fvORiIJHyFpit0Om1M5raM/xmJ1cQknx8YpXnp4QLd85e/Z61
         XknX3PqEDs4+HUkFpDlqXBIq9Iq4aUJ5J7U69LItpOwwuH0FDFXSqZij50g5N1JXi3Ym
         mEoqWzVRiCXjAPd5FcHU41ls+IgDZBmd69Ev5mJJcXi0F6ZqfYzU8+J/JbMUCr9wYtIo
         gHjLhVhKsCCe7SRBi1S5reomzoLOjU3LrGcjGDuhqHK4lynqjch6tpMNcOXOGigGmZqc
         J0lWTswU/K2WxZTfIkNUvJuStFlP4+dZxQFXbP8bYVeCps1z9a8DCn10m4meNlihHX5G
         cV+g==
X-Gm-Message-State: AOAM531ZvfGc/A2GuqpiJry4B24AZc2G65v0g54rnAjS482Ra1ZFB/EX
        TZiwPaKTjOYG8omDU3axaoZq7g==
X-Google-Smtp-Source: ABdhPJwqe491zYxJcWxzk0aAS5LHlsmEF9y4JhFaF+/F7qs++zbpwuKuDas2KR4Gx1O8jUub5KqnQA==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr68528wrw.145.1606247079348;
        Tue, 24 Nov 2020 11:44:39 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 32/40] drm/amd/amdgpu/vcn_v2_0: Fix a few kernel-doc misdemeanours
Date:   Tue, 24 Nov 2020 19:38:16 +0000
Message-Id: <20201124193824.1118741-33-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:483: warning: Excess function parameter 'sw' description in 'vcn_v2_0_disable_clock_gating'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:644: warning: Excess function parameter 'sw' description in 'vcn_v2_0_enable_clock_gating'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1404: warning: Function parameter or member 'count' not described in 'vcn_v2_0_dec_ring_insert_nop'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Function parameter or member 'addr' not described in 'vcn_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Function parameter or member 'seq' not described in 'vcn_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Function parameter or member 'flags' not described in 'vcn_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Excess function parameter 'fence' description in 'vcn_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1465: warning: Function parameter or member 'job' not described in 'vcn_v2_0_dec_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1465: warning: Function parameter or member 'flags' not described in 'vcn_v2_0_dec_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Function parameter or member 'addr' not described in 'vcn_v2_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Function parameter or member 'seq' not described in 'vcn_v2_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Function parameter or member 'flags' not described in 'vcn_v2_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Excess function parameter 'fence' description in 'vcn_v2_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1636: warning: Function parameter or member 'job' not described in 'vcn_v2_0_enc_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1636: warning: Function parameter or member 'flags' not described in 'vcn_v2_0_enc_ring_emit_ib'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e285f9c9d460e..5687c5ed0fb99 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -475,7 +475,6 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
  * vcn_v2_0_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -636,7 +635,6 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
  * vcn_v2_0_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Enable clock gating for VCN block
  */
@@ -1397,6 +1395,7 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
  * vcn_v2_0_dec_ring_insert_nop - insert a nop command
  *
  * @ring: amdgpu_ring pointer
+ * @count: the number of NOP packets to insert
  *
  * Write a nop command to the ring.
  */
@@ -1417,7 +1416,9 @@ void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  * vcn_v2_0_dec_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
@@ -1454,7 +1455,9 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
  * vcn_v2_0_dec_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: job to retrive vmid from
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer
  */
@@ -1600,7 +1603,9 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
  * vcn_v2_0_enc_ring_emit_fence - emit an enc fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write enc a fence and a trap command to the ring.
  */
@@ -1625,7 +1630,9 @@ void vcn_v2_0_enc_ring_insert_end(struct amdgpu_ring *ring)
  * vcn_v2_0_enc_ring_emit_ib - enc execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: job to retrive vmid from
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write enc ring commands to execute the indirect buffer
  */
-- 
2.25.1

