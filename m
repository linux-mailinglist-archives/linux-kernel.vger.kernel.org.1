Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627062B4CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgKPRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbgKPRaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05205C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so19573410wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
        b=ZBnRjH5bHdD/fr6ODOIv3yB6B8MvWEu+w+dRaMNIJ4yj/v3SIIw+od+35JUs/9KuDj
         6EvYZOlRHK6d8G5VJC6PLs36kwAf6UNWM/yp0+plhP0iT2JasQSq7sbtCZBmG7RW6I/y
         CPHErLD7H3mfTjWmpJe+4+Iw8jAixy/VmX9ZGE0ATZOsIOYh0HotctE6qn7L3M6MGr1Z
         +35D5kBsbJuc9PJh3i5k8I2oVKNMPpvyShGgTjIfeimqPDkzv8iOUMk03rUMgfHR0aU4
         1EvaXPkzLiEBYvnXqyRSYdGLmg4zeP1xgEzByo1a2XjImHxIyIMaft1/2IqoHjk+6l9D
         oZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
        b=rM5pmvS4pwNwoYniHbvrpfRSCsQWX8UrNvkh0zetgttiAbjmkWfrLTgsbqFjh5zV60
         Jpzzf9PF8otQZ8gvOz7XXSTz6ecZj6yvNRnmKSt5Cu1ikFtLL7YG31JswKI8tSL81JH4
         98lPnP7/EoHF3Bh23ppc41JtazP1aMQNmvG8n7+BEwyqItvxatbZNiZKFltpVA/J2OPC
         WHafh5n17yc4EgNbAbvX3RDN4VpltMUURwx/LVAD6lBXk6T1UcGpheUK9RHCAMvqVlEc
         mVF8lGWRURP5Pgy8JeeQJDR2daRBl2sPaMA4Q1w5GppPC0UnGKKMP2p0cxx6b/K6TPTO
         UKxg==
X-Gm-Message-State: AOAM533rXg988MOkp1uE0cCB0jtmU41Yjv2rPbS9QzwmZ5sZatLa9i/k
        NBWKpyZu6w1hV9srx+q3qlF5iw==
X-Google-Smtp-Source: ABdhPJw8KV+7wDQGTEX7r+P3jFUndKbF178C178OZT+4NFAaB6TbWQSLwP68uPGl6BK/lRpgQ3Mreg==
X-Received: by 2002:adf:e287:: with SMTP id v7mr21598502wri.252.1605547819721;
        Mon, 16 Nov 2020 09:30:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/43] drm/radeon/radeon_irq_kms: Demote non-conformant kernel-doc fix another
Date:   Mon, 16 Nov 2020 17:29:30 +0000
Message-Id: <20201116173005.1825880-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_irq_kms.c:56: warning: Function parameter or member 'irq' not described in 'radeon_driver_irq_handler_kms'
 drivers/gpu/drm/radeon/radeon_irq_kms.c:56: warning: Function parameter or member 'arg' not described in 'radeon_driver_irq_handler_kms'
 drivers/gpu/drm/radeon/radeon_irq_kms.c:571: warning: Function parameter or member 'n' not described in 'radeon_irq_kms_set_irq_n_enabled'
 drivers/gpu/drm/radeon/radeon_irq_kms.c:571: warning: Excess function parameter 'num' description in 'radeon_irq_kms_set_irq_n_enabled'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index b86bc88ad4308..a242b6053d47e 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -43,11 +43,9 @@
 
 #define RADEON_WAIT_IDLE_TIMEOUT 200
 
-/**
+/*
  * radeon_driver_irq_handler_kms - irq handler for KMS
  *
- * @int irq, void *arg: args
- *
  * This is the irq handler for the radeon KMS driver (all asics).
  * radeon_irq_process is a macro that points to the per-asic
  * irq handler callback.
@@ -549,14 +547,14 @@ void radeon_irq_kms_disable_hpd(struct radeon_device *rdev, unsigned hpd_mask)
 }
 
 /**
- * radeon_irq_kms_update_int_n - helper for updating interrupt enable registers
+ * radeon_irq_kms_set_irq_n_enabled - helper for updating interrupt enable registers
  *
  * @rdev: radeon device pointer
  * @reg: the register to write to enable/disable interrupts
  * @mask: the mask that enables the interrupts
  * @enable: whether to enable or disable the interrupt register
  * @name: the name of the interrupt register to print to the kernel log
- * @num: the number of the interrupt register to print to the kernel log
+ * @n: the number of the interrupt register to print to the kernel log
  *
  * Helper for updating the enable state of interrupt registers. Checks whether
  * or not the interrupt matches the enable state we want. If it doesn't, then
-- 
2.25.1

