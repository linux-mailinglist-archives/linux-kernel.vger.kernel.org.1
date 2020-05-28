Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A61E66AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404709AbgE1PrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404686AbgE1PrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:47:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB04C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so10705178plv.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KY8aQRYELLAf9/2I3C13n0AvLroYbmfmwpkCrL98Gv0=;
        b=CvqTv5pYPAdd6X3RyQls/VWekEcH11q0LJ7qJf5c56TvtFNlwd9Hq76OBcVcRIdXye
         frAGiLIfKX9m8sWcdgMq7BMReQbM4jtYCQwewrbSa92Sn8keEoNVTKGtLuRsw33UDbDS
         tJCxXprxz4EYFBGPBO/4WKEVpdayZ51g6BfqU5NyF8UsPWklu+YHZq7cFziV6zYX4NPR
         /NnvhskEu0rJBGH8hn1Z+edDNEWzjIE+zG70ZEu/N0Er1D1nKymsHoOZ6gOuwx1P6Ill
         D0Ilr1xNbViWFlkxkjXpevCn5+VswQ3S/gsvBpizyAfkOo6PHPPwvAI/+JLTQOAOtAPX
         Gj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KY8aQRYELLAf9/2I3C13n0AvLroYbmfmwpkCrL98Gv0=;
        b=G0ClkMyvcbm7/S3gsjkOYpSXwmPKo2pPbltHf1Ly9Xq417t6Z1ccTuQX2ynwXgBDBO
         n5/VZCcdA/pyLnoCRBBKcL2mFAIfOhq3T4BmQIAL5YwcuTrnhHRR9HRMezFOEg6pTfZe
         4+rDnMgJhRn8/uRXThCpNYg7iVV+Qi/wECzUp2nKGd/NgCQLeklkne9yXZgARM/v4sya
         rl0x0eaCAA5m/IyEgGAiQ6ZIEjG/echzKehX5mtbQ/ckUrEg+0kRWoVWPZQ1j/ARhSiv
         +IyxRkZwckvBjP/4b4yISbVpzWhrWtmhQsYnkDBFvNjdF0FyFUnNim8fqFfd1Gq8iq+B
         NJ1A==
X-Gm-Message-State: AOAM532XMEgdeeNYP1ofWBR/C6hc42aSWtvBSGDWa+PWT4iN4NR3Tghs
        4n56yDpExNkRshrkG08BGEuiVQ==
X-Google-Smtp-Source: ABdhPJy3Sol2FO0WDZNPj8c7jOKixvVKVciOZKOIyGeQHO4q9jqYHyeikxhpwzbAQlI2rsbc6NkQLg==
X-Received: by 2002:a17:90a:e2cb:: with SMTP id fr11mr4678496pjb.72.1590680827443;
        Thu, 28 May 2020 08:47:07 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id y22sm5212551pfc.132.2020.05.28.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:47:06 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v3 2/5] dt-bindings: regulator: Add labibb regulator
Date:   Thu, 28 May 2020 21:16:22 +0530
Message-Id: <20200528154625.17742-3-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528154625.17742-1-sumit.semwal@linaro.org>
References: <20200528154625.17742-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

Adding the devicetree binding for labibb regulator.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

--
v2: updated for better compatible string and names.
v3: moved to yaml

---
 .../regulator/qcom-labibb-regulator.yaml      | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
new file mode 100644
index 000000000000..5406601ecd65
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom-labibb-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost) Regulator
+
+maintainers:
+  - Sumit Semwal <sumit.semwal@linaro.org>
+
+description:
+  LAB can be used as a positive boost power supply and IBB can be used as a
+  negative boost power supply for display panels. Currently implemented for
+  pmi8998.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: qcom,pmi8998-lab-ibb
+
+  lab:
+    type: object
+    interrupts:
+      items:
+        - description: Short-circuit interrupt for lab.
+    interrupt-names:
+      maxItems: 1
+      items:
+        - const: sc-err
+
+  ibb:
+    type: object
+    interrupts:
+      items:
+        - description: Short-circuit interrupt for lab.
+    interrupt-names:
+      maxItems: 1
+      items:
+        - const: sc-err
+
+required:
+  - compatible
+
+examples:
+	pmi8998_lsid1: pmic@3 {
+		labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "lab-sc-err";
+			};
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "ibb-sc-err";
+			};
+
+		};
+	};
-- 
2.26.2

