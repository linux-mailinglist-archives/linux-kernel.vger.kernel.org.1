Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC482ED2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbhAGOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbhAGOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:32:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C335FC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:31:36 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id be12so3636596plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sH2bFxCKx1Y8BaQTg3VTlV/2EBMMuPOF6dbVWV5OFqo=;
        b=TwrjFtbYmKEKZ4701FStffI+UGbHHzVTwmX2K62eDF3mHt3kvetNBQRcpG7EMYgCyU
         8wq2Xvy4jTINk9Sq8ctTDoaw+WDvRGp06dFkI2Jf9UtP2bovkwnCD7D5YFEh6u8jytoH
         3QdzU9+2T5RZ0GOa1LkWmtaoXxeICzLVRHLuyQdMS0jjN5rBOhy94/njzFIFoTStuW+j
         UhyIWDNG5UaGEjW4RZzdMwzNPnI65obm2LYtv+6VifeZGYljZhBeEzuCE8uwDz9Hi+d2
         bG/mh8vPy49lxBFzo4bo4mnd2ZLYeogrdLzw6rddh1N9VDlQWxUOjgIrNc+9zVlL8VZx
         jWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sH2bFxCKx1Y8BaQTg3VTlV/2EBMMuPOF6dbVWV5OFqo=;
        b=f+9T/OLqHE6tgTQAvM9oKaa64Rej9N18r4Hv3mJmHf3wBIeQfpOt40QHMJrka+RGX5
         mm5FqkDzhsHUNhiJHyaxcUnmeuOrno6hupUHLMzKWUiA84D/Ad/93vlWXgby1X/XswbM
         rO4euT6AU/L9nDEJhTaZrTd9+WY1Pj4f5jiFV0OMEbzJfz7Dq66RPUOu1Koh7SOtg2G3
         SM8sFUlqFXVT28EL2p9lbARyKjsaxFIBCKKxRbVujeaQEcIi51h80+u7A9nad7MjE4f/
         xe9GWjf3fytOd5KGzrZZJ46br6iiBhNIfpEyi232YT1qVMGrJp7iNctR+Nxj7P2J0GAi
         3HHw==
X-Gm-Message-State: AOAM5333WFF4YAoB6JrUVKkafFvLw8QwXck4H3RgLoIdICRQWFyb5R8q
        W0Tn0+DO9CENkcKZHmAVaVzR
X-Google-Smtp-Source: ABdhPJzNk71bC17lPPMQlIwS45H2Kt1aqTQMKqplD0v8VlsGhks/Sakz2RN9lPCORLSLDErEG733AQ==
X-Received: by 2002:a17:902:d385:b029:da:c6e4:5cab with SMTP id e5-20020a170902d385b02900dac6e45cabmr9118029pld.7.1610029896186;
        Thu, 07 Jan 2021 06:31:36 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.128])
        by smtp.gmail.com with ESMTPSA id 19sm6096465pfu.85.2021.01.07.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 06:31:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
Date:   Thu,  7 Jan 2021 20:01:17 +0530
Message-Id: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.
While at it, let's also sort the compatibles in ascending order.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3b602fd6180b..9fa8a24fbc97 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -17,10 +17,11 @@ Required properties:
 		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
-		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
+		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
 	NOTE that some old device tree files may be floating around that only
 	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
 	but doing that should be considered a deprecated practice.
-- 
2.25.1

