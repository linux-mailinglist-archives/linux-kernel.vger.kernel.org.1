Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793C62B2DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKNPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgKNPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:21:10 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18492C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 07:21:10 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 199so12445059qkg.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hPmKg3FYk3Lzs70K/NYX4J1DHPtpY/HdRoRb6lm0KnA=;
        b=pJascp7VGYt/H6n29g64kblStEJQHiJchoF3UWHdzGdpjG81mpnsko/3z8m016I0IF
         QLUAPyXMENTvrzyVFNTy/8OdnM+2B6l3cHde4uEAwzpo48nwwjzvRhZSlnEwofdu6gOj
         vKgha1gL0RcUMSJ4YOAY1CCHnhKzaLg3s1rBHAxLgEtGt9xs1jzDcGxhJiAj9LsldP46
         QcSXOwRli2V706fEv5gpY3q+Nfhy1/Q4nvGECR5Xxdxsutm1e3EGO54vbYtv9hjVQqtX
         TWJknmynolLMmfZXxaacPwU9xBTpnG5YEpgEXoAOoCI6iNZ7NYnpHvxpZLfe9onNNIy+
         E9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPmKg3FYk3Lzs70K/NYX4J1DHPtpY/HdRoRb6lm0KnA=;
        b=hbKNd3Kzoh/ErVJPKcDNimj/R94pETA4e2UMgeBF6Z54QEoG87xYOwjnZcJjbdIOsU
         uymQm6WSadl74LeftA65ptox8gXIGOyI+9jT6ZtiVwniwh4McHHoTV7kLe9HkhwaRCen
         UwQ311Y2Ft1RAuzJWNZe09Jw+8bbJXt0tVljUWo/j+5mneCDxqd54B7Mxe6ll7ExCU9m
         aOIRUSrIC7+3658iIbXsWZBe9c5ewuyc3dgA/SyN3VPXWB807xci9U0SaoW+6/N16O5w
         aBF+He6KRJMTR3MhxSpNxuWFqXGv7YxkZR15uXEZDGc6Em2stlhXtQXJuy3FRPZ3BThJ
         poXA==
X-Gm-Message-State: AOAM533p7d4XMxCJMo+QmbYhJZuHToEziqGiwEzF2yn5x3dpLEsp8qQx
        QQkoEmBAxJGbssbIC45FsKP5sw==
X-Google-Smtp-Source: ABdhPJzgscgk0ohNXdNYoDcxxdIkRC8kNTlyMvItOc3OOIL+2bEmEN+MGO8+p9C4UiNuw9dUFWyyaw==
X-Received: by 2002:a37:2f43:: with SMTP id v64mr6878299qkh.127.1605367269282;
        Sat, 14 Nov 2020 07:21:09 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id h125sm8888368qkc.36.2020.11.14.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:21:08 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org, hch@lst.de
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v2 3/5] drm/msm: call dma_direct_bypass()
Date:   Sat, 14 Nov 2020 10:17:11 -0500
Message-Id: <20201114151717.5369-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201114151717.5369-1-jonathan@marek.ca>
References: <20201114151717.5369-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always use direct dma ops and no swiotlb.

Note: arm-smmu-qcom already avoids creating iommu dma ops, but not
everything uses arm-smmu-qcom and this also sets the dma mask.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/Kconfig   | 1 +
 drivers/gpu/drm/msm/msm_drv.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index e5816b498494..07c50405970a 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -20,6 +20,7 @@ config DRM_MSM
 	select SND_SOC_HDMI_CODEC if SND_SOC
 	select SYNC_FILE
 	select PM_OPP
+	select DMA_OPS_BYPASS
 	help
 	  DRM/KMS driver for MSM/snapdragon.
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 49685571dc0e..bae48afca82e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/kthread.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/sched/types.h>
@@ -1288,10 +1289,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	/* on all devices that I am aware of, iommu's which can map
-	 * any address the cpu can see are used:
+	/* always use direct dma ops and no swiotlb
+	 * note: arm-smmu-qcom already avoids creating iommu dma ops, but
+	 * not everything uses arm-smmu-qcom and this also sets the dma mask
 	 */
-	ret = dma_set_mask_and_coherent(&pdev->dev, ~0);
+	ret = dma_direct_bypass(&pdev->dev);
 	if (ret)
 		goto fail;
 
-- 
2.26.1

