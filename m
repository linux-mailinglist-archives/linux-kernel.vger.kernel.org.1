Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669092F9891
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbhAREOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbhARENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:13:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24406C061799
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 20:12:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w14so401415pfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 20:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SajeAnD/bM3T+Qtfi1lyQyoeSgIHCjSTfGa4G04tdEU=;
        b=C03eLdzTC8yp1Gau/ZSxf+IRYVt5U4z483XV1CHyli2tAa8QDkftqwbvma3j9dpbVL
         1EN+rejAmkLtuZ/PPtV2u9V8mTAPzRsSoNoC8UWjxsgQjXWLSyBAg4k+VqvG5LtIHNgZ
         3Hfb8WDEha2d9eTfPCfcmUMTCNoAoG/ZbunD74bFfIaI0K774XBUa7vYFkq+urjO1WDM
         Gmu2wL1XFW3q9DXQuIz6tiQeOPFJxyI2hGWfLEulHzvw0LtMSjiMYzvJHnWU/tmWLIBV
         TabM2X5eVPoVm1SLPRqnzY4Eg17lGf1ERfgpTS/iv86pcBLAgt4vA5b0L+f3/L48rBnD
         hVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SajeAnD/bM3T+Qtfi1lyQyoeSgIHCjSTfGa4G04tdEU=;
        b=UClGDGFa/K8eB33BCT6orOhg8FwC5vB4JAe1JNlUiNiM5372UNGO9AXqaMQkv5ShfG
         dP8RtNwBD9Kje3q9ZNz1dJa/aHyiXU2C4FeL1DDOhWKI3pLo2LhmxJBWEKUonjU30rTw
         8i2qqrXI/kTGmsJ2ZgSGy0nuV8ZTORgMp3mVs/mereEgSCOYeBA+w05NPKntwEqI2Cuo
         g5VAdlnkZgVXkd3k7OlUb07ewpITy02cvQaqRWQ+p6Dzohp+drbCR0ZarrnhOLDxTWSX
         Th63vJKYJSMcmhkD3FhGmnliKqS2ixk12SuxGdBcwXiNdbTjpJPoJYCK51znufZmMUGv
         RFfQ==
X-Gm-Message-State: AOAM531+KdHKWV5GOMHIsUOId2Sx3i9FyjNEzLaqujFV16yqDX9DiVQ0
        kSjHrkvAfZxDy2LmKAatgsMq
X-Google-Smtp-Source: ABdhPJw4926kqojiehh7sKxQnSVQDNFboJxACl+ctCL71e7hu5cMhEIzVGp1inNWucqpUFr4kV1Psw==
X-Received: by 2002:aa7:85d2:0:b029:1a2:73fe:5c28 with SMTP id z18-20020aa785d20000b02901a273fe5c28mr24296279pfn.40.1610943155657;
        Sun, 17 Jan 2021 20:12:35 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id h15sm6727319pja.4.2021.01.17.20.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 20:12:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com
Cc:     viresh.kumar@linaro.org, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/5] dt-bindings: clock: Add Qualcomm A7 PLL binding
Date:   Mon, 18 Jan 2021 09:41:54 +0530
Message-Id: <20210118041156.50016-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118041156.50016-1-manivannan.sadhasivam@linaro.org>
References: <20210118041156.50016-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree YAML binding for Cortex A7 PLL clock in Qualcomm
platforms like SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/clock/qcom,a7pll.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a7pll.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml
new file mode 100644
index 000000000000..8666e995725f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,a7pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm A7 PLL Binding
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  The A7 PLL on the Qualcomm platforms like SDX55 is used to provide high
+  frequency clock to the CPU.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdx55-a7pll
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    items:
+      - description: board XO clock
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    a7pll: clock@17808000 {
+        compatible = "qcom,sdx55-a7pll";
+        reg = <0x17808000 0x1000>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "bi_tcxo";
+        #clock-cells = <0>;
+    };
-- 
2.25.1

