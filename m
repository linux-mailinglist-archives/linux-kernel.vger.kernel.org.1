Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CBB2D98D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439920AbgLNN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:29:58 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37945 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439890AbgLNN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:29:32 -0500
Received: by mail-ua1-f67.google.com with SMTP id y26so5447498uan.5;
        Mon, 14 Dec 2020 05:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cE+oqAfA+GkiyVb1F1JkfAtzYUI1QcTqmk17SNa2LOM=;
        b=tp+0x0xLft5YtYSFQfNfeErLeoBo18wMgblt9LqDDZVqP8+2gXNq0s47LVchktpj2/
         8TzrK/FkOT4YsuMuT6LmBIMK/VbFSq/zlq2pgLOhPyI1vWce0K+vr7x6G2NMyACai0QN
         lELC7WYtiWT5WWW6tM1rhwVgkVYgDWQ+GoxPwx08pY3YH/kDpTFWiOqtGJ+jpcd4weKb
         OiidhFy/e3f4tmES89bXmFFbTSsBb8fTei+Q6iRVlcGGgSdnVrmyA4VCZZv3/ueJi3kO
         5cm2d74kunf0pQfucW/dbRk61t1iwq186CdrRJT9haBE7kWdzGAp9JzVAmdEik6dTkSV
         K+DQ==
X-Gm-Message-State: AOAM530PavaLZPKknRW51mQWD0UXsTDafyn+Ze7VGa9j0vP+FqrHQrwB
        J6uQ7xZ21IVxmSGuc/2TW46mjmjgbLonpg==
X-Google-Smtp-Source: ABdhPJxeW6HVj7qMaeAVjFzseMWk25Yd+2IR/8+m5q2VOq1JFb8GYnXQXrAxN38ZcEMU8AAq7cO7eQ==
X-Received: by 2002:ab0:35d7:: with SMTP id x23mr22764604uat.119.1607952529668;
        Mon, 14 Dec 2020 05:28:49 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id i187sm2261857vkb.37.2020.12.14.05.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 05:28:48 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id s13so2377007vkb.11;
        Mon, 14 Dec 2020 05:28:48 -0800 (PST)
X-Received: by 2002:a1f:5402:: with SMTP id i2mr18377523vkb.5.1607952528088;
 Mon, 14 Dec 2020 05:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20201211011934.6171-1-andre.przywara@arm.com> <20201211011934.6171-20-andre.przywara@arm.com>
 <20201214095831.j63nks3fqxlaw75w@gilmour> <20201214125343.0cd1bc6a@slackpad.fritz.box>
In-Reply-To: <20201214125343.0cd1bc6a@slackpad.fritz.box>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 14 Dec 2020 21:28:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v677X7h_Xo3L6gP0Ws4P0ROmZ0LhwNStZk-zcL7XtTRCLA@mail.gmail.com>
Message-ID: <CAGb2v677X7h_Xo3L6gP0Ws4P0ROmZ0LhwNStZk-zcL7XtTRCLA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 19/21] arm64: dts: allwinner: Add
 Allwinner H616 .dtsi file
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 8:53 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Mon, 14 Dec 2020 10:58:31 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> > On Fri, Dec 11, 2020 at 01:19:32AM +0000, Andre Przywara wrote:
> > > +   reserved-memory {
> > > +           #address-cells = <2>;
> > > +           #size-cells = <2>;
> > > +           ranges;
> > > +
> > > +           /* 512KiB reserved for ARM Trusted Firmware (BL31)
> > > */
> > > +           secmon_reserved: secmon@40000000 {
> > > +                   reg = <0x0 0x40000000 0x0 0x80000>;
> > > +                   no-map;
> > > +           };
> > > +   };
> >
> > This should still be set by the firmware
> >
> > > +           mmc0: mmc@4020000 {
> > > +                   compatible = "allwinner,sun50i-h616-mmc",
> > > +                                "allwinner,sun50i-a100-mmc";
> > > +                   reg = <0x04020000 0x1000>;
> > > +                   clocks = <&ccu CLK_BUS_MMC0>, <&ccu
> > > CLK_MMC0>;
> > > +                   clock-names = "ahb", "mmc";
> > > +                   resets = <&ccu RST_BUS_MMC0>;
> > > +                   reset-names = "ahb";
> > > +                   interrupts = <GIC_SPI 35
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +                   pinctrl-names = "default";
> > > +                   pinctrl-0 = <&mmc0_pins>;
> > > +                   status = "disabled";
> > > +                   #address-cells = <1>;
> > > +                   #size-cells = <0>;
> > > +           };
> >
> > Somewhat related: we shouldn't set the MMC speed flags in the drivers.
> > This is biting us on the already supported SoCs, so it would be great
> > to not repeat the same mistake with the new ones
>
> Do you mean to list the "sd-uhs-sdr50" and friends properties here in
> the DT?
> What is the best practice here in terms putting them in the .dts vs.
> the .dtsi? Surely the controller has limits, but bad traces on a board
> could impose further restrictions, right?
> Though that's probably rare, so it sounds like a lot of churn to list
> them in every board DT. So can we list everything in here (.dtsi), then
> delete in those affected boards only?

The driver will most certainly already have the basic high speed modes
enabled. Or we can list them in the .dtsi file.

For HS-DDR mode, we probably want to list that in the .dtsi file as well,
as that seems to be the one that is failing most of the time.

All the UHS-1 modes would be listed by board, since it requires a way
to cut power to the card and the ability to change I/O voltage levels.

I wonder if Allwinner still keeps the timing information in the driver,
or have they moved that to their vendor device tree files. We might want
to consider moving it as well.

ChenYu
