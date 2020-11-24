Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5962C311C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgKXTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgKXToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C07C061A4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:39 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so5249858wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTQ5gL/fFZGCODd+MpCfGseH3ViN6nmo6i+7UzfYda0=;
        b=vhF37QAFFTx6Db8V5kbTsDQoerTQjzFKn+ANrhtYl406/gkriHZ4ylI6iyUyHWakwL
         syhFicrl2QLMplXmezvxYV3ooX/dPhH+NAidO5uSgGBAsQKnXFaAa6nOiAE5/MIIqqim
         OMmeTkMW09SFmEzT4aTu3PXKiARnItjTQhCGDuZmz1rc2F7fsFs83nenchpwEI4xkYp1
         R8gHJTGIsSuPWgE8dpuoi+9FMQZt2f1AJKvbNTvNPL32C/06y6x55EQh6Ltz2MoxLmYA
         KjSBVlNHDSKg6spfxS0RARtsaRiHc7rKP+0tTem+q/z7LcztsPne7B3iF743KIvnBR66
         I1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTQ5gL/fFZGCODd+MpCfGseH3ViN6nmo6i+7UzfYda0=;
        b=pLefH6KZSomaqMk0HZfcxAnIj7bn9bQilRaWJx1tG3SvLbTdUt91qekg++HM8rOpSf
         dhVv6XmbjixGV5aMX82o5kB7Yri3aXjS+v/ZCaocJdz0UtKMmS8aWQPJ5Pb1T3Ssdq3d
         l5aDWGXGR8LncCZzVKwApUDTN/ScLroIsCJklev+aXEuIocs+wfoE08gHkcnh2ruRYY1
         87tlwK4tXrwcaEqSmljCVSI9SV5X71GHVnvtnaClgI0UhaaMPUcbfXI8KoxEnrwxJyKt
         7xVZ75Loa0VZrwN19N8p7jBD/3NprrpWL+kjIEdY5N/18whgH+I4Cg3ng4CHwiei+Kp9
         NmWg==
X-Gm-Message-State: AOAM531LSCeKIATdVpjwJWWEN7rfHz0BgYbf3JHaVIKBAzIf4wogcKqS
        nEf8tE4Tak6yisRFGH7dDCQmUQ==
X-Google-Smtp-Source: ABdhPJwPLyBXb00eAHfohzKLGLKoQMLk9bEUJuVpLR76WQmyJ6H7DoAgkfyLfw6viWi9n7ydO3Jwzw==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr80073wrq.11.1606247078052;
        Tue, 24 Nov 2020 11:44:38 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 31/40] drm/amd/amdgpu/jpeg_v2_0: Add some missing kernel-doc descriptions
Date:   Tue, 24 Nov 2020 19:38:15 +0000
Message-Id: <20201124193824.1118741-32-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Function parameter or member 'addr' not described in 'jpeg_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Function parameter or member 'seq' not described in 'jpeg_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Function parameter or member 'flags' not described in 'jpeg_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Excess function parameter 'fence' description in 'jpeg_v2_0_dec_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:549: warning: Function parameter or member 'job' not described in 'jpeg_v2_0_dec_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:549: warning: Function parameter or member 'flags' not described in 'jpeg_v2_0_dec_ring_emit_ib'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 6b80dcea80ec8..15c0224d48b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -489,7 +489,9 @@ void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
  * jpeg_v2_0_dec_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
@@ -538,7 +540,9 @@ void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
  * jpeg_v2_0_dec_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: job to retrive vmid from
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer.
  */
-- 
2.25.1

