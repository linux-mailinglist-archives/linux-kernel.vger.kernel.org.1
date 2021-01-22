Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525F93009D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbhAVRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbhAVP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:58:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E71522D50;
        Fri, 22 Jan 2021 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611331057;
        bh=7aC3z0tMQrxgT9LAygql9lROQDRoV7LOZG1LZRBoNv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBZCJub9fhmT4Bxmxve7r9iuBtKr1faLkzfb5/WfML2Nn9M7ByzRn4giDmCX0WxHT
         xkOA6FV7Ewu0y/DEMGgZ/FnPTaJaHn39IwHGym/Ya397LidT1AO4hmYnnaFlOBhFLa
         PMKvVwYViw9a7b516b95VF3GkbBey2AE9mIa6bG8oT3ZT+a6aw3KgsKcoFpY7tGuZQ
         SfvpOuK2vCdMZi01BTXFFRaT1UefTnTyl+RW+/g3YdHqHO4kPl9Z31uldK0Wq4NaD9
         NgKuUgpo4AVERDXVbPPL89uTjsV/QTPGjnd3j05OlBW2ZX2jsU2Yek0kkcD3jXEkjX
         xHsPnnHCd38iQ==
Date:   Fri, 22 Jan 2021 16:57:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yu Chen <chenyu56@huawei.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210122165725.1dcdbb5b@coco.lan>
In-Reply-To: <CAL_JsqKyMy010vOjSdbDPXs13ygvfHpK5pb_1TN0pLM9pwL97w@mail.gmail.com>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
        <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
        <20210115014731.GA4077569@robh.at.kernel.org>
        <20210119112653.46f26ce3@coco.lan>
        <CAL_JsqKyMy010vOjSdbDPXs13ygvfHpK5pb_1TN0pLM9pwL97w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 22 Jan 2021 08:51:37 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Jan 19, 2021 at 4:26 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Thu, 14 Jan 2021 19:47:31 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >  
> > > On Thu, Jan 14, 2021 at 06:35:44PM +0100, Mauro Carvalho Chehab wrote:  
> > > > The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> > > > for mainstream. Mode it from staging into the main driver's
> > > > phy/ directory.
> > > >
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
> > > >  MAINTAINERS                                   |   9 +-
> > > >  drivers/phy/hisilicon/Kconfig                 |  10 +
> > > >  drivers/phy/hisilicon/Makefile                |   1 +
> > > >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 ++++++++++++++++++
> > > >  drivers/staging/hikey9xx/Kconfig              |  11 -
> > > >  drivers/staging/hikey9xx/Makefile             |   2 -
> > > >  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
> > > >  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
> > > >  9 files changed, 759 insertions(+), 754 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > > >  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
> > > >  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
> > > >  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > > > new file mode 100644
> > > > index 000000000000..125a5d6546ae
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > > > @@ -0,0 +1,72 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/hisilicon,hi3670-usb3.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Hisilicon Kirin970 USB PHY
> > > > +
> > > > +maintainers:
> > > > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > >
> > > Blank line.  
> >
> > Ok.
> >  
> > >  
> > > > +description: |+
> > > > +  Bindings for USB3 PHY on HiSilicon Kirin 970.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: hisilicon,hi3670-usb-phy
> > > > +
> > > > +  "#phy-cells":
> > > > +    const: 0
> > > > +
> > > > +  hisilicon,pericrg-syscon:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > > +    description: phandle of syscon used to control iso refclk.
> > > > +
> > > > +  hisilicon,pctrl-syscon:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > > +    description: phandle of syscon used to control usb tcxo.
> > > > +
> > > > +  hisilicon,sctrl-syscon:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > > +    description: phandle of syscon used to control phy deep sleep.
> > > > +
> > > > +  hisilicon,eye-diagram-param:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: Eye diagram for phy.
> > > > +
> > > > +  hisilicon,tx-vboost-lvl:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: TX level vboost for phy.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - hisilicon,pericrg-syscon
> > > > +  - hisilicon,pctrl-syscon
> > > > +  - hisilicon,sctrl-syscon
> > > > +  - hisilicon,eye-diagram-param
> > > > +  - hisilicon,tx-vboost-lvl
> > > > +  - "#phy-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    bus {
> > > > +      #address-cells = <2>;
> > > > +      #size-cells = <2>;
> > > > +
> > > > +      usb3_otg_bc: usb3_otg_bc@ff200000 {
> > > > +        compatible = "syscon", "simple-mfd";
> > > > +        reg = <0x0 0xff200000 0x0 0x1000>;
> > > > +
> > > > +        usb_phy {  
> > >
> > > Is there a contiguous register region for this sub-block? If so, add
> > > 'reg' even though Linux doesn't need it currently.  
> >
> > No. The driver uses 4 syscon regions in order to access the needed
> > registers:  
> 
> I meant just for the parent device node. I assume these are the 'main'
> registers? If not, then maybe it should be a child of one of the other
> syscons.
> 
> 'reg' would just be for documentation ATM. However, if the subblock
> was reused on another chip, but at a different offset then reg would
> become useful. You could handle that with a fixed offset when 'reg' is
> missing, but adding it later would be too late.

Hmm... You meaning something like this:

	examples:
	  - |
	    bus {
	      #address-cells = <2>;
	      #size-cells = <2>;
	      reg = <0>;

right?

If so, I don't see any problem on doing that, but that fictional
"bus" was added there just to be able to set #address-cells and
#size-cells, in order to avoid warnings when checking the DT
validity, as recommended by a past review from your side.

The actual DT for USB is (from hi3670.dtsi):

/ {
	compatible = "hisilicon,hi3670";
	interrupt-parent = <&gic>;
	#address-cells = <2>;
	#size-cells = <2>;

	soc {
		compatible = "simple-bus";
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		crg_ctrl: crg_ctrl@fff35000 {
			compatible = "hisilicon,hi3670-crgctrl", "syscon";
			reg = <0x0 0xfff35000 0x0 0x1000>;
			#clock-cells = <1>;
		};

		...

		usb3_otg_bc: usb3_otg_bc@ff200000 {
			compatible = "syscon", "simple-mfd";
			reg = <0x0 0xff200000 0x0 0x1000>;

			usb_phy: usbphy {
				compatible = "hisilicon,hi3670-usb-phy";
				#phy-cells = <0>;
				hisilicon,pericrg-syscon = <&crg_ctrl>;
				hisilicon,pctrl-syscon = <&pctrl>;
				hisilicon,sctrl-syscon = <&sctrl>;
				hisilicon,eye-diagram-param = <0xFDFEE4>;
				hisilicon,tx-vboost-lvl = <0x5>;

				phy-supply = <&ldo17>;
			};
		};
		...
	};
};


Thanks,
Mauro
