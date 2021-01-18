Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE22FAC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394447AbhARVKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbhARVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:02:39 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:01:59 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x78so9460759ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6WyOf0eR79gLxpfXkkTKsFGZ48cTcGjXXrB5k3tHZU=;
        b=eBDibH/keDb+f0lcVDKsAk492JAG4MtqHrbbCztc/YVPyEOAJNaqKlI3o4NQcUGotO
         MxwVmD1/prmYv4Lxl8KfM727BO0IEECzyAcn4MW9L81BzDuTLg+d31sSJ+6WZ5tXjd/N
         Qyr8/PrBlIvnkdO1+7ZDRmyxMZYq+3Jp3rVewjANiT287qf1khStKvb+oVbaxrIZpqeT
         X1f7Zao1dh1EFwm1CmXybNk62vmzTR8dreF6DKX0CbzuRDkUJqkhBYxf0F4p+M5aYwNW
         MinsorPAw4zJR5ppuykQF68gZUjDf+gKf9dfyD4SWLLrBqX8CIjNeoPtCGeW14caDtZe
         NX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6WyOf0eR79gLxpfXkkTKsFGZ48cTcGjXXrB5k3tHZU=;
        b=ItOTyj4gCHnayybq1V7Um42OSNwvmPC0zayRdDiOLj35P/u7XB1OsvCuE4LvbbaYzj
         4jXafaA4HLv/7id0dvOxazl039VnzhX2oDM0Q/n+Qa7Kgd1ljnK+BMT9jNcsGjTWV6+V
         x4Q2dyW3A4toYmmPOu8qrExH1bh+17PcI+pidCaGQRULAEUQcLdna5kuKdN1x/TKRy3f
         3QCFwyvUvEZ2k+cLlUVgPHdBX1i84sFObG4Vu/nOMsKGRyQVer03h8XjW5lMHsXLuxov
         DE0V0tZR5o3GEsH0EKdoxr6eRC8kydVDtLcKnH8p/zRfnevM/Tmw9b6Dsn4EUzyqWCmn
         jmMw==
X-Gm-Message-State: AOAM532unvy9VZ8kWZ/JN8zq4aqg5aPiyO69sTo7EAVoaVpOLThsOdoP
        uTPa9U6FDwp5GGtYsurs0f9TiyYH1nbcmDfKncDm9A==
X-Google-Smtp-Source: ABdhPJzTV859+4Dye5PFFGFGBAj3QcEuu9tffkTQrp4dsq9G3sjdYXvOWg8oMzYU7lMlaIj1t00EM5XaB6IKWuXBwhY=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr1637715ybc.32.1611003718283;
 Mon, 18 Jan 2021 13:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-6-saravanak@google.com> <20210117230134.32042-1-michael@walle.cc>
In-Reply-To: <20210117230134.32042-1-michael@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 Jan 2021 13:01:22 -0800
Message-ID: <CAGETcx9=6fPAHLuMyfxfXTGxeSUO8FwHVU_F4bfqLTfK6c+eXw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Michael Walle <michael@walle.cc>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 3:01 PM Michael Walle <michael@walle.cc> wrote:
>
> Hi Saravana, again ;)

Hi again! :)

>
> > Cyclic dependencies in some firmware was one of the last remaining
> > reasons fw_devlink=on couldn't be set by default. Now that cyclic
> > dependencies don't block probing, set fw_devlink=on by default.
> >
> > Setting fw_devlink=on by default brings a bunch of benefits (currently,
> > only for systems with device tree firmware):
> > * Significantly cuts down deferred probes.
> > * Device probe is effectively attempted in graph order.
> > * Makes it much easier to load drivers as modules without having to
> >   worry about functional dependencies between modules (depmod is still
> >   needed for symbol dependencies).
> >
> > If this patch prevents some devices from probing, it's very likely due
> > to the system having one or more device drivers that "probe"/set up a
> > device (DT node with compatible property) without creating a struct
> > device for it.  If we hit such cases, the device drivers need to be
> > fixed so that they populate struct devices and probe them like normal
> > device drivers so that the driver core is aware of the devices and their
> > status. See [1] for an example of such a case.
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This breaks (at least) probing of the PCIe controllers of my board. The
> driver in question is
>   drivers/pci/controller/dwc/pci-layerscape.c
> I've also put the maintainers of this driver on CC. Looks like it uses a
> proper struct device. But it uses builtin_platform_driver_probe() and
> apparently it waits for the iommu which uses module_platform_driver().
> Dunno if that will work together.

Yeah, the builtin vs module doesn't matter. I've had fw_devlink work
multiple times with the consumer driver being built in and the
supplier actually loaded as a module. Making that work is one of the
goals of fw_devlink.

> The board device tree can be found here:
>   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
>
> Attached is the log with enabled "probe deferral" messages enabled.

I took a look at the logs. As you said, pci seems to be waiting on
iommu, but it's not clear why the iommu didn't probe by then. Can you
add initcall_debug=1 and enable the logs in device_link_add()? Btw, I
realize one compromise on the logs is to send them as an attachment
instead of inline. That way, it's still archived in the list, but I
don't have to deal with log lines getting wrapped, etc.

Thanks for reporting the issues. Also, could you try picking up all of
these changes and giving it a shot. It's unlikely to help, but I want
to rule out issues related to fixes in progress.

https://lore.kernel.org/lkml/20210116011412.3211292-1-saravanak@google.com/
https://lore.kernel.org/lkml/20210115210159.3090203-1-saravanak@google.com/
https://lore.kernel.org/lkml/20201218210750.3455872-1-saravanak@google.com/

Thanks,
Saravana
