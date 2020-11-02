Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD22A3152
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgKBRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgKBRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:19:17 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4008C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:19:16 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id r10so7154938plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gu7OzJg5YsHyAw9OdlR1gRKaz6bYEZ9rCRmoN2YqcRs=;
        b=tbS/ciRMaM0ywq7S9pBwsax3DG+avVuW1tjS5cu/eUgRRdJh4dbo4UPLChadxR1m8t
         4dvTLuoC4ZgtBcLTZvIzJQW1Bt+3gXbIFSSS3lqbylisp9GNlo9DiZOJJtqphxAh3fS2
         LlPksIINDJk2JjmLJkTgGGyCfsZsuQrk1YR997yzujP1fUHsxplRDEqxR0MeX9pUZkHW
         TOCEL9dSotXYRPJXksmybG6kHIyMny+Pxgtu//YreT+YKNU1q9ACXzjO2g+XX09hhFae
         umKdVEEcXJaIeExLuOB6MeyGYrEmF3UT7HZb7u28CauIeMMcrSZ9gty5bQmuoGCxkeIW
         8PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gu7OzJg5YsHyAw9OdlR1gRKaz6bYEZ9rCRmoN2YqcRs=;
        b=G8pCxYpuejUCfN936eF9qv6qO5ZO9xFQRWYDTnvDW+aQFMvGjg8xr0x6Nffua/xgdu
         Ag47AsJNbLxJNAR/ofBOB5Aws9WC80lpmJLNA9B10HMjktqpez7ikmxqDB5aNqznIiO6
         MiedMh/eWBBtZnaPJVu1lrY5K43tZSbrZ8gKR18HbmLjGNpWEuzevPcJuyS5KxCKMmAB
         ZB4Vv6HWbmYPS2X0BtQnDIyZfsxmZdGieWmtOfqreFiPvgW3JuBfXeISshiWnFh1tnb4
         A5hfBz+QuMbDOyaGfwACtAWjB/57wJPP6mRhAXbqv98mi4zZK/rBAZ7B4UPHtvIdxe2o
         L+8A==
X-Gm-Message-State: AOAM531CkIbujwKjCIoNwjgq79oPMzT+hEx4bRsF9dCG26Gjwl5hVtd9
        iQS68lND1D/6IJkOIerPxYZfYcKMhFA=
X-Google-Smtp-Source: ABdhPJw1/N+zCVEA2pWu+bXYevC4BP3Wxp6QkseKL6Ms7RpGDvbR+NhQ3y3BsLzDW89oVemL7opmCA==
X-Received: by 2002:a17:902:a503:b029:d6:d9d:f901 with SMTP id s3-20020a170902a503b02900d60d9df901mr22556442plq.54.1604337556537;
        Mon, 02 Nov 2020 09:19:16 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id j184sm3770129pfg.207.2020.11.02.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:19:16 -0800 (PST)
Date:   Mon, 2 Nov 2020 22:49:10 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, gregkh@linuxfoundation.org,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 4/6] drm/amdgpu/nbio: improve code indentation and alignment
Message-ID: <dccb007e6969300fc3dabad4887c4c589484e405.1604336791.git.mh12gx2825@gmail.com>
References: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

General code indentation and alignment changes such as replace spaces
by tabs or align function arguments as per the coding style
guidelines. Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 7b2fb050407d..d2f1fe55d388 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -32,7 +32,7 @@
 
 static u32 nbio_v6_1_get_rev_id(struct amdgpu_device *adev)
 {
-        u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
@@ -114,7 +114,7 @@ static void nbio_v6_1_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 static void nbio_v6_1_ih_doorbell_range(struct amdgpu_device *adev,
 					bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL_RANGE);
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, mmBIF_IH_DOORBELL_RANGE);
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index d34628e113fc..ae685813c419 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -43,7 +43,7 @@ static void nbio_v7_0_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v7_0_get_rev_id(struct amdgpu_device *adev)
 {
-        u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
@@ -126,7 +126,7 @@ static void nbio_v7_0_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 static void nbio_v7_0_ih_doorbell_range(struct amdgpu_device *adev,
 					bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0 , mmBIF_IH_DOORBELL_RANGE);
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, mmBIF_IH_DOORBELL_RANGE);
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
-- 
2.25.1

