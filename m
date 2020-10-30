Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D22A043E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJ3Lg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3LgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67509C0613D2;
        Fri, 30 Oct 2020 04:36:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w25so6306885edx.2;
        Fri, 30 Oct 2020 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fPvXfEo6tDYrksaupTeUcaqt7QQRL4mRzXpccz682w=;
        b=Nz01zMYdDTwWbGDy9hK5B/NPp3lF1UTRfNKmllSb2BGlM4FBMAHcQvoJaTq1WX0tkf
         ziEjPSMncxx951yA3oc6cokxS3jNviBek7I/h7aAYYr+F07ffM18ret9lMhPmmCluqPM
         GdEPzK/MuoKdTc1xbuS9r5Z8cEyRxpQjGc/Heu8+8dsJTKDV/W4nJbuDbMdfSRcx4CKY
         hCJpE6tMVLdPIFLFVCfcco9zxaYQnQgq6YbOAeRDIIuhmao+Hs/SOzHqUfZQVErDsA4x
         hUZob6pIperO2ZnGAM9FigeYryqEpqn0r3WukBxIdBgi6TwZ3xkwdxq1FFJcxwaG8DWX
         nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fPvXfEo6tDYrksaupTeUcaqt7QQRL4mRzXpccz682w=;
        b=OBbOkuH07HSyr4ML9qpclQLbrfA/dcmsqxP9dp9gLBRV6//6XPnDEuQPQCjBdgtgPD
         21sysJD2ciOnaw568NZa0GdYhzYX9bxxjuSv75q/nxwF4P/As5uj/XhANycFVizdpw4l
         5KoEJLn81KjTcMoDnNbEZVF/yQCorCTkf30bhHUuJMbdz6sSo52GzP67gFzBUn3WtMfM
         s+jD613HhGP9DAcF0rbiMtdkgeJlT7L3e+0+IfPPyKF+dL+EK4zmKiZ7e3dROvd0MEqN
         xkougpF81yA1nPjBT/zq4/aXD8tSabqrxlupGbt21aXogQNd8MAZ8M75tnqsBTvxPg7i
         GAxw==
X-Gm-Message-State: AOAM532N/xXoSs0kGzs9HK5NhhIKvHHGCtqeUo842w7QXi1ShJ8jDrUD
        WY1eeiDDhSVbcgARXykH71g=
X-Google-Smtp-Source: ABdhPJxHMtbrAkCqfmRCZoRvHtegiOI+nujon+I5UcjZPB7r1BONaieUlfjKeeyX6QBFQoiQWeIH2A==
X-Received: by 2002:a50:eb45:: with SMTP id z5mr1782625edp.144.1604057777033;
        Fri, 30 Oct 2020 04:36:17 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:16 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/11] dt-bindings: net: add the DPAA2 MAC DTS definition
Date:   Fri, 30 Oct 2020 13:35:45 +0200
Message-Id: <20201030113555.726487-2-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add a documentation entry for the DTS bindings needed and supported by
the dpaa2-mac driver.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
 - new patch
Changes in v3:
 - renamed dpmac@x into ethernet@x
 - renamed the new documentation file to use the same name as the
   compatible
 - marked additionalProperties as false
 - added a reference to ethernet-controller.yaml
Changes in v4:
 - none
Changes in v5:
 - none

 .../bindings/net/fsl,qoriq-mc-dpmac.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
new file mode 100644
index 000000000000..2159b7d1f537
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DPAA2 MAC bindings
+
+maintainers:
+  - Ioana Ciornei <ioana.ciornei@nxp.com>
+
+description:
+  This binding represents the DPAA2 MAC objects found on the fsl-mc bus and
+  located under the 'dpmacs' node for the fsl-mc bus DTS node.
+
+allOf:
+  - $ref: "ethernet-controller.yaml#"
+
+properties:
+  compatible:
+    const: fsl,qoriq-mc-dpmac
+
+  reg:
+    maxItems: 1
+    description: The DPMAC number
+
+  phy-handle: true
+
+  phy-connection-type: true
+
+  phy-mode: true
+
+  pcs-handle:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description:
+      A reference to a node representing a PCS PHY device found on
+      the internal MDIO bus.
+
+  managed: true
+
+required:
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dpmacs {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@4 {
+        compatible = "fsl,qoriq-mc-dpmac";
+        reg = <0x4>;
+        phy-handle = <&mdio1_phy6>;
+        phy-connection-type = "qsgmii";
+        managed = "in-band-status";
+        pcs-handle = <&pcs3_1>;
+      };
+    };
-- 
2.28.0

