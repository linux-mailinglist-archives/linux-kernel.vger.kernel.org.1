Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA2265DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgIKKYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 06:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIKKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:23:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB6C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:23:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 7so6313057pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqH4yqc10hEpkIrg/aMbO2IwxNCKJmgXegk9rRTi+t4=;
        b=D8pjuYf2QM/MK90zDGnk61XNcaIkOvPFVwRgAcwnFo3MMuIHlZQjcdxBvslpJKOc8a
         NczVh6k40ytAxSlEu3T4xqqQVEMh8aTHMUdBgS22bNshn1f8TEdU/m94AtUitgNrD9Lr
         WwTIUM0uM12VPUvSuwc9voIsi8yJpqAPlLh6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqH4yqc10hEpkIrg/aMbO2IwxNCKJmgXegk9rRTi+t4=;
        b=E1pwttUE5r2VjwaMHs5vRzkn0I82243pmGVaLkJcc724O/r4O02A5pPE5/HN7Lvaqp
         pV1xcuQRN3rj1+BrZ+tpeR4VFwi6qCS8igrKDeWkHNXnKEfglZwoVNQFhdIR+fz2CMBZ
         PyFhXJTmDB2XfCentbzBPEDh8GcAaV9NBftkslZrExYjPzw1FjsEi02rN2nF5oH4kfts
         i30ggBznegnuTwdAfIKAn590/Zr8UnPORa+UedUmx8c2gEVuCwwCDHOTmTJh/NlEM97h
         oWwsmN7d9W3wWexvSbiBT5hJhNvhbMSiiaHsSX74napU8ufU0nc249gTBBAzElm/hQEl
         vScg==
X-Gm-Message-State: AOAM531h6NxlKgLam8P7hx6LrfGea8/Iw5T2j90QhksRTg8AFw9KGKVU
        BQfwF8B8tRU18qP8yn5qVxHJ30ZYJZD7ouoh
X-Google-Smtp-Source: ABdhPJylmjQVh53sbYRpso8tKRK9CeBGsRQFoKJr4PigH8S8kBPYO+6bX4p/dVZuB/volU6e2Xe1cw==
X-Received: by 2002:a63:e345:: with SMTP id o5mr1235824pgj.208.1599819804149;
        Fri, 11 Sep 2020 03:23:24 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id np1sm1579434pjb.2.2020.09.11.03.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 03:23:23 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v9 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date:   Fri, 11 Sep 2020 18:22:58 +0800
Message-Id: <20200911102259.3667381-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911102259.3667381-1-cychiang@chromium.org>
References: <20200911102259.3667381-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for sc7180 sound card.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/qcom,sc7180.yaml           | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..a1fc53e33b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
+
+maintainers:
+  - Rohit kumar <rohitkr@codeaurora.org>
+  - Cheng-Yi Chiang <cychiang@chromium.org>
+
+description:
+  This binding describes the SC7180 sound card which uses LPASS for audio.
+
+properties:
+  compatible:
+    const: qcom,sc7180-sndcard
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^dai-link(@[0-9])?$":
+    description:
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    type: object
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
+      reg:
+        description: dai link address.
+
+      cpu:
+        description: Holds subnode which indicates cpu dai.
+        type: object
+        properties:
+          sound-dai: true
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        properties:
+          sound-dai: true
+
+    required:
+      - link-name
+      - cpu
+      - codec
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - model
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+
+  - |
+    sound {
+        compatible = "qcom,sc7180-sndcard";
+        model = "sc7180-snd-card";
+
+        audio-routing =
+                    "Headphone Jack", "HPOL",
+                    "Headphone Jack", "HPOR";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dai-link@0 {
+            link-name = "MultiMedia0";
+            reg = <0>;
+            cpu {
+                sound-dai = <&lpass_cpu 0>;
+            };
+
+            codec {
+                sound-dai = <&alc5682 0>;
+            };
+        };
+
+        dai-link@1 {
+            link-name = "MultiMedia1";
+            reg = <1>;
+            cpu {
+                sound-dai = <&lpass_cpu 1>;
+            };
+
+            codec {
+                sound-dai = <&max98357a>;
+            };
+        };
+
+        dai-link@2 {
+            link-name = "MultiMedia2";
+            reg = <2>;
+            cpu {
+                sound-dai = <&lpass_hdmi 0>;
+            };
+
+            codec {
+                sound-dai = <&msm_dp>;
+            };
+        };
+    };
-- 
2.28.0.618.gf4bc123cb7-goog

