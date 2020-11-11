Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175112AF08F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKKM1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:27:14 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13634 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKKM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:27:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fabd8a60000>; Wed, 11 Nov 2020 04:27:18 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 12:27:11 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 12:27:09 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/2] ASoC: audio-graph-card: Refactor schema
Date:   Wed, 11 Nov 2020 17:56:52 +0530
Message-ID: <1605097613-25301-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605097638; bh=s6JucEQhb3UOZuBf/Ti8tS8zH6e/6GIKsKPqPv9s3nE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=apC9FbcxzdKsFC91BM4Q6dRak677TIy5rMLb10s+1H4E82ecbKMDq6eRC4Zfjam9F
         jp04iJ14dmsNrA5FuEgL+WaPBTtfZx0R8m8a46gyRmPGndR6/7JrlwjU20FPAEv1JZ
         kE0fMZe6sRTq490Y2oDBHm5DmotYrUMLkg70Ba2jJRW43l39DdivOx4K6ISWP6GvY+
         nTOY8FFqBrUpmdRLUblZRUU1QUtuvoV7ss3epP6gwKptTTcmxkhqbVJkCbSDAUXRfV
         OwXOqlp/3S4F7JcoG9SHzI/qDuP+FwbcBcxIf8c/URg7H13GGXjIKREOKW7V2PCpot
         p7UDEIBDlAJ6w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be customized sound cards which are based on generic audio
graph. In such cases most of the stuff is reused from generic audio
graph. To facilitate this, refactor audio graph schema into multiple
files and the base schema can be reused for specific sound cards.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/sound/audio-graph-card.yaml           | 102 +-------------------
 .../devicetree/bindings/sound/audio-graph.yaml     | 107 +++++++++++++++++++++
 2 files changed, 110 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph.yaml

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
index 2329aeb..e047d7d 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
@@ -9,113 +9,17 @@ title: Audio Graph Card Driver Device Tree Bindings
 maintainers:
   - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
+allOf:
+  - $ref: /schemas/sound/audio-graph.yaml#
+
 properties:
   compatible:
     enum:
       - audio-graph-card
       - audio-graph-scu-card
 
-  dais:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-  label:
-    maxItems: 1
-  prefix:
-    description: "device name prefix"
-    $ref: /schemas/types.yaml#/definitions/string
-  routing:
-    description: |
-      A list of the connections between audio components.
-      Each entry is a pair of strings, the first being the
-      connection's sink, the second being the connection's source.
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-  widgets:
-    description: User specified audio sound widgets.
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-  convert-rate:
-    description: CPU to Codec rate convert.
-    $ref: /schemas/types.yaml#/definitions/uint32
-  convert-channels:
-    description: CPU to Codec rate channels.
-    $ref: /schemas/types.yaml#/definitions/uint32
-  pa-gpios:
-    maxItems: 1
-  hp-det-gpio:
-    maxItems: 1
-  mic-det-gpio:
-    maxItems: 1
-
-  port:
-    description: single OF-Graph subnode
-    type: object
-    properties:
-      reg:
-        maxItems: 1
-      prefix:
-        description: "device name prefix"
-        $ref: /schemas/types.yaml#/definitions/string
-      convert-rate:
-        description: CPU to Codec rate convert.
-        $ref: /schemas/types.yaml#/definitions/uint32
-      convert-channels:
-        description: CPU to Codec rate channels.
-        $ref: /schemas/types.yaml#/definitions/uint32
-    patternProperties:
-      "^endpoint(@[0-9a-f]+)?":
-        type: object
-        properties:
-          remote-endpoint:
-            maxItems: 1
-          mclk-fs:
-            description: |
-              Multiplication factor between stream rate and codec mclk.
-              When defined, mclk-fs property defined in dai-link sub nodes are ignored.
-            $ref: /schemas/types.yaml#/definitions/uint32
-          frame-inversion:
-            description: dai-link uses frame clock inversion
-            $ref: /schemas/types.yaml#/definitions/flag
-          bitclock-inversion:
-            description: dai-link uses bit clock inversion
-            $ref: /schemas/types.yaml#/definitions/flag
-          frame-master:
-            description: Indicates dai-link frame master.
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-            maxItems: 1
-          bitclock-master:
-            description: Indicates dai-link bit clock master
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-            maxItems: 1
-          dai-format:
-            description: audio format.
-            items:
-              enum:
-                - i2s
-                - right_j
-                - left_j
-                - dsp_a
-                - dsp_b
-                - ac97
-                - pdm
-                - msb
-                - lsb
-          convert-rate:
-            description: CPU to Codec rate convert.
-            $ref: /schemas/types.yaml#/definitions/uint32
-          convert-channels:
-            description: CPU to Codec rate channels.
-            $ref: /schemas/types.yaml#/definitions/uint32
-        required:
-          - remote-endpoint
-
-  ports:
-    description: multi OF-Graph subnode
-    type: object
-    patternProperties:
-      "^port(@[0-9a-f]+)?":
-        $ref: "#/properties/port"
-
 required:
   - compatible
