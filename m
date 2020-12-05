Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC532CF7E4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgLEARS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:17:18 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42281 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgLEARS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:17:18 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5CC9DC0006;
        Sat,  5 Dec 2020 00:16:36 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Date:   Sat,  5 Dec 2020 01:15:07 +0100
Message-Id: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree documentation for simple audio multiplexers

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Cc: Rob Herring <robh+dt@kernel.org>

 .../bindings/sound/simple-audio-mux.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/simple-audio-mux.yaml

diff --git a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
new file mode 100644
index 000000000000..5986d1fcbb54
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/simple-audio-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple Audio Multiplexer
+
+maintainers:
+  - Alexandre Belloni <aleandre.belloni@bootlin.com>
+
+description: |
+  Simple audio multiplexers are driven using gpios, allowing to select which of
+  their input line is connected to the output line.
+
+properties:
+  compatible:
+    const: simple-audio-mux
+
+  mux-gpios:
+    description: |
+      GPIOs used to select the input line.
+
+  sound-name-prefix:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Used as prefix for sink/source names of the component. Must be a
+      unique string among multiple instances of the same component.
+
+required:
+  - compatible
+  - mux-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    mux {
+        compatible = "simple-audio-mux";
+        mux-gpios = <&gpio 3 0>;
+    };
-- 
2.28.0

