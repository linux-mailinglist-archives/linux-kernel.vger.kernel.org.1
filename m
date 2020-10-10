Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9028A2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbgJJW7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:50 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57404 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733007AbgJJWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:42:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CE73B8030808;
        Sat, 10 Oct 2020 22:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xogfVj1ipFTm; Sun, 11 Oct 2020 01:41:26 +0300 (MSK)
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
Subject: [PATCH 00/18] dt-bindings: usb: Add generic USB HCD, xHCI, DWC USB3 DT schema
Date:   Sun, 11 Oct 2020 01:41:03 +0300
Message-ID: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've performed some work on the Generic USB HCD, xHCI and DWC USB3 DT
bindings in the framework of the Baikal-T1 SoC support integration into
the kernel. This patchset is a result of that work.

First of all we moved the generic USB properties from the legacy text
bindings into the USB HCD DT schema. So now the generic USB HCD-compatible
DT nodes are validated taking into account the optional properties like:
maximum-speed, dr_mode, otg-rev, usb-role-switch, etc. We've fixed these
properties a bit so they would correspond to what functionality kernel
currently supports.

Secondly we converted generic USB xHCI text bindings file into the DT
schema. It had to be split up into two bindings: DT schema with generic
xHCI properties and a generic xHCI device DT schema. The later will be
used to validate the pure xHCI-based nodes, while the former can be
utilized by some vendor-specific versions of xHCI.

Thirdly, what was primarily intended to be done for Baikal-T1 SoC USB we
converted the legacy text-based DWC USB3 bindings to DT schema and altered
the result a bit so it would be more coherent with what actually
controller and its driver support. Since we've now got the DWC USB3 DT
schema, we made it used to validate the sub-nodes of the Qualcom, TI and
Amlogic DWC3 DT nodes.

Alas the new DWC USB3 DT schema doesn't support all the DT nodes defined
as compatible with "snps,dwc3". There are next problems we've discovered
while were working on this patchset:

1) There are many "snps,dwc3"-compatible DT nodes, which names are defined
as "^usb[0-9](@.*)", "^dwc3(@.*)" and even "^dwusb(@.*)". It contradicts
to what usb-hcd.yaml requires. Since it's included into the allOf property
of the DWC USB3 DT binding, some USB DT nodes declared for Freescale,
Qualcomm, HiSilicon, Exynos, Allwinner, Omap, Stih and APM will fail the
dtbs_check validation. This is the main problem and currently I don't
really know how to fix it better. Ideally we should convert all the
problematic DT nodes to have "usb@"-prefixed names. But it will be very
painful due to having a lot of such nodes defined. On the other hand we
could just fix the usb-hcd.yaml file either by detaching the generic
properties into a separate DT schema and allOf-ing it in the HCDs with
non-standard node-names instead of using usb-hcd.yaml there, or just add
the non-standard node-names into the usb-hcd.yaml file. What do you think
would be better?

2) amlogic/meson-g12-common.dtsi has got a USB controller node defined
with boolean "snps,quirk-frame-length-adjustment", which actually is
supposed to have u32 type.

3) freescale/imx8mq.dtsi defines a USB controller node with unknown
"usb3-resume-missing-cas" property.

4) marvell/armada-37xx.dtsi defines a USB controller with unknown
"marvell,usb-misc-reg" property.

5) socionext/uniphier-pxs3.dtsi, uniphier-pxs2.dtsi define a USB
controller with too many PHYs.

We haven't fixed the problems denoted above in this patchset for now.
So any help, suggestions on how they (especially #1) could be fixed,
following up fixup patches would be appropriate.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (18):
  dt-bindings: usb: usb-hcd: Convert generic USB properties to DT schema
  dt-bindings: usb: usb-hcd: Add "wireless" maximum-speed property value
  dt-bindings: usb: usb-hcd: Add "otg-rev" property restriction
  dt-bindings: usb: usb-hcd: Add "ulpi/serial/hsic" PHY types
  dt-bindings: usb: usb-hcd: Add "tpl-support" property
  dt-bindings: usb: usb-hcd: Add generic "usb-phy" property
  dt-bindings: usb: Convert xHCI bindings to DT schema
  dt-bindings: usb: xhci: Add Broadcom STB v2 compatible device
  dt-bindings: usb: renesas-xhci: Refer to the usb-xhci.yaml file
  dt-bindings: usb: Convert DWC USB3 bindings to DT schema
  dt-bindings: usb: dwc3: Add interrupt-names property support
  dt-bindings: usb: dwc3: Add synopsys,dwc3 compatible string
  dt-bindings: usb: dwc3: Add Tx De-emphasis restrictions
  dt-bindings: usb: dwc3: Add Frame Length Adj restrictions
  dt-bindings: usb: meson-g12a-usb: Discard FL-adj property
  dt-bindings: usb: meson-g12a-usb: Validate DWC2/DWC3 sub-nodes
  dt-bindings: usb: keystone-dwc3: Validate DWC3 sub-node
  dt-bindings: usb: qcom,dwc3: Validate DWC3 sub-node

 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      |  16 +-
 .../devicetree/bindings/usb/dwc3.txt          | 125 -------
 .../devicetree/bindings/usb/generic-xhci.yaml |  65 ++++
 .../devicetree/bindings/usb/generic.txt       |  57 ----
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |   9 +-
 .../bindings/usb/renesas,usb-xhci.yaml        |   4 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 315 ++++++++++++++++++
 .../bindings/usb/ti,keystone-dwc3.yaml        |   4 +-
 .../devicetree/bindings/usb/usb-hcd.yaml      | 100 ++++++
 .../devicetree/bindings/usb/usb-xhci.txt      |  41 ---
 .../devicetree/bindings/usb/usb-xhci.yaml     |  40 +++
 11 files changed, 540 insertions(+), 236 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/generic-xhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/generic.txt
 create mode 100644 Documentation/devicetree/bindings/usb/snps,dwc3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-xhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-xhci.yaml

-- 
2.27.0

