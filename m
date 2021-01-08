Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7652EF8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbhAHUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbhAHUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95712C06129E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k10so8748717wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ToVqtfELMjein9lDL+03lGe+1Pl1kI6Nuvl2V02OQw=;
        b=nPDEIclvcchArGWcIIvap7p0tV/Rf2lx9TgJnp2hWX/nn04pew9eH1DzQvuV0oY5dO
         uYlPu7t+/BwZmmgpIRvGBX6xDjVNdvmLl+T2XbI2y544GNEB6poJK2wXefPMvuaFj0LP
         1bCfmVawsAnd5iffgC8cCaUk23jdkFMPX+hldzpdztsaQnGn2D8TM1pnYc4PdJ6sTXk3
         P1sqHnU5kzx2HnlGpQuZsYJ+pxTCkn5kn6mPH3fPIPc1QO5y/Xrw6NNIr/Q1c7Xnw8aQ
         r9Pdv/WXBOoNMt3BNY+r7SM95gZeSzHHPx7Kev1iki8AutO6xe2Cz9US+Kdjr5TXZeoz
         MdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ToVqtfELMjein9lDL+03lGe+1Pl1kI6Nuvl2V02OQw=;
        b=nLP9i187dcOwDjksN4XO8rlC6evWX/PANNTkMTUAU6Hsjhh1Wd2/HgXsSEftqXuatv
         rRixCCWktJem5FriXiUxQFtH/YsnxOlHbbf99cPntDiU/Ir5CPiJaiH4j10xtqQXKng4
         aRTeQiJhDQ7l7gI0JTKirEH3cEkw87ST9oyaj1tXDV1/Y4VrLujSFoA5iw0oRFGFVJMI
         ijwRXMsTVwaxXaqCETimOZWiTUUfQicCMnNrPHOXjaOJrws/I/1HVV9ItEfBYHQ8QLfc
         OygsWZUPuMViLltjAVMqxgmXSAMGjxJ/+bMu+Mh7p4uoj4GldtpSqlPkhGaNH/7ZWqVV
         zTGw==
X-Gm-Message-State: AOAM531EXdEmSzFVDss08Px16xiB3r8U4dld3lBpKtkhnhtDStVmXwiC
        IRWOPXYBUSoJR+KGFDeN13uYYw==
X-Google-Smtp-Source: ABdhPJwLriGozB2TPxioYAuJqC4MQxJsUyszHxe6cwB1QkejO+IfiqkrvkQrmnCI6WmGh/14mcUFyg==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr4586040wmd.159.1610136911373;
        Fri, 08 Jan 2021 12:15:11 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amd/amdgpu/vega20_ih: Add missing descriptions for 'ih' and fix spelling error
Date:   Fri,  8 Jan 2021 20:14:22 +0000
Message-Id: <20210108201457.3078600-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/vega20_ih.c:378: warning: Function parameter or member 'ih' not described in 'vega20_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c:421: warning: Function parameter or member 'ih' not described in 'vega20_ih_irq_rearm'
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c:447: warning: Function parameter or member 'ih' not described in 'vega20_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Feifei Xu <Feifei.Xu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 42032ca380ccf..5a3c867d58811 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -88,7 +88,7 @@ static void vega20_ih_init_register_offset(struct amdgpu_device *adev)
  * vega20_ih_toggle_ring_interrupts - toggle the interrupt ring buffer
  *
  * @adev: amdgpu_device pointer
- * @ih: amdgpu_ih_ring pointet
+ * @ih: amdgpu_ih_ring pointer
  * @enable: true - enable the interrupts, false - disable the interrupts
  *
  * Toggle the interrupt ring buffer (VEGA20)
@@ -367,6 +367,7 @@ static void vega20_ih_irq_disable(struct amdgpu_device *adev)
  * vega20_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (VEGA20).  Also check for
@@ -414,6 +415,7 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
  * vega20_ih_irq_rearm - rearm IRQ if lost
  *
  * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
  *
  */
 static void vega20_ih_irq_rearm(struct amdgpu_device *adev,
@@ -439,6 +441,7 @@ static void vega20_ih_irq_rearm(struct amdgpu_device *adev,
  * vega20_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.25.1

