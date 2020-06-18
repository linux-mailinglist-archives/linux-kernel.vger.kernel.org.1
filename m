Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DC1FFC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 22:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFRUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 16:24:51 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:39712 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgFRUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:24:50 -0400
Received: by mail-io1-f50.google.com with SMTP id f23so3371154iof.6;
        Thu, 18 Jun 2020 13:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQnT5OKkj6SNPDoc6XTrAFVTcb6kZvGTv+b4qeGWTA8=;
        b=cM+BF4YrMgyYnQn/RkMQOEbdl4zIy9YZcBaI9bn4Ww5p+otWQc16LvBXwN0/99MpOA
         wDUlc4yeiSjj6j17xpdJQyk55GKCrbUA4u6iKOPHW5pgdIYFYcbcpk1C85XuB9brvxwG
         4UN+OjUa5gcV/LuYTZnEi8ZPjQdd3+G9G2m+P906ObgC3ngdA9IpY37FxYRUdaJ0Mrrd
         yMUpbdIrm52aGoJDxS2bbopqiYHRaYe8KkoEGz9tuTkEs2U75d3mvv43HQl0fOFth3Ga
         df48cwfQMaZheyrhjCx7IEAGqjCXpoPZTXh3vR1vqLDRYW90DXb6cZql4x9SUF2wOdNA
         yPGA==
X-Gm-Message-State: AOAM531/AxpSKf7ZJjsmkG+AHAiAsokbE4bTF9ULha24mhwraSh1WowA
        LUav80EikbdrdnRLptGDRm+zBqPFWw==
X-Google-Smtp-Source: ABdhPJxjVmn1Amd/qpU8XZEpGV2Q4LTbsgEGH05SIW4SFBzA3+bLZwxVI/7E1PntDfc8G/7DNyCJiA==
X-Received: by 2002:a6b:6818:: with SMTP id d24mr497066ioc.57.1592511888947;
        Thu, 18 Jun 2020 13:24:48 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id c62sm2123127ill.62.2020.06.18.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:24:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] dt-bindings: display: Convert connectors to DT schema
Date:   Thu, 18 Jun 2020 14:24:47 -0600
Message-Id: <20200618202447.872851-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the analog TV, DVI, HDMI, and VGA connector bindings to DT schema
format.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I put myself as maintainer, but would be happy if someone else was like 
one of the Cc'ed people.

 .../display/connector/analog-tv-connector.txt | 31 --------
 .../connector/analog-tv-connector.yaml        | 47 ++++++++++++
 .../display/connector/dvi-connector.txt       | 36 ---------
 .../display/connector/dvi-connector.yaml      | 75 +++++++++++++++++++
 .../display/connector/hdmi-connector.txt      | 31 --------
 .../display/connector/hdmi-connector.yaml     | 63 ++++++++++++++++
 .../display/connector/vga-connector.txt       | 36 ---------
 .../display/connector/vga-connector.yaml      | 42 +++++++++++
 8 files changed, 227 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
 create mode 100644 Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/connector/dvi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/display/connector/dvi-connector.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/display/connector/hdmi-connector.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/connector/vga-connector.txt
 create mode 100644 Documentation/devicetree/bindings/display/connector/vga-connector.yaml

