Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5242C312E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgKXToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgKXToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:05 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FAC061A52
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so86194wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1J0FZrjGGbUvQrx4IUztzi5KvWWyU4p9mOY8CTJ3cA=;
        b=QXlVUxy6zeD7fG03DNRKZjOqWu/z5RftRerC7Nod0O6W82BFawtqlxypHgaR1y9cfS
         k4JVEcy4z2Sokjv0yUDlvFXL5rq2nVg+yG/XbM1ihly/c3pBUyKJBBqvWsEU772LQEJi
         IWtiAhdZe3S/MYFSU926bn1kXQwdlXGWXdZ+XUY5cN4hL72ZhijYDA/HDl1sh1wAwNu5
         XHyg/zNL2MIRxkfwfrh8n2HtZZohtLXDT9KfKPmgENUntqkpNScWvK+SWC/Pfwfq38MM
         P4fDdeodGJmFfOFLqHbuJ62dssNCTGpSfSnlew6jTU30F5HKWC0TY1t5QwaH7HwKEP+v
         vhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1J0FZrjGGbUvQrx4IUztzi5KvWWyU4p9mOY8CTJ3cA=;
        b=JIDM5LdNIC9wAQDxknRqNl9krRntawxtotanxBbcJt310T/9AalRKXn758/wHyQalk
         FyHRU5p9QeeGmJEH4n/nFUVDCKOywJQ7tbOGoeWthVuLMnFGo/cTnPpJi8WUPyEb0oKT
         B4EtFCCNCKQdpaSfuR2mG2N3bqOK0cIw3q31h701n/9HwVxIPJBpJN57BG3rlcKt7v9K
         YBT8GHXpX2q5MopiGwKeNfY/dHp79H90qDHdu1NkP2YJuqH9QpSrn+XGepxCq0ZXlTob
         Lk56QR5fYJ55Um3PaBme1j1T2fmfgbSo7nPucfxdrDCoVrElExMh28KccyZ7GFJQD3nh
         CiaA==
X-Gm-Message-State: AOAM5319UFqI0zHMqPRFsGDczReyKw+qI3wRXm9IW2B2GnGnL1MsSjuo
        6xvv4OamAt7rcaZZl6RO8MG5CA==
X-Google-Smtp-Source: ABdhPJxc2TNfGqS0ggO4k/it/goFudlMzzl3LPT5tEdGbregUV4F60QAMLaiU8tsX9d38vnfFQcSEw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr134617wmg.163.1606247044173;
        Tue, 24 Nov 2020 11:44:04 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/amdgpu/iceland_ih: Add missing function param descriptions for 'ih' and 'entry'
Date:   Tue, 24 Nov 2020 19:37:48 +0000
Message-Id: <20201124193824.1118741-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/iceland_ih.c:191: warning: Function parameter or member 'ih' not described in 'iceland_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c:223: warning: Function parameter or member 'ih' not described in 'iceland_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c:223: warning: Function parameter or member 'entry' not described in 'iceland_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c:253: warning: Function parameter or member 'ih' not described in 'iceland_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index a13dd9a51149a..37d8b6ca4dab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -179,6 +179,7 @@ static void iceland_ih_irq_disable(struct amdgpu_device *adev)
  * iceland_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (VI).  Also check for
@@ -213,6 +214,8 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
  * iceland_ih_decode_iv - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to decode
+ * @entry: IV entry to place decoded information into
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position.
@@ -245,6 +248,7 @@ static void iceland_ih_decode_iv(struct amdgpu_device *adev,
  * iceland_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to set rptr
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.25.1

