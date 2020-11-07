Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329BA2AA4D7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 12:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgKGL6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 06:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGL6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 06:58:24 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD763C0613CF;
        Sat,  7 Nov 2020 03:58:24 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r12so4526477iot.4;
        Sat, 07 Nov 2020 03:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehsrxR24+X4JoUL+5hOYvsNW1kB3ZSkbOufEBKUIwWI=;
        b=BHau8K4MVxYAcQx+Y3gp3RB9Rk5XAkXDCsNLK83oi81nJMoqpfbF8IYukTa6hqmxlG
         YWwTQOG6I9eEbLWO9VcklKA3ZjTTXoyOuUPHIY9P8M2fWG8cNc8v65zop37Tzrl6ku5n
         lDIYJVoCcoWVvRWjtnZTPRzUpjUOODY1ATdf4CkfvtGmoh0iphDnLKq76ObZvkjzVkNz
         1fCJWL6GLp/r0HVrgDg+9JCG2uPqAvtAngY+OBJn6W3PppoagtrHtR/vJ2koMFoS96Q+
         MxP/eck9nE3sllJEmAnxvzVXtSMj/QwfLU3nibkWYwHh+4S6EzffOwmWTXw/3qN58hcv
         ks9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehsrxR24+X4JoUL+5hOYvsNW1kB3ZSkbOufEBKUIwWI=;
        b=Pgb0eroOv8rxb1SNto5rDEaTo5zf2b/637FBmZQpA/F/RyMyF6cWZ8FN58mLVRiZ/+
         G98EIcGOhK5+1qgkXei4Rn/CDLJIgCI1heovXX97IPinXrG0BDKXzn0NCth5kAyIqFkg
         CvoI9WM/9ziYGAOzM5YXqR1EOpqVNoPmX4cm4L03awt7S5GKUVHo4nxv+6QudngmGsKB
         i6usdokIhlYw5v8hYTAq0640mZjGbrArYN7ZxMWKaXKeAKqRY/HOxaYkJbhM3cMleFGA
         3xIv3GTs24N3M+ZphoNGUD1dxzSeoeWhk+eSSDjvHJ5lHf3ZqJw9bCI2DUP3mcEexHqr
         MDQw==
X-Gm-Message-State: AOAM533pVUdY11gR10sBGrw4VMdaopgu9FFVT2D+j4g6WVR/tSjKpK3K
        HrfqnryTb7aAxI4DIOdrdNWOTOsuwgIpnA==
X-Google-Smtp-Source: ABdhPJySzuzJOFRFKMjqyXbR+UMBlxlHyoLrWZ60ji+vw9p8Wniju1cm7vLGtN6zZ8EEOD4uEUV5WQ==
X-Received: by 2002:a05:6602:5da:: with SMTP id w26mr4549025iox.207.1604750303852;
        Sat, 07 Nov 2020 03:58:23 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id n1sm2920671ile.86.2020.11.07.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:58:23 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/5] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Sat,  7 Nov 2020 05:58:04 -0600
Message-Id: <20201107115809.1866131-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  Correct errors in YAML
V3:  New to series

 .../devicetree/bindings/bus/fsl,spba-bus.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..d1037acd2734
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,66 @@
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
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,spba-bus
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^bus(@[0-9a-f]+)?$"
+
+  compatible:
+    contains:
+      const: fsl,spba-bus
+  items:
+    - const: fsl,spba-bus
+    - const: simple-bus
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
+type: object
+
+examples:
+  - |
+    bus {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+    };
-- 
2.25.1

