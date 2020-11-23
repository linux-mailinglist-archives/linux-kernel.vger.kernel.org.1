Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE72C0461
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgKWLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgKWLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16266C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so5263124wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HOTLquS1a42dGVr9bz1l9EZWYtJ3S+2UXgNiNnLXoLI=;
        b=Uu3PFLsVsi7flain8U5ubOSFOjf9aeein2CRsEPdGjFW3xzqfAueWWaYTJq2EtEAEb
         ENXZIBrA5guueBXUS95e0Imp78fMfwCLoliHzv8We9iHmewbcx4+02Mmpb19cHsagOvq
         9C20GI9WcfOEgnYwQRT0N4yrZP9CPUMedWD0hPbemW3gojXqYe2GelPIMFq6bR4cuuNz
         YYAGcq4Q7bML/Q+wU9YLK2q90I2unSkJle3DIxj0T2sCwO5im/7Kr6A+1AeIYKainpNp
         Sa5sIe1w5PokpQKU/89WPL/Qc+oRr82P6Ma1O7W3FiJufPYDgImWxJ9tsf1VKbXZito9
         2vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOTLquS1a42dGVr9bz1l9EZWYtJ3S+2UXgNiNnLXoLI=;
        b=sDc37QEuP7dwnfv79digMrmkaeFu6zMMh2MpthNj8PkwRHWp/rshaBTDnG/t3IURQU
         vTfZ0oJ0LBPlaSCDWkvOEnmLHCX4g474GFO1+uE6HDZUWioYXyLuP85EAsIc9yXBh1LN
         6s1fPK00KMCAXaC9Z25LxjECHO8jFNRcGRS6EklNSB8eF4IYNK5U/8QAcF+KQEdaLOhh
         5RG5so/NvVuq9OG+pvr90raKcVB09wxfZh9T3Lo6ToQmkLgVtfSeN1GRKkVaXTHzTlJt
         BOIQdV1yWbYwMSBwIBOumEfb/jwkb3mMgLpyh9ZJ65nNCkaJTdwMX1RsIiIztLV/0BlS
         gQIQ==
X-Gm-Message-State: AOAM533NxE5hMHyrlaA0Ouho+poNnzTfiqwEFabIfmrr4E9JcUtENxmR
        ohVZdZbKAhs8x52thjfPYtQV+g==
X-Google-Smtp-Source: ABdhPJzQqJOwuP10BOXdsN8wGv7anaDO5nCMhFGsDWrNNSRUZ452W4PnBjZ6V9XjfivqiECCkdrOIA==
X-Received: by 2002:adf:f441:: with SMTP id f1mr30643254wrp.225.1606130412831;
        Mon, 23 Nov 2020 03:20:12 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 36/40] drm/amd/amdgpu/gmc_v7_0: Add some missing kernel-doc descriptions
Date:   Mon, 23 Nov 2020 11:19:15 +0000
Message-Id: <20201123111919.233376-37-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:433: warning: Function parameter or member 'flush_type' not described in 'gmc_v7_0_flush_gpu_tlb_pasid'
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:433: warning: Function parameter or member 'all_hub' not described in 'gmc_v7_0_flush_gpu_tlb_pasid'
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:471: warning: Function parameter or member 'vmhub' not described in 'gmc_v7_0_flush_gpu_tlb'
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:471: warning: Function parameter or member 'flush_type' not described in 'gmc_v7_0_flush_gpu_tlb'
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:771: warning: Function parameter or member 'pasid' not described in 'gmc_v7_0_vm_decode_fault'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 80c146df338aa..fe71c89ecd26f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -424,6 +424,8 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  * @pasid: pasid to be flush
+ * @flush_type: unused
+ * @all_hub: unused
  *
  * Flush the TLB for the requested pasid.
  */
@@ -463,7 +465,9 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vmid: vm instance to flush
- *
+ * @vmhub: unused
+ * @flush_type: unused
+ * *
  * Flush the TLB for the requested page table (CIK).
  */
 static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
@@ -763,6 +767,7 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
  * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
  * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
  * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
+ * @pasid: debug logging only - no functional use
  *
  * Print human readable fault information (CIK).
  */
-- 
2.25.1