-  - dais
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
new file mode 100644
index 0000000..1e338d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/audio-graph.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Audio Graph Card Driver Device Tree Bindings
+
+maintainers:
+  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
+allOf:
+  - $ref: /schemas/graph.yaml#
+
+select: false
+
+properties:
+  dais:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+  label:
+    maxItems: 1
+  prefix:
+    description: "device name prefix"
+    $ref: /schemas/types.yaml#/definitions/string
+  routing:
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the
+      connection's sink, the second being the connection's source.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+  widgets:
+    description: User specified audio sound widgets.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+  convert-rate:
+    description: CPU to Codec rate convert.
+    $ref: /schemas/types.yaml#/definitions/uint32
+  convert-channels:
+    description: CPU to Codec rate channels.
+    $ref: /schemas/types.yaml#/definitions/uint32
+  pa-gpios:
+    maxItems: 1
+  hp-det-gpio:
+    maxItems: 1
+  mic-det-gpio:
+    maxItems: 1
+
+  port:
+    description: single OF-Graph subnode
+    type: object
+    properties:
+      prefix:
+        description: "device name prefix"
+        $ref: /schemas/types.yaml#/definitions/string
+      convert-rate:
+        description: CPU to Codec rate convert.
+        $ref: /schemas/types.yaml#/definitions/uint32
+      convert-channels:
+        description: CPU to Codec rate channels.
+        $ref: /schemas/types.yaml#/definitions/uint32
+    patternProperties:
+      "^endpoint(@[0-9a-f]+)?":
+        type: object
+        properties:
+          mclk-fs:
+            description: |
+              Multiplication factor between stream rate and codec mclk.
+              When defined, mclk-fs property defined in dai-link sub nodes are
+              ignored.
+            $ref: /schemas/types.yaml#/definitions/uint32
+          frame-inversion:
+            description: dai-link uses frame clock inversion
+            $ref: /schemas/types.yaml#/definitions/flag
+          bitclock-inversion:
+            description: dai-link uses bit clock inversion
+            $ref: /schemas/types.yaml#/definitions/flag
+          frame-master:
+            description: Indicates dai-link frame master.
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            maxItems: 1
+          bitclock-master:
+            description: Indicates dai-link bit clock master
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            maxItems: 1
+          dai-format:
+            description: audio format.
+            items:
+              enum:
+                - i2s
+                - right_j
+                - left_j
+                - dsp_a
+                - dsp_b
+                - ac97
+                - pdm
+                - msb
+                - lsb
+          convert-rate:
+            description: CPU to Codec rate convert.
+            $ref: /schemas/types.yaml#/definitions/uint32
+          convert-channels:
+            description: CPU to Codec rate channels.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - dais
+
+additionalProperties: true
-- 
2.7.4

