Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CF2B4D63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbgKPRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbgKPRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:18 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:17 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so25223wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
        b=vjRgiF3sSV4IhUHRkfrW6zpxaiOTAP5+ndmpMJ5njzwICymUi4FgUOeakjFqSbhu4P
         Ux+bCPQFOWiIKcYf5U+jGLeG+dNLaoDVDRnxbur3utiqelyXUWvmqV5okLCcKN+XHXGK
         3PTAT4CET3cVGb445Pcpfunq48d+MHHvGL8PFGirnEA9uULw5eR0b38qaAFibnFf2Kg8
         Vv06ZwvmKCQdSstEOvE6BbwJlK4BDuM8nEZo67fVcHjSfstZ/2DVeffUp/aDK3dofOkn
         3AsUz+crAA5fDsvaAni98zlrqW8tFV4fJAe46+wuXXTDPWp3Dt6Dr0c1P+61dZyZYABK
         cSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
        b=XJLPw7B9yNkdyAD4OfrnLMwXoplx3YOx/5KTaBmc9dH8ImvboRGokRKlk93zN1lrQW
         vukd32hkpoFDwPAXfTkpkjrqy/U4rl1RVWqF7yl6SGOYJZiYnFKrto7YiKQeG5RglPVV
         Vd2o5m+pnyvaE1TXTg9cKN5g8V49n7H4we754WFhXLpdPgBSPVYBoue3m80WWWQeAQW0
         dWupNZ5N1UXEvq0HrKulAa16BOo73/XFLVx3Ny7PckY15X5rg95wIjgvrbf6XoMAaWvh
         Ydp3wS5y+ROEfhQsK0tjntiGizLmErqPKKoxdnQ+fNcL8dq8tUXv+0iej3u6Xrl0Y36b
         QhAA==
X-Gm-Message-State: AOAM532ffWp5U9mzxh/tq+gmhGIdV2a14ZEYqbMR2beqZTOh4BBoQBkn
        tcQ/8TR29DjJdT2qIxwNghGECQ==
X-Google-Smtp-Source: ABdhPJxbzdfNIyAFT2LF3a9ZdTCAEIeELmy4y2jPN9Zvr+QlzxMIe75PBAOzGqb0m2oCDoDMXOde/Q==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr23442wmi.42.1605548235694;
        Mon, 16 Nov 2020 09:37:15 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/43] drm/radeon/radeon_irq_kms: Demote non-conformant kernel-doc fix another
Date:   Mon, 16 Nov 2020 17:36:25 +0000
Message-Id: <20201116173700.1830487-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
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

