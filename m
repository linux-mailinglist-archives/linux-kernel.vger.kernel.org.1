Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D02C311B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgKXTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgKXToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993FC061A54
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so23523819wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/U28BTdBGMRnDOnXaXT9FPg1voaJCOCB5Rl4gPT4og=;
        b=KX+rHvLcQeAGt+G+t9x+57/PA61xVTZTNqvrigBRVwItHIZSEB9puNLgxNps76v3U7
         +nctpHeQLuMb5l5/ossElcaIgrjUXHzAkRVRDbJQietyxRx7+E75MBsNDOAwIwJ1yVhp
         Kvx81ixX+I68QKaTdpbrHASnDDs9Qdf5452foUVxQQRkdW7xG15qBAL5FXNbeMz1FD68
         nkFmgNlu20yIyV237M2WdFXXxjNyAygCIZsUoMyTdVxffvk2w/yRmbJKQ9m7SamyVpbz
         hC+Cb4ChBuj+pHQj9q6wwZiFDndnnz/UUyIQ+ATocaQC04K74bfUNcKB8GKtWnDSi0Lk
         p9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/U28BTdBGMRnDOnXaXT9FPg1voaJCOCB5Rl4gPT4og=;
        b=GjVwGK2N16zxVJKBFn0dHYDlIzEPhZsQOtXbYfLqqG7y6fXB+kY/mRsNOQ3dObYfM4
         6D0n0v7Rypz8QB+qNB2X0aehHVJg0q/j2pJd1MXXUOM5tYz/uDTsydghSBXeHjqTqqM3
         2LIsnM1HJEySY27zeMrPXVjTNNa5gRSn8KY8psZF2f819ViJZG2F4LHYflJearSzJaiM
         keICuF5vHZAuJLZf0Mc4gds43KzDYHzSopqcuSm5OBNlKJbfLmTzEM55BrB8P1Xq0jxT
         oMbzw13LCNNgYvR71WVoPsoM6f8eAUelSlchecUN2eoW0a6+pSs4pi+IWDxUaosL2qnI
         aaEA==
X-Gm-Message-State: AOAM531JW9hHnPly8xVPerChodRG7LpcIBIXpD/sVqK8XpixFoS0qm94
        zB69CjLiwjGO1MvdX21wiQFMZA==
X-Google-Smtp-Source: ABdhPJy3OAmqTFNh+PuMtHw2N8gAQ2AEXQI+Mb4rG9z3tFFUCD2Fkoj3PE7C8G8IfbM8R1LsSFimOg==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr87661wrp.362.1606247075639;
        Tue, 24 Nov 2020 11:44:35 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/amdgpu/vcn_v1_0: Fix a few kernel-doc misdemeanours
Date:   Tue, 24 Nov 2020 19:38:13 +0000
Message-Id: <20201124193824.1118741-30-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:439: warning: Excess function parameter 'sw' description in 'vcn_v1_0_disable_clock_gating'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:566: warning: Excess function parameter 'sw' description in 'vcn_v1_0_enable_clock_gating'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Function parameter or member 'addr' not described in 'vcn_v1_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Function parameter or member 'seq' not described in 'vcn_v1_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Function parameter or member 'flags' not described in 'vcn_v1_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Excess function parameter 'fence' description in 'vcn_v1_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1495: warning: Function parameter or member 'job' not described in 'vcn_v1_0_dec_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1495: warning: Function parameter or member 'flags' not described in 'vcn_v1_0_dec_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Function parameter or member 'addr' not described in 'vcn_v1_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Function parameter or member 'seq' not described in 'vcn_v1_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Function parameter or member 'flags' not described in 'vcn_v1_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Excess function parameter 'fence' description in 'vcn_v1_0_enc_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1655: warning: Function parameter or member 'job' not described in 'vcn_v1_0_enc_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1655: warning: Function parameter or member 'flags' not described in 'vcn_v1_0_enc_ring_emit_ib'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 86e1ef732ebec..72148f3b27d04 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -431,7 +431,6 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
  * vcn_v1_0_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -558,7 +557,6 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
  * vcn_v1_0_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Enable clock gating for VCN block
  */
@@ -1445,7 +1443,9 @@ static void vcn_v1_0_dec_ring_insert_end(struct amdgpu_ring *ring)
  * vcn_v1_0_dec_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
@@ -1484,7 +1484,9 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
  * vcn_v1_0_dec_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: job to retrive vmid from
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer
  */
@@ -1619,7 +1621,9 @@ static void vcn_v1_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
  * vcn_v1_0_enc_ring_emit_fence - emit an enc fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write enc a fence and a trap command to the ring.
  */
@@ -1644,7 +1648,9 @@ static void vcn_v1_0_enc_ring_insert_end(struct amdgpu_ring *ring)
  * vcn_v1_0_enc_ring_emit_ib - enc execute indirect buffer
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

