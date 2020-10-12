Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1928C1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbgJLUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbgJLUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:00:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95850C0613D1;
        Mon, 12 Oct 2020 13:00:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so14555589pfp.13;
        Mon, 12 Oct 2020 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZMccl/fSc9Ch0A1iiQRgWO5Br2L8QOy57a18abEHXk=;
        b=qyTLhIW0Map0DCfGuRs4bETqgPA1ukwaCuvRfW5Ti1KvZK4EwY0CIzb6kxljvlZyvE
         AFOPmyx9Iscxf+sh8SKUWwlmbdkHujkv/f1o7PTKDLqjSR6/ETDY2Y0hj0OmSuZCXxM2
         PLOXH6cVvuN7EzXnl+6dCN4p2V75dPC+h46JXoCkD6vQ7HeHs9c5LK8kX8I2/qSCEmKo
         vc8+tPPYB8dqZEUnI1geKxy6guBHJJf41y44PlU7a/pJYFMX9rB2ckPFbfhwZ5ioqszg
         BVN/i7anf69yUS6QA0gRpUZ0Hp4KbRTOM/vCw0vW17qBrIcAB9NKR5jEZ6U1lz7EaBsu
         hY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZMccl/fSc9Ch0A1iiQRgWO5Br2L8QOy57a18abEHXk=;
        b=m1JVFbFS1JZA4HcKptA/mQrO7zX37wAtTJTTUYR37D3pPbHJTdtGWkiV2f6zd6rB/N
         wp68QBIRlmB+3XKsTY1BPIGtycEdo/43YmLEKxSJpdsCZusy4KJC9pCy+f/okAuoMmRf
         U+w1GF8g/9o5pqMuwpns6mk/5GGoaLWlFjGuQWbEps8DSSqG/9r8sJBZLR0x8Midb6No
         HupJgIKSIDOzO00QeYUdeoYhU//0wSCO8lr5E9ZgQAvHeJ1e7ufFrOWmApzizuSrjRke
         8XYkxccEU0/bOw2MMcrSwyAsHhmNtfkwjIY5KrYBBHZ29RvVQ1lWwrvWw9dXgft8j5D9
         9JOA==
X-Gm-Message-State: AOAM532snIeDIDBmRpLV7lMzI2ZWUthWAhdkZse4PQRvVTwqcjZuebJe
        M9ZnRl9weDNbr7XStx0aV8fIW22uXw0=
X-Google-Smtp-Source: ABdhPJx/5WHy1S4sRhK4n9EJ832Bt19hQhlIxvtPVQv2tamP/45LxKgoloK4Ijwu75E2oTNDM65gdA==
X-Received: by 2002:a17:90a:ff06:: with SMTP id ce6mr21152224pjb.38.1602532826844;
        Mon, 12 Oct 2020 13:00:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y124sm13556909pfy.28.2020.10.12.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:00:26 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: Add support for Broadcom USB pin map driver
Date:   Mon, 12 Oct 2020 16:00:06 -0400
Message-Id: <20201012200007.8862-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201012200007.8862-1-alcooperx@gmail.com>
References: <20201012200007.8862-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the Broadcom USB pin map driver. This driver allows
some USB input and output signals to be mapped to any GPIO instead
of the normal dedicated pins to/from the XHCI controller.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/usb/brcm,usb-pinmap.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
new file mode 100644
index 000000000000..ffa148b9eaa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/brcm,usb-pinmap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom USB pin map Controller Device Tree Bindings
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - const: brcm,usb-pinmap
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt for signals mirrored to out-gpios.
+
+  in-gpios:
+    description: Array of one or two GPIO pins used for input signals.
+
+  brcm,in-functions:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Array of input signal names, one per gpio in in-gpios.
+
+  brcm,in-masks:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Array of enable and mask pairs, one per gpio in-gpios.
+
+  out-gpios:
+    description: Array of one GPIO pin used for output signals.
+
+  brcm,out-functions:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Array of output signal names, one per gpio in out-gpios.
+
+  brcm,out-masks:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Array of enable, value, changed and clear masks, one
+      per gpio in out-gpios.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+dependencies:
+  in-gpios: [ interrupts ]
+
+examples:
+  - |
+    usb_pinmap: usb-pinmap@22000d0 {
+        compatible = "brcm,usb-pinmap";
+        reg = <0x22000d0 0x4>;
+        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
+        brcm,in-functions = "VBUS", "PWRFLT";
+        brcm,in-masks = <0x8000 0x40000 0x10000 0x80000>;
+        out-gpios = <&gpio 20 0>;
+        brcm,out-functions = "PWRON";
+        brcm,out-masks = <0x20000 0x800000 0x400000 0x200000>;
+        interrupts = <0x0 0xb2 0x4>;
+    };
+
+...
-- 
2.17.1

