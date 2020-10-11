Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC60B28A893
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbgJKRxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 13:53:45 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:58984 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgJKRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 13:53:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C28F18030865;
        Sun, 11 Oct 2020 17:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gTghl0HaVN0J; Sun, 11 Oct 2020 20:53:41 +0300 (MSK)
Date:   Sun, 11 Oct 2020 20:53:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 02/18] dt-bindings: usb: usb-hcd: Add "wireless"
 maximum-speed property value
Message-ID: <20201011175333.2v46x6kiugqnvlpk@mobilestation>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-3-Sergey.Semin@baikalelectronics.ru>
 <20201011144236.GA271079@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201011144236.GA271079@kroah.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 04:42:36PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 11, 2020 at 01:41:05AM +0300, Serge Semin wrote:
> > It appears that the "maximum-speed" property can also accept the
> > "wireless" value. Add it to the enumeration of the possible property
> > values then.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  Documentation/devicetree/bindings/usb/usb-hcd.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > index 815de24127db..e1a82a2b3295 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > @@ -28,7 +28,7 @@ properties:
> >       isn't passed via DT, USB controllers should default to their maximum HW
> >       capability.
> >     $ref: /schemas/types.yaml#/definitions/string
> > -   enum: ["low-speed", "full-speed", "high-speed", "super-speed",
> > +   enum: ["low-speed", "full-speed", "high-speed", "wireless", "super-speed",
> >            "super-speed-plus"]
> 

> Are you sure?  wireless usb has been removed from the kernel, where do
> you see a user of this?  If it's still in there, we need to just drop
> it.

My decision on suggesting this patch has been based purely on the speed types
the USB core API supports and what usb_get_maximum_speed() can return.
USB_SPEED_WIRELESS type is one of the possible return values. As I can see
aside the rest of the USB speeds the wireless speed is also defined
in the kernel USB subsystem. Moreover it is used in some kernel drivers.
(See the USB_SPEED_WIRELESS enumeration constant usage.)
Are you sure that the wireless speed support has been really removed?

-Sergey

> 
> thanks,
> 
> greg k-h
