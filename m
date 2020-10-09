Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D0289194
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbgJITIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJITIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:08:51 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8638CC0613D2;
        Fri,  9 Oct 2020 12:08:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y14so7926307pgf.12;
        Fri, 09 Oct 2020 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZMccl/fSc9Ch0A1iiQRgWO5Br2L8QOy57a18abEHXk=;
        b=iiikoazAc/u+rJgyAMFx1ZzeTIYrdnmm+A9b0iRz2qK7EW6uwB2yvn8AyfuFBGU487
         LQO0zIyp1zIBlGlG+6NliPZvMYVjA4aDlPQdz4JHpdHtD39y9SE8Kokuh7yJS6nKVL4h
         S5ypTpPqH8C9JhOTPVb6tAuYRLtzCIDWFmZB1vpgTK9tI7BHasrldONSd3vUfyjm1YtR
         XPIJExZXYZJFaTjjexM0UiXPlkiO73dgwaDeThP7dHT3IIq/dK6FZlK7jnqwWZ0547Wh
         6im9ia5vRnHPyRz+klHTGfqpWLd+M+QpHSSp6OnBIx8sAacGgdxxJRVWli5xkSSldJIV
         I5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZMccl/fSc9Ch0A1iiQRgWO5Br2L8QOy57a18abEHXk=;
        b=dfrFjCIRbK8/d9Mc7TCWBWSJP99Oq32aB0LuVCPgd5EZzBpN6jZJzF2EjXoYernn1n
         x0g/4c6yZtZkIBrzPF0Dvn4WoD1Z1GPFLUSor9DohWqVzSBEqCsatttApXT9WrGmy+QF
         WAq8188rDLsbDh+eu3taBs/3+665Fx6N3bDdn1WBD8Mee2jiJ+Q79Z6Fz33uER98VTLE
         MCh2NsX4uFb6t7WprCwZs0WTM19ORt0tFnYjlyJuX74YRR+IfJOCBUGhvK59KqaTV/oR
         WYKYVWpzZn7kLh12+MRdoBOoJo1RL1A7OBqDjeq9AwNbSAZXW3SPA2VgdjljNdN1WuJ6
         5uNA==
X-Gm-Message-State: AOAM530a8RBjCvFKm9O4eMfBmgl0fVwDSXVzTZfGMeMcheM3yOl9Xchn
        vCxPoA5DxaPSG/+YJmCSlqThPn7j1zc=
X-Google-Smtp-Source: ABdhPJzB9ySBJEB0vlB1pTiKMs2oUy6kzpC1nvyR/7MYCgt8iU9SelrbyWSXmxTtZHgZH1yO6RuXYg==
X-Received: by 2002:a17:90b:3716:: with SMTP id mg22mr6388508pjb.83.1602270530852;
        Fri, 09 Oct 2020 12:08:50 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o20sm12281043pgh.63.2020.10.09.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:08:50 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: Add support for Broadcom USB pin map driver
Date:   Fri,  9 Oct 2020 15:08:38 -0400
Message-Id: <20201009190839.12612-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009190839.12612-1-alcooperx@gmail.com>
References: <20201009190839.12612-1-alcooperx@gmail.com>
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

