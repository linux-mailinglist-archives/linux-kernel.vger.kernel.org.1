Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329112A7D25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgKELgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgKELfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:35:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10240C061A4A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:35:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y12so1353820wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h26eF40PaZ6KFdIeJwqF0Jrhx2dZ+TjpA76DU5/WGXs=;
        b=A5gN26/QGnbFvWXObUHshDqAtdfrClrjhHVzBuZ2Em2uF1PHbH4rhMRUWcxsKi3aS2
         Npc/b7sch95U53NAI9/xCSy3FOM9XALICFJfyZvurXHYfDQXw322nZqcEtynhR8L+yLu
         NIAE26kV3+aPVl0X0+8YSmbuOEC0PUEVwoR1HeZNN9/JmfcxDX+6jgzCA7eHPYe6F8Yx
         HF5bzJQULgMQtlxkn0TZoGFhE3Qcj+1vP4otC+CI2G8/qDgATB5nXKRXmC3Iy1ermgxS
         X5U6w37i5mEr7Eoa7eW5sr40UGS6t5UA8SyMSM7cuF7QdctTJ0+rg0Sj4qvgCs0y4tzv
         Umig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h26eF40PaZ6KFdIeJwqF0Jrhx2dZ+TjpA76DU5/WGXs=;
        b=KLlJQS70ue267GJcDUNaFbGBL3e/UBT0FRFHLqrymn4G/2mB7X3elDxTqtH9gBHb9M
         h65idmNg0kLiWZ/22xOYIUlruvZkjCU3jkNBA5SjRkHlH205in5ghNkB3TIPQzc8LCpg
         Qy4SyYxkSQzrXrtXPkm3FgSY1hHVNLGkhpctAOT+fGtZayx+TC4xgCTjIE+mvEbwwnij
         11RKD81Kz5QN79YHxcD9gmXv5y6nh5Q0TI0P/cxii2F5ef/XK7Vhkqd/Ru74utjxwOVD
         ThlWuc0dx+T6dEhy9aCdd8ouk4xhvbRT92YHw9WqfofWnIiWWRBGUYhRaLlcgtb/RLHt
         j++A==
X-Gm-Message-State: AOAM530md2Kxl9bdaIIKgZlM2JjRLuylu/dXBQZtdVMlIGGwvoose9FX
        z5js4YrVl2gaDtuxIEG9euCG3g==
X-Google-Smtp-Source: ABdhPJzVH+JLYWx3/VdBd29lN0VHHvZvfqQqzrKcNGXGXvJOP8nTqgblg5xpxlLZ5X7yOtAzJmWlcg==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr2513853wrn.9.1604576107810;
        Thu, 05 Nov 2020 03:35:07 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t199sm2096129wmt.46.2020.11.05.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:35:06 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/6] ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
Date:   Thu,  5 Nov 2020 11:34:56 +0000
Message-Id: <20201105113458.12360-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
References: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec VA macro which is
for connecting with DMICs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
new file mode 100644
index 000000000000..679b49cbe30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-va-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) VA Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-va-macro
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
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: core
+      - const: dcodec
+
+  clock-output-names:
+    items:
+      - const: fsgen
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
+    codec@3370000 {
+      compatible = "qcom,sm8250-lpass-va-macro";
+      reg = <0x3370000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&aoncc 0>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+      clock-names = "mclk", "core", "dcodec";
+      clock-output-names = "fsgen";
+      qcom,dmic-sample-rate = <600000>;
+      vdd-micb-supply = <&vreg_s4a_1p8>;
+    };
-- 
2.21.0

