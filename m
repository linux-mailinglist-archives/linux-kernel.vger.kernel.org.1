Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF72C2F7FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbhAOPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733116AbhAOPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:40:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA9C061794;
        Fri, 15 Jan 2021 07:39:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o17so13757756lfg.4;
        Fri, 15 Jan 2021 07:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7im1QXvoU9pnwhNU516Up7aImtiZpLV/k+KA0KsbcAE=;
        b=qbSvhrRlFFWplAJZXDw8nkCVTFgkNpvW+CyQHlqom83lOcBI6lP1ZUAnLA1RwqKiY4
         qots7YAfLkvtJkf9rHTne2G2A+dNqeyMUowh3mIVK7zIGxIOoSz59mfTRn37SiX0z1li
         acO8itK70B+ig9uU27eL9844ScY9NF/rj6Ps6C3YzjwYWjCYPy2CfoEZiQN6/HXomN5j
         7fWKASDPDdbLGFc7lEpd2Dc4rK/zUId06Zlqw3MtFOgn9ebyse4YDzOTmT0er5p3br2B
         quiDC3Zk20fvOrP62KKt9hYM63iuyyOgWDn8Rzk1AQkyxhYUPeF7p6yixV0DSENtNqIs
         k4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7im1QXvoU9pnwhNU516Up7aImtiZpLV/k+KA0KsbcAE=;
        b=d75wQoAaF9UR+gOjW3F+/nD7lBZ/TUPr4a6VKmwg+7vSnjkf2TQ4Ke2/cq0Njkf/kb
         Z7XLUHNJK+LrmYm3YAEtEfJ7iScdqaG8Z1XYk4c3ijAetGcZXyLlUnxgYy4AGMcWLsfK
         PdNLsQydUcv+BKmhkNtzHGAfw1dFguqXR+KsO/hdGUzML6C0p+8ScXm8z9WgYOETuWdM
         oDkFySp6WKJRbzWW82NrqnG75glKLKsvxkVjOkV52s5EB/O5Q25MXxmyWRBpZdBRPQ10
         plNu8ptRYfEJGnyB8l76R8+9SvpXObRhpsuJGaxQkQnlUjqtV1il8IRw6vtxGWK4AvZO
         TPaA==
X-Gm-Message-State: AOAM532OhbRyXrR0El3b/AQHAlDZFytop2SJWCZzDM5YuNO+lqe8SC89
        4EHyDOrxEz4LuW1vO9MEO9A=
X-Google-Smtp-Source: ABdhPJzGH6aFky/BcP4EsxiG2NISHHzisLOpSgA1WLSUZmC8Spq6xttOYv7Ularabh36qAmG5jLxXw==
X-Received: by 2002:a19:9d3:: with SMTP id 202mr5640760lfj.388.1610725160638;
        Fri, 15 Jan 2021 07:39:20 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id j2sm931567lfe.134.2021.01.15.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:39:20 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] dt-bindings: mtd: add binding from BCM4908 partitions
Date:   Fri, 15 Jan 2021 16:39:00 +0100
Message-Id: <20210115153901.31052-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115153901.31052-1-zajec5@gmail.com>
References: <20210115153901.31052-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses fixed partitions layout but function of some partitions may
vary. Some devices use multiple firmware partitions and those should be
marked to let system discover their purpose.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../partitions/brcm,bcm4908-partitions.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
new file mode 100644
index 000000000000..4090b61a3da7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/brcm,bcm4908-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4908 partitioning
+
+description: |
+  Broadcom BCM4908 CFE bootloader supports two firmware partitions. One is used
+  for regular booting, the other is treated as fallback.
+
+  This binding allows defining all fixed partitions and marking those containing
+  firmware. System can use that information e.g. for booting or flashing
+  purposes.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: brcm,bcm4908-partitions
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+patternProperties:
+  "@[0-9a-f]+$":
+    allOf:
+      - $ref: "partition.yaml#"
+      - properties:
+          compatible:
+            const: brcm,bcm4908-firmware
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "brcm,bcm4908-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "cferom";
+            reg = <0x0 0x100000>;
+        };
+
+        partition@100000 {
+            compatible = "brcm,bcm4908-firmware";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@1000000 {
+            compatible = "brcm,bcm4908-firmware";
+            reg = <0x1000000 0xf00000>;
+        };
+
+        partition@1f00000 {
+            label = "calibration";
+            reg = <0x1f00000 0x100000>;
+        };
+    };
-- 
2.26.2

