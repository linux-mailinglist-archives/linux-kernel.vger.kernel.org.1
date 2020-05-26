Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8569E19EA5E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDEK2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 06:28:35 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39346 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDEK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:28:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 143448001469;
        Sun,  5 Apr 2020 10:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yvBCia97BFRy; Sun,  5 Apr 2020 13:28:30 +0300 (MSK)
Date:   Sun, 5 Apr 2020 13:28:51 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: clk: Add Baikal-T1 AXI-bus CCU bindings
Message-ID: <20200405102851.36gmlma522gx6j5o@ubsrv2.baikal.int>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130055.7F70E8030793@mail.baikalelectronics.ru>
 <20200312205011.GA10607@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312205011.GA10607@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:50:11PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 04:00:45PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > After being gained by the CCU PLLs the signals must be transformed to
> > be suitable for the clock-consumers. This is done by a set of dividers
> > embedded into the CCU. A first block of dividers is used to create
> > reference clocks for AXI-bus of high-speed peripheral IP-cores of the
> > chip. So the AXI-bus CCU dts-node is an ordinary clock-provider with
> > standard set of properties supported. But in addition to that each
> > AXI-bus clock divider provide a way to reset the corresponding clock
> > domain. This makes the AXI-bus CCU dts-node to be also a reset-provider.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  .../bindings/clock/be,bt1-ccu-axi.yaml        | 151 ++++++++++++++++++
> >  include/dt-bindings/clock/bt1-ccu.h           |  13 ++
> >  include/dt-bindings/reset/bt1-ccu.h           |  23 +++
> >  3 files changed, 187 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
> >  create mode 100644 include/dt-bindings/reset/bt1-ccu.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
> > new file mode 100644
> > index 000000000000..6b1eefdead27
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
> > @@ -0,0 +1,151 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings:
> 
> (GPL-2.0-only OR BSD-2-Clause)

Ok.

> 
> > +#
> > +# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
> > +#
> > +# Baikal-T1 AXI-bus Clocks Control Unit Device Tree Bindings.
> 
> As Stephen said, drop this. You can keep the copyright, just make it 
> line 2.

Ok.

> 
> > +#
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/be,bt1-ccu-axi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Baikal-T1 AXI-bus Clock Control Unit
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description: |
> > +  Clocks Control Unit is the core of Baikal-T1 SoC responsible for the chip
> > +  subsystems clocking and resetting. The CCU is connected with an external
> > +  fixed rate oscillator, which signal is transformed into clocks of various
> > +  frequencies and then propagated to either individual IP-blocks or to groups
> > +  of blocks (clock domains). The transformation is done by means of an embedded
> > +  into CCU PLLs and gateable/non-gateable dividers. Each clock domain can be
> > +  also individually reset by using the domain clocks divider configuration
> > +  registers. Baikal-T1 CCU is logically divided into the next components:
> > +  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
> > +     in general can provide any frequency supported by the CCU PLLs).
> > +  2) PLLs clocks generators (PLLs).
> > +  3) AXI-bus clock dividers (AXI) - described in this bindings file.
> > +  4) System devices reference clock dividers (SYS).
> > +  which are connected with each other as shown on the next figure:
> > +          +---------------+
> > +          | Baikal-T1 CCU |
> > +          |   +----+------|- MIPS P5600 cores
> > +          | +-|PLLs|------|- DDR controller
> > +          | | +----+      |
> > +  +----+  | |  |  |       |
> > +  |XTAL|--|-+  |  | +---+-|
> > +  +----+  | |  |  +-|AXI|-|- AXI-bus
> > +          | |  |    +---+-|
> > +          | |  |          |
> > +          | |  +----+---+-|- APB-bus
> > +          | +-------|SYS|-|- Low-speed Devices
> > +          |         +---+-|- High-speed Devices
> > +          +---------------+
> > +  Each sub-block is represented as a separate dts-node and has an individual
> > +  driver to be bound with.
> > +
> > +  In order to create signals of wide range frequencies the external oscillator
> > +  output is primarily connected to a set of CCU PLLs. Some of PLLs CLKOUT are
> > +  then passed over CCU dividers to create signals required for the target clock
> > +  domain (like AXI-bus consumers). The dividers have the following structure:
> > +          +--------------+
> > +  CLKIN --|->+----+ 1|\  |
> > +  SETCLK--|--|/DIV|->| | |
> > +  CLKDIV--|--|    |  | |-|->CLKLOUT
> > +  LOCK----|--+----+  | | |
> > +          |          |/  |
> > +          |           |  |
> > +  EN------|-----------+  |
> > +  RST-----|--------------|->RSTOUT
> > +          +--------------+
> > +  where CLKIN is the reference clock coming either from a CCU PLL, SETCLK - a
> > +  command to update the output clock in accordance with a set divider,
> > +  CLKDIV - clocks divider, LOCK - a signal of the output clock stabilization,
> > +  EN - enable/disable the divider block, RST/RSTOUT - reset clocks domain
> > +  signal. Depending on the consumer IP-core peculiarities the dividers may lack
> > +  of some functionality depicted on the figure above (like EN,
> > +  CLKDIV/LOCK/SETCLK). In this case the corresponding clock provider just
> > +  doesn't expose either switching functions, or the rate configuration, or
> > +  both of them.
> > +
> > +  The CCU AXI dts-node uses the common clock bindings [1] with no custom
> > +  properties. The list of exported clocks and reset signals can be found in
> > +  the files: 'dt-bindings/clock/bt1-ccu.h' and 'dt-bindings/reset/bt1-ccu.h'.
> > +
> > +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +allOf:
> > +  - $ref: /schemas/clock/clock.yaml#
> 
> Drop this, not needed (clock.yaml is applied to every node).

