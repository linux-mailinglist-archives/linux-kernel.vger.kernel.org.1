Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143582C4F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgKZH3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgKZH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:29:38 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB31C061A04
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w4so958847pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GP/RLQWEDchE9LzjUTRfvMF58ENPqeEQ3Vvq9pvpD94=;
        b=IWikPKEJRAA2PtKy1qmWs9edanz/sraQoZz85InqUpvpd3Qb2wTR3VtjV/LytD0yD+
         lpHISQBnRBRAS+vYYklCmBCH7uH8UU7glm7CX3aGQgkbc/7KZJVeCtHGpkF/ujiMjPtb
         CLn5qSIK5qS8VwEFr5v+KGodrJNlRDYS1WOcdKuehu8zujpJQwKzRFOJ1XOlPEd9hHRG
         5synRKoaNvhkgypQvhqWREpxSf/cksVw1KzUNG0j1v3IwgaHezLx7sHXaqFsNGJ0W9bW
         ANSsG3rS1ngNk/JE+ka2+7TNU+GaWoVPRsKAbJ1Thyllq4Hly1rUcuSNqb2w6s3Fn+i6
         VS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GP/RLQWEDchE9LzjUTRfvMF58ENPqeEQ3Vvq9pvpD94=;
        b=V59ESRggU89Io+FdNqwM42wom9zbUEJF8lYIFUI6HcEFkJvpz35Kr8lgHWnqF7/bxS
         fizQo/3nR/b5/MeEyxA/d/TjVjNhX/8SYFCYCmmmCvDveL2/Zeg+kGtpn0GShlybjmUr
         hzpn0pjCqbJ3rHehQ65GL7hqDYpks4Vd7yjM46YQoiIOVKTChv/aLTPWxl4O7wUSJJyR
         hbMvx39ZIykOO9JuYdQCQYYGmP7RXl6f4PtROEYZoCN6oSFJwRjUyOmYKbPP1XobwyLr
         Z/culYUiHl7zF0FHejanJ43vKNPhouK4umjrb1L0MnjNzgbtVhSi+IyhuvD9zdqlYQrp
         pHHA==
X-Gm-Message-State: AOAM531qpedM0SmOAnlGKB4GxybFndpYyea/nYkddazvaJIQSEYhTyqy
        mD6ASToIOMkJJllak4YOd9VS
X-Google-Smtp-Source: ABdhPJxdnS7t3IQhsVxD7mCMRvjEQ63yhQJXiRPytWksfZRnVUiYTj9+m57D6KAKudr11ehEwmVCWQ==
X-Received: by 2002:a62:76c2:0:b029:198:1469:3a8d with SMTP id r185-20020a6276c20000b029019814693a8dmr1693866pfc.20.1606375777812;
        Wed, 25 Nov 2020 23:29:37 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6e95:f2a:3996:9d7f:e389:7f7d])
        by smtp.gmail.com with ESMTPSA id t9sm5508097pjq.46.2020.11.25.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:29:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v4 3/6] dt-bindings: clock: Introduce RPMHCC bindings for SDX55
Date:   Thu, 26 Nov 2020 12:58:41 +0530
Message-Id: <20201126072844.35370-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126072844.35370-1-manivannan.sadhasivam@linaro.org>
References: <20201126072844.35370-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Add compatible for SDX55 RPMHCC and DT include.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 include/dt-bindings/clock/qcom,rpmh.h                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index a46a3a799a70..a54930f111ba 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,sc7180-rpmh-clk
       - qcom,sdm845-rpmh-clk
+      - qcom,sdx55-rpmh-clk
       - qcom,sm8150-rpmh-clk
       - qcom,sm8250-rpmh-clk
 
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index 2e6c54e65455..cd806eccb7dd 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -21,5 +21,6 @@
 #define RPMH_IPA_CLK				12
 #define RPMH_LN_BB_CLK1				13
 #define RPMH_LN_BB_CLK1_A			14
+#define RPMH_QPIC_CLK				15
 
 #endif
-- 
2.25.1

