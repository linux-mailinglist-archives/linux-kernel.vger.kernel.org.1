Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D12C313E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKXTqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgKXToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B17C061A4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so99856wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEjMnBpqRZf7QYQfeBkVq9GHSjZiAa3R2MyumxVQjCg=;
        b=nQxuyfZyrLc6yy0cC6OO28iMpbA3g68SZwmc8nH+2WzT/A9hGEJWsdoV9Pxc9FrTRn
         Y/c8zmaIhPXEZQx6TDah7htFUQdimDx1ELdmxZn9dXhpmz/7eQqwSp/Pq1Ko1uRQkR1I
         yDp8naTL2GOals/p1vqjO5M0LkD/TcxmH4B09TqjFSGDdsVF3OmDxjriT1ZKrG5vHmQp
         sq75q3UBrxZX/Rl8P0JlAK6gKBWxHWJydUI1Aeoch5D4p1ibAfZdq/6ELCIyixNc9TsQ
         dGGkQsep1Mjz9ZkRSD2tveFZWf8wiwjJQ7OfTNU5ntPPVO1jGDghkvZBLVyLEU8XXK6v
         1eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEjMnBpqRZf7QYQfeBkVq9GHSjZiAa3R2MyumxVQjCg=;
        b=rcHs5QgedT+YPIU2tFRAU/20gjHYjbpAGiEoRChxt6d/XC85SzagnEqX4LQl6ZxZaF
         x0ZruTDji4Xk0zDUmjQvAoO7onM1/FV2kjxq6tl0Q97HrON9ycScEwjQ5n24QWzxmaCx
         bIorYTC8ljf+trBmlyD2WgWMQJlkwRg8KgsgDIImPrpAPkMRE34AYP3dbKqxIsDpbqep
         17ehDmubXAenFK08JrPk9ntj1/WZOX0jzw5GBrNiOTPk39jhWbkVdTRKLalJvw1664Tx
         ej1XvKvwSQlqT2bKfwqQyVUXnyvoiurdVWl2SF3ZG8wcVo6qUhwLF51TYhNBxldGiOuT
         UDww==
X-Gm-Message-State: AOAM530X6NdBrMiXk8mPIawaZg0maYc5avoUOtySafHalpbg6dCaFPhI
        phaQEm8xGhR+kIN/GveERz3QPQ==
X-Google-Smtp-Source: ABdhPJytaeH48vRIW7y5TgGrqNMtaoLUD+BjpD1p0QffcBspU2L6jVRH+drONjLcGY0K05OG+mFhYg==
X-Received: by 2002:a7b:ce0e:: with SMTP id m14mr170464wmc.17.1606247050295;
        Tue, 24 Nov 2020 11:44:10 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhigang Luo <zhigang.luo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 09/40] drm/amd/amdgpu/vega10_ih: Add descriptions for 'ih' and 'entry'
Date:   Tue, 24 Nov 2020 19:37:53 +0000
Message-Id: <20201124193824.1118741-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/vega10_ih.c:377: warning: Function parameter or member 'ih' not described in 'vega10_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c:440: warning: Function parameter or member 'ih' not described in 'vega10_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c:440: warning: Function parameter or member 'entry' not described in 'vega10_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c:480: warning: Function parameter or member 'ih' not described in 'vega10_ih_irq_rearm'
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c:513: warning: Function parameter or member 'ih' not described in 'vega10_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Zhigang Luo <zhigang.luo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 407c6093c2ec0..578fdee5b9758 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -366,6 +366,7 @@ static void vega10_ih_irq_disable(struct amdgpu_device *adev)
  * vega10_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (VEGA10).  Also check for
@@ -430,6 +431,8 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
  * vega10_ih_decode_iv - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to decode
+ * @entry: IV entry to place decoded information into
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position.
@@ -473,6 +476,7 @@ static void vega10_ih_decode_iv(struct amdgpu_device *adev,
  * vega10_ih_irq_rearm - rearm IRQ if lost
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring to match
  *
  */
 static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
@@ -505,6 +509,7 @@ static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
  * vega10_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to set rptr
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.25.1

