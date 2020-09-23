Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210E2761D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIWURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:17:12 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32760C0613CE;
        Wed, 23 Sep 2020 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sAXLjSw4bXvt4ULvSVuGX8PiMcU6/29nSp6I5KqoHZU=; b=KsPy9WIQN6Lbf++6pjd3iDlBIp
        ZQhDgiL7FDmPb2YgAX8hNTVS+AOOIba/AkFuYwGzDoeAKSh0lMwn2Xfv6CuklL9j+24DQqMfLv5VF
        VpKCgIpVoopMVwuZM5PSIM5AkLSMA0MkA+y6qKyWH8eIPJmka2cs3h4ifWgn4CwyySz4=;
Received: from p200300ccff08ce001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:ce00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kLBCJ-0007kd-MU; Wed, 23 Sep 2020 22:17:04 +0200
Date:   Wed, 23 Sep 2020 22:17:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH v2] dt-bindings: mfd: Convert rn5t618 to json-schema
Message-ID: <20200923221702.0ce93780@aktux>
In-Reply-To: <20200923014041.GA3669674@bogus>
References: <20200916061757.32144-1-andreas@kemnade.info>
        <20200923014041.GA3669674@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 19:40:41 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 16, 2020 at 08:17:57AM +0200, Andreas Kemnade wrote:
> > Convert the RN5T618 binding to DT schema format. Also
> > clearly state which regulators are available.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > - drop irq description
> > 
> > Due to its .txt-format history BSD license was not added.
> >  .../bindings/mfd/ricoh,rn5t618.yaml           | 111 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
> >  2 files changed, 111 insertions(+), 52 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > new file mode 100644
> > index 000000000000..d70e85a09c84
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > @@ -0,0 +1,111 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ricoh,rn5t618.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ricoh RN5T567/RN5T618/RC5T619 PMIC
> > +
> > +maintainers:
> > +  - Andreas Kemnade <andreas@kemnade.info>
> > +
> > +description: |
> > +  Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
> > +  integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
> > +  GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
> > +  The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
> > +  fuel gauge, and an ADC.
> > +  The RC5T619 additionnally includes USB charger detection and an RTC.
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ricoh,rn5t567
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$":
> > +              $ref: ../regulator/regulator.yaml
> > +          additionalProperties: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ricoh,rn5t618
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$":
> > +              $ref: ../regulator/regulator.yaml
> > +          additionalProperties: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ricoh,rc5t619
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
> > +              $ref: ../regulator/regulator.yaml
> > +          additionalProperties: false
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ricoh,rn5t567
> > +      - ricoh,rn5t618
> > +      - ricoh,rc5t619
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  system-power-controller:
> > +    type: boolean
> > +    description: |
> > +      See Documentation/devicetree/bindings/power/power-controller.txt
> > +
> > +  regulators:
> > +    type: object  
> 
> Add here:
> 
> $ref: ../regulator/regulator.yaml
> 
> And then the occurrances up above can be just 'true'.
> 
That feels wrong. I would think that gets applied to things directly
below regulator node and not to the individual regulator subnodes. To
check that I did:

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index ec505dbbf87c..077cb473d5f4 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -188,6 +188,8 @@ patternProperties:
 
     additionalProperties: false
 
+additionalProperties: false
+


additionally to your requested change with this result:
andi@aktux:~/gta04/dt-chk$ DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml makearm dt_binding_check
  CHKDT   Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.yaml
  DTC     Documentation/devicetree/bindings/mfd/ricoh,rn5t618.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/mfd/ricoh,rn5t618.example.dt.yaml
/home/andi/gta04/dt-chk/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.example.dt.yaml: pmic@32: regulators: 'DCDC1', 'DCDC2' do not match any of the regexes: '.*-supply$', 'pinctrl-[0-9]+', 'regulator-state-(standby|mem|disk)'
	From schema: /home/andi/kernel/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml


> 
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      pmic@32 {
> > +        compatible = "ricoh,rn5t618";
> > +        reg = <0x32>;
> > +        interrupt-parent = <&gpio5>;
> > +        interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> > +        system-power-controller;
> > +
> > +        regulators {
> > +          DCDC1 {
> > +            regulator-min-microvolt = <1050000>;
> > +            regulator-max-microvolt = <1050000>;
> > +          };
> > +
> > +          DCDC2 {
> > +            regulator-min-microvolt = <1175000>;
> > +            regulator-max-microvolt = <1175000>;
> > +          };
> > +        };
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
> > deleted file mode 100644
> > index 16778ea00dbc..000000000000
> > --- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
> > +++ /dev/null
> > @@ -1,52 +0,0 @@
> > -* Ricoh RN5T567/RN5T618 PMIC
> > -
> > -Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
> > -integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
> > -GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
> > -The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
> > -fuel gauge, and an ADC.
> > -The RC5T619 additionnally includes USB charger detection and an RTC.
> > -
> > -Required properties:
> > - - compatible: must be one of
> > -		"ricoh,rn5t567"
> > -		"ricoh,rn5t618"
> > -		"ricoh,rc5t619"
> > - - reg: the I2C slave address of the device
> > -
> > -Optional properties:
> > - - interrupts: interrupt mapping for IRQ
> > -   See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > - - system-power-controller:
> > -   See Documentation/devicetree/bindings/power/power-controller.txt
> > -
> > -Sub-nodes:
> > - - regulators: the node is required if the regulator functionality is
> > -   needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, DCDC4
> > -   (RN5T567/RC5T619), LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO8,
> > -   LDO9, LDO10, LDORTC1 and LDORTC2.
> > -   LDO7-10 are specific to RC5T619.
> > -   The common bindings for each individual regulator can be found in:
> > -   Documentation/devicetree/bindings/regulator/regulator.txt
> > -
> > -Example:
> > -
> > -	pmic@32 {
> > -		compatible = "ricoh,rn5t618";
> > -		reg = <0x32>;
> > -		interrupt-parent = <&gpio5>;
> > -		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> > -		system-power-controller;
> > -
> > -		regulators {
> > -			DCDC1 {
> > -				regulator-min-microvolt = <1050000>;
> > -				regulator-max-microvolt = <1050000>;
> > -			};
> > -
> > -			DCDC2 {
> > -				regulator-min-microvolt = <1175000>;
> > -				regulator-max-microvolt = <1175000>;
> > -			};
> > -		};
> > -	};
> > -- 
> > 2.20.1
> >   
> 

