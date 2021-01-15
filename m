Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7CE2F7117
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbhAODow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732584AbhAODou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:44:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEBCC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:43:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so3997711plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9PD4ybSHZrcBjqJdCoM6Loutk4FCNAKb8nE3vMhAu8=;
        b=ULgpNlpghQ9NJjD5vXpJkCkxc5lpEZk+FKzDxjuV8U3gtUVPgS4zRvph+8sD0vuzHU
         kQvyNzl5N3kMb/BVxk35jR/bz8moMQ5n3zKWW/F/acBIEglyH5B4zMCpZlXDCXfv1SOb
         9h8ceUKhgzwe8+Hym9qjEKTFdhJwMjbVNZKdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9PD4ybSHZrcBjqJdCoM6Loutk4FCNAKb8nE3vMhAu8=;
        b=I6T+nBar9g0S8A50E669YCJsID7MDetvmvSwrT3xC5iBDXjM0HQ+IX40AmbZPnLVj6
         CECxpWZXRtaWnqwbCFpPDycBgBvmsP2FVNaSTnR0gwKYT/7qFIOeQqDluQHiNuc3IoM6
         SNViKvuqXnTbj0SufovF31pPcKL1KE5UA7d0q+CKfAz5IRDfkCF5SEOFHgntU3r1+/Q9
         01ElOJZuGpeN9eDlwhoHO/Q/aKwuBFmfyM7/ZbPmYEe9ZHh9caYwLmZHJ7PFKXgrqoET
         1ZUOwyOQCL5/UgysZnpuUCO96p42T7Yw5DNUNKchtY/1k2w2ozKdjjd2gJFKLG+wMmQh
         oeHg==
X-Gm-Message-State: AOAM532EWu2XSOPv2vbGK2k2aFQ91zBimTRYphc4tfv0LKkmFnE4E03u
        9ttZ1i8ewJ4fVfOvQZdngT1hew==
X-Google-Smtp-Source: ABdhPJxzUj6LzFxBo07BcRycwd7BfBvw0qIjiQ85/31Woj+IflcM3doIGxugpkX9nsBytclcZTlsrQ==
X-Received: by 2002:a17:90a:4042:: with SMTP id k2mr8498240pjg.160.1610682213617;
        Thu, 14 Jan 2021 19:43:33 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u12sm6499062pfh.98.2021.01.14.19.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 19:43:33 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        alsa-devel@alsa-project.org,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 3/4] ASoC: qcom: Stop casting away __iomem for error pointers
Date:   Thu, 14 Jan 2021 19:43:26 -0800
Message-Id: <20210115034327.617223-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to cast away __iomem when testing with IS_ERR() or
converting with PTR_ERR(). Modern sparse can handle this just fine.
Drop it.

Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Cc: Srinivasa Rao <srivasam@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/qcom/lpass-cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 40126202a4a3..b267fe8db3fc 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -788,10 +788,10 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
 
 	drvdata->lpaif = devm_ioremap_resource(dev, res);
-	if (IS_ERR((void const __force *)drvdata->lpaif)) {
+	if (IS_ERR(drvdata->lpaif)) {
 		dev_err(dev, "error mapping reg resource: %ld\n",
-				PTR_ERR((void const __force *)drvdata->lpaif));
-		return PTR_ERR((void const __force *)drvdata->lpaif);
+				PTR_ERR(drvdata->lpaif));
+		return PTR_ERR(drvdata->lpaif);
 	}
 
 	lpass_cpu_regmap_config.max_register = LPAIF_WRDMAPER_REG(variant,
@@ -810,10 +810,10 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-hdmiif");
 
 		drvdata->hdmiif = devm_ioremap_resource(dev, res);
-		if (IS_ERR((void const __force *)drvdata->hdmiif)) {
+		if (IS_ERR(drvdata->hdmiif)) {
 			dev_err(dev, "error mapping reg resource: %ld\n",
-					PTR_ERR((void const __force *)drvdata->hdmiif));
-			return PTR_ERR((void const __force *)drvdata->hdmiif);
+					PTR_ERR(drvdata->hdmiif));
+			return PTR_ERR(drvdata->hdmiif);
 		}
 
 		lpass_hdmi_regmap_config.max_register = LPAIF_HDMI_RDMAPER_REG(variant,
-- 
https://chromeos.dev

