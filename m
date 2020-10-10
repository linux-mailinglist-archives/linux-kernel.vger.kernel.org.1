Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489228A435
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbgJJXON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 19:14:13 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57874 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbgJJWyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:54:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id F1A198030867;
        Sat, 10 Oct 2020 22:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5yd1RSH1bPYm; Sun, 11 Oct 2020 01:41:28 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/18] dt-bindings: usb: usb-hcd: Add "tpl-support" property
Date:   Sun, 11 Oct 2020 01:41:08 +0300
Message-ID: <20201010224121.12672-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host controller device might be designed to work for the particular
products or applications. In that case it' DT node is supposed to be
equipped with the tpl-support property.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 Documentation/devicetree/bindings/usb/usb-hcd.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
index 1eddcbf0a9d8..c898166a8c6c 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
@@ -97,6 +97,12 @@ properties:
     enum: ["host", "peripheral"]
     default: "peripheral"
 
+  tpl-support:
+    description: |
+      Indicates if the Targeted Peripheral List is supported for given
+      targeted hosts (non-PC hosts).
+    type: boolean
+
 examples:
   - |
     usb {
-- 
2.27.0

