Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187402A3540
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKBUhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:37:09 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37076 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:37:01 -0500
Received: by mail-ot1-f47.google.com with SMTP id l36so5895291ota.4;
        Mon, 02 Nov 2020 12:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/f8b/7igunu+rdknGPrkDKABiJMLsPgsX/ibrfgyuE=;
        b=kc/jH4nOO0sdmL4Haqm9O0pz0OLqiAWGLnf2O0p4Mqp/Hm40U4O/+VSVMF7ns1fF89
         0QZuBU/PukqcqBapGLkN2eH+nyprxSPfvcZ/qOXa7hYRE836wAu7cL+OMNrh/jQPm4Mr
         uPNicodsfdcFi6Ydu0NR9oiopS5yElv/P2lbann70dCrdnuwQ1nQcdOlau3ILqBi0A+y
         jrak/QFBnuJdcTtMSq05SEKQ+4xUYCBHpJB8+kHVJxkaxyAor+EaDnrhUx1ZShX3Z+5o
         CUiRKPz9zFDr3H5XQbx7slcoVuhhRVxKfBLDerzPEhAgOTqGgrX1JXsH0YTNz6FE6D0w
         51BA==
X-Gm-Message-State: AOAM5315ls5c2vt8R5Oa2U5dLvT1W1tUIZbFuCrZVi8naGnwRyxHLprH
        wIuSbx6niR/faNWtzPDmKSL5eRqorg==
X-Google-Smtp-Source: ABdhPJyf/s8o41om4q5HEutHixRV/SLqdRJbExtNHML1Yger7QCH8tsfRI6Lo7DxdnBJe4ivuO4ROw==
X-Received: by 2002:a9d:6847:: with SMTP id c7mr12821073oto.134.1604349418876;
        Mon, 02 Nov 2020 12:36:58 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z8sm3839151otm.45.2020.11.02.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:36:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        kuninori.morimoto.gx@renesas.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v3 1/3] dt-bindings: Convert graph bindings to json-schema
Date:   Mon,  2 Nov 2020 14:36:54 -0600
Message-Id: <20201102203656.220187-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102203656.220187-1-robh@kernel.org>
References: <20201102203656.220187-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameer Pujar <spujar@nvidia.com>

Convert device tree bindings of graph to YAML format. Currently graph.txt
doc is referenced in multiple files and all of these need to use schema
references. For now graph.txt is updated to refer to graph.yaml.

For users of the graph binding, they should reference to the graph
schema from either 'ports' or 'port' property:

properties:
  ports:
    type: object
    $ref: graph.yaml#/properties/ports

    properties:
      port@0:
        description: What data this port has

      ...

Or:

properties:
  port:
    description: What data this port has
    type: object
    $ref: graph.yaml#/properties/port

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Move port 'reg' to port@* and make required
 - Make remote-endpoint required
 - Add 'additionalProperties: true' now required
 - Fix yamllint warnings

 Documentation/devicetree/bindings/graph.txt  | 129 +-----------
 Documentation/devicetree/bindings/graph.yaml | 199 +++++++++++++++++++
 2 files changed, 200 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/graph.yaml

