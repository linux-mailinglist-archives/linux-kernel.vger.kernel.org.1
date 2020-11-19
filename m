Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1672B9680
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgKSPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgKSPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA890C0613CF;
        Thu, 19 Nov 2020 07:43:42 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so6893275wrc.8;
        Thu, 19 Nov 2020 07:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iULKoUBIR5d2U0BfaYo4iVlUh0dLV0ntO+8RNSncvCo=;
        b=G0wtP2V8M7tYSzNmumEeuwPiNMGINkNXZdIwlMrKdtCM082U2ZqmilBRGRExmfqc+Q
         QV69Q/+zCecC4U+UpUlnCfjNfm8XL6bfuxVYXSAI4srIDVZubmgBylCPW/3D+duIxhfF
         KtTpBC+w9ls4ORMhQy/BJAK8lHAYDXTGqlFpLX4w14KtskOV99Zpx/Q1zpuqyd+cAAkq
         vHOnzYPSg100pkhvDfanY5bWWPz1pIx6GCFLqvnPGX2qy7MflSJP7/WqpSSinGSb1p5n
         /6kPPpV3eBI+fhu2wb9D4PiQL0aguT37jHG/lSFSjqscRi7GOyPCEHcY5CbT97sLB1bI
         CWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iULKoUBIR5d2U0BfaYo4iVlUh0dLV0ntO+8RNSncvCo=;
        b=in5j431p8QUTzrsDtSkGLdgI9ILR1PgBdVtYgn9OBsCXWaglKJxhHIMLWSweO8CcKD
         iiYm25yGCUzXQbQhcumOIxysy1FUBQoEawtCGgb2kYKtbcaMSMYwlzQc7fXehHIAjUYx
         4VKy43KSeUatpTt9Lxrd68J9vPWJ7s0CF8rxeyWTPIRQn5Ug10BSQewVqwyz1XCJOkis
         Ce62Ld3g+cySxjlSOOX96uU7EoAtV93ToPwQqHIo7v8IWaD4Vs5u7mldz9YmOH9gcCxe
         H1HA5S0MIGeR56nLSIrl1M2yTTRZTeG0Jn1kv0dawgq52IOgRdAjDT48Kt+QHgB/Evqx
         dvNw==
X-Gm-Message-State: AOAM533g4HsqrD3Tq82tEowpN9sqJjR7bFV1tl7I+2SK1Maia3ow7o2f
        fJIWV9y25VlAYID888gV+NU=
X-Google-Smtp-Source: ABdhPJy2zNZBjLmzfMIUoS3cRB5AW5P2DbKrJSnQWMtlb9ZCrBR6ldh0gqW6HRqpVbfeXke1b4vfWg==
X-Received: by 2002:adf:ea91:: with SMTP id s17mr10895240wrm.349.1605800621574;
        Thu, 19 Nov 2020 07:43:41 -0800 (PST)
Received: from localhost.localdomain (234.red-79-158-79.dynamicip.rima-tde.net. [79.158.79.234])
        by smtp.gmail.com with ESMTPSA id w10sm181303wra.34.2020.11.19.07.43.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 07:43:41 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, neil@brown.name,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
Date:   Thu, 19 Nov 2020 16:43:34 +0100
Message-Id: <20201119154337.9195-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
References: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe Mediatek MT7621 PCIe PHY.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/mediatek,mt7621-pci-phy.yaml | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
new file mode 100644
index 000000000000..cf32bbc45b5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/mediatek,mt7621-pci-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek Mt7621 PCIe PHY Device Tree Bindings
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: mediatek,mt7621-pci-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 1
+    description: selects if the phy is dual-ported
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie0_phy: pcie-phy@1e149000 {
+      compatible = "mediatek,mt7621-pci-phy";
+      reg = <0x1e149000 0x0700>;
+      #phy-cells = <1>;
+    };
-- 
2.25.1

