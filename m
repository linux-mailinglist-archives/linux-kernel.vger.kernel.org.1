Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD548298F11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781272AbgJZOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:20:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780740AbgJZOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:20:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id e2so12676719wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fhF75GuKHMndQwzvj5pm/aPCcKWXm3nNYC2yFpkJSw=;
        b=n8mxJ2N5zGLAVgMbyvJa2AD3AWeMri/klQxXd2NFfZg3SVtfycsOGmmXQoRyJaZm0R
         uj+Nytd4IuM3ItTvSr1BaaQyS70biV+qHdpZ2ZICzYJIYj/vOtu1GMuQWAyw7PNXLK5j
         xg8tnS1FvFm7DlHZhl/GEc/ovK+dLYhLt5uCUlC1n4HMtyhOrEyHRxdGYFQjeGTLmTdW
         yF+aCe+KPRwKdqNXHHLssg1p6RqcX8VyHJbLlyln+egHJfbDuTJckSO9eNypAZbVz4ju
         YONoQy+iJz5sgSIVwhT/FAyQzbNHrJUDgfE6vmF3PawwDSegYJWjgmlCNOYA60vA4u9N
         MzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fhF75GuKHMndQwzvj5pm/aPCcKWXm3nNYC2yFpkJSw=;
        b=VkRbAAGTCLLLakhGxsmHEbpcoA5sUeBhd41PP34b6LorH239OyExg5YuDA4jDkV2Ts
         ITsYCIm3jKAbbKeg+N4o049d1sDTkC4FR9pC2xGmTcU+HPEjBq+aJKIjdjJre+H4AWQq
         FfkZhBQZEf67Z4X2MxN7+PANIeJjp5d5zN8GHlFPsEHso1EU9dUlM1d48cSa/3l3Y321
         wOwK7oo8E2I1JMhQ9zyCaL2XJNNbk/46SjIzVTjeL0MvsV/v0Q1XB0u1w9lXo6aW9beq
         nPEyvsMPxSImFcAfyjrIxuYDSZnHzGORXIh7O6vA9GdbErH2QcmTuMmwOoSZKcJapEq2
         xrGA==
X-Gm-Message-State: AOAM532LWiuuDo8pCvW8sN4fslYN12EwJVg2gbVKSlnX3PpN6HXZDK5M
        3HqeJVA8/q0cv5Tut9Nn4z9kdg==
X-Google-Smtp-Source: ABdhPJzRknpzQ3DDUBfPXoKWaIYT8Q1ET9vJ4ZC9mONx0jPu42Q5mgIlfYfzAJTNI8FXYCCXXKXr/Q==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr17236581wmf.105.1603721999005;
        Mon, 26 Oct 2020 07:19:59 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g4sm20253333wmh.13.2020.10.26.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:19:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 4/6] ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
Date:   Mon, 26 Oct 2020 14:19:43 +0000
Message-Id: <20201026141945.19707-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec VA macro which is
for connecting with DMICs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
bindings depend on gfm headers from "clk: qcom : add sm8250 LPASS GFM drivers"
patches posted at
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2352255.html

 .../bindings/sound/qcom,lpass-va-macro.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
new file mode 100644
index 000000000000..214b4b117d39
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -0,0 +1,68 @@
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
+    #include <dt-bindings/clock/qcom,sm8250-lpass-aoncc.h>
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    codec@3370000 {
+      compatible = "qcom,sm8250-lpass-va-macro";
+      reg = <0x3370000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&aoncc LPASS_CDC_VA_MCLK>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+      clock-names = "mclk", "core", "dcodec";
+      clock-output-names = "fsgen";
+      qcom,dmic-sample-rate = <600000>;
+      vdd-micb-supply = <&vreg_s4a_1p8>;
+    };
-- 
2.21.0

