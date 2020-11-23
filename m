Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E242C044D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgKWLTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgKWLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:44 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AACC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:44 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so12926817wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9nOuAyNuSnMvxG/2OuToweTEm0XWfNfEAno5/MOVLo=;
        b=xSR30k//SbK/enLO3H8pSlIZr+qDnzQ4F182rUTLcw60ffjqKJ6/b+s0Q9PnW3SYXp
         rcrwgNOW5QOKlBuRXUpBxmyYyIrkhr/rbJyigkVt+P7QphFULKRVhNaIu9czDJv5KROf
         p0JjkrmLIAkXOFeIomlmVrCUR6DbjDeVrCla2G2wEdTqWlrh3QkuJu+tjetZXsybVkxP
         OwD16s+yjEazWU7hgyhq1XqTwLKlNdTpvZYQJ2BVPTBABuNwDWNDgKeCJ2xwudYLvUQg
         dDp70KjdGfIIVFJSuyv6TXu4MFfJlITpN06KDk5JzmYYBUAO7m1iKAwH2MQoDA9nE2SE
         mN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9nOuAyNuSnMvxG/2OuToweTEm0XWfNfEAno5/MOVLo=;
        b=YbViNxIifJUB8E56GAjkb0HgCT00ZZNFKUPlQYCtdY2+izBQOAOJe4BiHBkh5JsgVz
         8v2ty6iiIEr6U034Utm0XMYQVMC2QsJxhodVXtNyt7g6BF7H+cLFpA/BeqPUmV39dUdP
         EyCKB3VeNIOhSHN3qmDpP8ihlQSHR9UioIESYp1ZvF1Rxi9svHjfgq3xwU3mm6OZ38j9
         PwAjVUu6PQ9FYJ4C7tH5tDrBhEj/a8lEoNxCSo+i4YCI2gAxo+hg5sSpHCZ21PF45TPs
         vj+aQAA2geKlnnsUNbhtQBQsFDnZL3qMUqgB/XfB6RjjSMxsfo3l3ne8651s7D1iDBi6
         nwWQ==
X-Gm-Message-State: AOAM533fAFJThlA6hk6ayaCz+73MUvsVLZSvfS8gRw2Xgj5VRtp+ozgu
        YwI4c2I477DBEdRcxrg5/abj6g==
X-Google-Smtp-Source: ABdhPJxUpRdYurIcVkn8Ye5orOlel09O+wUB5od5cshSiFGQNoDMp700kYFgoQ8ZFbeS4FAuWafhxg==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr23805537wmc.11.1606130383174;
        Mon, 23 Nov 2020 03:19:43 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:42 -0800 (PST)
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
Subject: [PATCH 16/40] drm/amd/amdgpu/si_dma: Fix a bunch of function documentation issues
Date:   Mon, 23 Nov 2020 11:18:55 +0000
Message-Id: <20201123111919.233376-17-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/si_dma.c:92: warning: Function parameter or member 'addr' not described in 'si_dma_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:92: warning: Function parameter or member 'seq' not described in 'si_dma_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:92: warning: Function parameter or member 'flags' not described in 'si_dma_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:92: warning: Excess function parameter 'fence' description in 'si_dma_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:252: warning: Function parameter or member 'timeout' not described in 'si_dma_ring_test_ib'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:408: warning: Function parameter or member 'ring' not described in 'si_dma_ring_pad_ib'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:446: warning: Function parameter or member 'vmid' not described in 'si_dma_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:446: warning: Function parameter or member 'pd_addr' not described in 'si_dma_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:446: warning: Excess function parameter 'vm' description in 'si_dma_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:781: warning: Function parameter or member 'ib' not described in 'si_dma_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:781: warning: Function parameter or member 'tmz' not described in 'si_dma_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:781: warning: Excess function parameter 'ring' description in 'si_dma_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:804: warning: Function parameter or member 'ib' not described in 'si_dma_emit_fill_buffer'
 drivers/gpu/drm/amd/amdgpu/si_dma.c:804: warning: Excess function parameter 'ring' description in 'si_dma_emit_fill_buffer'

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
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 7d2bbcbe547b2..540dced190f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -81,7 +81,9 @@ static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
  * si_dma_ring_emit_fence - emit a fence on the DMA ring
  *
  * @ring: amdgpu ring pointer
- * @fence: amdgpu fence object
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Add a DMA fence packet to the ring to write
  * the fence seq number and DMA trap packet to generate
@@ -244,6 +246,7 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
  * si_dma_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
  *
  * Test a simple IB in the DMA ring (VI).
  * Returns 0 on success, error on failure.
@@ -401,6 +404,7 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
 /**
  * si_dma_pad_ib - pad the IB to the required number of dw
  *
+ * @ring: amdgpu_ring pointer
  * @ib: indirect buffer to fill with padding
  *
  */
@@ -436,7 +440,8 @@ static void si_dma_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
  * si_dma_ring_emit_vm_flush - cik vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
- * @vm: amdgpu_vm pointer
+ * @vmid: vmid number to use
+ * @pd_addr: address
  *
  * Update the page table base and flush the VM TLB
  * using sDMA (VI).
@@ -764,10 +769,11 @@ static void si_dma_set_irq_funcs(struct amdgpu_device *adev)
 /**
  * si_dma_emit_copy_buffer - copy buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to copy to
  * @src_offset: src GPU address
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
+ * @tmz: unused
  *
  * Copy GPU buffers using the DMA engine (VI).
  * Used by the amdgpu ttm implementation to move pages if
@@ -790,7 +796,7 @@ static void si_dma_emit_copy_buffer(struct amdgpu_ib *ib,
 /**
  * si_dma_emit_fill_buffer - fill buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to copy to
  * @src_data: value to write to buffer
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
-- 
2.25.1

