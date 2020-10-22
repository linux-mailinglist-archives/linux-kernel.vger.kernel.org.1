Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A330295F40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899211AbgJVNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506706AbgJVNDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:03:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B3C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:03:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so2118869wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX1+Nd2NMN3YgumN5l7d/iU16tJSrs+AyQOv7OqussM=;
        b=OiEfgRwHO4RHB2ajFDtyhUv0emmGE3Mfj6csuFijExTsUCqStVBs9xPPiqio03ZED4
         Ds5kmkqvMiW/nWz/lawqt7iAjDUoh7Sz4SgE4HBWOcs7M8SxoWf23R81bvDTC21pv+N5
         KkYfLick8Hjahnd8KGEw4fO4VtlRfnaa+a/JKWZVTxLaam4XVek8kTyGoKHwlu8NBOwM
         jmUntjClG/VQET+rS+5H3TdlPexnFa++T3ju4p9OkesOz39TyCzD5iABkChZel/lTmnn
         g7Qfxw8DuH1LdTZF1DXkIM4A9ayUpxeS2fzYHo2RkyuTSgwsohCIp5qg3/K3ZQF0hZor
         A6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX1+Nd2NMN3YgumN5l7d/iU16tJSrs+AyQOv7OqussM=;
        b=GyPkMbn3C4+hRxlb0eLWtz1hH8IN0+iegDSlr05yIbEer7PHrSGZWGbwpXUeAGQNlZ
         FKMkAbQfjp7VA5+ajBmAawCQlRpWRhA+UY0zXdJP0xnwRqau2aHI15cNb3MflY+BJQY5
         TaxDlqO1XT9U2pyyrGHXkpNcO52VlObH4xzF3MrTxtgpTd53sbiqBKivBHV5fIfpFdWj
         iY10Wd5mrNYaLyX45lBzdJpYsVSqjyy6dGjelC9FpEYGDlFKpJOlF0oJqpBbct/U5FP/
         0T9yadapHb5jT2N1obBdfcusqKs5r5XqhCR9J72t11P/lK4+E+mef/u+GrXnfsOAMebn
         YUxg==
X-Gm-Message-State: AOAM53252dqbinxFPnI7stvOHdDXOvu4eY+lOiIWuvOYTKebL8D9/Dnp
        mymS0C1cl5UQPMuypz8Q/UO2UQ==
X-Google-Smtp-Source: ABdhPJwmfpkqQOZIduZK7eQOlIhxMw1GvztKPG1ikqKZEp5ek0w7uSuu53iY/P1EhvWosnvGkow31A==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr2317121wmk.127.1603371799182;
        Thu, 22 Oct 2020 06:03:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m12sm3705818wrs.92.2020.10.22.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:03:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Date:   Thu, 22 Oct 2020 14:02:54 +0100
Message-Id: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make use of devm_of_platform_populate to remove some redundant code!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 10 +---------
 sound/soc/qcom/qdsp6/q6afe.c | 10 +---------
 sound/soc/qcom/qdsp6/q6asm.c |  9 +--------
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 2f3ea6beb066..e4b3d566447a 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -601,14 +601,7 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6adm_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id q6adm_device_id[]  = {
@@ -619,7 +612,6 @@ MODULE_DEVICE_TABLE(of, q6adm_device_id);
 
 static struct apr_driver qcom_q6adm_driver = {
 	.probe = q6adm_probe,
-	.remove = q6adm_remove,
 	.callback = q6adm_callback,
 	.driver = {
 		.name = "qcom-q6adm",
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 688878a002a4..2efde6bd2123 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1740,14 +1740,7 @@ static int q6afe_probe(struct apr_device *adev)
 
 	dev_set_drvdata(dev, afe);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6afe_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id q6afe_device_id[]  = {
@@ -1758,7 +1751,6 @@ MODULE_DEVICE_TABLE(of, q6afe_device_id);
 
 static struct apr_driver qcom_q6afe_driver = {
 	.probe = q6afe_probe,
-	.remove = q6afe_remove,
 	.callback = q6afe_callback,
 	.driver = {
 		.name = "qcom-q6afe",
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index d745a02fcd5f..0965c0d4ac2d 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1724,15 +1724,9 @@ static int q6asm_probe(struct apr_device *adev)
 	spin_lock_init(&q6asm->slock);
 	dev_set_drvdata(dev, q6asm);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	return devm_of_platform_populate(dev);
 }
 
-static int q6asm_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
-}
 static const struct of_device_id q6asm_device_id[]  = {
 	{ .compatible = "qcom,q6asm" },
 	{},
@@ -1741,7 +1735,6 @@ MODULE_DEVICE_TABLE(of, q6asm_device_id);
 
 static struct apr_driver qcom_q6asm_driver = {
 	.probe = q6asm_probe,
-	.remove = q6asm_remove,
 	.callback = q6asm_srvc_callback,
 	.driver = {
 		.name = "qcom-q6asm",
-- 
2.21.0

