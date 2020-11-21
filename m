Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1E2BC058
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgKUPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 10:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKUPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 10:50:44 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA790C0613CF;
        Sat, 21 Nov 2020 07:50:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so13971655wrg.7;
        Sat, 21 Nov 2020 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFEWyS5RVPcGUpN9QStio+eEKKIHGhXUMH3chmxWTAI=;
        b=Lm0VT517zPj6Yim7Dyifi0idbHd/Q0+shr4EW29l0udSkUQ1mnrcqk6S6Eazm+BCi4
         jdVcj6DvjgxwfaZs63s8LHE3CUwsqR2Hn2dTadzpxKNrorycmERpxWOIVi4ZsKuo/f0m
         qCgYZQc9xehcD6OMVbo0PA94QYJa/gI3v8oRlQBB0pA5HKukMtlB2VZGCM5gVuUfpq1a
         rvw7GIBAbbtohgf7ubRiaSsIOKD8CY8k1G+yrzVUN4+Znuv58glKezt6ES3XS0++4avm
         E7IZIs1j9L6vVjpW1Lhu2ux7qG0wZvnOvlAiWmYydK1OuS/nKabSVBiODWUc6/RxfsMl
         q+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFEWyS5RVPcGUpN9QStio+eEKKIHGhXUMH3chmxWTAI=;
        b=RNkHAXgp9iCGjS5ROVxUTGTsBnqFwB1iOL3+BOHPMu8EvxrNDm9zAeT8pfuDmpg20Y
         VGiFceW7fZRW/u8V8GVn25h/QtRNVrnCV8poFpdG2gl8NT5EnkB5qcOC4ttxxGZwN92j
         rTLhhW58+R1FYXfyFf6RFwQW4ZERW5tOizVKq+Ze5zx7VoY94iXlcqL30iRFG7E7WQAN
         AjIb4ttiUJ1bjJqjCk8K5i0aU1RNe7O2U7/+9UewhTyl0ok443+FrOkpEb/2++a8ZLcA
         Bfrb5ipCvZ7czBsMkd+oGNwguVlm0z0Cjt9pYeQOnz1lhNAyGe31DngqUsGKyHelFa99
         cArQ==
X-Gm-Message-State: AOAM530azxPzxRUJq7FqiYtN+ZqQXHudCs6o/NeZg5MQ8OKIHe2Esb19
        lKJ6SJulmQKDAvbpeYhLMXA=
X-Google-Smtp-Source: ABdhPJxNwrNKx7yiY521VRcz8tWddpSy577DrmPIkYw6rYHLVTiTjGvvmbL1d4+rJJhJizC1q+Z54Q==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr21194191wrr.13.1605973841433;
        Sat, 21 Nov 2020 07:50:41 -0800 (PST)
Received: from localhost.localdomain (161.red-83-46-194.dynamicip.rima-tde.net. [83.46.194.161])
        by smtp.gmail.com with ESMTPSA id n128sm7959598wmb.46.2020.11.21.07.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2020 07:50:40 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, neil@brown.name,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
Date:   Sat, 21 Nov 2020 16:50:34 +0100
Message-Id: <20201121155037.21354-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121155037.21354-1-sergio.paracuellos@gmail.com>
References: <20201121155037.21354-1-sergio.paracuellos@gmail.com>
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
index 000000000000..0ccaded3f245
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

