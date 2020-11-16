Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614312B4E44
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbgKPRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387838AbgKPRmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:11 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B6BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:09 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so57501wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdkaNwQj8NyYLTZAwxAzCnUjBubyLoQ1IDILNJ47mBc=;
        b=KYfB0p1J8ty+Ajm53YV2GUUYUG37fGMs+sTFghOyy81qeMcYCCBI0/1BHv2PUUIjDE
         YJYsC/JCj7JtTZj3LyeZyJ1ma6n7LJCEiHH/ECiJExw5fRbRQdumA6Nqr77uK6bjFOuI
         BdrOz9vOe7aKsV8/DI8+LaFvwRQe2SdAvBaMINlVnHFLwMn2zrcuItOO7epWpzEzcjjy
         LL8GNS3NJxYFhMeaQpdHZhvjk7TSm74KER7gMmo4vmP71LM3IdxdizLCIdPV2MH7hQ17
         JfRc3KXZvX7Yqz6mbHZE9RjWwh5uzsQrwJoHLX7oWExRQ5v6vbpRbZzjuFUDhyOTxtV2
         42Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdkaNwQj8NyYLTZAwxAzCnUjBubyLoQ1IDILNJ47mBc=;
        b=eggYh/xLfLLhY/d8oLz3KIK7gFPugMgQygnArvNuDlgvHXIvGqx24S5do69SoOhK+j
         6qqx7rNpwMSFo7//2blNRybTqWNRtyGTwyB1k8tX6XjI2HJWOj3W5eK+NstmTiPCxZnh
         DLkvDHUIOS2HwKQN7avpcebK/pYExLF5RFr6h3UxQHSmqkV4XHWbwdnoxVbEqgUC8JIo
         rdVLNkwK1zfqDrfKS+NoLFSrmzfiWadSy5v7kcLwedvihEeODlQkBOuEyv+W06ko5bZb
         FdwpP1w8gr3+svf0GwJbdLmR16xdutEM/H4M/ucG4ZkI6c4BIf8XHosNXEQ8cWo7nNKX
         qKgg==
X-Gm-Message-State: AOAM531DJNrNQtmByjKjpKtm5xmDGzIEvzRPeGkJXSp8B4azMKS2ls2Z
        DoK+5DTjMWm6PZoXOYsgvlnkGA==
X-Google-Smtp-Source: ABdhPJy4j2soVkwNqRi5Mut8ukSXC78cgBDynmPGR3xvRkypNFcub1qJ/G6B6xgySH2RieWkvkMAcA==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr17523wmi.164.1605548528328;
        Mon, 16 Nov 2020 09:42:08 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/42] drm/v3d/v3d_drv: Remove unused static variable 'v3d_v3d_pm_ops'
Date:   Mon, 16 Nov 2020 17:41:04 +0000
Message-Id: <20201116174112.1833368-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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
index 2da0c1180bc69..42d401fd244e3 100644
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

