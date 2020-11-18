Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA92B880A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKRXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgKRXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:04:07 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64796C0613D4;
        Wed, 18 Nov 2020 15:04:23 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id o11so3885128ioo.11;
        Wed, 18 Nov 2020 15:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZInfu40eo3XacJI7eI2K4THUhHpJzqFnWGIhkKbNPA=;
        b=r1eTScUlpMCi+wfL+yTeADRmqIgR+GKM0GxRz7Y52/P+6Y+qEkKnQbfAoGKACWux0W
         I5HwmolD4eRnjP+XfPZfPp9eiuEk2gEvIr2LmZKRGu382D/Y88+kdmyJVn0e9FP5Gjon
         SZVHAVqRJ2IOM8qMTOkd4goYUqU+bLgtGQfMu4uqRV98/xl0badJyXMgOyNUTBBQTD/x
         o9awPEHt/Ht8fR/ClRK+/1oQfYnzST6XAD2e7KGLmMwPqZe6TkpQg9puz1aO1hYfZTf+
         KCPr/jvOMdVOBvq5VzLJqZxIcT6uKK+Wz16qNIpvEOrcpOYCaXG4aEMnkiB9cwHgOn8D
         SO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZInfu40eo3XacJI7eI2K4THUhHpJzqFnWGIhkKbNPA=;
        b=WvmN7nie383y8LG2XYJN3WJ5Atq8ZGN/4O4FLX5BePdFXvZW3aCVPznKIM3dPwiA5r
         PdAL5DPG2BZUMgNqCvmIOdp94E9RWFoSQaBd48lKYjDYB337p98K3GXE25YSjWm8LvBX
         oKnI4kzFdD4Ilnxf3HkhAdY52cgZCiTHX4LInOgoKFmmHLd6pytZyYcTQWdOk198lG6y
         CS8VzvdBzKHoVdZbHZ50NV+vPfx74KgQVRT7pKCWzV6jGt+hINS64SF+6Ne5HOp5dX5p
         CYxm1K1u+OcBR0Jp/1bisZ4PIwpj4n75NBmm56MrVfBPB6ZZ2fBC2cnDJUsDNtb1fnzZ
         sbag==
X-Gm-Message-State: AOAM5333fNv0plfeRmtXivMNXhMB/lTcQYn3lWugqKWLcG5jUyYw1bk9
        CP1djJE81rAzLkufQNMLvGKgBfHAW7ee4w==
X-Google-Smtp-Source: ABdhPJyQ/aXChbmc6QkF8lrU/p0AZU1LMj1QBrEUlLQp26Iuw3vXZqhvAhxX7FXrR3F0fq7gjBWPrA==
X-Received: by 2002:a5d:9284:: with SMTP id s4mr17947604iom.165.1605740662300;
        Wed, 18 Nov 2020 15:04:22 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:3c68:20ab:3887:3631])
        by smtp.gmail.com with ESMTPSA id f8sm12968577ioc.24.2020.11.18.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:04:21 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Wed, 18 Nov 2020 17:04:14 -0600
Message-Id: <20201118230414.121316-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
make dt_binding_check -j8 |grep spba
  DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
  DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml

V5:  Rebase on 5.10-rc2 to be able to check yaml
     Add Reg entry

V4:  Remove an accidental makefile change
     Move type:object under additional properties

V3:  Rebase sample from aips-bus example
     Split off from series adding i.MX8M Nano functions to reduce noise

V2:  Attempted to update yaml from feedback

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..e9f77ecae3d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
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
+    items:
+      - const: fsl,spba-bus
+      - const: simple-bus
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - reg
+  - ranges
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    bus@30000000 {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x30000000 0x100000>;
+        ranges;
+    };
-- 
2.25.1