diff --git a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
deleted file mode 100644
index 883bcb2604c7..000000000000
--- a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Analog TV Connector
-===================
-
-Required properties:
-- compatible: "composite-video-connector" or "svideo-connector"
-
-Optional properties:
-- label: a symbolic name for the connector
-- sdtv-standards: limit the supported TV standards on a connector to the given
-                  ones. If not specified all TV standards are allowed.
-                  Possible TV standards are defined in
-                  include/dt-bindings/display/sdtv-standards.h.
-
-Required nodes:
-- Video port for TV input
-
-Example
--------
-#include <dt-bindings/display/sdtv-standards.h>
-
-tv: connector {
-	compatible = "composite-video-connector";
-	label = "tv";
-	sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
-
-	port {
-		tv_connector_in: endpoint {
-			remote-endpoint = <&venc_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml
new file mode 100644
index 000000000000..d9ac42cb7e04
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/connector/analog-tv-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog TV Connector
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - composite-video-connector
+      - svideo-connector
+
+  label: true
+
+  sdtv-standards:
+    description: Limit the supported TV standards on a connector to the given
+      ones. If not specified all TV standards are allowed. Possible TV
+      standards are defined in include/dt-bindings/display/sdtv-standards.h.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  port:
+    description: Connection to controller providing analog TV signals
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/display/sdtv-standards.h>
+
+    connector {
+      compatible = "composite-video-connector";
+      label = "tv";
+      sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
+
+      port {
+        tv_connector_in: endpoint {
+          remote-endpoint = <&venc_out>;
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/connector/dvi-connector.txt b/Documentation/devicetree/bindings/display/connector/dvi-connector.txt
deleted file mode 100644
index 207e42e9eba0..000000000000
--- a/Documentation/devicetree/bindings/display/connector/dvi-connector.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-DVI Connector
-==============
-
-Required properties:
-- compatible: "dvi-connector"
-
-Optional properties:
-- label: a symbolic name for the connector
-- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
-- analog: the connector has DVI analog pins
-- digital: the connector has DVI digital pins
-- dual-link: the connector has pins for DVI dual-link
-- hpd-gpios: HPD GPIO number
-
-Required nodes:
-- Video port for DVI input
-
-Note: One (or both) of 'analog' or 'digital' must be set.
-
-Example
--------
-
-dvi0: connector@0 {
-	compatible = "dvi-connector";
-	label = "dvi";
-
-	digital;
-
-	ddc-i2c-bus = <&i2c3>;
-
-	port {
-		dvi_connector_in: endpoint {
-			remote-endpoint = <&tfp410_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/connector/dvi-connector.yaml b/Documentation/devicetree/bindings/display/connector/dvi-connector.yaml
new file mode 100644
index 000000000000..aaf61bce64ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/connector/dvi-connector.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/connector/dvi-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DVI Connector
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: dvi-connector
+
+  type:
+    description: The HDMI connector type
+    enum:
+      - a   # Standard full size
+      - b   # Never deployed?
+      - c   # Mini
+      - d   # Micro
+      - e   # automotive
+
+  label: true
+
+  hpd-gpios:
+    description: A GPIO line connected to HPD
+    maxItems: 1
+
+  ddc-i2c-bus:
+    description: phandle link to the I2C controller used for DDC EDID probing
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  analog:
+    type: boolean
+    description: the connector has DVI analog pins
+
+  digital:
+    type: boolean
+    description: the connector has DVI digital pins
+
+  dual-link:
+    type: boolean
+    description: the connector has pins for DVI dual-link
+
+  port:
+    description: Connection to controller providing DVI signals
+
+anyOf:
+  - required:
+      - analog
+  - required:
+      - digital
+
+additionalProperties: false
+
+examples:
+  - |
+    connector {
+      compatible = "dvi-connector";
+      label = "dvi";
+
+      digital;
+
+      ddc-i2c-bus = <&i2c3>;
+
+      port {
+        dvi_connector_in: endpoint {
+          remote-endpoint = <&tfp410_out>;
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
deleted file mode 100644
index aeb07c4bd703..000000000000
--- a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-HDMI Connector
-==============
-
-Required properties:
-- compatible: "hdmi-connector"
-- type: the HDMI connector type: "a", "b", "c", "d" or "e"
-
-Optional properties:
-- label: a symbolic name for the connector
-- hpd-gpios: HPD GPIO number
-- ddc-i2c-bus: phandle link to the I2C controller used for DDC EDID probing
-- ddc-en-gpios: signal to enable DDC bus
-
-Required nodes:
-- Video port for HDMI input
-
-Example
--------
-
-hdmi0: connector@1 {
-	compatible = "hdmi-connector";
-	label = "hdmi";
-
-	type = "a";
-
-	port {
-		hdmi_connector_in: endpoint {
-			remote-endpoint = <&tpd12s015_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/connector/hdmi-connector.yaml b/Documentation/devicetree/bindings/display/connector/hdmi-connector.yaml
new file mode 100644
index 000000000000..57f0193a12e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/connector/hdmi-connector.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/connector/hdmi-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDMI Connector
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: hdmi-connector
+
+  type:
+    description: The HDMI connector type
+    enum:
+      - a   # Standard full size
+      - b   # Never deployed?
+      - c   # Mini
+      - d   # Micro
+      - e   # automotive
+
+  label: true
+
+  hpd-gpios:
+    description: A GPIO line connected to HPD
+    maxItems: 1
+
+  ddc-i2c-bus:
+    description: phandle link to the I2C controller used for DDC EDID probing
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  ddc-en-gpios:
+    description: GPIO signal to enable DDC bus
+    maxItems: 1
+
+  port:
+    description: Connection to controller providing HDMI signals
+
+required:
+  - compatible
+  - type
+
+additionalProperties: false
+
+examples:
+  - |
+    connector {
+      compatible = "hdmi-connector";
+      label = "hdmi";
+
+      type = "a";
+
+      port {
+        hdmi_connector_in: endpoint {
+          remote-endpoint = <&tpd12s015_out>;
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/connector/vga-connector.txt b/Documentation/devicetree/bindings/display/connector/vga-connector.txt
deleted file mode 100644
index c727f298e7ad..000000000000
--- a/Documentation/devicetree/bindings/display/connector/vga-connector.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-VGA Connector
-=============
-
-Required properties:
-
-- compatible: "vga-connector"
-
-Optional properties:
-
-- label: a symbolic name for the connector corresponding to a hardware label
-- ddc-i2c-bus: phandle to the I2C bus that is connected to VGA DDC
-
-Required nodes:
-
-The VGA connector internal connections are modeled using the OF graph bindings
-specified in Documentation/devicetree/bindings/graph.txt.
-
-The VGA connector has a single port that must be connected to a video source
-port.
-
-
-Example
--------
-
-vga0: connector@0 {
-	compatible = "vga-connector";
-	label = "vga";
-
-	ddc-i2c-bus = <&i2c3>;
-
-	port {
-		vga_connector_in: endpoint {
-			remote-endpoint = <&adv7123_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/connector/vga-connector.yaml b/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
new file mode 100644
index 000000000000..cc1245f471bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/connector/vga-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VGA Connector
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: vga-connector
+
+  label: true
+
+  ddc-i2c-bus:
+    description: phandle link to the I2C controller used for DDC EDID probing
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  port:
+    description: Connection to controller providing VGA signals
+
+additionalProperties: false
+
+examples:
+  - |
+    connector {
+      compatible = "vga-connector";
+      label = "vga";
+
+      ddc-i2c-bus = <&i2c3>;
+
+      port {
+        vga_connector_in: endpoint {
+          remote-endpoint = <&adv7123_out>;
+        };
+      };
+    };
+
+...
-- 
2.25.1

