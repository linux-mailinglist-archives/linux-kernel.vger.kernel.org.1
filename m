Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD828A34D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgJJXIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 19:08:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57900 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgJJXH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 19:07:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8B5CB80023F6;
        Sat, 10 Oct 2020 22:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9LvnvvbOwoSk; Sun, 11 Oct 2020 01:41:36 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: [PATCH 16/18] dt-bindings: usb: meson-g12a-usb: Validate DWC2/DWC3 sub-nodes
Date:   Sun, 11 Oct 2020 01:41:19 +0300
Message-ID: <20201010224121.12672-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A USB DT sub-nodes are supposed to be compatible with the
generic DWC USB2 and USB3 devices. Since now we've got DT schemas for
both of the later IP cores let's make sure that the Amlogic G12A USB
DT nodes are fully evaluated including the DWC sub-nodes.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index 88184d7e26cc..3e8ac0ff90de 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -78,7 +78,20 @@ properties:
 
 patternProperties:
   "^usb@[0-9a-f]+$":
-    type: object
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: snps,dwc2
+        then:
+          $ref: dwc2.yaml#
+      - if:
+          properties:
+            compatible:
+              const: snps,dwc3
+        then:
+          $ref: snps,dwc3.yaml#
 
 additionalProperties: false
 
-- 
2.27.0

