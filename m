Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1678C2C3138
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKXTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKXToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:23 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD524C061A52
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:22 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so8354750wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKQ4eVfCC+mCoQiVeoENgqpzgP5ax0zNTjB2JRG9QPQ=;
        b=QeNMhMwB6olgk2tTgty1xYOD4fxbeZFv6AiF39TRiM/ye/iu4cm1QjUqhWyQfnG/vA
         MUsZflIZPtM2F2+J94JZYhEJHY8TX+MhwEocvZJ0h3NwvA+PojdZw1cNSD7O5L+QQ8qJ
         IxCaCReSZZEqWG3EpTV8v4DNYHJXCtkQ3DEZJkBnUN9I+mH+HchsWmDW1T4OPFjIutym
         y7gnxJ7mKcRWERn+6QqglgDxD9jdBaXj6yEZrwsHxqfemTCq4kCtoaaYsaRlF3THGBGb
         5zHXoOfQ5sBwztOyraxok2FV9anmXTQ+mHslC7rIEIkrmkVxsmat4Apvhd2G8rBuHHA7
         mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKQ4eVfCC+mCoQiVeoENgqpzgP5ax0zNTjB2JRG9QPQ=;
        b=U8x8oyfLDrp0UkqUauhnO5YggUIc/7jQm2v2VSNLNAOCQoQi1BhnfCOHXRvNVHQ8t2
         eDQfh8Aa6IAgjatS/Lu/HRvvsMWQFypXHYVTcD28mjYpSk5dGz1U7xaZ9Bsxt9LJZ4yg
         UbR2mN4H/FpqbSHKN9GIoSx3dxdWGt9Dp4rbkgG4cJqVbUHVdzoFufmip94PsjHShb4J
         JWMwf2SfZ1ucqr6OWPKxaxOHblRBY+V4p/eXAgd4G7it60ccyXNZq3OOPiblsUqDuqiM
         4yeIecrDQh3SMGW8pJDetHLDXD/ZzeKj/gKcpOgiKdL2H4uN/HQJtOQp4cAYJgLKp2WG
         NwKg==
X-Gm-Message-State: AOAM5309BrCBSGcJTVPRIvAU6EoS/DATg9Gwff/mY1EtJFxNR6nCJRvP
        m9pZ+/g5cJDEtXB/z7bweVZUHw==
X-Google-Smtp-Source: ABdhPJxKkmdcF0OWQWLZT8x2a6ZORn84qC5Z1gI250KIOsXgYz/258WAI71Mwe14Wgva03ANUfVrTA==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr106282wro.172.1606247061627;
        Tue, 24 Nov 2020 11:44:21 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:20 -0800 (PST)
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
Subject: [PATCH 18/40] drm/amd/amdgpu/sdma_v3_0: Fix a bunch of kernel-doc function documentation issues
Date:   Tue, 24 Nov 2020 19:38:02 +0000
Message-Id: <20201124193824.1118741-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:428: warning: Function parameter or member 'job' not described in 'sdma_v3_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:428: warning: Function parameter or member 'flags' not described in 'sdma_v3_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:484: warning: Function parameter or member 'addr' not described in 'sdma_v3_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:484: warning: Function parameter or member 'seq' not described in 'sdma_v3_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:484: warning: Function parameter or member 'flags' not described in 'sdma_v3_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:484: warning: Excess function parameter 'fence' description in 'sdma_v3_0_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:870: warning: Function parameter or member 'timeout' not described in 'sdma_v3_0_ring_test_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1018: warning: Function parameter or member 'ring' not described in 'sdma_v3_0_ring_pad_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1070: warning: Function parameter or member 'vmid' not described in 'sdma_v3_0_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1070: warning: Function parameter or member 'pd_addr' not described in 'sdma_v3_0_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1070: warning: Excess function parameter 'vm' description in 'sdma_v3_0_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1643: warning: Function parameter or member 'ib' not described in 'sdma_v3_0_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1643: warning: Function parameter or member 'tmz' not described in 'sdma_v3_0_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1643: warning: Excess function parameter 'ring' description in 'sdma_v3_0_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1668: warning: Function parameter or member 'ib' not described in 'sdma_v3_0_emit_fill_buffer'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1668: warning: Excess function parameter 'ring' description in 'sdma_v3_0_emit_fill_buffer'

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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c59f6f6f4c091..43410a7bccc25 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -417,7 +417,9 @@ static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  * sdma_v3_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
  * @ring: amdgpu ring pointer
+ * @job: job to retrive vmid from
  * @ib: IB object to schedule
+ * @flags: unused
  *
  * Schedule an IB in the DMA ring (VI).
  */
@@ -473,7 +475,9 @@ static void sdma_v3_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
  * sdma_v3_0_ring_emit_fence - emit a fence on the DMA ring
  *
  * @ring: amdgpu ring pointer
- * @fence: amdgpu fence object
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Add a DMA fence packet to the ring to write
  * the fence seq number and DMA trap packet to generate
@@ -862,6 +866,7 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
  * sdma_v3_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
  *
  * Test a simple IB in the DMA ring (VI).
  * Returns 0 on success, error on failure.
@@ -1011,6 +1016,7 @@ static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 /**
  * sdma_v3_0_ring_pad_ib - pad the IB to the required number of dw
  *
+ * @ring: amdgpu_ring structure holding ring information
  * @ib: indirect buffer to fill with padding
  *
  */
@@ -1060,7 +1066,8 @@ static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
  * sdma_v3_0_ring_emit_vm_flush - cik vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
- * @vm: amdgpu_vm pointer
+ * @vmid: vmid number to use
+ * @pd_addr: address
  *
  * Update the page table base and flush the VM TLB
  * using sDMA (VI).
@@ -1630,6 +1637,7 @@ static void sdma_v3_0_set_irq_funcs(struct amdgpu_device *adev)
  * @src_offset: src GPU address
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
+ * @tmz: unused
  *
  * Copy GPU buffers using the DMA engine (VI).
  * Used by the amdgpu ttm implementation to move pages if
@@ -1654,7 +1662,7 @@ static void sdma_v3_0_emit_copy_buffer(struct amdgpu_ib *ib,
 /**
  * sdma_v3_0_emit_fill_buffer - fill buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to copy to
  * @src_data: value to write to buffer
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
-- 
2.25.1

