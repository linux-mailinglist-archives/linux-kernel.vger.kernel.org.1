Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D02EBDEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAFMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbhAFMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F14C06135D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:53:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 15so2161278pgx.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1QQZy4nTcMZS1H/pSqUElj03pASMBM/FVGxS1OW0tM=;
        b=VUT/BPY5z5FqK3BG7CFZ4T9G+vHVjC18NtWumnYMps5nmN73Am9+QSe5fxVGBpk0Ne
         uBykCEjmbtiqLQ9Cowme6LK0QkGbFAbROVU/yRgRgY39zv+Ayh5M6qI7rdhpxdBhdQrF
         2b3lSXZh8iGvpSPpG7pGqkzeD31qNj/T6mqcwZX+eLF0VZSNVx+jZVXt+d4nm3atuiw1
         UefhmcjG32RTfPnCcSYxJm/IiJ7ciHxzYT/bUzCUSOzeYdOWCaidslwP6xDaIAN5i9/2
         IJ3D1dSB0xaBs54nTjd7wESoWdGnT2vhoAx2CRQbBymgMsn5EipFK0/LN6zh6sW0JA6o
         RCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1QQZy4nTcMZS1H/pSqUElj03pASMBM/FVGxS1OW0tM=;
        b=qS0o0z+P21++9IbFmyNjdZnW4EnZZa9tch//lI9BBS94edm2Dpt2/5Mi61j2gIMoNq
         l4WPF2ZnBXofHtsvZ3E1lfTaSU17F36YBfh48greNHXDQbqZuoq917eW9RJAsTlEYHJt
         pmPzncHJ5yXYiCsI9D15WEM9gPwSD2PxmcTVkMR07aZnDHohsw+KNIQJwi27Q8ZxDLKD
         kGJ8SV56aX1SauRB29kenGYq/8NP0dNWI/K1LRlBu0QYNdpJrmDoHpgWxvNKtV/WZ78n
         GQ/LeUS9SBPH3aovpg84G375TFDbT2eAon3ocmdC56BUobc4PW01o9sajXKUBILcjImk
         Xuiw==
X-Gm-Message-State: AOAM531ZtTVUrKelw5hG1tS8izW1QXOj3IPYiiRZTTA3RziBoJpu2scN
        kN5eldcSFOX2PbmfeKzGE+UO
X-Google-Smtp-Source: ABdhPJzVadhU9fuvWw/FXRD8koVE9iZfw42dms6L9j95M2lI8vyqCU8PECwigSbABL6F1VjoXc8e7w==
X-Received: by 2002:a62:820d:0:b029:1ad:d810:6805 with SMTP id w13-20020a62820d0000b02901add8106805mr4008232pfd.63.1609937631165;
        Wed, 06 Jan 2021 04:53:51 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:53:50 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 03/18] dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
Date:   Wed,  6 Jan 2021 18:23:07 +0530
Message-Id: <20210106125322.61840-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.
While at it, let's also sort the compatibles in ascending order.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
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

