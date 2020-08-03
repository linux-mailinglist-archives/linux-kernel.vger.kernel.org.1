Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05566239DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 06:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgHCEBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 00:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHCEBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:01:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A941C061757
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:01:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so6811340pjr.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HddkWWY8Rx43iOmkebsAosLkWhk0laALdAzS7aNVW0o=;
        b=ExnEfLKvpQuoR44gsXAbve07rZhvE0L8IQkIIeHBAjvUZaydxSYN8AyjPX+0t96SfW
         tJfMaq17X20bLRNxQ7uLG+3zqxuM0ScVRYAhcqbaSdOE4wkA12+AU0Lxc5+0NhzG2iFX
         mS7CWKaWdWXJIQ/MnDjJPvE2sd+fqNKXR5QsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HddkWWY8Rx43iOmkebsAosLkWhk0laALdAzS7aNVW0o=;
        b=qzEjsY1OtXxhIkDnmJDphq0FQXJwIo+myU7cAHeROWK5fMFZ3ecIf7z+gOHF7BxZMy
         MMSGgkAscrY7+BWFt0aFg6UYXqcUgC2eYvKya3wr4nL7zGfZbBOQR13WC0QG6gUekTCn
         cAs2zGzWFaE1uERuGteylqHewC6FEmu85U1Mv5IE3eupNQe9I5zeiUwZAI/FpMOIzhTZ
         W/p3RK/epWVhbTYzf2AbEtvy0n9JZAVWN2Wg+ASOOcZRyWSGQ/9A8j8iA1oSXZpS1xRC
         HgPJJ2BIaPz0E9coGrYHoFroNvgtK6TN7nZEWsqKoZVnbrD+hAqBLI/OLuqM8Dxhzvfi
         zS9Q==
X-Gm-Message-State: AOAM531dwQWV7mhtIcc2OC6K46DHsQjHUxL6zhx6GbEiXgrPUtnyMAIs
        QFy0doufSBWVmvTGLDNmVbONzVFGXcpS6g==
X-Google-Smtp-Source: ABdhPJwnMRgGqxCkQaAC3q6BdFwkxHy8qbbV7wbFd54Qi87GMPeA5DwSJbHIZo6TiVnS1w9dDkVo/w==
X-Received: by 2002:a17:90a:20af:: with SMTP id f44mr14182023pjg.169.1596427299437;
        Sun, 02 Aug 2020 21:01:39 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id p11sm17549569pgh.80.2020.08.02.21.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 21:01:38 -0700 (PDT)
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
        Stephan Gerhold <stephan@gerhold.net>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v4 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date:   Mon,  3 Aug 2020 12:01:21 +0800
Message-Id: <20200803040122.2063634-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803040122.2063634-1-cychiang@chromium.org>
References: <20200803040122.2063634-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for sc7180 sound card.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..c74f0fe9fb3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,113 @@
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
+    contains:
+      const: qcom,sc7180-sndcard
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
+  aux-dev:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the codec for headset detection
+
+patternProperties:
+  "^dai-link(@[0-9]+)?$":
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
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
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
+        aux-dev = <&alc5682>;
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
+    };
-- 
2.28.0.163.g6104cc2f0b6-goog

