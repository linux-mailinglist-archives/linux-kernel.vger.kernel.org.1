Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9032AF43C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKKO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKKO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:58:10 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90484C0613D1;
        Wed, 11 Nov 2020 06:58:09 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id q1so2207064ilt.6;
        Wed, 11 Nov 2020 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgAIziHuY+2kUNj8ODhklCWP95ddG2zrRxQsnyJcrZM=;
        b=mSqJEHYAZiCcJPvoSGfPyRgK2Dx+KCj+cqHHgvpMkgt/Ti+dkQ2Fw3JG1gdsDJTQqB
         SjxRSro86NYx34w8dZh4Doa7xqVoTyZHmpDWF0xZSZ+ktR0bzjQke0fvw28pilcvQCtZ
         IRVHndHcVQOwujNkyM2uf/uCrotkbuWnoMgO1ItyS9cqKAcI66gGbtOpQORNSavRN5ih
         VUT1xVj3CjxCyRKf94SXkdaiP6ARJfm472SW0dcXeSWdLz9Ef7G/0dmIEFgiNY7uiZzL
         Wa8fT37D6cV9qg9Hu+ysgiOIJnhZiD7jR4SjVddtiWZOfkHms1sDm9ZzVrZXzsQJLdY7
         WSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgAIziHuY+2kUNj8ODhklCWP95ddG2zrRxQsnyJcrZM=;
        b=WD+7t1+xmYxyg+m1MdZVNMGsdIBjlpzS+rLtkYdOTIR8YT6Pu9QaSqOzC46mCwWdD9
         cmhVEi95tF2C8AzDPpquFNvzN5Qyt8C7lNnnY480IIzwgHglNS4KMVlB3ERlXhti7sSH
         sfWMos4XMnpNaKCIbeWaCl9UaS3cEI4UPFcJsumKhI34RlBDG7nj7oAKnYlQaG+gTzmK
         cEY1DR1rxQbflFudfqFPFc7LZTzDV1XjiRz/4+jL1RJrd+DN35C6ab8Oa98DHk+CuWyP
         sG/6ZDCQzqVZMHTtKVWMNujKvBudbGG/d9p6qcct99EutxIIuL/sW94GPpbd3K/b3Hf7
         Z1xw==
X-Gm-Message-State: AOAM531nEQnGmS+qBe6lCR98h3U+vW/Pu+i5YjgsbRLlvnF5q7gSMG6o
        Crrd26SksKcmxknR0HlbxmxnmhRW3wBqKQ==
X-Google-Smtp-Source: ABdhPJy0UZZ+Ab+ZtKA5lDJQ/3GtSM8PPRWhf6DOXRNF42NeklnKDpN7QtAk8FptZdYMRGtPbVfPpw==
X-Received: by 2002:a92:480e:: with SMTP id v14mr17297561ila.218.1605106688452;
        Wed, 11 Nov 2020 06:58:08 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:59b1:ae74:30a3:447f])
        by smtp.gmail.com with ESMTPSA id m2sm1374674ilj.24.2020.11.11.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 06:58:07 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Wed, 11 Nov 2020 08:57:57 -0600
Message-Id: <20201111145757.74974-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
make dt_binding_check showed no errors if I did this right.

V3:  Rebase sample from aips-bus example
     Split off from series adding i.MX8M Nano functions to reduce noise
V2:  Attempted to update yaml from feedback

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index f50420099a55..ec8073cb2e71 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,8 +3,6 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
-DT_SCHEMA_LINT = $(shell which yamllint)
-
 DT_SCHEMA_MIN_VERSION = 2020.8.1
 
 PHONY += check_dtschema_version
@@ -26,10 +24,6 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
-quiet_cmd_yamllint = LINT    $(src)
-      cmd_yamllint = $(find_cmd) | \
-                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint
-
 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = $(find_cmd) | \
                          xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)
@@ -43,7 +37,6 @@ quiet_cmd_mk_schema = SCHEMA  $@
 		      rm -f $$f
 
 define rule_chkdt
-	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
 	$(call cmd,chk_bindings)
 	$(call cmd,mk_schema)
 endef
@@ -55,7 +48,7 @@ override DTC_FLAGS := \
 	-Wno-graph_child_address \
 	-Wno-interrupt_provider
 
-$(obj)/processed-schema-examples.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
+$(obj)/processed-schema-examples.json: $(DT_DOCS) check_dtschema_version FORCE
 	$(call if_changed_rule,chkdt)
 
 ifeq ($(DT_SCHEMA_FILES),)
diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..91dae405ed39
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,65 @@
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
+    bus@30000000 {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x30000000 0x100000>;
+        ranges;
+    };
-- 
2.25.1

