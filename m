Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEE2C0464
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgKWLUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgKWLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:19 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E65C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so17515673wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XzaLPcLzyh2up8e5kwP+nCHZJEB2WNWkcaV5TphNj8=;
        b=fFIghWFECT8oOj8Gu6q8wWn9L5Fsp3uSgLhqf4xoYHzANzX9dnQy+cCA25K4kRYNg7
         FZ2lQihD8sQIOAZh9U99hIjJKi/4DqiRzkm+KMU2/FoHpzwC82+M8bNqfnVvEmKrm8t/
         lfxAuN4z4hfJNTekVocscG1M+td6PQFn1y8fWKMtOULHbg1wBKDyhAcnpBFudv5YTyzS
         qeG35MgmaOjGVq5q81vUOK9ppiAYrv9JfodWa7vBEJxkBEhINB+44gRA2QXEMyj81anE
         0rZFFj6ta/VsXd6K2OtmQI7hbWA8UBuHofWGPJEiVBedvS74vena5C/SamFn+8lWjn9s
         XvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XzaLPcLzyh2up8e5kwP+nCHZJEB2WNWkcaV5TphNj8=;
        b=fA7YjfXsALIRrOPs9Tff6hqE5YN/GHTb1xNoGHlXNBQHqAWFtW01kYrQu14RlJWNrk
         w/TK3jQCYfJX33ctmRxJiEDbNCI0YWscfN9Acf9VqvbQBQCyUiJJQaExTpk5EY4iTYkd
         8awXgppOB3Ib9WOoDlHsGAtWchRhUk9RqikLENRUxIvEBMyL7iSqG2pqEZbx66LS5DIj
         LFPrFh7oOComPwmY7771JIO3IhEUCZNJrdSJWI4WnBjTv1uIqBNmdSqY0I0KxbZ2J5wS
         3AQ/XgIwZ/nzPiAeELbDZXuUbs0mJj1eoUnctu45QA8PeG2LHpGYKLZQ7IcJYgd4voGH
         reTA==
X-Gm-Message-State: AOAM533Nshj8nukrgtl1vdVIk1UAmemGSgB10g/evj+PVQ9sRS2d/7Ev
        DhXKCMUK4RkcCYgzsnVzWNf5dg==
X-Google-Smtp-Source: ABdhPJw4krFHGvCPonuYMQCc5j4oEqKwHKw6hTdw1CAKFuCsPJi/oWSZPQ18RWzyyhjvj3TopaDe2A==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr22884154wme.23.1606130417818;
        Mon, 23 Nov 2020 03:20:17 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 40/40] drm/amd/amdgpu/gmc_v9_0: Suppy some missing function doc descriptions
Date:   Mon, 23 Nov 2020 11:19:19 +0000
Message-Id: <20201123111919.233376-41-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:382:23: warning: ‘ecc_umc_mcumc_status_addrs’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:720: warning: Function parameter or member 'vmhub' not described in 'gmc_v9_0_flush_gpu_tlb'
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:836: warning: Function parameter or member 'flush_type' not described in 'gmc_v9_0_flush_gpu_tlb_pasid'
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:836: warning: Function parameter or member 'all_hub' not described in 'gmc_v9_0_flush_gpu_tlb_pasid'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fbee43b4ba64d..a83743ab3e8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -675,6 +675,7 @@ static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vmid: vm instance to flush
+ * @vmhub: vmhub type
  * @flush_type: the flush type
  *
  * Flush the TLB for the requested page table using certain type.
@@ -791,6 +792,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * @adev: amdgpu_device pointer
  * @pasid: pasid to be flush
+ * @flush_type: the flush type
+ * @all_hub: Used with PACKET3_INVALIDATE_TLBS_ALL_HUB()
  *
  * Flush the TLB for the requested pasid.
  */
-- 
2.25.1

