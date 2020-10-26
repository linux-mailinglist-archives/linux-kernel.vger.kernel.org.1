Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873FB298CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774663AbgJZMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:02:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37256 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769492AbgJZMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:02:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so12161406wre.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTQ3e0/LCgzSJvFHZrL2OGlp6ZdNfQa4Pg2C/+kTcwM=;
        b=kBVBSo7TLFU9aJEGInvgMuGoCqqdAp6Jff0SPFqq4sy/zqZ1u8AYWNVM41NLwGDxs4
         dZTrqH7i5sb50AbMIkroNlCNGrpkFVOrR0GJn9u7TPM0vV/EBt8wBEBVSrDisRiPaJBu
         RoM5lZIE9CsSxvlOoo6iq1rswox1/k2yV3FjBjdBrhmNvHb1zcDuknKOwj2gBgrcaLzt
         1BIY+OMlyAcOGS/awvl0GO8vrzaYICWSRfbmFO+tBfOYC6vjUbHFvN2sykk191PHOwqw
         32ZdMGJR6vaVxzFoixcoo0s5gaNTdrPK3tWnI/2arVwDFPLMVnZjvgmHEZcROAZ9R81i
         +OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTQ3e0/LCgzSJvFHZrL2OGlp6ZdNfQa4Pg2C/+kTcwM=;
        b=hWlWNaP/ivkcM/SCV1SLgvRO6wlFuuInyLPWbHHk9veVyHSX1goQ0PB48QZ195qylu
         mgLSYVCzLe8l/X3Ke/rhGP/4IDypTwMarvpBW7Fi+KADJhF8pJhCAmUgs6qz7tVg7Yxj
         lrYQ/L73YvtHflZ+aOi+BR4oY/5hTt3H2O+SU9p4zH21zR0PRIKm/tOAxCVDsWMrhRZc
         tsgi+kOTw8MtbQla68a8CwQxOPOE9WgZVniGH1hGaBJ2UfVg+RPOfwkNfa/y6MhztAFg
         LwDX3P6JF8seZd77h9tN27zw0H7ePU9+FdtPcD2/+6WuyIbSi3wuduz4nNKHxecRe+H2
         H0oQ==
X-Gm-Message-State: AOAM5302IwYghmg0Rb98V3Hnc0dEUHWy/YGmbGz1FRkotKgdEMDSzAth
        TUfiM53B5lKYxwGhNQ4q95GLqw==
X-Google-Smtp-Source: ABdhPJwUyieU/ekWNPwftMTRNEkVHONiD842F/oO7wHaAKSawRTzT9zbP/E/TXWWlF9ODFFx8s1a5w==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr16672202wrw.145.1603713747473;
        Mon, 26 Oct 2020 05:02:27 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id i33sm23659337wri.79.2020.10.26.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:02:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v3 2/4] dt-bindings: clock: Add support for LPASS Always ON Controller
Date:   Mon, 26 Oct 2020 12:02:19 +0000
Message-Id: <20201026120221.18984-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201026120221.18984-1-srinivas.kandagatla@linaro.org>
References: <20201026120221.18984-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always ON Clock controller is a block inside LPASS which controls
1 Glitch free muxes to LPASS codec Macros.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/clock/qcom,aoncc-sm8250.yaml     | 58 +++++++++++++++++++
 .../clock/qcom,sm8250-lpass-aoncc.h           | 11 ++++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
new file mode 100644
index 000000000000..c40a74b5d672
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,aoncc-sm8250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for LPASS Always ON Clock Controller on SM8250 SoCs
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell.
+  See include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h for the full list
+  of Audio Clock controller clock IDs.
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-aon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: LPASS Core voting clock
+      - description: Glitch Free Mux register clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8250-lpass-aoncc.h>
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    clock-controller@3800000 {
+      #clock-cells = <1>;
+      compatible = "qcom,sm8250-lpass-aon";
+      reg = <0x03380000 0x40000>;
+      clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+      clock-names = "core", "bus";
+    };
diff --git a/include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h b/include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h
new file mode 100644
index 000000000000..f5a1cfac8612
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_CLK_LPASS_AONCC_SM8250_H
+#define _DT_BINDINGS_CLK_LPASS_AONCC_SM8250_H
+
+/* from AOCC */
+#define LPASS_CDC_VA_MCLK				0
+#define LPASS_CDC_TX_NPL				1
+#define LPASS_CDC_TX_MCLK				2
+
+#endif /* _DT_BINDINGS_CLK_LPASS_AONCC_SM8250_H */
-- 
2.21.0

