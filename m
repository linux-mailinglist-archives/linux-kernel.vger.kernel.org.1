Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5F2E9181
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhADINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbhADIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:13:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796DC0617A5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 00:11:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so14128831plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SajeAnD/bM3T+Qtfi1lyQyoeSgIHCjSTfGa4G04tdEU=;
        b=d57p44xYkAfTKPD/W6X3/fJl0rjkV7I2LaLHztAPAVpf/QB99QozubH7hoAP5v9Co6
         xjNWgCneY25yaMLkAWcJOI/7qictDJPROg78bCyW0Kw4PCI9vCS7mlqbGnlcEPytpyQ8
         +eDAPxw9av0lUcETEduC/NziZeHr8HCRnoK1CGaREsg/+CdBAITprxPQM5z7Wm5icYEL
         IliejGJ6DaP0vRdwapwweIdCN87ePnTs9zNUijeF6H4rNy387VRCmOO6fxT0uWCYBMxq
         VWxVdi1XtOjyVZN7UBJtrgFb8+GRqbFXba+t2Hn+zpRb9QwAWsaDcV/YRoZ4yyw2jS84
         m7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SajeAnD/bM3T+Qtfi1lyQyoeSgIHCjSTfGa4G04tdEU=;
        b=ueEh3nADUDKtdL3vaaSz+C/tmFslEp2/nZlrEunUBox3yT0gegMGx1Dt8Vb17wpkMu
         2NtE0SbvMC36O+LVW6DmcBrbL8+m93qrNSpJei5dHhTVKJswHgxIQzzciawVpZKfHPEd
         KpQjiEa10rNP0xxWeAtCKN5/1QPRo3Yy/ktHX+9uKsZSglX2KPD8WxqS5gxbQn01JiRL
         8oLcuxvhwmb4gXEa5a88TqDSjVLxCpnf0snrZXeJOWJca0XCesbQdixD45mVa6QR99mg
         kTtHDiBHjKh0piqQcHV3+bh2QpgJV/FJopE2PlKKRM+8aefqzBVPRni4ePmSEFwdtTvU
         GirQ==
X-Gm-Message-State: AOAM532uLeUhIJFxSGZ5TMHnYJl+lSSbmJq+OO/3vwllIi0UMDTBorb0
        ikpRiItoeqFTCHo5i+Wf1Pqt
X-Google-Smtp-Source: ABdhPJxF5ORVTpxCWmZAbSGJk5tsy+dsR2IJF1AKqZAjyimmP80KE4lWYbJvVOQaAqNu7bprN0TOWQ==
X-Received: by 2002:a17:90b:68e:: with SMTP id m14mr28507675pjz.228.1609747913323;
        Mon, 04 Jan 2021 00:11:53 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.160])
        by smtp.gmail.com with ESMTPSA id n7sm55051339pfn.141.2021.01.04.00.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 00:11:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com
Cc:     viresh.kumar@linaro.org, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] dt-bindings: clock: Add Qualcomm A7 PLL binding
Date:   Mon,  4 Jan 2021 13:41:23 +0530
Message-Id: <20210104081125.147300-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104081125.147300-1-manivannan.sadhasivam@linaro.org>
References: <20210104081125.147300-1-manivannan.sadhasivam@linaro.org>
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

