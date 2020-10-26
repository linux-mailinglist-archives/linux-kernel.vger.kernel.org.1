Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9086029936B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787359AbgJZRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:10:00 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45463 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787165AbgJZRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:09:57 -0400
Received: by mail-wr1-f43.google.com with SMTP id e17so13506922wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2w2zKDInoE0nEOTDxRu7ShBOzqjTt9h0UybMigLUZ7A=;
        b=QyVBpuNWrUnrnE3nTTLRUCTTT7/VWyI7mqP6SZtt6v6Yh+Vi69RNMQPZ3o69D3F35h
         6DVQ0nFx8sAjMCDjq57ChbigaaQiARydxivJHmF76gmNGhyLkIr2iZop2GQokTPbviM5
         HjsmiNXw1FVzyc7T8Dp4NavK4QbWTiK7BTQy4p0Qao49DiTdS34k1uRdczQnl/rfU211
         DeDMue360GnBjFdGc+AS4BaSwFRudBqxnpjJ3cDw99VJajlid8o0K+YMkzG8KQU+b6wl
         4TAGsmXNOaRQDEOYaeXTA096bZDNyY5gSOQ6DtZ0klKQbYbiOmNBOJ8TDDuJyLUsPaiy
         hLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2w2zKDInoE0nEOTDxRu7ShBOzqjTt9h0UybMigLUZ7A=;
        b=NNYxe48eNms5BI6uKLE4SFSnDdXe53EF6FEgCMu8MdkCSJaDrN2oKSGMINIAlODrEv
         TPdKKtp0EqdNQisf/+lbzt6cxe5RQ+jC+zNbfb400Sv93p2z3xXo1OLivJ7y+4Zj8Szp
         bC5ld8Xf2BHRVj8/udWTD05YnqoAqUQVZqL9K9ASgvJ/fmyV2ieELVQMoi3BxDsS6n2d
         Xml2lG8Geesv/MaBzVIxAoiXMvTwTeSudAwKaJKKHLJcj+bfkZnxDYT3BGCUwr9Qm235
         a3UCCvnUOLeTSKj5qwRQoNn8jZRajO3jr4NuusTdoFtcFKs6vmEozxmnpz45aNGl9W/d
         nzLg==
X-Gm-Message-State: AOAM531mpaa3sSvbasPoOE8OeFnfRU8nBJ+DdKlTcqQEEVxLC+a0YIwf
        vc+FHU3onxzd/l/AhtiAzyURIA==
X-Google-Smtp-Source: ABdhPJzKEdmT+P+QVCtJT7v9CNbZUhOtFVFaiIx+8jOI4D+7abuPMZkk56f8H5emMxrZ2Xr3U3VXEg==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr18201344wrp.385.1603732192856;
        Mon, 26 Oct 2020 10:09:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u133sm23136174wmb.6.2020.10.26.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:09:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Add SM8250 sound card bindings
Date:   Mon, 26 Oct 2020 17:09:46 +0000
Message-Id: <20201026170947.10567-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings required for SM8250 based soundcards
for example Qualcomm Robotics RB5 Development Kit which makes
use of ADSP and Internal LPASS codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,sm8250.yaml           | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
new file mode 100644
index 000000000000..b8f97fe6e92c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc. SM8250 ASoC sound card driver
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  This bindings describes SC8250 SoC based sound cards
+  which uses LPASS internal codec for audio.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,qrb5165-rb5
+      - items:
+        - const: qcom,sm8250
+        - const: qcom,qrb5165-rb5
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source. Valid names could be power supplies,
+      MicBias of codec and the jacks on the board.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User visible long sound card name
+
+patternProperties:
+  ".*-dai-link$":
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
+      cpu:
+        description: Holds subnode which indicates cpu dai.
+        type: object
+        properties:
+          sound-dai: true
+
+      platform:
+        description: Holds subnode which indicates platform dai.
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
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - model
+
+additionalProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    #include <dt-bindings/sound/qcom,q6asm.h>
+    sound {
+        compatible = "qcom,qrb5165-rb5";
+        model = "Qualcomm-qrb5165-RB5-WSA8815-Speakers-DMIC0";
+        audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+                    "SpkrRight IN", "WSA_SPK2 OUT",
+                    "VA DMIC0", "vdd-micb",
+                    "VA DMIC1", "vdd-micb",
+                    "MM_DL1",  "MultiMedia1 Playback",
+                    "MM_DL2",  "MultiMedia2 Playback",
+                    "MultiMedia3 Capture", "MM_UL3";
+
+        mm1-dai-link {
+            link-name = "MultiMedia0";
+            cpu {
+                sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+            };
+        };
+
+        mm2-dai-link {
+            link-name = "MultiMedia2";
+            cpu {
+                sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+            };
+        };
+
+        mm3-dai-link {
+            link-name = "MultiMedia3";
+            cpu {
+                sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+            };
+        };
+
+        hdmi-dai-link {
+            link-name = "HDMI Playback";
+            cpu {
+                sound-dai = <&q6afedai TERTIARY_MI2S_RX>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+
+            codec {
+                sound-dai = <&lt9611_codec 0>;
+            };
+        };
+
+        wsa-dai-link {
+            link-name = "WSA Playback";
+            cpu {
+                sound-dai = <&q6afedai WSA_CODEC_DMA_RX_0>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+
+            codec {
+                sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro>;
+            };
+        };
+
+        va-dai-link {
+            link-name = "VA Capture";
+            cpu {
+                sound-dai = <&q6afedai VA_CODEC_DMA_TX_0>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+
+            codec {
+                sound-dai = <&vamacro 0>;
+            };
+        };
+    };
-- 
2.21.0

