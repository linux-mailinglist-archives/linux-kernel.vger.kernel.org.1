Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA63528CFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgJMOA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:00:58 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40980 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgJMOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:00:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 685658030719;
        Tue, 13 Oct 2020 14:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lv4tIgF3X7hf; Tue, 13 Oct 2020 17:00:47 +0300 (MSK)
Date:   Tue, 13 Oct 2020 17:00:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 01/18] dt-bindings: usb: usb-hcd: Convert generic USB
 properties to DT schema
Message-ID: <20201013140045.aznrmrop3z3ujdss@mobilestation>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-2-Sergey.Semin@baikalelectronics.ru>
 <20201013121441.GA3269269@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013121441.GA3269269@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 07:14:41AM -0500, Rob Herring wrote:
> On Sun, Oct 11, 2020 at 01:41:04AM +0300, Serge Semin wrote:
> > The generic USB HCD properties have been described in the legacy bindings
> > text file: Documentation/devicetree/bindings/usb/generic.txt . Let's
> > convert it' content into the USB HCD DT schema properties so all USB DT
> > nodes would be validated to have them properly utilized.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../devicetree/bindings/usb/generic.txt       | 57 -------------
> >  .../devicetree/bindings/usb/usb-hcd.yaml      | 84 +++++++++++++++++++
> >  2 files changed, 84 insertions(+), 57 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/usb/generic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> > deleted file mode 100644
> > index ba472e7aefc9..000000000000
> > --- a/Documentation/devicetree/bindings/usb/generic.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -Generic USB Properties
> > -
> > -Optional properties:
> > - - maximum-speed: tells USB controllers we want to work up to a certain
> > -			speed. Valid arguments are "super-speed-plus",
> > -			"super-speed", "high-speed", "full-speed" and
> > -			"low-speed". In case this isn't passed via DT, USB
> > -			controllers should default to their maximum HW
> > -			capability.
> > - - dr_mode: tells Dual-Role USB controllers that we want to work on a
> > -			particular mode. Valid arguments are "host",
> > -			"peripheral" and "otg". In case this attribute isn't
> > -			passed via DT, USB DRD controllers should default to
> > -			OTG.
> > - - phy_type: tells USB controllers that we want to configure the core to support
> > -			a UTMI+ PHY with an 8- or 16-bit interface if UTMI+ is
> > -			selected. Valid arguments are "utmi" and "utmi_wide".
> > -			In case this isn't passed via DT, USB controllers should
> > -			default to HW capability.
> > - - otg-rev: tells usb driver the release number of the OTG and EH supplement
> > -			with which the device and its descriptors are compliant,
> > -			in binary-coded decimal (i.e. 2.0 is 0200H). This
> > -			property is used if any real OTG features(HNP/SRP/ADP)
> > -			is enabled, if ADP is required, otg-rev should be
> > -			0x0200 or above.
> > - - companion: phandle of a companion
> > - - hnp-disable: tells OTG controllers we want to disable OTG HNP, normally HNP
> > -			is the basic function of real OTG except you want it
> > -			to be a srp-capable only B device.
> > - - srp-disable: tells OTG controllers we want to disable OTG SRP, SRP is
> > -			optional for OTG device.
> > - - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
> > -			optional for OTG device.
> > - - usb-role-switch: boolean, indicates that the device is capable of assigning
> > -			the USB data role (USB host or USB device) for a given
> > -			USB connector, such as Type-C, Type-B(micro).
> > -			see connector/usb-connector.yaml.
> > - - role-switch-default-mode: indicating if usb-role-switch is enabled, the
> > -			device default operation mode of controller while usb
> > -			role is USB_ROLE_NONE. Valid arguments are "host" and
> > -			"peripheral". Defaults to "peripheral" if not
> > -			specified.
> > -
> > -
> > -This is an attribute to a USB controller such as:
> > -
> > -dwc3@4a030000 {
> > -	compatible = "synopsys,dwc3";
> > -	reg = <0x4a030000 0xcfff>;
> > -	interrupts = <0 92 4>
> > -	usb-phy = <&usb2_phy>, <&usb3,phy>;
> > -	maximum-speed = "super-speed";
> > -	dr_mode = "otg";
> > -	phy_type = "utmi_wide";
> > -	otg-rev = <0x0200>;
> > -	adp-disable;
> > -};
> > diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > index 7263b7f2b510..815de24127db 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > @@ -22,9 +22,93 @@ properties:
> >      description:
> >        Name specifier for the USB PHY
> >  
> > +  maximum-speed:
> > +   description: |
> 

