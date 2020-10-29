Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E629EA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJ2LJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgJ2LIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:08:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EFC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:08:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m13so2281438wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pb7xypbNoJbZw5gP7ennlwPkwkNiPmMk0DOyYJok4RQ=;
        b=HM3q6a3yJCGdXY1DBlswPFUkHxkfvm4jfKDKHbt3jmHArOSddOjmbKEoY3kMN6T56y
         FZVVmpnQhkKM6VXHY3obPjGwtTuBJ1HSjQ28T4MH3ggIbVCOnK9j6YdqSkpbMUO5TBkN
         WDPoyTzo7Tm0Dxg9xHLy2y+1S3bg7VIDL87ZwlwTsf8E9tmNGowwP5+g6Ea2SkWqOrKY
         Qrdy0Hsi5Q+O1DbFpNCEIKjkgGvm+qMPyJXm1AXm97VFTY/LC67955IM20JkiapwOqb5
         VfrRpxv386HDPvUeMaB2G05U8Q7n/L/b/magbSXBQ6gTHTHf5jM+u0VVwf/GBrIkO52v
         5mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pb7xypbNoJbZw5gP7ennlwPkwkNiPmMk0DOyYJok4RQ=;
        b=LIjDMWEghxSkLkMwVJ25cNF+id6FaRrYFZdoNbVSZxQR083KUWvWkr6+Xfy3tQIkZp
         FUayp7aFTL4oRjQwqvevvP2rjONrgmYBrdyUa4I+GwZAMmDf75QVmQ/jaPYA46xDqyh1
         rEhrHm0YnaWJ8uEfkZH9B1f1kXgpqwF/wuV0CnPShXrf6g9fbW9hFqkVi+IcAaHkJt64
         GpFiMduE0pQks61ETmK428bQ05LT4PLJlHkIf4rrNGANAJdr5l0qojEdtcXeylVV8WFO
         otjb8N3HEgD20Tc449W30fxRmkuNLvLFs4KdAL+NFm9MGJn6ob/zJjYfLohBilXMiSqa
         FZSg==
X-Gm-Message-State: AOAM530b+LDYUSiGXdb5kGC2lDCzmhF9NVYRVujGMOXy5kWzTqGd/fcZ
        IHSzrcamTMjSAAdybRH6k471ByuuEH1QQA==
X-Google-Smtp-Source: ABdhPJwsY44TbhELz8IScFVHaVqQ/MSSf0v7ECfkzqf94KE5Uk+twFQZdBNS6b6K4AR1kVCEzZqLaQ==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr4949833wrj.177.1603969726157;
        Thu, 29 Oct 2020 04:08:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n4sm3710830wmi.32.2020.10.29.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:08:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/6] ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
Date:   Thu, 29 Oct 2020 11:08:27 +0000
Message-Id: <20201029110829.16425-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec VA macro which is
for connecting with DMICs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

