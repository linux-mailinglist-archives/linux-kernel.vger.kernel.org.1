Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1088B2C3107
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKXToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKXToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5746C061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:12 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so71231wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/LGt8e6L64JAUL4CT/1IK4l3Dhv3BlKAOxBbtF4q2Y=;
        b=MEXHM1XESDogQHFfN3R4bynB0veB0Mi8lFjJtgfaZVWY5T8zvvbNN+2TlP9zYS1vHI
         6ESdKOievxShN8Cu7g04MDj+zHLSuErcwz3GRGoqe8nc0On0bv8drWOofDWVMObj44zn
         N86Zx52vI4kQ0f/LB0c6zQ2AhmPavlAJ8TwbKti0GwoW1hTjD8RgAHVaqRnwkkbF52rd
         +BvbH351Wdbh1h886XoNMPWoWrIKEw13vmaG9CZzvqOmA8LwSl8yJcs5hvKcV+AVmc1m
         0KGpQ0lfL6evjhd0DdKTcGJfqI77zymc/Wj6gNniRR699QG7F9yQdEuNfEuFt1HhoQkY
         GCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/LGt8e6L64JAUL4CT/1IK4l3Dhv3BlKAOxBbtF4q2Y=;
        b=igqDtyG547vDHw650zvVi5YTVrnzB/mmoEeuDKXYwLTicsrTzGnWXp91oSKcYVX1a1
         MXaAcI+Qh1m+y2/0kkhz+nbJp863mJXURE8PR32KLsBy71KHvEzTUPEhuclJBkOV2kk0
         g10eLFZCrzfoa8kG+qoljEvrue+IMH6X0Ez9BQN9eDmYOKgDqvFv6/6IblrJl1QofcaK
         Gg43XE03kEUBBPdMu+03u0pdqNB6VrCJ4ioV0OxHBj8o7ZoLVI3I74gIFA7h25Eg3wV4
         thDtxDzkhHHg/I6kaleGHXLFpAU2AGjKzLpyWxbesQesCGpN78cZBlUD6xSzjGxuhUZz
         IMAA==
X-Gm-Message-State: AOAM533N8QWTHleam5j5jgxP7MsBTrhRGshDd1rrnGp6f9JG+pt9S4ha
        8O3bkyIHJ7/z9FZfgEp3iCYIVQ==
X-Google-Smtp-Source: ABdhPJyxOoAxWaCxDE+GYFO65fr1bgljFI1ba7+hik2P3LFmw6uXan361fLLAp0T1omJO2iSZUaVQA==
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr49811wmc.149.1606247051472;
        Tue, 24 Nov 2020 11:44:11 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Sierra <alex.sierra@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 10/40] drm/amd/amdgpu/navi10_ih: Add descriptions for 'ih' and 'entry'
Date:   Tue, 24 Nov 2020 19:37:54 +0000
Message-Id: <20201124193824.1118741-11-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/navi10_ih.c:453: warning: Function parameter or member 'ih' not described in 'navi10_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c:512: warning: Function parameter or member 'ih' not described in 'navi10_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c:512: warning: Function parameter or member 'entry' not described in 'navi10_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c:552: warning: Function parameter or member 'ih' not described in 'navi10_ih_irq_rearm'
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c:585: warning: Function parameter or member 'ih' not described in 'navi10_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Alex Sierra <alex.sierra@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 837769fcb35b7..3338052b080b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -442,6 +442,7 @@ static void navi10_ih_irq_disable(struct amdgpu_device *adev)
  * navi10_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (NAVI10).  Also check for
@@ -502,6 +503,8 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
  * navi10_ih_decode_iv - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to decode
+ * @entry: IV entry to place decoded information into
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position.
@@ -545,6 +548,7 @@ static void navi10_ih_decode_iv(struct amdgpu_device *adev,
  * navi10_ih_irq_rearm - rearm IRQ if lost
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring to match
  *
  */
 static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
@@ -578,6 +582,7 @@ static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  *
+ * @ih: IH ring buffer to set rptr
  * Set the IH ring buffer rptr.
  */
 static void navi10_ih_set_rptr(struct amdgpu_device *adev,
-- 
2.25.1

