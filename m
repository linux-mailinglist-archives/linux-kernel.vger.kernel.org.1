Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78322A7D35
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgKELhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgKELfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:35:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E40C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:35:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y12so1353521wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0nELbaPuoZuw7n2kK2InfOxpklKvuZiw/YN5nvB5ZE=;
        b=Bg8F75qD1t0buJgZKe3m9CAY34R3lRU5P+FXqaEhjCHOiR5eMBjVjVFVS/rJawUAR8
         QWqQ+vM9Y+FcdhPadGSRi2xROAO+lbNEQCG/ZvaI/K8VyZ42gfQ+Oo8fPLvkc3tIG3+7
         4p9FjBnCU9bv5p0SEpQm2OL9rY4DYdMDq2fFdBZwSl+Ruir8M0MpUVzHT14NotN5fkpz
         G6ljSC+cIqCt94LxmIWpfBHobl5ox8BZPAq5HDVLL1g+NAclZ/R1jBiOI61zBzVu2dMH
         F1ElPylLigyp3PlkyR945L8g+9/wjSBCwgUs89MKlX/HBtx/kzuagSwo7czDqZ8ik7g+
         ByVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0nELbaPuoZuw7n2kK2InfOxpklKvuZiw/YN5nvB5ZE=;
        b=lWWRnQB/kqotpy5yndbJ3E2IHH991SUIRbZu3nGL7XiCsRks0XAMz/h2n/qi9czcg1
         XqBX1nzQDlwTj82d9jHWLnwTs0lUA49eyct7Zb+ms6Fw7RNlea0udPZsMhaoP3NG/LLG
         r9TegJpd9ESJlYgO2mZYVkjjLHAq8RepBuk9WUpfYzfN3+H9SahCYiwuwC+cpnff90Ul
         7UHtrZAK1JLebtW4jBQ9xKCD0BD9cCVqv+e/+9QqFBmNx13gsdgyXrcVPyjlRtxlRi1Q
         OYy32/O4y906jCeooWiJU8Vws9E7+BakWBWA4EQRuvGiZe+ifhdd6KE0eiZSUD7yv3km
         E8vA==
X-Gm-Message-State: AOAM531sLnMoblbAtXCHXlLTXk7LDjn3b543K1Lj4MBgNAB20g1avqkV
        wq6kIvNUtVswxKGVNCo9XARUjysQI78TL2Gs
X-Google-Smtp-Source: ABdhPJxTVmVQUrNEA4GTeoFaIN01h8QI27hO2N2sXTb+CiyJJUppgxi+Aebf0Vpo0haN3OnpMj0Oxg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr2576474wrp.394.1604576103192;
        Thu, 05 Nov 2020 03:35:03 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t199sm2096129wmt.46.2020.11.05.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:35:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
Date:   Thu,  5 Nov 2020 11:34:53 +0000
Message-Id: <20201105113458.12360-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
References: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec WSA macro which is
for connecting with WSA Smart speakers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
new file mode 100644
index 000000000000..435b019a1e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-wsa-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) VA Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-wsa-macro
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: npl
+      - const: macro
+      - const: dcodec
+      - const: fsgen
+
+  clock-output-names:
+    items:
+      - const: mclk
+
+  qcom,dmic-sample-rate:
+    description: dmic sample rate
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  vdd-micb-supply:
+    description: phandle to voltage regulator of MIC Bias
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    codec@3240000 {
+      compatible = "qcom,sm8250-lpass-wsa-macro";
+      reg = <0x3240000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&audiocc 1>,
+               <&audiocc 0>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+    };
-- 
2.21.0

