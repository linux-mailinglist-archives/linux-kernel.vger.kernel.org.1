Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FD2C3118
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKXTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgKXToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:39 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93CC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:38 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so84400wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzhA0w/k4kTJP8KS6ZWIOoU4RVum3eSvqAYOY6/W8wg=;
        b=CrS3VLKK9D1gUkCIA06uIjuxPlrWUCRwMEZOWxFbRV7fIAbtAAc/to7IXQeBff+VeI
         h0PjFmPQRxNRUwSruKjdKt4GFbQalr0csKiQsdY22z9hKPZZYSs1cA18dNWskDnWS44Z
         wMxwqfOMs6ujI/T/ZFnO/uUVEDzrorssQyIbqoGn+MIe6oeoRurZaEiXmb4kJOtwbyEP
         ryyDf+Q11Rpg/uk5lXWWFQKZgIMOydzVZyEuitEJh2BdPdwfxdKnfmb6n/bRqYCgR9TI
         jWlSwFHkmQeuviVAJ2SLH5jbKuAQAbxjt5ytBB5B/n7F34njf/oY59uCRF8oIllIOnYw
         wgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzhA0w/k4kTJP8KS6ZWIOoU4RVum3eSvqAYOY6/W8wg=;
        b=ejjD1GIphfzfjXkQMLbcRc5LxO7GI6ymKFdgDmEPWGkpeEqgP+Ob/R9qj5jxnn7mUk
         +A+U3tti0grYxpfEOVjtDN6HXwFqlYlNORgwwKo5DzNPb7EXR3uX9seqAlYdp478gBYE
         C//8ikbxVmOn6BLzUV31QNJ1i+lSlJMDqNCPTslEmBX8mrzL3v1AeCogh8EX90EnP9mU
         NfMHowMV+CM9NVmy+6C2EOIFy3oFcQCktphGCh/XzvLRh+a423g99VbzpEtTivdsgl9H
         7w2h3NCrgCgmwmTxQvXLMdgPcgJ+ITmYZqGSR5dAc71V3/o6L3XB54OddF4yUZLWZwTC
         XTPQ==
X-Gm-Message-State: AOAM533uif/PYcIvV1AGCwMZvoVpOFzhPv+mvlyQ/87EefdLFymKT7x9
        8/shPJ1mfDajSr2S22xZdHZgCQ==
X-Google-Smtp-Source: ABdhPJz/XlQqxXfWUnEWMz20ZEAn4PW7t6qvC5ObPEolRflflnVotMsK4efDfs9ws06qCyvrybXRDw==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr63586wmm.89.1606247076873;
        Tue, 24 Nov 2020 11:44:36 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Veerabadhran G <vegopala@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/amdgpu/jpeg_v1_0: Add some missing function param descriptions
Date:   Tue, 24 Nov 2020 19:38:14 +0000
Message-Id: <20201124193824.1118741-31-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Function parameter or member 'addr' not described in 'jpeg_v1_0_decode_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Function parameter or member 'seq' not described in 'jpeg_v1_0_decode_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Function parameter or member 'flags' not described in 'jpeg_v1_0_decode_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Excess function parameter 'fence' description in 'jpeg_v1_0_decode_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:293: warning: Function parameter or member 'job' not described in 'jpeg_v1_0_decode_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:293: warning: Function parameter or member 'flags' not described in 'jpeg_v1_0_decode_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:518: warning: Function parameter or member 'mode' not described in 'jpeg_v1_0_start'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Veerabadhran G <vegopala@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index c600b61b5f45d..c87102b238e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -210,7 +210,9 @@ static void jpeg_v1_0_decode_ring_insert_end(struct amdgpu_ring *ring)
  * jpeg_v1_0_decode_ring_emit_fence - emit an fence & trap command
  *
  * @ring: amdgpu_ring pointer
- * @fence: fence to emit
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
@@ -282,7 +284,9 @@ static void jpeg_v1_0_decode_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
  * jpeg_v1_0_decode_ring_emit_ib - execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
+ * @job: job to retrive vmid from
  * @ib: indirect buffer to execute
+ * @flags: unused
  *
  * Write ring commands to execute the indirect buffer.
  */
@@ -511,6 +515,7 @@ void jpeg_v1_0_sw_fini(void *handle)
  * jpeg_v1_0_start - start JPEG block
  *
  * @adev: amdgpu_device pointer
+ * @mode: SPG or DPG mode
  *
  * Setup and start the JPEG block
  */
-- 
2.25.1