> Drop the '|' if there's no formatting to preserve.

Thanks for noticing this. I should have refreshed my YAML multi-line
knowledge https://yaml-multiline.info/ .) I'll fix it in all the patches of
the series.

> 
> > +     Tells USB controllers we want to work up to a certain speed. In case this
> > +     isn't passed via DT, USB controllers should default to their maximum HW
> > +     capability.
> > +   $ref: /schemas/types.yaml#/definitions/string
> > +   enum: ["low-speed", "full-speed", "high-speed", "super-speed",
> > +          "super-speed-plus"]
> 

> One per line and drop the quotes.

Ok.

-Sergey

> 
> > +
> > +  dr_mode:
> > +    description: |
> > +      Tells Dual-Role USB controllers that we want to work on a particular
> > +      mode. In case this attribute isn't passed via DT, USB DRD controllers
> > +      should default to OTG.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: ["host", "peripheral", "otg"]
> > +
> > +  phy_type:
> > +    description: |
> > +      Tells USB controllers that we want to configure the core to support a
> > +      UTMI+ PHY with an 8- or 16-bit interface if UTMI+ is selected. In case
> > +      this isn't passed via DT, USB controllers should default to HW
> > +      capability.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: ["utmi", "utmi_wide"]
> > +
> > +  otg-rev:
> > +    description: |
> > +      Tells usb driver the release number of the OTG and EH supplement with
> > +      which the device and its descriptors are compliant, in binary-coded
> > +      decimal (i.e. 2.0 is 0200H). This property is used if any real OTG
> > +      features (HNP/SRP/ADP) is enabled. If ADP is required, otg-rev should be
> > +      0x0200 or above.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  companion:
> > +    description: Phandle of a companion device
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  hnp-disable:
> > +    description: |
> > +      Tells OTG controllers we want to disable OTG HNP. Normally HNP is the
> > +      basic function of real OTG except you want it to be a srp-capable only B
> > +      device.
> > +    type: boolean
> > +
> > +  srp-disable:
> > +    description: |
> > +      Tells OTG controllers we want to disable OTG SRP. SRP is optional for OTG
> > +      device.
> > +    type: boolean
> > +
> > +  adp-disable:
> > +    description: |
> > +      Tells OTG controllers we want to disable OTG ADP. ADP is optional for OTG
> > +      device.
> > +    type: boolean
> > +
> > +  usb-role-switch:
> > +    description: |
> > +      Indicates that the device is capable of assigning the USB data role
> > +      (USB host or USB device) for a given USB connector, such as Type-C,
> > +      Type-B(micro). See connector/usb-connector.yaml.
> > +
> > +  role-switch-default-mode:
> > +    description: |
> > +      Indicates if usb-role-switch is enabled, the device default operation
> > +      mode of controller while usb role is USB_ROLE_NONE.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: ["host", "peripheral"]
> > +    default: "peripheral"
> > +
> >  examples:
> >    - |
> >      usb {
> >          phys = <&usb2_phy1>, <&usb3_phy1>;
> >          phy-names = "usb";
> >      };
> > +  - |
> > +    usb@4a030000 {
> > +        compatible = "snps,dwc3";
> > +        reg = <0x4a030000 0xcfff>;
> > +        interrupts = <0 92 4>;
> > +        usb-phy = <&usb2_phy>, <&usb3_phy>;
> > +        maximum-speed = "super-speed";
> > +        dr_mode = "otg";
> > +        phy_type = "utmi_wide";
> > +        otg-rev = <0x0200>;
> > +        adp-disable;
> > +    };
> > -- 
> > 2.27.0
> > 
