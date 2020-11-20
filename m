Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212A62BAF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKTQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:09:05 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57877 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:09:04 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BACACC0008;
        Fri, 20 Nov 2020 16:09:01 +0000 (UTC)
Date:   Fri, 20 Nov 2020 17:09:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Device Tree List <devicetree@vger.kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: phy: Add sparx5-serdes bindings
Message-ID: <20201120160901.GA348979@piout.net>
References: <20201120150359.2041940-1-steen.hegelund@microchip.com>
 <20201120150359.2041940-2-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120150359.2041940-2-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/11/2020 16:03:56+0100, Steen Hegelund wrote:
> Document the Sparx5 ethernet serdes phy driver bindings.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  .../bindings/phy/microchip,sparx5-serdes.yaml | 296 ++++++++++++++++++
>  1 file changed, 296 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> new file mode 100644
> index 000000000000..0bfb752e7686
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> @@ -0,0 +1,296 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/microchip,sparx5-serdes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Sparx5 Serdes controller
> +
> +maintainers:
> +  - Steen Hegelund <steen.hegelund@microchip.com>
> +
> +description: |
> +  The Sparx5 SERDES interfaces share the same basic functionality, but
> +  support different operating modes and line rates.
> +
> +  The following list lists the SERDES features:
> +
> +  * RX Adaptive Decision Feedback Equalizer (DFE)
> +  * Programmable continuous time linear equalizer (CTLE)
> +  * Rx variable gain control
> +  * Rx built-in fault detector (loss-of-lock/loss-of-signal)
> +  * Adjustable tx de-emphasis (FFE)
> +  * Tx output amplitude control
> +  * Supports rx eye monitor
> +  * Multiple loopback modes
> +  * Prbs generator and checker
> +  * Polarity inversion control
> +
> +  SERDES6G:
> +
> +  The SERDES6G is a high-speed SERDES interface, which can operate at
> +  the following data rates:
> +
> +  * 100 Mbps (100BASE-FX)
> +  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
> +  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
> +  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
> +
> +  SERDES10G
> +
> +  The SERDES10G is a high-speed SERDES interface, which can operate at
> +  the following data rates:
> +
> +  * 100 Mbps (100BASE-FX)
> +  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
> +  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
> +  * 5 Gbps (QSGMII/USGMII)
> +  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
> +  * 10 Gbps (10G-USGMII)
> +  * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
> +
> +  SERDES25G
> +
> +  The SERDES25G is a high-speed SERDES interface, which can operate at
> +  the following data rates:
> +
> +  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
> +  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
> +  * 5 Gbps (QSGMII/USGMII)
> +  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
> +  * 10 Gbps (10G-USGMII)
> +  * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
> +  * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
> +
> +properties:
> +  $nodename:
> +    pattern: "^serdes@[0-9a-f]+$"
> +
> +  compatible:
> +    const: microchip,sparx5-serdes.yaml

This has a spurious .yaml suffix ;)

> +
> +  reg:
> +    description: Address and length of the register set for the device

You don't actually have to describe this property a sit comes from the
generic schema. But maybe you could set maxItems

> +
> +  reg-names:
> +    description: |
> +      Names for each of the address spaces defined in
> +      the 'reg' property. Expects the names in the same order as the
> +      corresponding memory region in the that property.
> +

Same comment, even better, I tink you could list the expected names in
an enum or a const list

> +  '#phy-cells':
> +    const: 1
> +    description: |
> +      - The main serdes input port
> +
> +  clocks:
> +    description:
> +      A list containing the phandle to the core clock of the Sparx5 device.

You can drop the description and simply have maxItems: 1


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
