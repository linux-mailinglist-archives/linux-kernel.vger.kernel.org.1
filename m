Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545E42CC24E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbgLBQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgLBQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:30:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31426C061A48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:29:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 64so4639257wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WGzIfA6C7tegyEi04/CfzUdmHOXOxjoWOJduGSUQyE=;
        b=UfJqB8G3k6wmhtNqoNQF/PpY5MhYH1VK5d5tS5Kw+wYW1JkNdpjFCA1/07pHPk2rxG
         k36LX2vPQiTFUrshcE6f2JDzhLRWycS1Uwegg+yDsBVjQU9NX5NwPb0oC1TB79sZffoF
         JYSSzgNAqoGXuwQdmXm+OiQKnuU/weLBtyxHCAV6OrL+LNBKRGuPhFtZqR6ZYzZZ5KB/
         MgFN7J27FX1jF03fd8N7xxrX/5Gaw5EJBb7fIOKG5OngVeJ9eW/oY3DgY+FBgQzD/0Pd
         /miqE3hZnR+AMurntVD/wlaXSLCbSaxft0LLewcQ/ancw8RuPFtOeTBk76CzetTc0EmY
         nVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WGzIfA6C7tegyEi04/CfzUdmHOXOxjoWOJduGSUQyE=;
        b=ixdEuoaeD84ZDDmVzmvkqpfWoM/8P5eyv+0ikU4LIhC6z65iNpeu1O0/Tk+r61e65Q
         ZXPoyoL4Y3HaQeuILRpjMXZ5BsqQwhXs6C/2YcbIEIp56EjBvloiuwm2FAnTvqW4k1S4
         Zku2Pw0CvabMgMoR0MziHYnb7AECfKI/nw4vHnWYP9CFzCdY6NRojWRxJVRoC83FXrWf
         TfMeynaW649G7Lyn3Mg0JpKkFkqcI6TTSMO1mOdH5pP1ZZocALn4jv3VD8wkLb4NZS/J
         VJKcn6OWf2dwo6seVv5e9polk6DquqwdCXZOeAgFDxtPLUfq7inmPw8YcwpZV01ckaQ/
         ghsQ==
X-Gm-Message-State: AOAM532+EdbshAkbkCNpqsSFG3W70WgrwulSU8NT7v98paxilVw5nWrJ
        iQ0Q+Flyk8c+OPYWhYmq3bdnkg==
X-Google-Smtp-Source: ABdhPJxNn+BybhwP0TQjbRibRL+8KTLNdpBEe/EkYkqqUuwmkyuIt/xxlubMTl9ztnr8AEM2hNnKbw==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr4504957wrq.294.1606926587814;
        Wed, 02 Dec 2020 08:29:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o5sm2569882wmh.8.2020.12.02.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:29:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: Add sm8250 lpass lpi pinctrl bindings
Date:   Wed,  2 Dec 2020 16:29:42 +0000
Message-Id: <20201202162943.15210-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201202162943.15210-1-srinivas.kandagatla@linaro.org>
References: <20201202162943.15210-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm SM8250
LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../pinctrl/qcom,lpass-lpi-pinctrl.yaml       | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..e47ebf934daf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
+  Low Power Island (LPI) TLMM block
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  LPASS LPI IP on most Qualcomm SoCs
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-lpi-pinctrl
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: LPASS Core voting clock
+      - description: LPASS Audio voting clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: audio
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '-pins$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9])$"
+        minItems: 1
+        maxItems: 14
+
+      function:
+        enum: [ gpio, swr_tx_clk, qua_mi2s_sclk, swr_tx_data, qua_mi2s_ws,
+                qua_mi2s_data, swr_rx_clk, swr_rx_data, dmic1_clk, i2s1_clk,
+                dmic1_data, i2s1_ws, dmic2_clk, dmic2_data, i2s1_data,
+                i2s2_clk, wsa_swr_clk, i2s2_ws, wsa_swr_data, dmic3_clk,
+                dmic3_data, i2s2_data ]
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      slew-rate:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+            0: No adjustments
+            1: Higher Slew rate (faster edges)
+            2: Lower Slew rate (slower edges)
+            3: Reserved (No adjustments)
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      bias-disable: true
+
+      output-high: true
+
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    lpi_tlmm: pinctrl@33c0000 {
+        compatible = "qcom,sm8250-lpass-lpi-pinctrl";
+        reg = <0x33c0000 0x20000>,
+              <0x3550000 0x10000>;
+        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpi_tlmm 0 0 14>;
+    };
-- 
2.21.0

