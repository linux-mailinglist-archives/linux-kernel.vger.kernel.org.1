Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189772F4F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAMQCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhAMQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:02:19 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4DC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:01:00 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y22so3096658ljn.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tp+yIknuWY62Mm5kLJz89RJjtUuXNij6I82RhlunuQ=;
        b=sOD7qIhiA3NT2BuJw3KxbLqVE1mlgVsVUznc6NKranIoJzlZUaWuMN88sj7504tZyv
         Ta3OmN3tYjKFYR9P1QU4bogwbdYMRjDfAQZ2r+tlci3DNEunmkMbyMVwgSMoaxRxSH3T
         UInLgdLC/QQ88vUk5RsjvcUdPBlDQx4LvqBsf+M+O28Vj1LVhL5/mMznca4toF/oXgJd
         3ts0bq68RVnEZsClGM2Ci+pQKW631bkXMovie7RjaCtrUAxayTKqLKg9V6DOqy/s2dKr
         nJUNTr2GKEiASenvbmbAz+6OiF0vu7PEayiQhUWaEtOhKAnsmfqfYhFUzQteUdD2/nmZ
         DEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tp+yIknuWY62Mm5kLJz89RJjtUuXNij6I82RhlunuQ=;
        b=apkyBhd5c/js5IwGlxrH6lSnBt9dgVs4pUCDQSop3LEHNUkse6LZ8hduK2EezXDw0z
         PK5D9Vp57U94la8fPm6EPGQOQ1ZwGtX+OqrjMgYKYsCSpPrb6QH0wduZr3unBp/9Mpuy
         1euKjAI15nBo7pIDqy+J2t1ZYMvv8lATP3Oy1fEZ/yvRR2Yu9pJK2nSYr9eqAAQlbvle
         FdqoHVcCTVYE9aGRBkmtS0QeZqFQDnWFfyWuDbL4y3Mdv5nvnlsLMxtt2z/1cWaSWDHQ
         IZAxqB8tyHbYnzS11OA3uRk4bCKeU9nTTV5K40WiC23nF0WnTZOGSq7W7T/EaNFY364r
         tGgQ==
X-Gm-Message-State: AOAM530QF5sI/cqQcUCrz9A26KnbW5tT1MBOSLSgYWuk0keD+w3VXzFB
        9kaijn7D5mmB60o4fXHyOiNc4Q==
X-Google-Smtp-Source: ABdhPJyK4uwb48EGWk++nnNdHRHtb4aHkQgCWvB3ZFSEfZefbUUFLDl1xXK7gWpde+hEbaregfQ/GA==
X-Received: by 2002:a05:651c:11c4:: with SMTP id z4mr1253519ljo.443.1610553658857;
        Wed, 13 Jan 2021 08:00:58 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.189])
        by smtp.gmail.com with ESMTPSA id m25sm248559lfb.144.2021.01.13.08.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:00:58 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: misc: qcom,qca6390: add binding for QCA6390 device
Date:   Wed, 13 Jan 2021 19:00:52 +0300
Message-Id: <20210113160053.3974229-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113160053.3974229-1-dmitry.baryshkov@linaro.org>
References: <20210113160053.3974229-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
being controlled through the UART and WiFi being present on PCIe bus.
Both blocks share common power sources. Add binding to describe power
sequencing required to power up this device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/misc/qcom,qca6390.yaml           | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,qca6390.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,qca6390.yaml b/Documentation/devicetree/bindings/misc/qcom,qca6390.yaml
new file mode 100644
index 000000000000..bb507eb6e0a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,qca6390.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mfd/qcom,qca6390.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm QCA6390 WiFi + Bluetoot SoC bindings
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  This binding describes thes Qualcomm QCA6390 or QCA6391 power supplies and
+  enablement pins.
+
+properties:
+  compatible:
+    const: qcom,qca6390
+
+  '#power-domain-cells':
+    const: 0
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: active
+
+  vddaon-supply:
+    description:
+      0.95V always-on LDO power input
+
+  vddpmu-supply:
+    description:
+      0.95V LDO power input to PMU
+
+  vddrfa1-supply:
+    description:
+      0.95V LDO power input to RFA
+
+  vddrfa2-supply:
+    description:
+      1.25V LDO power input to RFA
+
+  vddrfa3-supply:
+    description:
+      2V LDO power input to RFA
+
+  vddpcie1-supply:
+    description:
+      1.25V LDO power input to PCIe part
+
+  vddpcie2-supply:
+    description:
+      2V LDO power input to PCIe part
+
+  vddio-supply:
+    description:
+      1.8V VIO input
+
+additionalProperties: false
+
+examples:
+  - |
+    qca6390: qca6390 {
+      compatible = "qcom,qca6390";
+      #power-domain-cells = <0>;
+
+      vddaon-supply = <&vreg_s6a_0p95>;
+      vddpmu-supply = <&vreg_s2f_0p95>;
+      vddrfa1-supply = <&vreg_s2f_0p95>;
+      vddrfa2-supply = <&vreg_s8c_1p3>;
+      vddrfa3-supply = <&vreg_s5a_1p9>;
+      vddpcie1-supply = <&vreg_s8c_1p3>;
+      vddpcie2-supply = <&vreg_s5a_1p9>;
+      vddio-supply = <&vreg_s4a_1p8>;
+      pinctrl-names = "default", "active";
+      pinctrl-0 = <&wlan_default_state &bt_default_state>;
+      pinctrl-1 = <&wlan_active_state &bt_active_state>;
+    };
+...
-- 
2.29.2

