Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB18E2AC6F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgKIVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbgKIVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:27 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D687C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so9575862wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tr0ixvpAne6ZdwZHnMFSb4ufpkRvb3k+F4potoikpiI=;
        b=gos6PdJK9eoOZt5jAVidZVPiNSp7oMO7v/VwIq7DXK6v8BMHqbyy322XdWXNcfBWKf
         rYyWHR0GBx0IoFGoaAXbiyoTaY9cr2uiACim4xVlAVhQp/drKv8pdLkhLS/HH5Kkx5md
         tol4j4FQeDeqF37INsLFh+mswbJiu4IN7tG/6B56wbIe2ENo8DXUBHxhH/Q+KYN9N6oH
         SelA1dZwpqUDcK+AXu+wxqkKMHHFLCicP4Uu5f2aAIJHV65JPoXv5nKByQNEr4PA1sO/
         nexs/LOKUrdFkJwytG62ilL+tRypUFvudMmo0ni9onyE480ckbyN2peZV9UCw2Qys3c0
         PIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tr0ixvpAne6ZdwZHnMFSb4ufpkRvb3k+F4potoikpiI=;
        b=t6NLuyNmeQD0JOA7+SNo+a8i9NREc9StTdMre/bSsmX5aBZSIfJT7JxdBH24MZobBj
         gX1kYVkD7Zvs7KPGlaoGgiTSjbd2aDmJXOJSA3N4H7oa19z8UJXIu6KqvwQIUniNvlbZ
         ziYHPf2HGHDgl/pMphkp6xBxNFb56cY10rnLPTsLghGccZsOygx1kSqVYNkjFXH9Skko
         L7rtdDrIaa3nnc1XG0k326/WzX3sgybMsZ/gJBNLmgGjjSva6GC45QauzCpRtNpm2XoG
         /aLY+m4QmCpjYlpcJa3JS06NBcKTZg6KYF+FHCXPF8N6UUh8Vknr/HY8ZpLWCpBrorTh
         FIUQ==
X-Gm-Message-State: AOAM533JqSg7B9FR5S7Hi2ZgiEJIC+IkEpXQ/fvjjes7cmHcB4+YAAbo
        pDMisOw9OisHgU9Dod3d0X+pnw==
X-Google-Smtp-Source: ABdhPJyBmNq1JIYMn1Ln21eExIKIRlKHSenjgVq526BS9p+l/W7PscsUXFgUiNU3unXijKsSI7AghA==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr11354521wrx.367.1604956765807;
        Mon, 09 Nov 2020 13:19:25 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/20] drm/radeon/radeon_irq_kms: Demote non-conformant kernel-doc fix another
Date:   Mon,  9 Nov 2020 21:18:44 +0000
Message-Id: <20201109211855.3340030-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
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
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index b86bc88ad4308..3521084030d24 100644
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
@@ -556,7 +554,7 @@ void radeon_irq_kms_disable_hpd(struct radeon_device *rdev, unsigned hpd_mask)
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

