Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97002F7FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbhAOPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbhAOPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:39:59 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECCC0613D3;
        Fri, 15 Jan 2021 07:39:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n8so2041664ljg.3;
        Fri, 15 Jan 2021 07:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srgjk5QVmLK3FqpIHac5AnRKp8slJiIMm3vehhv+DqU=;
        b=rvx+H0Qmrb/n8UlxFo7AwfzpD8AvmON747N0xAQWZMOMoqQ0OL0/5baVgkHSaWmC/p
         Mj1BV9d7TQG2L8lnoJfpvQTgZQJsx83QWH+CTBtp26ZXGJep7yS6qnq2uQcnxVIISGLh
         bWK097qEVIUgDIO9Dxgkn5KRuMq+Dj0lsN6WDazstZSuanVzmWYxSHqxilmzB3GWefkk
         TDa0CVDHzn/fuKj7oBfBR4i2EJuKFLh4igDaQ5TbxZ3gEDRNpxGrtuJCaE/AnmRa/utq
         UcGEOA+//9WHn4LKCU/ASjfQ1OllFemiUb0sXAiMnbP5x086r7T+GzIXMwJUlTp8lbiO
         QgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srgjk5QVmLK3FqpIHac5AnRKp8slJiIMm3vehhv+DqU=;
        b=opMux2KF1snd44aVyIulUlzT6EvewZ/T48hAOkXWmVR5znf0qJk+P2ap7geeT27KKE
         slNPyTXujcIx0CAZgjPi9+5EqIwiwSz5iW4IvjzBLlBw/YjQVjdNAvtkyHK22AGb4EEJ
         VvknW6qJFzrOVKlxXxA68c1A02KE+dUWe16MvYyGY3OR281bAPqHyf7iFbBh9PXcFULJ
         Xpj3ViGufgmy6c/WM1wIKPDsu3W/UG2o0hJtYK5bgSgXdBWPiqXY7aajau19hfVLo81M
         CHpU8Qdj9AVZ9yhhv5v7BsmeHlrgqibomsPcOqlap0rhyFGR8qbn8Amm8sJJrSMROWLI
         VPQA==
X-Gm-Message-State: AOAM531rs66SLFMVcQRXtCwhmDRZXXc7WTngyXpIyvdhI4iRXT3VYY95
        fDV6cPHDa00VEEVx6fmddC8=
X-Google-Smtp-Source: ABdhPJwZjsLS3nFSwGHZRWYqxl3I/ZmEVsseUeiRs/KOrZkYVTEFxEN9eg31UyjKv5J8wc64/oYLLA==
X-Received: by 2002:a2e:8416:: with SMTP id z22mr5535221ljg.347.1610725155447;
        Fri, 15 Jan 2021 07:39:15 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id j2sm931567lfe.134.2021.01.15.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:39:14 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: mtd: move partition binding to its own file
Date:   Fri, 15 Jan 2021 16:38:59 +0100
Message-Id: <20210115153901.31052-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Single partition binding is quite common and may be:
1. Used by multiple parsers
2. Extended for more specific cases

Move it to separated file to avoid code duplication.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../mtd/partitions/fixed-partitions.yaml      | 33 +------------
 .../bindings/mtd/partitions/partition.yaml    | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 6d4a3450e064..ea4cace6a955 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -27,38 +27,7 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    description: node describing a single flash partition
-    type: object
-
-    properties:
-      reg:
-        description: partition's offset and size within the flash
-        maxItems: 1
-
-      label:
-        description: The label / name for this partition. If omitted, the label
-          is taken from the node name (excluding the unit address).
-
-      read-only:
-        description: This parameter, if present, is a hint that this partition
-          should only be mounted read-only. This is usually used for flash
-          partitions containing early-boot firmware images or data which should
-          not be clobbered.
-        type: boolean
-
-      lock:
-        description: Do not unlock the partition at initialization time (not
-          supported on all devices)
-        type: boolean
-
-      slc-mode:
-        description: This parameter, if present, allows one to emulate SLC mode
-          on a partition attached to an MLC NAND thus making this partition
-          immune to paired-pages corruptions
-        type: boolean
-
-    required:
-      - reg
+    $ref: "partition.yaml#"
 
 required:
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
new file mode 100644
index 000000000000..e1ac08064425
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partition
+
+description: |
+  This binding describes a single flash partition. Each partition must have its
+  relative offset and size specified. Depending on partition function extra
+  properties can be used.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  reg:
+    description: partition's offset and size within the flash
+    maxItems: 1
+
+  label:
+    description: The label / name for this partition. If omitted, the label
+      is taken from the node name (excluding the unit address).
+
+  read-only:
+    description: This parameter, if present, is a hint that this partition
+      should only be mounted read-only. This is usually used for flash
+      partitions containing early-boot firmware images or data which should
+      not be clobbered.
+    type: boolean
+
+  lock:
+    description: Do not unlock the partition at initialization time (not
+      supported on all devices)
+    type: boolean
+
+  slc-mode:
+    description: This parameter, if present, allows one to emulate SLC mode
+      on a partition attached to an MLC NAND thus making this partition
+      immune to paired-pages corruptions
+    type: boolean
+
+required:
+  - reg
+
+additionalProperties: true
-- 
2.26.2

