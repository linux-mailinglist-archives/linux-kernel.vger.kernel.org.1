Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C101F2C0139
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgKWILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 03:11:36 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:6884 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKWILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606119095; x=1637655095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIHFe3eMlr8hGngDvyobczYEKIBuVjw0uBpL6ZOgHxQ=;
  b=PZBhaLtIcpgdeUYRE0SowuduBR0/wcXtnBbcvt8jWG4flGIOTv8p8Nf1
   R4qt9u+7IKUj3E1ALVklHnxnRSYXFacVIyZgtTgP2AJ8VczLvWgIHl1Pa
   80VbJZG3xekNK5nFWhEMJ6nv7yVlMSP2Pl5dms/IGmF25Vj6q83sBlukD
   mteEbafKtBUK5bEyzYXbzUxmjauxe6XGt251gU51ZJVW2xtY5AEg+6N54
   i0yPhrOFeselcgi6VziwLtQfknjJWwsVsomAr18LnPHqQ+SmSAbisKtol
   G0zm+LkLe+QGecWdlzbbgKeyZAYrpUu4OXRzUkR0ZixhUIc3Ue0tIi5gn
   Q==;
IronPort-SDR: GphTcWOltQRN4KeJPyTfTbC/BMfYPJQE7W3Mp8A6V7IrDwYIOCUVVO8TsF/MQLE08g5vlsrxrr
 ZPTlPJoeWzu2/De1D/JBqs66B+PPMqKKQli+7G7lMc+hqV5Z+hUQnkMEt77AA7SsrxxPxid2EC
 Vez9OcU9ZqF/jGYuF1mBOaYtm7+fp7kwTmM2pa1XsT+ZgGInmPBp8JAiHPDZqfkTF+rRGbV6gI
 3H8MnY0HVxgmGGui2iZ3mKN/Zz1MrORMW8nmoHNIKdYJTn18+eRJ1bCXYrpKRhvYWuUnwB8A/W
 3k8=
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="94550758"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2020 01:11:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 01:11:34 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 23 Nov 2020 01:11:34 -0700
Date:   Mon, 23 Nov 2020 09:11:33 +0100
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Device Tree List <devicetree@vger.kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: phy: Add sparx5-serdes bindings
Message-ID: <20201123081133.hy5rkpjzpri6sojt@mchp-dev-shegelun>
References: <20201120150359.2041940-1-steen.hegelund@microchip.com>
 <20201120150359.2041940-2-steen.hegelund@microchip.com>
 <20201120160901.GA348979@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20201120160901.GA348979@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2020 17:09, Alexandre Belloni wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>Hi,
>
>On 20/11/2020 16:03:56+0100, Steen Hegelund wrote:
>> Document the Sparx5 ethernet serdes phy driver bindings.
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
>> ---
>>  .../bindings/phy/microchip,sparx5-serdes.yaml | 296 ++++++++++++++++++
>>  1 file changed, 296 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>> new file mode 100644
>> index 000000000000..0bfb752e7686
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>> @@ -0,0 +1,296 @@
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
>
>This has a spurious .yaml suffix ;)

I will remove that.
>
>> +
>> +  reg:
>> +    description: Address and length of the register set for the device
>
>You don't actually have to describe this property a sit comes from the
>generic schema. But maybe you could set maxItems

OK, I will remove the description.
Wouldn't minItems be better here, since there might be more targets in the
future, to support more modes?

>
>> +
>> +  reg-names:
>> +    description: |
>> +      Names for each of the address spaces defined in
>> +      the 'reg' property. Expects the names in the same order as the
>> +      corresponding memory region in the that property.
>> +
>
>Same comment, even better, I tink you could list the expected names in
>an enum or a const list

OK, it is a long list, but then it will be automatically checked.
>
>> +  '#phy-cells':
>> +    const: 1
>> +    description: |
>> +      - The main serdes input port
>> +
>> +  clocks:
>> +    description:
>> +      A list containing the phandle to the core clock of the Sparx5 device.
>
>You can drop the description and simply have maxItems: 1

OK
>
>
>--
>Alexandre Belloni, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin.com

BR
Steen

---------------------------------------
Steen Hegelund
steen.hegelund@microchip.com
