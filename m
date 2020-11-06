Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D72A9F78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgKFVuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgKFVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so2779848wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BAWNAgt/8o6t/4tV7E6hU4K4LH6BnOtAjU2sn0ZUiI=;
        b=TxSb65pMrJbCHOjX25f6OYd4V3p7wJVF4lcHGevOnmecoTAVwndthxXLhT3rNte7gY
         AxAnOEXF595IqOTv2Y5tl+q50a13jAGJ59jbWY73piaE9WrgUamD9uoaZbFhY8wJMRg2
         D1CJcaJ5NE9ZQKz0Q8+Es7snc67U/gUqzxXuX4Y6nXFEwrGx3ic3MXsvei2itMhLMVB8
         JVNmWtaKLiz5e3hAyW4MwkdidZUdfHiWY/HKn2rt37hARCWQPKS0ohh8s4047lOVBBrX
         S6un+r7uNWVJchl8piFvJz5DGC95hpA+4lq85jUn/8NZ4cRfK/K7b85Y78SdYlNn0Z4b
         M/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BAWNAgt/8o6t/4tV7E6hU4K4LH6BnOtAjU2sn0ZUiI=;
        b=g+7FmnXBGnCKlxUD6/gJzU2fQo3Cmt8SV9aIkvN+O8HjsEujMX3Kc2eJpicHa3DOOH
         Ct0c38vsQwNEB6nsay0swxsRwxS3FexnAlSlgqTrmJ02lXg9rsfuh4aJASOIcvIcagO2
         UAy+cSBOVqBLUVyP1C8U8rh87Q8BsQHs3U2JStJP+yQCJtNrEhMCgjaUnYFNoKSogrq3
         W3H8ZF2D7WjjM8hYSU68tYv8n8YiYd2lwCTgjcqnwftP3jpXx+dB2KJ0JdDCeS/e3LNU
         x3WRY9+IumHnpxg6FvxwcaD+yum1rLyE6+19Z2lxKt11rbAnlFg9vDsFe00KjBSzZBKd
         afLw==
X-Gm-Message-State: AOAM531SuPeitOpZOej/nZkXjpQieEze3ZWBr2qQ7CWoCoTvIWvYl51x
        Qb2rOA+M6SYfjQxTUnjNAyQ1iw==
X-Google-Smtp-Source: ABdhPJy3ISjKEsh/TLodAV9GaCzMV/+XKqTLBvTA/E2UlVG6XDxzt/sZfJ35v8GxQBN0sREoRPqZHA==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr1084417wrp.142.1604699417367;
        Fri, 06 Nov 2020 13:50:17 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/19] drm/v3d/v3d_drv: Remove unused static variable 'v3d_v3d_pm_ops'
Date:   Fri,  6 Nov 2020 21:49:49 +0000
Message-Id: <20201106214949.2042120-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/v3d/v3d_drv.c:73:32: warning: ‘v3d_v3d_pm_ops’ defined but not used [-Wunused-const-variable=]

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 9f7c261938312..a5bf09458451c 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -38,42 +38,6 @@
 #define DRIVER_MINOR 0
 #define DRIVER_PATCHLEVEL 0
 
-#ifdef CONFIG_PM
-static int v3d_runtime_suspend(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct v3d_dev *v3d = to_v3d_dev(drm);
-
-	v3d_irq_disable(v3d);
-
-	clk_disable_unprepare(v3d->clk);
-
-	return 0;
-}
-
-static int v3d_runtime_resume(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct v3d_dev *v3d = to_v3d_dev(drm);
-	int ret;
-
-	ret = clk_prepare_enable(v3d->clk);
-	if (ret != 0)
-		return ret;
-
-	/* XXX: VPM base */
-
-	v3d_mmu_set_page_table(v3d);
-	v3d_irq_enable(v3d);
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops v3d_v3d_pm_ops = {
-	SET_RUNTIME_PM_OPS(v3d_runtime_suspend, v3d_runtime_resume, NULL)
-};
-
 static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 			       struct drm_file *file_priv)
 {
-- 
2.25.1

