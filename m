Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA94269696
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgINU3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgINU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:28:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0317C06178B;
        Mon, 14 Sep 2020 13:28:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so1000956wrs.5;
        Mon, 14 Sep 2020 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3NW5tBzNgSyxbqDXPS+AIHRYV3jrMEfIQIxh8yJnmE=;
        b=DkGaJ69fEFToaU6BaXoWj9CMA92LLAJ4tie/E6SItGshG8d/JM/KguQDTS4ADmva1l
         AD2x7LmLvclO9rxuQAZoLld+DwbpIgcLItA8tYU4fvE62j0Bku4Mj71q/0Q0zLNqNA4Z
         9DW9CPPBmSKL3gi/a64t573WRQDbr7hZ7Fjn//pLIApLF84nk4z3oR0C7dzNaXwSzURn
         IoSrZ5J59vnl96qBTvXTJoAsRkRQ9w8i9RxBpOvlb0yrJhHN4yU2FOwiGptvlUYp+Wd3
         ZXItKGmOzfC/398MKET8lB1rZnWAUI+vhpHwxGU/ARtZSZolrhs6qpIUrT+xsiMx+tSX
         ZEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3NW5tBzNgSyxbqDXPS+AIHRYV3jrMEfIQIxh8yJnmE=;
        b=V79pEb3jT8IAqhb3QZfmV5M9ocZRl3vsBulBhkZWELyJk/NggtW8i75y33YoBhYneZ
         J7IwV+l0/5Bqfm9330WgUAxAopHwn0Y5Z1r1DzN2cOXmU86PKj/zNoR8BuodV13+YTBw
         xRCT71VfzrbGOesAZesKY6ixPZ+xx9+TEMPmOYxAb8wYT268JioGmLS1nzq8iRj8QjkV
         E2ADLy2fG8mBE/FGvVGUVU5ItjloOqLPANt93d4fO1KfuRdnyj1YVroxAI7Dk+y3b5ov
         WWTcKEwsM/hiqra79XqvL//l7bAOOV6FCeSl0+S8Gt8mLxMaF15daunLjfUAU0+/M2fc
         RxkA==
X-Gm-Message-State: AOAM531W2IA0oreprLa8+qjbwKzHiJEmsth+YPkJr6M1LwFqo+PQ93+L
        iudvok090I/6W6bmQoRQ8Xk=
X-Google-Smtp-Source: ABdhPJyzQtdHpbq7AZHioH/BW68K9/t4T+ZG15PmwPWjn0vX3/NhQL1Oexgh/mcIyB71EjO7KQPQOA==
X-Received: by 2002:adf:a106:: with SMTP id o6mr17780548wro.1.1600115293358;
        Mon, 14 Sep 2020 13:28:13 -0700 (PDT)
Received: from localhost.localdomain (oi48z9.static.otenet.gr. [79.129.51.141])
        by smtp.gmail.com with ESMTPSA id 92sm24201125wra.19.2020.09.14.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:28:12 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v7 1/3] dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
Date:   Mon, 14 Sep 2020 23:27:17 +0300
Message-Id: <c2046b747574ea56c1cf05c05b402c7f01d5e4fc.1600114378.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
References: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
and S900 SoCs and provides support for handling up to 3 external
interrupt lines.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v7:
 - None

Changes in v6:
 - Got rid of the 'actions,owl-sirq' compatible, per Robs's feedback
 - Replaced 'actions,ext-interrupts' with 'interrupts', as agreed with
   Rob and Marc

Changes in v5:
 - Updated controller description statements both in the commit message
   and the binding doc

 .../actions,owl-sirq.yaml                     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
new file mode 100644
index 000000000000..5da333c644c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs SIRQ interrupt controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
+  and S900) and provides support for handling up to 3 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sirq
+      - actions,s700-sirq
+      - actions,s900-sirq
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number, between 0 and 2, while the second
+      cell is the trigger type as defined in interrupt.txt in this directory.
+
+  'interrupts':
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines.
+      They shall be specified sequentially from output 0 to 2.
+    minItems: 3
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - 'interrupts'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sirq: interrupt-controller@b01b0200 {
+      compatible = "actions,s500-sirq";
+      reg = <0xb01b0200 0x4>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
+                   <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
+                   <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
+    };
+
+...
-- 
2.28.0

