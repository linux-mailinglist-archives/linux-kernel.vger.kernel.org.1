Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF42FB754
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbhASKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387430AbhASK1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:27:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DD42312B;
        Tue, 19 Jan 2021 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611052019;
        bh=Ar1/SklmNFyzFiDjsKFwakgEW96TKWupJSp0Bvsmmrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bsZ8Tz3WzvfuDSeraGRRIKOeIxd8F0dD5h3NBVe6NLv6nAXKyKRI6N4ZDXTk0OcOR
         5SXBFK3z3rJFFybGYpXxLTNf5C2EjFikiD8i++3c2/zGAvcKGtrMaRrzUbqKhujrM8
         J10VpZuuHP4j19SRX/jhhbMqsswfsI34ZKo6B1eYXx1ho/XO3VY8lWF9N7AoCH2rQ3
         /mYUOzN+KMU40TscEcH9kfun7U1gGtHUzbm0rJCL/Lkq44zw5neqHluuvmScGhWOI4
         JfOHmSf49BH4Gx1Rd6dAbVz4LRFGpd2mSomCIL+iKPf4ylRiIRU0wM0cMzLd3CdCd6
         XScBmD8g/wm8Q==
Date:   Tue, 19 Jan 2021 11:26:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210119112653.46f26ce3@coco.lan>
In-Reply-To: <20210115014731.GA4077569@robh.at.kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
        <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
        <20210115014731.GA4077569@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 14 Jan 2021 19:47:31 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Thu, Jan 14, 2021 at 06:35:44PM +0100, Mauro Carvalho Chehab wrote:
> > The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> > for mainstream. Mode it from staging into the main driver's
> > phy/ directory.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
> >  MAINTAINERS                                   |   9 +-
> >  drivers/phy/hisilicon/Kconfig                 |  10 +
> >  drivers/phy/hisilicon/Makefile                |   1 +
> >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 ++++++++++++++++++
> >  drivers/staging/hikey9xx/Kconfig              |  11 -
> >  drivers/staging/hikey9xx/Makefile             |   2 -
> >  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
> >  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
> >  9 files changed, 759 insertions(+), 754 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> >  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
> >  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
> >  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > new file mode 100644
> > index 000000000000..125a5d6546ae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/hisilicon,hi3670-usb3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Hisilicon Kirin970 USB PHY
> > +
> > +maintainers:
> > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Blank line.

Ok.

> 
> > +description: |+
> > +  Bindings for USB3 PHY on HiSilicon Kirin 970.
> > +
> > +properties:
> > +  compatible:
> > +    const: hisilicon,hi3670-usb-phy
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  hisilicon,pericrg-syscon:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > +    description: phandle of syscon used to control iso refclk.
> > +
> > +  hisilicon,pctrl-syscon:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > +    description: phandle of syscon used to control usb tcxo.
> > +
> > +  hisilicon,sctrl-syscon:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > +    description: phandle of syscon used to control phy deep sleep.
> > +
> > +  hisilicon,eye-diagram-param:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Eye diagram for phy.
> > +
> > +  hisilicon,tx-vboost-lvl:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: TX level vboost for phy.
> > +
> > +required:
> > +  - compatible
> > +  - hisilicon,pericrg-syscon
> > +  - hisilicon,pctrl-syscon
> > +  - hisilicon,sctrl-syscon
> > +  - hisilicon,eye-diagram-param
> > +  - hisilicon,tx-vboost-lvl
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    bus {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      usb3_otg_bc: usb3_otg_bc@ff200000 {
> > +        compatible = "syscon", "simple-mfd";
> > +        reg = <0x0 0xff200000 0x0 0x1000>;
> > +
> > +        usb_phy {  
> 
> Is there a contiguous register region for this sub-block? If so, add 
> 'reg' even though Linux doesn't need it currently.

No. The driver uses 4 syscon regions in order to access the needed
registers:

	priv->peri_crg = syscon_regmap_lookup_by_phandle(dev->of_node,
							 "hisilicon,pericrg-syscon");
	if (IS_ERR(priv->peri_crg)) {
		dev_err(dev, "no hisilicon,pericrg-syscon\n");
		return PTR_ERR(priv->peri_crg);
	}

	priv->pctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
						      "hisilicon,pctrl-syscon");
	if (IS_ERR(priv->pctrl)) {
		dev_err(dev, "no hisilicon,pctrl-syscon\n");
		return PTR_ERR(priv->pctrl);
	}

	priv->sctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
						      "hisilicon,sctrl-syscon");
	if (IS_ERR(priv->sctrl)) {
		dev_err(dev, "no hisilicon,sctrl-syscon\n");
		return PTR_ERR(priv->sctrl);
	}

	/* node of hi3670 phy is a sub-node of usb3_otg_bc */
	priv->usb31misc = syscon_node_to_regmap(dev->parent->of_node);
	if (IS_ERR(priv->usb31misc)) {
		dev_err(dev, "no hisilicon,usb3-otg-bc-syscon\n");
		return PTR_ERR(priv->usb31misc);
	}

So, I don't see what an additional reg would help here.

> > +          compatible = "hisilicon,hi3670-usb-phy";
> > +          #phy-cells = <0>;
> > +          hisilicon,pericrg-syscon = <&crg_ctrl>;
> > +          hisilicon,pctrl-syscon = <&pctrl>;
> > +          hisilicon,sctrl-syscon = <&sctrl>;
> > +          hisilicon,eye-diagram-param = <0xfdfee4>;
> > +          hisilicon,tx-vboost-lvl = <0x5>;
> > +        };
> > +      };
> > +    };  

Thanks,
Mauro
