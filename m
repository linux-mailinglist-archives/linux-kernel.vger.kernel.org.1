Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CE26DCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgIQNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgIQN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:29:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7FC06121F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:29:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so2105977wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUMo3GZuZkiCAs7huH9d/ejZ9gr6xHUFGAKzWL17mgQ=;
        b=i9DpJQqXX4EdOMnZfe9sNIegP+26XkuputedjvvKwhyoMrHu5zSZWPIW4+bEcx3gIu
         tp9SKOmM40h8aWqV0uxpxJdyfvnUvIMtphzMY8hnr/J1I/ugvF1T4Vyiv9QqSStvxPsp
         6kCjdDgy8qRxWtx8+EvO72PiONBF/Bb2RO4QKIXzo+59euX2/7uvKSVZW5Nrz5og5I5m
         fSxreDQIzoE9ihVb1gRgq8M5cLxSRDDh7Jn/YLmmrGPbXgzRmFV2JV4atFoJkdvjYpr/
         vT3/ScxH3vtSs6CbSARaciwRRKrbQfsj/hZ/7KKqHD9aRbqT7ffwzYr7y+IZtFF11a1B
         8K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUMo3GZuZkiCAs7huH9d/ejZ9gr6xHUFGAKzWL17mgQ=;
        b=NJeptUy3BFMEIEtgSeFlf+R0mMUgkzuwvyCkQ0Yq07RjUR1NpX2rENoiw2hfRgVBec
         aLPSCFlWsMbFK2FXYHByKZO7mMhHiHSVzqr9Af/7dl2kwB99riEyvqxtAxPjjHyQhnFx
         /8St9zszNMULMaWqOwbCbnBG7ucqKc1I+csW7Q9++YNO6uDrSaNZq2FypD5Un+I+rrNY
         6F4tOtInGnHAwUMDxC4GAqk3tJ7k9LoNXPeisOblzDIzQoLtEf94ebShQzvcw9rBQgNP
         pqagY0tShCRNe2GKoPtZhgdoSBP7XECIXgoc+6HTmtQvF9DpCQkHP4tKB9WjpwZTQ47B
         A45w==
X-Gm-Message-State: AOAM531dzsLP/Gpmmm0sjAcvdSOa8TMS36ShFGPUxekbkXASUulGWRPK
        H4kqKAa9mRkvijBVX+MHcii8TQ==
X-Google-Smtp-Source: ABdhPJxe2gpW2Ll4hNvhqzTx8vE2OnSQkybD+M3SsRe0FQvXFOnYQmf3b09tZtXWiIaoWYkfRE9dzw==
X-Received: by 2002:adf:dd44:: with SMTP id u4mr30915898wrm.22.1600349338913;
        Thu, 17 Sep 2020 06:28:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n10sm11486910wmk.7.2020.09.17.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:28:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] dt-bindings: clock: Add support for LPASS Always ON Controller
Date:   Thu, 17 Sep 2020 14:28:48 +0100
Message-Id: <20200917132850.7730-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917132850.7730-1-srinivas.kandagatla@linaro.org>
References: <20200917132850.7730-1-srinivas.kandagatla@linaro.org>
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
index 000000000000..1846c79c6535
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
+      reg = <0 0x03380000 0 0x40000>;
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

