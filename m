Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39822EA7E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbhAEJsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbhAEJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD0C06179F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:46:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so1399599pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6ZtUI4Q1Kv9KoNZEzoxKYY3jMlU4aqhIrm/Qzwt2c4=;
        b=IqfZ+0JlcPO/0fdghcVD5HMjwJRSj3ILQCXHtqVd3MsXiOgcBW79R1FU9U+RCrUzuL
         o6qefTTjpGjlCBXdr+DIfWfqPQ1ln6ANDE4Kr0/TXvH0rUBRRJowRP4dROoRAwTN5k1M
         5DrP7iFvZXRpEUdpMnwIQ/Qg6r91KkRTYnte/uMEyw/U4Iv+szIFp7ZL/s3DTmAHd7Qa
         9UuNkzgBbkhN25Sg1cZy63BafrYzoyks385n5TJFnIgqz/scMZ+BQ7Z8YhM9Dx/HsNJP
         hNqU1hzRtOr9JQ96V8dIQQcoV8FMjqqV1H1iIZjEB1+U5eqSEzi2NYDDp1rYy7qlBF7M
         uqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6ZtUI4Q1Kv9KoNZEzoxKYY3jMlU4aqhIrm/Qzwt2c4=;
        b=ToEpafZAEOU3FVQ7Rjeud7TL18SiJFdpUDgDre9usiWeji2m6HBLVO6bpPE5UmKtB/
         rWtSW9e05IbgSb/5KzDyHeAZ/JdLTeVo4Ie9yQTWWeWv6l05Ads20UfXptp4zJuH5web
         aq05gs5lg8HVs1G/79ml5ObW93LQzuS4cKAuUnMD6o6iQhoUCBclIqDzl9ByGF+Jduab
         1j2lGrtDGZwxURjanlqsmvtLb3w9BmXwkhcZHdzUpiT75mAKw5Sa6QGISHvkDx9TmvLU
         CcyaNlQcLlV/K++3qcJ//9oBbdnm9+PdXHA/eUrR05SOSOdiLm2IkG7aBfLGabBZ3/yu
         oaAg==
X-Gm-Message-State: AOAM531HFqsDmi+lBpnztPSv0rRbjw3CMwodruCmPVwD7qhVXulnPFcL
        w4oy0hYVwXu7rhzynN0q0Tzj
X-Google-Smtp-Source: ABdhPJwdjtf7ZxrFvOutgpEuMZ/Fbn0O2zhvjfCj2mZbSvhf7tqZ/2tBGg2gBBXspakdgD+yLNisnw==
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr3326064pjs.141.1609840014897;
        Tue, 05 Jan 2021 01:46:54 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:46:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 03/18] dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
Date:   Tue,  5 Jan 2021 15:16:21 +0530
Message-Id: <20210105094636.10301-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3b602fd6180b..31f4a5628595 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -21,6 +21,7 @@ Required properties:
 		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
 	NOTE that some old device tree files may be floating around that only
 	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
 	but doing that should be considered a deprecated practice.
-- 
2.25.1

