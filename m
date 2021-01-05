Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8204E2EB556
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbhAEWZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbhAEWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:25:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DDFC06179A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:23:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 23so2113490lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4sAiyArUy52pWcai1J+mIoA8s+FFE+f9MM1+ahYCSU=;
        b=gSstDj7kJ/OpDFDoqs1xPxaHEMvZpCbZScFn/j+wkKEi4397BOHzU/7uJJX7lav6Yp
         9ujkJ1wuM6Kyj+DydTSui7f6ypRH4cbI8xcoUhuClYmgbFhcM2ODIzJO/ehvDuzYO8v4
         5/eWwAW9lom4PDt7sp9cFxmXO3QlkfVhvgK5wsdxSMS0x1xyDoUbDMvp7UpAKoBv4MXQ
         p9AUri7MKrrGYZI45OByNHyEzeh0imrWTVYiXc2E/Z2MrvVJJPS1ByEHNFqG1T1wJ6Ur
         oUQBGk6HWzotNKjBzWK6ItnX0fnM5EL6LLGFhk4+uf2Ehuf+d8Ig/021w5EX2/+cCF7T
         95BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4sAiyArUy52pWcai1J+mIoA8s+FFE+f9MM1+ahYCSU=;
        b=VwxJIQlFUaB9bwKQ/ivmdcKCVYNzHZZpW9wgysCuv8KO+ZZZNCpENNJ0wSyQjfGdTQ
         QiwsWhnwPA3vtKoQMK+4dY5t4x0oRO7NvlyWzjNV/40Oq+l0ACF63kTHRCIVpbT0lWj2
         VabaoHkFCPLRFwNHrilSISbYdR2y1hDyVaFxY9h4lxhao072Y4X5qn3oMxDCFBj776D0
         t4mG/d2Z3NhIHM8j6ejj7KplpflNm/0AXWtYCw0UefI0iC5VtAQuPka70SafI1OcDzYk
         bqJ+rf7+UK6gnWZRvNJJqmMu4vmDJZIZLCxWx+beqjmHNQH9X/C8HR+mez2BZTdt9ObW
         buSA==
X-Gm-Message-State: AOAM53252A/k7xXS3hCV/KrzspP4KD/9P4xV7uE475H0CdNhXIDqrw7i
        uOTN80W/5hRcIWBMLgS6g6A2UDSLht1DyEatFKifwg==
X-Google-Smtp-Source: ABdhPJxO4Z9b+ShG5jTz0D26Lj9xrsPscyospToUwxd20F05ow49opQ6EQWGJlHtNr59vnokxZTG9VLesox0NFc/mxg=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr627702lfs.529.1609885434234;
 Tue, 05 Jan 2021 14:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-4-martin.blumenstingl@googlemail.com>
 <CACRpkdZo-U_cAhbKb4E+d+p+5FenXkGYW0RXxyk4M5uyEPCpzw@mail.gmail.com>
 <CAFBinCCLubmDvxfabQHx2-ucgAsm1NArMUrtPx-UA2nX5xoFFA@mail.gmail.com> <CAFBinCAZXJ2=fTQuAUyW1hNeJDHY3_pxo4UhxUaOZC=i1bpFxw@mail.gmail.com>
In-Reply-To: <CAFBinCAZXJ2=fTQuAUyW1hNeJDHY3_pxo4UhxUaOZC=i1bpFxw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 23:23:43 +0100
Message-ID: <CACRpkdbKQaT61w6r9Hx40Qvy+7qyLNm-fx-BpL_wdGcB=tmcqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 4:28 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Wed, Oct 7, 2020 at 9:44 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > As noted on the earlier patches I think this should be folded into the
> > > existing XHCI USB driver in drivers/usb/host/xhci-pci.c or, if that
> > > gets messy, as a separate bolt-on, something like
> > > xhci-pci-gpio.[c|h] in the drivers/usb/host/* directory.
> > > You can use a Kconfig symbol for the GPIO portions or not.
> > OK, I will do that if there are no objections from other developers
> > I am intending to place the relevant code in xhci-pci-etron.c, similar
> > to what we already have with xhci-pci-renesas.c
>
> I tried this and unfortunately there's a catch.
> the nice thing about having a separate GPIO driver means that the
> xhci-pci driver doesn't need to know about it.

Since PCI devices have device-wide power management and things
like that I think that is a really dangerous idea.

What if the GPIO driver starts poking around in this PCI device
when the main driver is also probed and has put the device
into sleep state?

This type of set-up needs to be discussed with
the PCI maintainer to make sure it is safe.

> I implemented xhci-pci-etron.c and gave it a Kconfig option.
> xhci-pci is then calling into xhci-pci-etron (through some
> etron_xhci_pci_probe function).

This sounds about right.

> unfortunately this means that xhci-pci now depends on xhci-pci-etron.
> for xhci-pci-renesas this is fine (I think) because that part of the
> code is needed to get the xHCI controller going
> but for xhci-pci-etron this is a different story: the GPIO controller
> is entirely optional and only used on few devices

I might be naive but should it not be the other way around?
That xhci-pci-etron is dependent on xhci-pci? I imagine
it would be an optional add-on.

> my goal is (at some point in the future) to have the GPIO driver in OpenWrt.
> I am not sure if they would accept a patch where xhci-pci would then
> pull in the dependencies for that Etron controller, even though most
> boards don't need it.

Make sure the etron part is an additional module that can be
loaded after xhci-pci.

OpenWrt support optional modules to be compiled per-system.

Yours,
Linus Walleij
