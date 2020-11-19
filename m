Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1407B2B9750
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgKSQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:02:52 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:29306 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgKSQCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605801771; x=1637337771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PgE2IHY/QaUILgqSVOhOMGRBawy2BD5ojuvrGKpF5Ng=;
  b=Kx0BXkLUwuBoTqkt2fRrglaDhZb46yinIBNatjNtsaTqqFDoJEDPPYTT
   WgoWt+MUa0t5TNZR9kI18PduZGoBoUs43ukPOkwMGbdDiwJ9ljU0eVKtP
   nI0vYyHXNLnhibbueU/42yBLAW881uwn96aEVmDvYWGbs9QaohgYArl2E
   2AjgMujr4IHdknooQ2V1d8OKMUVBfbBleZTYlMBDj6ub3orzqztXHq6Yg
   /RbH7AD1eDyrLFemdDUdcUkyBcIQMgLp6kOOq0DcbC5NwIjdw27kRR+lL
   YkTiBz4fe8M7UK8mke2aEi5YJDxycIm5yA3CHhV/4cneFFW1LNfbMGlCj
   g==;
IronPort-SDR: 52RACXbzldvtXd+iz18ySCmbLXCcW1N5Nh8MJTPAB5uFpUqLDM3IcJiKgjnOoQ75soXwwjOAT+
 6TSW8R+41Ke2Fyj/klBl6Piz+fk9H539MEJK6SBY3/5VPKbw44VJadrON1b2fC2+ZvJMszZANf
 +miYtSQr4cnjemcztgrPzJcwYHKVT7hsdlZcl+1ZbE/i5OnQQVBWYkGCr2FNqWer15fMayaMOr
 385/gzYBGPM2YbrjrTHd3jAyByU1hiPpcwaizPeP/2G+Zi2ZKFXRuwyWI46VL0RezV6yi/MQS8
 lpA=
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="99112012"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 09:02:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 09:02:42 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 19 Nov 2020 09:02:42 -0700
Date:   Thu, 19 Nov 2020 17:02:42 +0100
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: Add sparx5-serdes bindings
Message-ID: <20201119160242.nyifff7ckwkxkf76@mchp-dev-shegelun>
References: <20201110144910.558164-1-steen.hegelund@microchip.com>
 <20201110144910.558164-2-steen.hegelund@microchip.com>
 <20201119055807.GZ50232@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20201119055807.GZ50232@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2020 11:28, Vinod Koul wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On 10-11-20, 15:49, Steen Hegelund wrote:
>> Document the Sparx5 ethernet serdes phy driver bindings.
>
>Rob ..?
>
>Also pls cc devicetree@vger.kernel.org
>
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
>> ---
>>  .../bindings/phy/microchip,sparx5-serdes.yaml | 283 ++++++++++++++++++
>>  1 file changed, 283 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>> new file mode 100644
>> index 000000000000..a3a5b68f0a43
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>> @@ -0,0 +1,283 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/microchip,sparx5-serdes.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip Sparx5 Serdes controller
>> +
>> +maintainers:
>> +  - Steen Hegelund <steen.hegelund@microchip.com>
>> +
>> +description: |
>> +  The Sparx5 SERDES interfaces share the same basic functionality, but
>> +  support different operating modes and line rates.
>> +
>> +  The following list lists the SERDES features:
>> +
>> +  * RX Adaptive Decision Feedback Equalizer (DFE)
>> +  * Programmable continuous time linear equalizer (CTLE)
>> +  * Rx variable gain control
>> +  * Rx built-in fault detector (loss-of-lock/loss-of-signal)
>> +  * Adjustable tx de-emphasis (FFE)
>> +  * Tx output amplitude control
>> +  * Supports rx eye monitor
>> +  * Multiple loopback modes
>> +  * Prbs generator and checker
>> +  * Polarity inversion control
>> +
>> +  SERDES6G:
>> +
>> +  The SERDES6G is a high-speed SERDES interface, which can operate at
>> +  the following data rates:
>> +
>> +  * 100 Mbps (100BASE-FX)
>> +  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
>> +  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
>> +  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
>> +
>> +  SERDES10G
>> +
>> +  The SERDES10G is a high-speed SERDES interface, which can operate at
>> +  the following data rates:
>> +
>> +  * 100 Mbps (100BASE-FX)
>> +  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
>> +  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
>> +  * 5 Gbps (QSGMII/USGMII)
>> +  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
>> +  * 10 Gbps (10G-USGMII)
>> +  * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
>> +
>> +  SERDES25G
>> +
>> +  The SERDES25G is a high-speed SERDES interface, which can operate at
>> +  the following data rates:
>> +
>> +  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
>> +  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
>> +  * 5 Gbps (QSGMII/USGMII)
>> +  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
>> +  * 10 Gbps (10G-USGMII)
>> +  * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
>> +  * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^serdes@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    const: microchip,sparx5-serdes.yaml
>> +
>> +  reg:
>> +    description: Address and length of the register set for the device
>> +
>> +  '#phy-cells':
>> +    const: 1
>> +    description: |
>> +      - The main serdes input port
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#phy-cells'
>
>reg-names missing here
>

I will add them.


>> +    };
>> +
>> +...
>> --
>> 2.29.2
>
>--
>~Vinod

BR
Steen

---------------------------------------
Steen Hegelund
steen.hegelund@microchip.com
