Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37377298F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781254AbgJZOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:19:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37634 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781238AbgJZOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:19:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id c16so12661569wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lL98uNKY4MHm3XdA4qICH5iQBbu3vZ12fypi1tkdJtc=;
        b=VtqluNgOZrXHFfeBjfqvh6nrDjHFFrC2GHp5ILryvFqy0DPnpR4OrF3BJcxXKON/K+
         9GJsPCjrauvfANYLkd4vQN3yIvzdvEA1MDxRymiB9nu8gowS/cAC6EFmbOajsTUVybxq
         CeavafZnyKz8HkiuPkh/AtnVqMB3atQTwk2eKiimoze29LA5EPVleTejFX1PSItQzS/p
         E2rPiiDFHgSZtLbeyr4J0yXj1yGtWePBu0hkYhQjNu4vfC4+HHQETS3oW/874/spCbqg
         S3si2X9451WKMmWparfVtHL9dJ/QlpujTj8BtgPNSAr2zU/jdVKNqmqEkMZ1GnQAIueS
         2Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lL98uNKY4MHm3XdA4qICH5iQBbu3vZ12fypi1tkdJtc=;
        b=X8QRVJgPe/jx/m1gOvQswU8VoV3j1qqpMxl/vOKZ6lSt7bZY6w17PlIdvxcZeT5g8C
         XlM3Hqhq4fVTPwrnuM32suaa8TuWG2Wp/VjrdmLl7cW9N2z+H09so2065dY3Sz2ZTGO1
         8jAUn2r1/RXUDxYRFmSeJoi5184GwmGhecicFEckm4tTgJN3lgmGsnSQf1QkPCmlWWJY
         uAXATKbSwyLTVj1tGox6t0chmqzyDPKn6yqqE4hyGhNJPmgaV2b9JqiBk2xJhHqErlLQ
         C4cSEz0Q8+/+d5x7kVo7EE95tEyDJnVVNiYrwB0l7kpUIfgQVj6AjcJHpJLFmH6y8vYP
         U+/g==
X-Gm-Message-State: AOAM532mZGnfTYv44/lrlnhjVgDLWpAAMLibw+PbIIFoUH3wND9mLNF3
        /x+gCLnvV6RQvPMuXAZeunbdVg==
X-Google-Smtp-Source: ABdhPJxXMGoAU22hHhWUasDH8Fm5MNAfxEXV8ZQo/ciYj9SfPoH/6Farn1XMzEEcYj+yUsm5khsWkg==
X-Received: by 2002:a1c:b7c6:: with SMTP id h189mr17240075wmf.154.1603721994586;
        Mon, 26 Oct 2020 07:19:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g4sm20253333wmh.13.2020.10.26.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:19:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 1/6] ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
Date:   Mon, 26 Oct 2020 14:19:40 +0000
Message-Id: <20201026141945.19707-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec WSA macro which is
for connecting with WSA Smart speakers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

bindings depend on gfm headers from "clk: qcom : add sm8250 LPASS GFM drivers"
patches posted at
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2352255.html

 .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
new file mode 100644
index 000000000000..7054f6feac47
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -0,0 +1,70 @@
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
+    #include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    codec@3240000 {
+      compatible = "qcom,sm8250-lpass-wsa-macro";
+      reg = <0x3240000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&audiocc LPASS_CDC_WSA_MCLK>,
+               <&audiocc LPASS_CDC_WSA_NPL>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+    };
-- 
2.21.0

