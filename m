Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACD2FC62D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbhATA4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbhATA4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:56:14 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B93C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 16:55:27 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id j17so6587275vso.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 16:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw49I/WjqXHtAn1nksIvlFE5Cbb/b93wT+2o+eq9Aao=;
        b=QXU92RzdHm8WhBLTML/i6tbQedBOpmYB9c55gZtQ/k/5V8xEnPhpQuATlxhBWvsHKr
         v+YOMpiO+AW1MbT5zIp8BjQt9+R9YN/XkLmzTDyt3BAK3iE0wHRd3PYM3FiDoPtKihPt
         boovePotfeu3UNTqW5THBj44uJ4qfBgGmlLkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw49I/WjqXHtAn1nksIvlFE5Cbb/b93wT+2o+eq9Aao=;
        b=dEHLC9i4RxDA5K6JL0g7imSd/hPg+h+wOun7/xR6CdwJztgBzEpYC1U+5uLttmbaD6
         w+KXcr7apqRroy2RD16fLKakiMB58Lc4T4Z54W5e9hEZGEit5WND9ufs3mQO1BSyZCVd
         pjOK6zJc/UJr6I/ctfxihetD1h/rvqRS+skVu+RZIyQ6z9f3Hakc4Qtb69OgcxZBX681
         0qNCKIslna4/b/OEInHBNIeCpj3wnJy2uVc9xZ7ne8ABhhEb4PS4wXfB2uav4n6RAjNR
         SjUH6Aeh10UvfD7FDsdaCh5XMxrpiiroHld0JR++5GXXmChh1uwPRnQUwM9shf6df7wo
         gmMQ==
X-Gm-Message-State: AOAM530y5vo6etWMrSdfyHsSg9jWyg7qoYHTsRNBtbZfHOrOZqS2DlQz
        EqV/ZoeM3nDUp2weTczQnI8mAfKkgwc69OZvrC6wCA==
X-Google-Smtp-Source: ABdhPJyGD9XHA9hSrZna7yVfHYBJ2SCRkroR+gd9m1y0xVyN/Eand4LjtS3RAVL7/xKPuBQ5ve/SsqTt781JmAnSxZs=
X-Received: by 2002:a05:6102:3205:: with SMTP id r5mr4689659vsf.36.1611104126639;
 Tue, 19 Jan 2021 16:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20210116052623.3196274-1-grundler@chromium.org>
 <20210116052623.3196274-3-grundler@chromium.org> <20210119134558.5072a1cc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210119134558.5072a1cc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 20 Jan 2021 00:55:15 +0000
Message-ID: <CANEJEGsd8c1RYnKXsWOhLFDOh89EXAUtLUPMrbWf+2+yin5kHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: usb: cdc_ncm: don't spew notifications
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 9:46 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 Jan 2021 21:26:23 -0800 Grant Grundler wrote:
> > RTL8156 sends notifications about every 32ms.
> > Only display/log notifications when something changes.
> >
> > This issue has been reported by others:
> >       https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1832472
> >       https://lkml.org/lkml/2020/8/27/1083
> >
> > ...
> > [785962.779840] usb 1-1: new high-speed USB device number 5 using xhci_hcd
> > [785962.929944] usb 1-1: New USB device found, idVendor=0bda, idProduct=8156, bcdDevice=30.00
> > [785962.929949] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> > [785962.929952] usb 1-1: Product: USB 10/100/1G/2.5G LAN
> > [785962.929954] usb 1-1: Manufacturer: Realtek
> > [785962.929956] usb 1-1: SerialNumber: 000000001
> > [785962.991755] usbcore: registered new interface driver cdc_ether
> > [785963.017068] cdc_ncm 1-1:2.0: MAC-Address: 00:24:27:88:08:15
> > [785963.017072] cdc_ncm 1-1:2.0: setting rx_max = 16384
> > [785963.017169] cdc_ncm 1-1:2.0: setting tx_max = 16384
> > [785963.017682] cdc_ncm 1-1:2.0 usb0: register 'cdc_ncm' at usb-0000:00:14.0-1, CDC NCM, 00:24:27:88:08:15
> > [785963.019211] usbcore: registered new interface driver cdc_ncm
> > [785963.023856] usbcore: registered new interface driver cdc_wdm
> > [785963.025461] usbcore: registered new interface driver cdc_mbim
> > [785963.038824] cdc_ncm 1-1:2.0 enx002427880815: renamed from usb0
> > [785963.089586] cdc_ncm 1-1:2.0 enx002427880815: network connection: disconnected
> > [785963.121673] cdc_ncm 1-1:2.0 enx002427880815: network connection: disconnected
> > [785963.153682] cdc_ncm 1-1:2.0 enx002427880815: network connection: disconnected
> > ...
> >
> > This is about 2KB per second and will overwrite all contents of a 1MB
> > dmesg buffer in under 10 minutes rendering them useless for debugging
> > many kernel problems.
> >
> > This is also an extra 180 MB/day in /var/logs (or 1GB per week) rendering
> > the majority of those logs useless too.
> >
> > When the link is up (expected state), spew amount is >2x higher:
> > ...
> > [786139.600992] cdc_ncm 2-1:2.0 enx002427880815: network connection: connected
> > [786139.632997] cdc_ncm 2-1:2.0 enx002427880815: 2500 mbit/s downlink 2500 mbit/s uplink
> > [786139.665097] cdc_ncm 2-1:2.0 enx002427880815: network connection: connected
> > [786139.697100] cdc_ncm 2-1:2.0 enx002427880815: 2500 mbit/s downlink 2500 mbit/s uplink
> > [786139.729094] cdc_ncm 2-1:2.0 enx002427880815: network connection: connected
> > [786139.761108] cdc_ncm 2-1:2.0 enx002427880815: 2500 mbit/s downlink 2500 mbit/s uplink
> > ...
> >
> > Chrome OS cannot support RTL8156 until this is fixed.
>
> > @@ -1867,7 +1876,8 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
> >                * USB_CDC_NOTIFY_NETWORK_CONNECTION notification shall be
> >                * sent by device after USB_CDC_NOTIFY_SPEED_CHANGE.
> >                */
> > -             usbnet_link_change(dev, !!event->wValue, 0);
> > +             if (netif_carrier_ok(dev->net) != !!event->wValue)
> > +                     usbnet_link_change(dev, !!event->wValue, 0);
> >               break;
> >
> >       case USB_CDC_NOTIFY_SPEED_CHANGE:
>
> Thanks for the patch, this looks like an improvement over:
>
> 59b4a8fa27f5 ("CDC-NCM: remove "connected" log message")
>
> right? Should we bring the "network connection: connected" message back?

Yes, we can revert Roland's patch. I didn't see that one.

> Do you want all of these patches to be applied to 5.11 and backported?

Yes to 5.11. Only the 3rd one really needs to be applied to stable kernels.

> Feels to me like the last one is a fix and the rest can go into -next,
> WDYT?

Exactly.

Thanks!
grant
