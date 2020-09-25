Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5803278EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgIYQgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:35:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D06C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:35:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so3677612wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bpd0ex9vvY6SQ5en4jWq2M6OKTm6oUME3P+ZpZGPI6s=;
        b=zyX82bt+ytgyrk0f8RwzH58E0OfhMMqY4i9QNq2hlE+OzJ6A8byCHFixtWFxJji7ab
         9lHFpmIwEE2gEvUpODGZlnvcnITt98a0hj4+cHsCbUBOwDDIdy5dGUaZGKy0R5bC0Llg
         BNwqX3OJlS1wL/zTNpAl0icxs88BJJq/Li0k14roL19lJDDq4gOb1RZvJfytWg4vkOUw
         2mAmGK6NDbgLICCJ7AuO/Q/SO23Q4K8bk4Togq7ifTrtQ49tLHevh09d4J08vGU0akeR
         5YPZDCS/YBWOKGg2A5CoEKkiHUKl/RA6sHJUKGYLFojRFF0ZGSPX1D603DFAk/XiNgrG
         sv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpd0ex9vvY6SQ5en4jWq2M6OKTm6oUME3P+ZpZGPI6s=;
        b=o8Yz245TRl9Ex0EZbtUTz50AItI9WAQp7NqEkllKnGXpupuKnqNbxgpVSkMJNxm8pr
         GBiMr+s77JABStIQ5cshpq7giP3XPddISStRNEJscF9BUMrViwDZRnswXx22ZEJaU9V1
         hEQ3xQcwdRi1M2bFT9F60VPuKYp95StwUuG+xn4kHWb5nzIyhqKSOEo9CqdzWobc/8h/
         G/U7r0l/B2miNehJrP1pLsrTheepetzn2qNiI/4WGGaYArtkVwTjHr9BGHqBpQS9/TE/
         CV3Ua9EdIzPCJSVAJubzxecjmp+51Be9+4AZ6HKaMo+J5XlxR0UEpnG2IjjiZLvI6OVz
         BebQ==
X-Gm-Message-State: AOAM5310OnZOsT6eCTd1OvG9ArrAUk9NUGyY4eUk2Kty8c3eqWLLwF2r
        JM9fVXF333KgNN//ZC2GrPDp+w==
X-Google-Smtp-Source: ABdhPJxCqksHMhJ5v/p3c6y2QZzOnEUWDGqb0X0nE9xPUfRvg+gK84eHkkl2RNzUwq5OiElLpfIAjg==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr4075058wmg.178.1601051756621;
        Fri, 25 Sep 2020 09:35:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm3733883wro.18.2020.09.25.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:35:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] ASoC: qdsp6: add ifdef CONFIG_OF around of_device_id
Date:   Fri, 25 Sep 2020 17:35:51 +0100
Message-Id: <20200925163552.20717-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
References: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ifdef CONFIG_OF around of_device_id table to fix below
W=1 compile test warning with !CONFIG_OF:

sound/soc/qcom/qdsp6/q6afe-clocks.c:254:34: warning: unused variable
 'q6afe_clock_device_id' [-Wunused-const-variable]

Fix this warning for across all qdsp6 drivers.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c        | 2 ++
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 2 ++
 sound/soc/qcom/qdsp6/q6afe.c        | 2 ++
 sound/soc/qcom/qdsp6/q6asm-dai.c    | 2 ++
 sound/soc/qcom/qdsp6/q6asm.c        | 3 +++
 sound/soc/qcom/qdsp6/q6core.c       | 2 ++
 sound/soc/qcom/qdsp6/q6routing.c    | 2 ++
 8 files changed, 17 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 2f3ea6beb066..72f29720398c 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -611,11 +611,13 @@ static int q6adm_remove(struct apr_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6adm_device_id[]  = {
 	{ .compatible = "qcom,q6adm" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6adm_device_id);
+#endif
 
 static struct apr_driver qcom_q6adm_driver = {
 	.probe = q6adm_probe,
diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 2967f4546af5..25b409597d51 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -251,11 +251,13 @@ static int q6afe_clock_dev_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6afe_clock_device_id[] = {
 	{ .compatible = "qcom,q6afe-clocks" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6afe_clock_device_id);
+#endif
 
 static struct platform_driver q6afe_clock_platform_driver = {
 	.driver = {
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index d58b86a98114..4e1f101281e7 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1689,11 +1689,13 @@ static int q6afe_dai_dev_probe(struct platform_device *pdev)
 					  q6afe_dais, ARRAY_SIZE(q6afe_dais));
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6afe_dai_device_id[] = {
 	{ .compatible = "qcom,q6afe-dais" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
+#endif
 
 static struct platform_driver q6afe_dai_platform_driver = {
 	.driver = {
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 688878a002a4..0ca1e4aae518 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1750,11 +1750,13 @@ static int q6afe_remove(struct apr_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6afe_device_id[]  = {
 	{ .compatible = "qcom,q6afe" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6afe_device_id);
+#endif
 
 static struct apr_driver qcom_q6afe_driver = {
 	.probe = q6afe_probe,
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a1dd31f306ce..c9ac9c1d26c4 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -1334,11 +1334,13 @@ static int q6asm_dai_probe(struct platform_device *pdev)
 					       pdata->dais, pdata->num_dais);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6asm_dai_device_id[] = {
 	{ .compatible = "qcom,q6asm-dais" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6asm_dai_device_id);
+#endif
 
 static struct platform_driver q6asm_dai_platform_driver = {
 	.driver = {
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index d745a02fcd5f..790abc135223 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1733,11 +1733,14 @@ static int q6asm_remove(struct apr_device *adev)
 
 	return 0;
 }
+
+#ifdef CONFIG_OF
 static const struct of_device_id q6asm_device_id[]  = {
 	{ .compatible = "qcom,q6asm" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6asm_device_id);
+#endif
 
 static struct apr_driver qcom_q6asm_driver = {
 	.probe = q6asm_probe,
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index ae314a652efe..5358fefd4210 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -354,11 +354,13 @@ static int q6core_exit(struct apr_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6core_device_id[]  = {
 	{ .compatible = "qcom,q6core" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6core_device_id);
+#endif
 
 static struct apr_driver qcom_q6core_driver = {
 	.probe = q6core_probe,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index b12539fae6ed..53185e26fea1 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -1143,11 +1143,13 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id q6pcm_routing_device_id[] = {
 	{ .compatible = "qcom,q6adm-routing" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
+#endif
 
 static struct platform_driver q6pcm_routing_platform_driver = {
 	.driver = {
-- 
2.21.0

