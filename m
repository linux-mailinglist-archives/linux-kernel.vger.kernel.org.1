Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3D82E01C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLUVFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:05:08 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50758 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:05:08 -0500
Received: by mail-wm1-f49.google.com with SMTP id 190so207100wmz.0;
        Mon, 21 Dec 2020 13:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dsnNjmwcuVkeuRHLqROWQ9lGvdQSW7my2nTIVReeyR8=;
        b=BCYEwJMJwKQYlivjtAy1TkPfHoMv1Ro+eBvhnbuB3ShmvIWKtiDKe+3u34eVJ4SYCl
         DZsZ08FeE5Yi6gRcX1AmfE89HfqR0SKmPoZ9hyuUILKTiZw5n33NBjwltqY5bYlt1aaj
         CxQGYsX+kej1bWVZ+4ZWzdb2ZZhzOYj2wEAR7832orTbAzeNtN5FSuTX/RZMOwz6Vb+Q
         zm/VCsApKqD758JV+yQJrK83wdg7O5BxafrmLdBs38BOo3BfbPsjz7n7txUDngNd/a2i
         ybkWnNlW5q2b8qcAF4sINCiddKHiTNuF4t9JKXckt0hRlAzq3/+VZiDlMGC3wIj90voe
         l/Lg==
X-Gm-Message-State: AOAM533EP1EKtEiyLLCEGXh0sf18dUovoX6IKjIUy1qhrsJ8u4KS9zdp
        tT7p68YIj+IZDWtAh8VmD+VJyMG+5GRqGg==
X-Google-Smtp-Source: ABdhPJysKzeZfeg6+bS9PqIUdpBgFlcY8AWgEKpWO6Qq6XoLnemp1NYIvayrZ5SEqPNlu7iR5ueWyg==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr18497648wme.3.1608584666260;
        Mon, 21 Dec 2020 13:04:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b127sm22859713wmc.45.2020.12.21.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:04:25 -0800 (PST)
Date:   Mon, 21 Dec 2020 22:04:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 16/18] arm64: dts: hi3660: Harmonize DWC USB3 DT nodes
 name
Message-ID: <20201221210423.GA2504@kozik-lap>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
 <20201111091552.15593-17-Sergey.Semin@baikalelectronics.ru>
 <CALAqxLWGujgR7p8Vb5S_RimRVYxwm5XF-c4NkKgMH-43wEBaWg@mail.gmail.com>
 <20201219110603.GA8061@kozik-lap>
 <CALAqxLWAFs+8VKKuMMg2gyfGXgQSjaWv9H5ayuohEK9m6OS3TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALAqxLWAFs+8VKKuMMg2gyfGXgQSjaWv9H5ayuohEK9m6OS3TA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:24:11PM -0800, John Stultz wrote:
> On Sat, Dec 19, 2020 at 3:06 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Fri, Dec 18, 2020 at 09:11:42PM -0800, John Stultz wrote:
> > > On Wed, Nov 11, 2020 at 1:22 AM Serge Semin
> > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > In accordance with the DWC USB3 bindings the corresponding node
> > > > name is suppose to comply with the Generic USB HCD DT schema, which
> > > > requires the USB nodes to have the name acceptable by the regexp:
> > > > "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> > > > named.
> > > >
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > > index d25aac5e0bf8..aea3800029b5 100644
> > > > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > > @@ -1166,7 +1166,7 @@ usb_phy: usb-phy {
> > > >                         };
> > > >                 };
> > > >
> > > > -               dwc3: dwc3@ff100000 {
> > > > +               dwc3: usb@ff100000 {
> > > >                         compatible = "snps,dwc3";
> > > >                         reg = <0x0 0xff100000 0x0 0x100000>;
> > >
> > >
> > > Oof. So this patch is breaking the usb gadget functionality on HiKey960 w/ AOSP.
> > >
> > > In order to choose the right controller for gadget mode with AOSP, one
> > > sets the "sys.usb.controller" property, which until now for HiKey960
> > > has been "ff100000.dwc3".
> > > After this patch, the controller isn't found and we would have to
> > > change userland to use "ff100000.usb", which would then break booting
> > > on older kernels (testing various LTS releases on AOSP is one of the
> > > key uses of the HiKey960).
> > >
> > > So while I understand the desire to unify the schema, as HiKey960
> > > really isn't likely to be used outside of AOSP, I wonder if reverting
> > > this one change is in the best interest of not breaking existing
> > > userland?
> >
> > The node names are not part of an ABI, are they? I expect only
> > compatibles and properties to be stable. If user-space looks for
> > something by name, it's a user-space's mistake.  Not mentioning that you
> > also look for specific address... Imagine remapping of addresses with
> > ranges (for whatever reason) - AOSP also would be broken? Addresses are
> > definitely not an ABI.
> 
> Though that is how it's exported through sysfs.

The ABI is the format of sysfs file for example in /sys/devices. However
the ABI is not the exact address or node name of each device.

> In AOSP it is then used to setup the configfs gadget by writing that
> value into /config/usb_gadget/g1/UDC.
> 
> Given there may be multiple controllers on a device, or even if its
> just one and the dummy hcd driver is enabled, I'm not sure how folks
> reference the "right" one without the node name?

I think it is the same type of problem as for all other subsystems, e.g.
mmc, hwmon/iio.  They usually solve it either with aliases or with
special property with the name/label.

> I understand the fuzziness with sysfs ABI, and I get that having
> consistent naming is important, but like the eth0 -> enp3s0 changes,
> it seems like this is going to break things.

One could argue whether interface name is or is not ABI. But please tell
me how the address of a device in one's representation (for example DT)
is a part of a stable interface?

> Greg? Is there some better way AOSP should be doing this?

If you need to find specific device, maybe go through the given bus and
check compatibles?

Best regards,
Krzysztof
