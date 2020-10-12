Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB028BC82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390744AbgJLPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390230AbgJLPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:41:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9F120575;
        Mon, 12 Oct 2020 15:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602517271;
        bh=4zjbxbiZnTcWfsU0KfqSsCdB4lRjPlB+YmVxhvhPiZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJBagWKjX7tJj7n4ywqPFBnd86pkp4ggzcfQCBjYW2yHHYsXaA+Tm6GCio0To5+g8
         zFlm2o6pEI/EjzJrGwT7tI/V529Xn8t8/1R3pW5+WOvnraD68gGF8K7QB/HwdSXD/S
         ho3Y771Y3HUr+R/d5siOkIMP54u+89ki4nKdSe04=
Date:   Mon, 12 Oct 2020 17:41:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
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
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] dt-bindings: usb: usb-hcd: Add "wireless"
 maximum-speed property value
Message-ID: <20201012154150.GA1565332@kroah.com>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-3-Sergey.Semin@baikalelectronics.ru>
 <20201011144236.GA271079@kroah.com>
 <20201011175333.2v46x6kiugqnvlpk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011175333.2v46x6kiugqnvlpk@mobilestation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 08:53:33PM +0300, Serge Semin wrote:
> On Sun, Oct 11, 2020 at 04:42:36PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Oct 11, 2020 at 01:41:05AM +0300, Serge Semin wrote:
> > > It appears that the "maximum-speed" property can also accept the
> > > "wireless" value. Add it to the enumeration of the possible property
> > > values then.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > ---
> > >  Documentation/devicetree/bindings/usb/usb-hcd.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > > index 815de24127db..e1a82a2b3295 100644
> > > --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> > > @@ -28,7 +28,7 @@ properties:
> > >       isn't passed via DT, USB controllers should default to their maximum HW
> > >       capability.
> > >     $ref: /schemas/types.yaml#/definitions/string
> > > -   enum: ["low-speed", "full-speed", "high-speed", "super-speed",
> > > +   enum: ["low-speed", "full-speed", "high-speed", "wireless", "super-speed",
> > >            "super-speed-plus"]
> > 
> 
> > Are you sure?  wireless usb has been removed from the kernel, where do
> > you see a user of this?  If it's still in there, we need to just drop
> > it.
> 
> My decision on suggesting this patch has been based purely on the speed types
> the USB core API supports and what usb_get_maximum_speed() can return.
> USB_SPEED_WIRELESS type is one of the possible return values. As I can see
> aside the rest of the USB speeds the wireless speed is also defined
> in the kernel USB subsystem. Moreover it is used in some kernel drivers.
> (See the USB_SPEED_WIRELESS enumeration constant usage.)
> Are you sure that the wireless speed support has been really removed?

All of the drivers that implement and support this should have been
removed.  Code in the USB core is probably not removed, but patches are
gladly welcome.

Please do not add new wireless support as it is not going to happen,
because there are no wireless devices in the world.

thanks,

greg k-h
