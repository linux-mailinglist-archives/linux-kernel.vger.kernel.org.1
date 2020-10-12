Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B628BAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbgJLOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:22:13 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:35204 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbgJLOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:22:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 289818030867;
        Mon, 12 Oct 2020 14:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bHN2z32UxKxQ; Mon, 12 Oct 2020 17:22:03 +0300 (MSK)
Date:   Mon, 12 Oct 2020 17:22:01 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Neil Armstrong <narmstrong@baylibre.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
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
Subject: Re: [PATCH 15/18] dt-bindings: usb: meson-g12a-usb: Discard FL-adj
 property
Message-ID: <20201012142201.7fr2n5xwvei23yog@mobilestation>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-16-Sergey.Semin@baikalelectronics.ru>
 <329129ac-ff44-4928-bca4-805297a8c456@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <329129ac-ff44-4928-bca4-805297a8c456@baylibre.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:54:25AM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 11/10/2020 00:41, Serge Semin wrote:
> > An empty snps,quirk-frame-length-adjustment won't cause any change
> > performed by the driver. Moreover the DT schema validation will fail,
> > since it expects the property being assigned with some value. So just
> > discard the property declaration then from the example.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Note the same problem is in the DT source file
> > arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi .
> > ---
> >  .../devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml     | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> > index 5b04a7dfa018..88184d7e26cc 100644
> > --- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> > +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> > @@ -209,6 +209,5 @@ examples:
> >                interrupts = <30>;
> >                dr_mode = "host";
> >                snps,dis_u2_susphy_quirk;
> > -              snps,quirk-frame-length-adjustment;
> >            };
> >      };
> > 
> 

> Thanks for reporting this, actually the fladj must be 0x20 on this hw,
> but we do set this on the PHY side, so we can let the dwc3 side 0 here.

I can convert this patch to initializing the "snps,quirk-frame-length-adjustment"
property with 0x20 value instead. Since most likely I'll have to send a v2/v3/etc
of this patchset, that modification won't be too much work to do. What do you think?

Anyway please note, that I've fixed the improper property usage in the DT schema
example only. "snps,quirk-frame-length-adjustment" defined as boolean still
persists in the DTS file: arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi .
So if you ever try to validate that dts file with "make dtbs_check" scenario, it
will fail.

-Sergey

> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Neil
> 
