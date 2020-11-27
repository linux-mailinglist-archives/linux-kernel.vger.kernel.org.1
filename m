Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE62C63B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgK0LO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgK0LOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:14:55 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1037C0613D1;
        Fri, 27 Nov 2020 03:14:54 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 142so5501754ljj.10;
        Fri, 27 Nov 2020 03:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7EfRMxFMYxp8cafazqipRekaMl967mWX/R9ctE83nsg=;
        b=P1kLGEEhxSt0HXNDK7TmwL+lEYEc1KV78LzoIyXCWjWxa1LL1M7eTDg6qUgQgJ3IGs
         oaCrWBPMNeyBihFmqve8ySqZDZnLujfvbZ8hthXDJFgPicVBFC+prduHJLoXXSqsguvJ
         8WD3faP4UcttLB4wR3MLcojPKI78YBHS7Rb6UBcwRvrS2qddOE6WX+j24Ams1ZUrju0B
         pS7jHZhJthMKHlBqcFbu7/EEHbBrMQt6X9uhayMZsIuksT3/5SttwEr/nWpIRcZFgsx0
         4+/TQTzv/VhOuNy+Beph86Pzd4UAR3e3RTsOzt8qeDxVgF5SwPbvP98BQK4d9DVIWnNr
         Vy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7EfRMxFMYxp8cafazqipRekaMl967mWX/R9ctE83nsg=;
        b=VCpl4W1ppiaJmMR88UP5A2fjZpcp2IgCVYimxHONGIw6EIUA2aqCnuqJwsIR1fmEF+
         8uBtoRlCSNPIJsTRP6K4+I9eYD/VsirsV4J3g/BDOCrXJQGnGZOlYykE9F8VA5KVMeFd
         Tky7LhZ0JsEMZ7ZYKAWnzKQjrLB+psBXQwdTctxSKBtAdC2hAWUqe0dpRULQI9WBqQoY
         9S9y2MlfKcqsIRz0CcAY9R4ljULFb3SZ+L2XaWc4ZGpgjhg/+1tu5tEwufnWPBW3TxwC
         oahYHIUpg29sdX0dTohzDGsdkcsJRHkbtJtypLBy/AX+kA6jdqryiJN+KvYz17Mf7g3E
         7uuw==
X-Gm-Message-State: AOAM53357mqYLm4krGqaUzOYyKEC3kA47iERMOuAMHACLHdQiaiwXvud
        bv/WurwBjwZ6DaC9V/dDTWUL1yVgz0w=
X-Google-Smtp-Source: ABdhPJwW2Mk/ZnjKgb+JPWWTBN+H3/dxTUjU7lc3170fsL5fbWced/4BFGL/cbWAHWSLiBEa5CP12Q==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr3071556ljk.150.1606475693078;
        Fri, 27 Nov 2020 03:14:53 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o7sm921105ljg.41.2020.11.27.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 03:14:52 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 PCIe reset binding
Date:   Fri, 27 Nov 2020 12:14:41 +0100
Message-Id: <20201127111442.1096-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 was built using older PCIe hardware block that requires using
external reset block controlling PERST# signals.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../reset/brcm,bcm4908-misc-pcie-reset.yaml   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-misc-pcie-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm4908-misc-pcie-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm4908-misc-pcie-reset.yaml
new file mode 100644
index 000000000000..88aebb370838
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm4908-misc-pcie-reset.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/brcm,bcm4908-misc-pcie-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom MISC block PCIe reset controller
+
+description: This document describes reset controller handling PCIe PERST#
+  signals. On BCM4908 it's a part of the MISC block.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: brcm,bcm4908-misc-pcie-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    description: PCIe core id
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@ff802644 {
+        compatible = "brcm,bcm4908-misc-pcie-reset";
+        reg = <0xff802644 0x04>;
+        #reset-cells = <1>;
+    };
-- 
2.26.2

