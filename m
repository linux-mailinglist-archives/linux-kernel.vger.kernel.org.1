Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5F2A8188
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgKEOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbgKEOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so2096762wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rv3e4lR5n3wbFt5a45993iZf/YGmwbWZWnMbXebEIvs=;
        b=XSREkBYK380J4CWNoXmcHRvUSexcxURarBudmCsFRVoIQ5vYDbDJky11tMykMICSa5
         4t9WSt6mx44I9x9YihMhfrnjm70iija84cbYr3L4NqZKBysrWKTcAV2f60BmrUPyFPBc
         uy2UBtjWg1mmBR2rV9UNTmvSNlis678WRkrwrShYsej7hOIa9wV1hL4KdbtQJtzxDpWt
         pdjB5XWNlS0fZTNFXn5zMylPY7TooJTMlFDSFAhcBEEuM3+ByEeXJGnioaHz511LVgxV
         vP5bJbK0TsnoToAaMHJdezPZ7VCMgyK37zQ060GU0rjX/IC+TOsbCJNFnwcMXfS16kho
         26yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rv3e4lR5n3wbFt5a45993iZf/YGmwbWZWnMbXebEIvs=;
        b=aA08QTfIDSSAaCCazi5dsfiaXrrEvlLQHW+dlfoARO3ZFnA8kj3Svx19gGYgVl0vdz
         AMGMKNzL05/rq4zPwp+nw6+Ih3g36GLkiFL03VpvVaZqPxLdeoj9fpWNVvUWiJvvqe7A
         wnVuecdy/OO/B7YsHB5yXa74xn+kz5WocsbNslneequ0cyVmoeZzf+wAj+CiQg8Z52ui
         nfd8GUOHwwMz6hOCXxeU0Ql/U+ffsSca5W85xgPkxQr1bvauGyGD30CsS9DQh8fYozi/
         GlTSaD4P7Qg8RrO3AHb+a4cdRRoIlelLJ/cGjxvEBF4ZPrWoy3mlkWS8g6+55IIwOLKx
         PrfA==
X-Gm-Message-State: AOAM533ZtNPkx4jtuN/zdbibkFCC2NataA/BMGlx78mPp6ewlFS34J3v
        nbkKBQ2QMKMW7yLaRMSjdnCmdPVxXHIzJE+J
X-Google-Smtp-Source: ABdhPJyRZrB38ZvyOkJUZt6MoLWccltE1b+bbQaqzlHiYSRu4qcXO2ij1vEYl45QgtpeTpFIvxmy+Q==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr3321445wrs.373.1604587953215;
        Thu, 05 Nov 2020 06:52:33 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/19] gpu: drm: radeon: radeon_drv: Remove unused variable 'ret'
Date:   Thu,  5 Nov 2020 14:45:13 +0000
Message-Id: <20201105144517.1826692-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_drv.c: In function ‘radeon_pmops_runtime_suspend’:
 drivers/gpu/drm/radeon/radeon_drv.c:455:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 65061c949aeea..f5f1cb700d873 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -452,7 +452,6 @@ static int radeon_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	int ret;
 
 	if (!radeon_is_px(drm_dev)) {
 		pm_runtime_forbid(dev);
@@ -462,7 +461,7 @@ static int radeon_pmops_runtime_suspend(struct device *dev)
 	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 	drm_kms_helper_poll_disable(drm_dev);
 
-	ret = radeon_suspend_kms(drm_dev, false, false, false);
+	radeon_suspend_kms(drm_dev, false, false, false);
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
 	pci_ignore_hotplug(pdev);
-- 
2.25.1

