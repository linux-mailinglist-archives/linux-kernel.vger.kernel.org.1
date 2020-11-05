Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA5C2A86C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgKETH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgKETH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:07:26 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6ECC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:07:25 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id w20so553376pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BgiHrklnpeZTNfHUUb4/9/03koRegsKFGWvFTDnluCI=;
        b=BQ/GK9ILSECdU6RkFDXdQ8h/kV97zEXhRiqF43KL4JQ02EvmZYyDQX8iljTDwvsxlk
         2KURmI63vEDuwxwkyxfBvt1+5rUT00ML/HZRRAOj/6W/BXz7xEI945mma7f77t9bggTG
         xryBjaLokvtkPgT31UTriTMo2C6mSt6kA3t18NvNgr7mgq34KurD2FXD2SHZ6qw2S0iy
         VyuXyphZz8aPTHnJ7eEzWgrfslyWZnwQRi8TpbRnqHaFluD9nLHNmRVAI9q2shklV1hp
         JexCegf6zGvyB/pj/ag/agnLS5lHCEijBHwSGmhv7PyANiL2gjbczwL2qis/nzppeaSR
         aDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BgiHrklnpeZTNfHUUb4/9/03koRegsKFGWvFTDnluCI=;
        b=o5ID8Tur1GcUsoJUsCecV84e1Fxq8fqKOXPNjT+lQW/q0o2v/iLbQ+Q/Ef8fXrWMYx
         0Os70SQxUHZN3KdZf4I1z4WOnSZ41E1hNYRUJ4dLBg+Jmcu/likDJW9InllNn/vSF0K1
         hVaThN/Bcy9tw1Fuw9cHCWgGSLNOFtj1hPfG67CT7OKCkgJn6UlUEulc2R1jnEB51FoU
         SXjfrV0uYHOuk6b+mRHyRcvRRxyeTZdrixHvGGQkYATr6XOVhLlIWDAe1IuW7NaTqBvv
         r1j6ESTkyNbi3ixA25XjzUzqVUUS+PZr2aa3U94XmjTE/oH+QqDcsYBuWniC+RzBqtQe
         mscQ==
X-Gm-Message-State: AOAM532bpAU7waAWnL3//fM1+gnsQ8E3aD7g+fapjLuwfQe4qnNb+9sv
        wMCwexjEtVw24cfGA8tYzLc=
X-Google-Smtp-Source: ABdhPJzw1QtrJdsbGtpN9Hgsb+fZFPtDupUe6LGfnX647S6DMfeeXsi+H9L4NS+pKucT9+mvxKLi2A==
X-Received: by 2002:a17:902:ed04:b029:d6:e878:1013 with SMTP id b4-20020a170902ed04b02900d6e8781013mr3461916pld.56.1604603245478;
        Thu, 05 Nov 2020 11:07:25 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id j2sm3190842pgi.48.2020.11.05.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:07:25 -0800 (PST)
Date:   Fri, 6 Nov 2020 00:37:18 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com
Subject: [PATCH] drm/vmwgfx: replace idr_init() by idr_init_base()
Message-ID: <20201105190718.GA89863@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier for this driver.
The idr_alloc for this driver uses 1 as start value for ID range. The
new function idr_init_base allows IDR to set the ID lookup from base 1.
This avoids all lookups that otherwise starts from 0 since 0 is always
unused / available.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 16077785ad47..cbedcb043803 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -540,7 +540,7 @@ ttm_object_device_init(struct ttm_mem_global *mem_glob,
 	if (ret != 0)
 		goto out_no_object_hash;
 
-	idr_init(&tdev->idr);
+	idr_init_base(&tdev->idr, 1);
 	tdev->ops = *ops;
 	tdev->dmabuf_release = tdev->ops.release;
 	tdev->ops.release = ttm_prime_dmabuf_release;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 31e3e5c9f362..a24d9363a17e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -675,7 +675,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	spin_lock_init(&dev_priv->cursor_lock);
 
 	for (i = vmw_res_context; i < vmw_res_max; ++i) {
-		idr_init(&dev_priv->res_idr[i]);
+		idr_init_base(&dev_priv->res_idr[i], 1);
 		INIT_LIST_HEAD(&dev_priv->res_lru[i]);
 	}
 
-- 
2.25.1