diff --git a/Documentation/devicetree/bindings/graph.txt b/Documentation/devicetree/bindings/graph.txt
index 0415e2c53ba0..b7818d61cef7 100644
--- a/Documentation/devicetree/bindings/graph.txt
+++ b/Documentation/devicetree/bindings/graph.txt
@@ -1,128 +1 @@
-Common bindings for device graphs
-
-General concept
----------------
-
-The hierarchical organisation of the device tree is well suited to describe
-control flow to devices, but there can be more complex connections between
-devices that work together to form a logical compound device, following an
-arbitrarily complex graph.
-There already is a simple directed graph between devices tree nodes using
-phandle properties pointing to other nodes to describe connections that
-can not be inferred from device tree parent-child relationships. The device
-tree graph bindings described herein abstract more complex devices that can
-have multiple specifiable ports, each of which can be linked to one or more
-ports of other devices.
-
-These common bindings do not contain any information about the direction or
-type of the connections, they just map their existence. Specific properties
-may be described by specialized bindings depending on the type of connection.
-
-To see how this binding applies to video pipelines, for example, see
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-Here the ports describe data interfaces, and the links between them are
-the connecting data buses. A single port with multiple connections can
-correspond to multiple devices being connected to the same physical bus.
-
-Organisation of ports and endpoints
------------------------------------
-
-Ports are described by child 'port' nodes contained in the device node.
-Each port node contains an 'endpoint' subnode for each remote device port
-connected to this port. If a single port is connected to more than one
-remote device, an 'endpoint' child node must be provided for each link.
-If more than one port is present in a device node or there is more than one
-endpoint at a port, or a port node needs to be associated with a selected
-hardware interface, a common scheme using '#address-cells', '#size-cells'
-and 'reg' properties is used to number the nodes.
-
-device {
-        ...
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        port@0 {
-	        #address-cells = <1>;
-	        #size-cells = <0>;
-		reg = <0>;
-
-                endpoint@0 {
-			reg = <0>;
-			...
-		};
-                endpoint@1 {
-			reg = <1>;
-			...
-		};
-        };
-
-        port@1 {
-		reg = <1>;
-
-		endpoint { ... };
-	};
-};
-
-All 'port' nodes can be grouped under an optional 'ports' node, which
-allows to specify #address-cells, #size-cells properties for the 'port'
-nodes independently from any other child device nodes a device might
-have.
-
-device {
-        ...
-        ports {
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                port@0 {
-                        ...
-                        endpoint@0 { ... };
-                        endpoint@1 { ... };
-                };
-
-                port@1 { ... };
-        };
-};
-
-Links between endpoints
------------------------
-
-Each endpoint should contain a 'remote-endpoint' phandle property that points
-to the corresponding endpoint in the port of the remote device. In turn, the
-remote endpoint should contain a 'remote-endpoint' property. If it has one, it
-must not point to anything other than the local endpoint. Two endpoints with
-their 'remote-endpoint' phandles pointing at each other form a link between the
-containing ports.
-
-device-1 {
-        port {
-                device_1_output: endpoint {
-                        remote-endpoint = <&device_2_input>;
-                };
-        };
-};
-
-device-2 {
-        port {
-                device_2_input: endpoint {
-                        remote-endpoint = <&device_1_output>;
-                };
-        };
-};
-
-Required properties
--------------------
-
-If there is more than one 'port' or more than one 'endpoint' node or 'reg'
-property present in the port and/or endpoint nodes then the following
-properties are required in a relevant parent node:
-
- - #address-cells : number of cells required to define port/endpoint
-                    identifier, should be 1.
- - #size-cells    : should be zero.
-
-Optional endpoint properties
-----------------------------
-
-- remote-endpoint: phandle to an 'endpoint' subnode of a remote device node.
-
+This file has moved to graph.yaml
diff --git a/Documentation/devicetree/bindings/graph.yaml b/Documentation/devicetree/bindings/graph.yaml
new file mode 100644
index 000000000000..b56720c5a13e
--- /dev/null
+++ b/Documentation/devicetree/bindings/graph.yaml
@@ -0,0 +1,199 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/graph.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common bindings for device graphs
+
+description: |
+  The hierarchical organisation of the device tree is well suited to describe
+  control flow to devices, but there can be more complex connections between
+  devices that work together to form a logical compound device, following an
+  arbitrarily complex graph.
+  There already is a simple directed graph between devices tree nodes using
+  phandle properties pointing to other nodes to describe connections that
+  can not be inferred from device tree parent-child relationships. The device
+  tree graph bindings described herein abstract more complex devices that can
+  have multiple specifiable ports, each of which can be linked to one or more
+  ports of other devices.
+
+  These common bindings do not contain any information about the direction or
+  type of the connections, they just map their existence. Specific properties
+  may be described by specialized bindings depending on the type of connection.
+
+  To see how this binding applies to video pipelines, for example, see
+  Documentation/devicetree/bindings/media/video-interfaces.txt.
+  Here the ports describe data interfaces, and the links between them are
+  the connecting data buses. A single port with multiple connections can
+  correspond to multiple devices being connected to the same physical bus.
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+select: false
+
+properties:
+  port:
+    type: object
+    description:
+      If there is more than one endpoint node or 'reg' property present in
+      endpoint nodes then '#address-cells' and '#size-cells' properties are
+      required.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^endpoint(@[0-9a-f]+)?$":
+        type: object
+        properties:
+          reg:
+            maxItems: 1
+
+          remote-endpoint:
+            description: |
+              phandle to an 'endpoint' subnode of a remote device node.
+            $ref: /schemas/types.yaml#/definitions/phandle
+
+        required:
+          - remote-endpoint
+
+  ports:
+    type: object
+    description: |
+      If there is more than one port node or 'reg' property present in port
+      nodes then '#address-cells' and '#size-cells' properties are required.
+      In such cases all port nodes can be grouped under 'ports' independently
+      from any other child device nodes a device might have.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^port(@[0-9a-f]+)?$":
+        $ref: "#/properties/port"
+        type: object
+
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
+
+
+    additionalProperties: false
+
+additionalProperties: true
+
+examples:
+  # Organisation of ports and endpoints:
+  #
+  # Ports are described by child 'port' nodes contained in the device node.
+  # Each port node contains an 'endpoint' subnode for each remote device port
+  # connected to this port. If a single port is connected to more than one
+  # remote device, an 'endpoint' child node must be provided for each link.
+  # If more than one port is present in a device node or there is more than
+  # one endpoint at a port, or a port node needs to be associated with a
+  # selected hardware interface, a common scheme using '#address-cells',
+  # '#size-cells' and 'reg' properties is used to number the nodes.
+  - |
+    device {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0>;
+
+            endpoint@0 {
+                reg = <0>;
+                // ...
+            };
+            endpoint@1 {
+                reg = <1>;
+                // ...
+            };
+        };
+
+        port@1 {
+            reg = <1>;
+
+            endpoint {
+                // ...
+            };
+        };
+    };
+
+  # All 'port' nodes can be grouped under an optional 'ports' node, which
+  # allows to specify #address-cells, #size-cells properties for the 'port'
+  # nodes independently from any other child device nodes a device might
+  # have.
+  - |
+    device {
+        // ...
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0>;
+                // ...
+
+                endpoint@0 {
+                    reg = <0>;
+                    // ...
+                };
+                endpoint@1 {
+                    reg = <1>;
+                    // ...
+                };
+            };
+
+            port@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <1>;
+                // ...
+            };
+        };
+    };
+
+  # Links between endpoints:
+  #
+  # Each endpoint should contain a 'remote-endpoint' phandle property that
+  # points to the corresponding endpoint in the port of the remote device.
+  # In turn, the remote endpoint should contain a 'remote-endpoint' property.
+  # If it has one, it must not point to anything other than the local endpoint.
+  # Two endpoints with their 'remote-endpoint' phandles pointing at each other
+  # form a link between the containing ports.
+  - |
+    device-1 {
+        port {
+            device_1_output: endpoint {
+                remote-endpoint = <&device_2_input>;
+            };
+        };
+    };
+
+    device-2 {
+        port {
+            device_2_input: endpoint {
+                remote-endpoint = <&device_1_output>;
+            };
+        };
+    };
+
+...
--
2.25.1
