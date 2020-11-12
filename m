Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC62B0D21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKLTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKLTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:00:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B05C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:00:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so7132426wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zw4/3H58DclPUryUYajc25e3NyANX/uApXUC9a6irt8=;
        b=bgWa0+Br46K2f9cJcIoWiHatx+XZjXt4+HVAL0qFLplwDys63qQgg/LK5a21NfQA9L
         8EAXKlgh7nQTW1R6FD75ZYHnq+8lTfi4DGRZOb5hdMaVAYkTaJjlHCq0BLmMKRR7TpNi
         bMnmV9WWrZ5QkUV2JGlo2bCMHfEKU2jQbtRCQwzwkBh1Czg55uoMo3Wtf03L8QeFwL6u
         Hy8qH5DZrhrRvRC24d68W5iNxZYnREggOEp30K/dHyOd1CHMrsR999bt1rHU5mPMNqJY
         SSH69rINO6PADc5ZiszGLW5qNqlHrE+8zjyzXAEVUHz479E1gjQtFaQqlYkxy3lNI6Xx
         SXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zw4/3H58DclPUryUYajc25e3NyANX/uApXUC9a6irt8=;
        b=ZoQk+b88S5N6ZP+r5Ux6hof+ktQ206iDFQ4toV5zY/PwAETNHSWZ0gJD5MN7xIDP7t
         6nC03CLVIxfY1AWsddOzi4RbLs2NTZIFAMIoV+WB+5N+60xQxRe3xjyC/0XVYys6NaxX
         hndrPSLZvVEpfZNkFhuDkNozfw6rfFFTs8s06hSKliP/tU4pb8VoP449DSJlXTWaMs0H
         vAeXABF7nCrg9TuEBSpol1jTKfnOOgY8gNO/Ly5Hia5h4LgO42EfLewEGtJqRuihAYzC
         qq/zx1XEBdZrNa4cfqPLhOgyE4zUhH8h+Ljm+fY+4hbkF4ZJUr7KLTGlrCJdoVDkJC/p
         hOvw==
X-Gm-Message-State: AOAM533fV1PDgqE5nza40DkNeUwE8K3F+3M3pRhXfDSjF+PMEgtnbCEJ
        NYkW/ClW0pT3Zh+Jviqd13kglA==
X-Google-Smtp-Source: ABdhPJxxwFYZtMQX5DH7hJKIUrjEBbmXGyRjjXYs/MLIPQVaWJDaZogWWz8Cc5Qz/4L83VgvX/sopg==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr1062991wrr.343.1605207645290;
        Thu, 12 Nov 2020 11:00:45 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:00:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/30] drm/savage/savage_bci: Remove set but never used 'aper_rsrc' and 'fb_rsrc'
Date:   Thu, 12 Nov 2020 19:00:10 +0000
Message-Id: <20201112190039.2785914-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment about them (also removed) says:

 /* fb_rsrc and aper_rsrc aren't really used currently, but still exist
  * in case we decide we need information on the BAR for BSD in the
  * future.
  */

Well that was written 12 years ago in 2008.  We are now in the future
and they are still superfluous.  We can always add them again at a
later date if they are ever required.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/savage/savage_bci.c: In function ‘savage_driver_firstopen’:
 drivers/gpu/drm/savage/savage_bci.c:580:24: warning: variable ‘aper_rsrc’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/savage/savage_bci.c:580:15: warning: variable ‘fb_rsrc’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/savage/savage_bci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/savage/savage_bci.c b/drivers/gpu/drm/savage/savage_bci.c
index 6889d6534ebab..606e5b807a6e7 100644
--- a/drivers/gpu/drm/savage/savage_bci.c
+++ b/drivers/gpu/drm/savage/savage_bci.c
@@ -573,19 +573,12 @@ int savage_driver_firstopen(struct drm_device *dev)
 {
 	drm_savage_private_t *dev_priv = dev->dev_private;
 	unsigned long mmio_base, fb_base, fb_size, aperture_base;
-	/* fb_rsrc and aper_rsrc aren't really used currently, but still exist
-	 * in case we decide we need information on the BAR for BSD in the
-	 * future.
-	 */
-	unsigned int fb_rsrc, aper_rsrc;
 	int ret = 0;
 
 	if (S3_SAVAGE3D_SERIES(dev_priv->chipset)) {
-		fb_rsrc = 0;
 		fb_base = pci_resource_start(dev->pdev, 0);
 		fb_size = SAVAGE_FB_SIZE_S3;
 		mmio_base = fb_base + SAVAGE_FB_SIZE_S3;
-		aper_rsrc = 0;
 		aperture_base = fb_base + SAVAGE_APERTURE_OFFSET;
 		/* this should always be true */
 		if (pci_resource_len(dev->pdev, 0) == 0x08000000) {
@@ -607,10 +600,8 @@ int savage_driver_firstopen(struct drm_device *dev)
 	} else if (dev_priv->chipset != S3_SUPERSAVAGE &&
 		   dev_priv->chipset != S3_SAVAGE2000) {
 		mmio_base = pci_resource_start(dev->pdev, 0);
-		fb_rsrc = 1;
 		fb_base = pci_resource_start(dev->pdev, 1);
 		fb_size = SAVAGE_FB_SIZE_S4;
-		aper_rsrc = 1;
 		aperture_base = fb_base + SAVAGE_APERTURE_OFFSET;
 		/* this should always be true */
 		if (pci_resource_len(dev->pdev, 1) == 0x08000000) {
@@ -626,10 +617,8 @@ int savage_driver_firstopen(struct drm_device *dev)
 		}
 	} else {
 		mmio_base = pci_resource_start(dev->pdev, 0);
-		fb_rsrc = 1;
 		fb_base = pci_resource_start(dev->pdev, 1);
 		fb_size = pci_resource_len(dev->pdev, 1);
-		aper_rsrc = 2;
 		aperture_base = pci_resource_start(dev->pdev, 2);
 		/* Automatic MTRR setup will do the right thing. */
 	}
-- 
2.25.1

