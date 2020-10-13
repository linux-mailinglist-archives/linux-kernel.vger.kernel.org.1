Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B928D17D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgJMPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:50:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41584 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgJMPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:50:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BDADD8030865;
        Tue, 13 Oct 2020 15:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WSgFyl4htUsp; Tue, 13 Oct 2020 18:50:21 +0300 (MSK)
Date:   Tue, 13 Oct 2020 18:50:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH 16/18] dt-bindings: usb: meson-g12a-usb: Validate
 DWC2/DWC3 sub-nodes
Message-ID: <20201013155020.l7uqti25kk3mhdmy@mobilestation>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-17-Sergey.Semin@baikalelectronics.ru>
 <20201013124203.GE3269269@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013124203.GE3269269@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 07:42:03AM -0500, Rob Herring wrote:
> On Sun, Oct 11, 2020 at 01:41:19AM +0300, Serge Semin wrote:
> > Amlogic G12A USB DT sub-nodes are supposed to be compatible with the
> > generic DWC USB2 and USB3 devices. Since now we've got DT schemas for
> > both of the later IP cores let's make sure that the Amlogic G12A USB
> > DT nodes are fully evaluated including the DWC sub-nodes.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> > index 88184d7e26cc..3e8ac0ff90de 100644
> > --- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> > +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> > @@ -78,7 +78,20 @@ properties:
> >  
> >  patternProperties:
> >    "^usb@[0-9a-f]+$":
> > -    type: object
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                const: snps,dwc2
> > +        then:
> > +          $ref: dwc2.yaml#
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              const: snps,dwc3
> > +        then:
> > +          $ref: snps,dwc3.yaml#
> 

> It should be enough to do just:
> 
> oneOf:
>   - $ref: dwc2.yaml#
>   - $ref: snps,dwc3.yaml#

Ah, good point! Thanks.

-Sergey

