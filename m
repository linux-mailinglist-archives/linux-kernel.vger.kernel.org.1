Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4652C0404
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgKWLTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgKWLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:31 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D07C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:29 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so12926360wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3B/KaL6lbZ9zuu2YqnYL7UVJgLjNHABYqPf54e94gA=;
        b=X7RnHup733yvNd5GimGso4o9/T3XaFbuUKo+8vlBb1i04UqjjqU+gouvm1F5oupNWS
         BomN/tXqfJzPLSfhAo2piups1yBhjqEcRaetJDB9M9CPSz8dY18tYeWRITTg8zeVU6wA
         ZXVHFZWP7cv9RGf4nRiv5KYKIq6iEsnU3Q3laz7HJuvKh1NH9pn6tghcdJPzJtBO9jho
         /lEHrYrGhZ2YkzGkBGKJq3V8QIyvFjkwy9ORYao30ziQWobEGrTq4qnDKCRMgPzT/RDk
         kZCQDeNnM4DK2tlCPEC+8dj5IBlSjNdakXDmgTGgg5c+PeYltCvUsGySk94440hbTN4+
         jA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3B/KaL6lbZ9zuu2YqnYL7UVJgLjNHABYqPf54e94gA=;
        b=YUEToLr2SqCS+Lu2y/qhJUGUxUU4kF1SqY7mF9n+Jw/lMYzmr9jiTtPrDiBgqACHsB
         Sr9ePNhVjXAZeXprucrFdceJs3S0r0Xq/Bs/B5nXgaOK+ZTKPAhPrS369/oXoba0pfGX
         YILhOc9+vEAq8bjq7dA9U0EeLL+VkhkqPHuafN8lvZ69CikKSCCIId0fC7EC1QITSIJS
         vHQYtxsvN4oPFXt1fxyhNpv0vxK5HRFxm+1pwQ3y582bKroHXMQqWaqFHELclHjSbjC8
         673DdJTZkEwmnzvUT8lOenyGUkApsyNy7GCysYdz+fCH2den8hiJpYO9heXfz4EM8/D0
         NrMw==
X-Gm-Message-State: AOAM532QkJX+E+0V+WLDlcWNaJWgtloYPjc6yE6w5c2W7Ak3VilEtokg
        NwCCJsZA0haUafjFHffCvbxkEg==
X-Google-Smtp-Source: ABdhPJw+kE/HFpA8IbAvR/VhGAiwljYiZ2gmlli5OMqraGE1wVTEZSgXQGtUS7kbK02vyP6jiUyntQ==
X-Received: by 2002:a05:600c:22d5:: with SMTP id 21mr22033465wmg.33.1606130368160;
        Mon, 23 Nov 2020 03:19:28 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/amdgpu/amdgpu_virt: Correct possible copy/paste or doc-rot misnaming issue
Date:   Mon, 23 Nov 2020 11:18:43 +0000
Message-Id: <20201123111919.233376-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:115: warning: Function parameter or member 'adev' not described in 'amdgpu_virt_request_full_gpu'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:115: warning: Excess function parameter 'amdgpu' description in 'amdgpu_virt_request_full_gpu'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:138: warning: Function parameter or member 'adev' not described in 'amdgpu_virt_release_full_gpu'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:138: warning: Excess function parameter 'amdgpu' description in 'amdgpu_virt_release_full_gpu'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:159: warning: Function parameter or member 'adev' not described in 'amdgpu_virt_reset_gpu'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:159: warning: Excess function parameter 'amdgpu' description in 'amdgpu_virt_reset_gpu'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:194: warning: Function parameter or member 'adev' not described in 'amdgpu_virt_wait_reset'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:194: warning: Excess function parameter 'amdgpu' description in 'amdgpu_virt_wait_reset'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:210: warning: Function parameter or member 'adev' not described in 'amdgpu_virt_alloc_mm_table'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:210: warning: Excess function parameter 'amdgpu' description in 'amdgpu_virt_alloc_mm_table'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:239: warning: Function parameter or member 'adev' not described in 'amdgpu_virt_free_mm_table'
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:239: warning: Excess function parameter 'amdgpu' description in 'amdgpu_virt_free_mm_table'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 905b85391e64a..462c5dd8ca72c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -106,7 +106,7 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 
 /**
  * amdgpu_virt_request_full_gpu() - request full gpu access
- * @amdgpu:	amdgpu device.
+ * @adev:	amdgpu device.
  * @init:	is driver init time.
  * When start to init/fini driver, first need to request full gpu access.
  * Return: Zero if request success, otherwise will return error.
@@ -129,7 +129,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 
 /**
  * amdgpu_virt_release_full_gpu() - release full gpu access
- * @amdgpu:	amdgpu device.
+ * @adev:	amdgpu device.
  * @init:	is driver init time.
  * When finishing driver init/fini, need to release full gpu access.
  * Return: Zero if release success, otherwise will returen error.
@@ -151,7 +151,7 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)
 
 /**
  * amdgpu_virt_reset_gpu() - reset gpu
- * @amdgpu:	amdgpu device.
+ * @adev:	amdgpu device.
  * Send reset command to GPU hypervisor to reset GPU that VM is using
  * Return: Zero if reset success, otherwise will return error.
  */
@@ -186,7 +186,7 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 
 /**
  * amdgpu_virt_wait_reset() - wait for reset gpu completed
- * @amdgpu:	amdgpu device.
+ * @adev:	amdgpu device.
  * Wait for GPU reset completed.
  * Return: Zero if reset success, otherwise will return error.
  */
@@ -202,7 +202,7 @@ int amdgpu_virt_wait_reset(struct amdgpu_device *adev)
 
 /**
  * amdgpu_virt_alloc_mm_table() - alloc memory for mm table
- * @amdgpu:	amdgpu device.
+ * @adev:	amdgpu device.
  * MM table is used by UVD and VCE for its initialization
  * Return: Zero if allocate success.
  */
@@ -232,7 +232,7 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev)
 
 /**
  * amdgpu_virt_free_mm_table() - free mm table memory
- * @amdgpu:	amdgpu device.
+ * @adev:	amdgpu device.
  * Free MM table memory
  */
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
-- 
2.25.1

