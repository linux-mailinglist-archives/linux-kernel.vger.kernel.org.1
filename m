Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB41F2F348C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbhALPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:47:16 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40702 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391359AbhALPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:47:14 -0500
Received: by mail-ot1-f54.google.com with SMTP id j12so2653127ota.7;
        Tue, 12 Jan 2021 07:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fb9ZODMho6VxfT24gPCQtitvFnjpusn/Qj8vbt2ELx0=;
        b=VcNp7f9DizoeEy1Ij3PetMi13uTaTQ5WbWnqjE8etEsIv4+gqSDXJU8ffaa74ZB5sZ
         heNs4uCt49Ru2FcveviNpKu6JeQvhcT8eihIdRrgZMz7NM5I1xztn3nWWu4mpAvuGS8L
         9UoAJvlXYEXfheEVU3Pf8LFpWcWbFJW2LpydeU6D0qnTkeWU5iYL1K9lZscZ/VzhW5+v
         LjaCEv6JLJQ6rIMDpWZ0NAR1eT5E/fjJacKmEF+3dQ2aji9UHuAOON4LS0SN7N0np4f8
         8mollgxI08+sMrBfoNFPKxIg0hTsQNVxneoVhhiHAw7HjjxNqd3/HnjkB7p/BzWi3DuO
         tdPg==
X-Gm-Message-State: AOAM530Hx/Es8ABT1sZi8wwYZvOT4+UBuJAyk1xgNOu4o6S2ucNWAzVX
        xQwkuVFSGPN+YVGkUHYa12BJ8dFknQ==
X-Google-Smtp-Source: ABdhPJyVPzpD5+coVijJld97m+uMLu+NiHfBvXArgI6PWy4SkqJnajRG8m1dsnEAPRDwHfGMfBNocg==
X-Received: by 2002:a05:6830:1308:: with SMTP id p8mr5941otq.330.1610466392915;
        Tue, 12 Jan 2021 07:46:32 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id v17sm632876oou.41.2021.01.12.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:46:32 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] dt-bindings: Remove plain text OF graph binding
Date:   Tue, 12 Jan 2021 09:46:31 -0600
Message-Id: <20210112154631.406250-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameer Pujar <spujar@nvidia.com>

A schema for the OF graph binding has been added to the dt-schema repo
based on graph.txt contents. Let's replace graph.txt now duplicated
contents with a reference to the schema.

For users of the graph binding, they should reference to the graph
schema from either 'ports' or 'port' property:

properties:
  ports:
    $ref: /schemas/graph.yaml#/properties/ports

    properties:
      port@0:
        $ref: /schemas/graph.yaml#/properties/port
        description: What data this port has

      ...

Or:

properties:
  port:
    description: What data this port has
    $ref: /schemas/graph.yaml#/properties/port

Cc: Sameer Pujar <spujar@nvidia.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[robh: moved graph.yaml to dt-schema repo, expanded commit msg]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/graph.txt | 129 +-------------------
 1 file changed, 1 insertion(+), 128 deletions(-)

diff --git a/Documentation/devicetree/bindings/graph.txt b/Documentation/devicetree/bindings/graph.txt
index 0415e2c53ba0..14733b5cb61e 100644
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
+This file has moved to graph.yaml in dt-schema repo
-- 
2.27.0