Ok.

> 
> > +
> > +properties:
> > +  compatible:
> > +    const: be,bt1-ccu-axi
> > +
> > +  reg:
> > +    description: AXI-bus CCU dividers sub-block base address.
> 
> Don't really need this.

Ok, but as I said multiple times in others patchsets reply messages,
most likely this property will be removed from the bindings in accordance
with an alternative design of the Baikal-T1 System Controller DT node.
See the next RFC for details: https://lkml.org/lkml/2020/3/22/393

> 
> > +    maxItems: 1
> > +
> > +  "#clock-cells":
> > +    description: |
> > +      Clocks are referenced by the node phandle and an unique identifier
> > +      from 'dt-bindings/clock/bt1-ccu.h'.
> > +    const: 1
> > +
> > +  "#reset-cells":
> > +    description: |
> > +      AXI-bus CCU sub-block provides a reset signal for each clock domain,
> > +      which unique identifiers are in 'dt-bindings/reset/bt1-ccu.h'.
> > +    const: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: CCU SATA PLL output clock.
> > +      - description: CCU PCIe PLL output clock.
> > +      - description: CCU Ethernet PLL output clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sata_clk
> > +      - const: pcie_clk
> > +      - const: eth_clk
> > +
> > +  clock-output-names: true
> > +
> > +  assigned-clocks: true
> > +
> > +  assigned-clock-rates: true
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
> > +  - clocks
> > +  - clock-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/bt1-ccu.h>
> > +
> > +    ccu_axi: ccu_axi@1F04D030 {
> 
> clock-controller@1f04d030

Ok.

> 
> > +      compatible = "be,bt1-ccu-axi";
> > +      reg = <0x1F04D030 0x030>;
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> > +
> > +      clocks = <&ccu_pll CCU_SATA_PLL>,
> > +               <&ccu_pll CCU_PCIE_PLL>,
> > +               <&ccu_pll CCU_ETH_PLL>;
> > +      clock-names = "sata_clk", "pcie_clk", "eth_clk";
> > +
> > +      clock-output-names = "axi_main_clk", "axi_ddr_clk",
> > +                           "axi_sata_clk", "axi_gmac0_clk",
> > +                           "axi_gmac1_clk", "axi_xgmac_clk",
> > +                           "axi_pcie_m_clk", "axi_pcie_s_clk",
> > +                           "axi_usb_clk", "axi_hwa_clk",
> > +                           "axi_sram_clk";
> > +    };
> > +...
> > diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/clock/bt1-ccu.h
> > index 86e63162ade0..ebe723c6e0a8 100644
> > --- a/include/dt-bindings/clock/bt1-ccu.h
> > +++ b/include/dt-bindings/clock/bt1-ccu.h
> > @@ -14,4 +14,17 @@
> >  #define CCU_PCIE_PLL			3
> >  #define CCU_ETH_PLL			4
> >  
> > +/* Baikal-T1 AXI-bus CCU Clocks indeces. */
> > +#define CCU_AXI_MAIN_CLK		0
> > +#define CCU_AXI_DDR_CLK			1
> > +#define CCU_AXI_SATA_CLK		2
> > +#define CCU_AXI_GMAC0_CLK		3
> > +#define CCU_AXI_GMAC1_CLK		4
> > +#define CCU_AXI_XGMAC_CLK		5
> > +#define CCU_AXI_PCIE_M_CLK		6
> > +#define CCU_AXI_PCIE_S_CLK		7
> > +#define CCU_AXI_USB_CLK			8
> > +#define CCU_AXI_HWA_CLK			9
> > +#define CCU_AXI_SRAM_CLK		10
> > +
> >  #endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
> > diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
> > new file mode 100644
> > index 000000000000..4de5b6bcd433
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/bt1-ccu.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> > + *
> > + * Baikal-T1 CCU reset indeces.
> > + */
> > +#ifndef __DT_BINDINGS_RESET_BT1_CCU_H
> > +#define __DT_BINDINGS_RESET_BT1_CCU_H
> > +
> > +/* Baikal-T1 AXI-bus CCU Reset indeces. */
> > +#define CCU_AXI_MAIN_RST		0
> > +#define CCU_AXI_DDR_RST			1
> > +#define CCU_AXI_SATA_RST		2
> > +#define CCU_AXI_GMAC0_RST		3
> > +#define CCU_AXI_GMAC1_RST		4
> > +#define CCU_AXI_XGMAC_RST		5
> > +#define CCU_AXI_PCIE_M_RST		6
> > +#define CCU_AXI_PCIE_S_RST		7
> > +#define CCU_AXI_USB_RST			8
> > +#define CCU_AXI_HWA_RST			9
> > +#define CCU_AXI_SRAM_RST		10
> > +
> > +#endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
> > -- 
> > 2.25.1
> > 
