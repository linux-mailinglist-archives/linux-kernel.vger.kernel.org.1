Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184E029EA16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgJ2LIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgJ2LIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:08:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B989C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:08:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s9so2271159wro.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3gNqkE0Rt+WwKhPrdqCOYgsX+TR72hWXEKI4+Ir+B4=;
        b=Ecgz5qHFCC0xkZin/OSTXC6WslgznGQEV4jEOrncjDTygu7NmaIBq9jF/zg6I/7uu0
         CX8pGDB8tZVnepm5fnfxqhtADMUpVKKLZMg7QEObOPEY8Zs1Rlii2c1HqpKb8tHv5NyW
         vTt+65Ouc3Rq84ullY4WAmnGKznxqRc99T/4piNGD156QuDAsyGJg0IR1350IbWm519O
         3RJdNOqZJOVvbg1mrrPgzsdQxcbuZovB5xjRvKnlat59Puy1iSVPFt+dz5KfN/aObv4c
         zFN2xbsbgCvGTEw0j04OiuWAAJDevFgYD2NXg4K+jA7/hGHzdi2QxeCBP7BjboQob7+u
         bVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3gNqkE0Rt+WwKhPrdqCOYgsX+TR72hWXEKI4+Ir+B4=;
        b=Z1SJ3sZw3BQZ6IJ3/XOXGwgqT67XuMjz98CABU1BKK+57izHd4WGbTLUo5FAeedqCa
         g5qXw+aFbtpKec2CcF/ar//93RRVAsxmEFRlE8bwsco0FFkQhatWIUjupHlnYKmlSVYl
         aetsWykzbDFR5dS0sz0ejX81L+Ndq/yuYR4dl8Rf9h7ExxaYOZkWT4U5R0GtfFv9k0b2
         F9Xs+PGfcmybHyGZmtS0aMYsD5RV+LsUGcME1RuOif4cvTwTQsmBOZ270CBSrWRQmjyo
         ig1qD25Ffc4EWdiO5UXg/BuN17gRR7nFj4qiFn0t/myJ2uJOnhalCIHHQp21U6Eyzhwl
         dNdQ==
X-Gm-Message-State: AOAM532iIQPk9FdSyb5lIpwxY5Ss0nIwBwB7vkPgf/qrKKJHn3Ad3vZS
        sI+/HzquiB3s0ue/FtOMbyW7iw==
X-Google-Smtp-Source: ABdhPJyjx1tewy2ssRVNGcVaXrfzGcvyw+lhMD2Mr6TXfnvwvBguV/HdKRrkE1n9KbjATDV3zK5tFw==
X-Received: by 2002:adf:8296:: with SMTP id 22mr2468015wrc.341.1603969721966;
        Thu, 29 Oct 2020 04:08:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n4sm3710830wmi.32.2020.10.29.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:08:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/6] ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
Date:   Thu, 29 Oct 2020 11:08:24 +0000
Message-Id: <20201029110829.16425-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec WSA macro which is
for connecting with WSA Smart speakers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

