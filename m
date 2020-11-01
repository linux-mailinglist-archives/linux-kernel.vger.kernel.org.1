Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8207F2A1E3A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKANNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgKANNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:13:20 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC844C0617A6;
        Sun,  1 Nov 2020 05:13:19 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id c11so10590838iln.9;
        Sun, 01 Nov 2020 05:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmRnGB7IbCX0cBw66kbT+LMbVje+Vny1+S8fRWaedwg=;
        b=GqcsJEIMGrq/QN1XyF5sHRsmBNe54su4GmimLOVSMosXdTAOQlz7dSnsw3yKimS1/c
         dSYrBYiz1PntM5N64U8+OrlFoIi8R9IFmRa4YIiQEQ20MvI3o3JF2/YY/LBGRQ4fZWaN
         39K79Qm5uzxXL2jMz+1Tu356TETWsQsUmuCm/UYhwPEL17reK2WFEWWa/QE2vuuO7mlm
         FSecwDIFKl04C4glA3CEeEF1UL3GjHJ6nOjXQB8nkx5if2LquZK3y8/xKJ1U/G/LDt2u
         ciNhz4mg7TaQSxZ6DrF9XkMtvT0eFTJoiwBYnGIgCSlphZf0WqMd68hr9evVmtSb/Jab
         m5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmRnGB7IbCX0cBw66kbT+LMbVje+Vny1+S8fRWaedwg=;
        b=bqjgESTfr+P+FcttkI3d/DWmnONx7Spybqg4MK+mlgwdH5bVl9+FgR1rTyR8UIzLCn
         GhG/52Ppgyr9QtLXbVn7FzbY8+pFj944EGiACswUtiJybY8vQG8sWkR/rvFbQg23kB0s
         MAfBZ0EG53Kn3/lIL8CDS9hRPgntExKWelEv5HsfEce2ahKtQPPqetOELoUUszt5apxp
         xzvKS/IZIdz1nqmeOrzTQe5wmPOe0qVFBA6+Cnre4tOXQZURNVD6yqp5ZG8WaT9C76Sh
         5Zj0hsn/3Znvs1LtUxFWlXat9KDIr4AjEbiR9V3syc/eOhGY80VDEd4t91+jVMxmzXQ5
         fFOA==
X-Gm-Message-State: AOAM532SZ9sgfrdTkPNybIjcoGN00E2VhTijpsvzwOdRwt6kyJxXmEbj
        V7XFRTzdDXujoTEv4590slvjghlWXlfFcQ==
X-Google-Smtp-Source: ABdhPJyfM2UAQHbFDikWtef5A1D3tXsCiJFoLvmOzV50b5KTRYAF5kyYHYN/CEIv5EofEA6lTzkYQQ==
X-Received: by 2002:a92:6b08:: with SMTP id g8mr2230767ilc.32.1604236398740;
        Sun, 01 Nov 2020 05:13:18 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id x5sm9017991ilc.15.2020.11.01.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 05:13:17 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Sun,  1 Nov 2020 07:12:56 -0600
Message-Id: <20201101131257.782279-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..acb3944168ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Shared Peripherals Bus Interface
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: |
+  A simple bus enabling access to shared peripherals.
+
+  The "spba-bus" follows the "simple-bus" set of properties, as
+  specified in the Devicetree Specification.  It is an extension of
+  "simple-bus" because the SDMA controller uses this compatible flag to
+  determine which peripherals are available to it and the range over which
+  the SDMA can access.  There are no special clocks for the bus, because
+  the SDMA controller itself has its interrupt, and clock assignments.
+
+properties:
+  $nodename:
+    pattern: "^bus(@[0-9a-f]+)?$"
+
+  compatible:
+    contains:
+      const: fsl,spba-bus
+    description:
+      Shall contain "fsl,spba-bus" in addition to "simple-bus"
+      compatible strings.
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+
+additionalProperties: true
+
+examples:
+  - |
+
+    bus {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+    };
-- 
2.25.1

