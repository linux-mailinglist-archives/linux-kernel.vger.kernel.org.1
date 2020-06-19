Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6242002E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgFSHoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbgFSHoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:44:13 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD72208DB;
        Fri, 19 Jun 2020 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592552652;
        bh=UdDU2Ya8vvambIemCpJSHDyYc3tTlgjpyYV4GqGjg7c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x4gR7SivjA0NaN3zVriYZxI06Of4cPLXFhY7saGIN+j0SGoA/uS6U3hEhXvrCvQGp
         zvUIrIwCWpKO52kedNkvexEt8/110ih9j03LnJ82GqFUI3WyIfgyg9BFs6RYiu+0c3
         NzvyYl/NLT94Yf3vnqKVdKMx6hcFWXpI2vUq3E2w=
Received: by mail-lj1-f170.google.com with SMTP id z9so10341469ljh.13;
        Fri, 19 Jun 2020 00:44:12 -0700 (PDT)
X-Gm-Message-State: AOAM533FH2WCH5W0SAZ4EAr8JjCyVDANlPPPoe2eN/413yaAbPptkzI8
        KtwrpYGg6xFD2qrKrB0HTlU5BhEIGWmuYzIPc6A=
X-Google-Smtp-Source: ABdhPJxpgPxVbsbdq4U2Eaj5lpIoQ25R0xdkESNoUt3toyGEX1pPhSRtMLztuyplRf2KFBgpuHYhG9cYIJBoEC1f1Mo=
X-Received: by 2002:a2e:8896:: with SMTP id k22mr1087416lji.331.1592552650603;
 Fri, 19 Jun 2020 00:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200618080223.951737-1-lee.jones@linaro.org> <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
 <20200618100704.GC954398@dell> <CAGb2v67GJUzomptOzzvafcQ-wAqrJvNNeEZsY7gVQ_kByqBT8w@mail.gmail.com>
 <20200619064141.GK954398@dell>
In-Reply-To: <20200619064141.GK954398@dell>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 19 Jun 2020 15:43:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v65aAAegOCdMYF=VkTT8pWwuT9d=mhVKCSwztecMJa-ung@mail.gmail.com>
Message-ID: <CAGb2v65aAAegOCdMYF=VkTT8pWwuT9d=mhVKCSwztecMJa-ung@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON) access
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        DTML <devicetree@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        michael@walle.cc, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 2:41 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 19 Jun 2020, Chen-Yu Tsai wrote:
>
> > On Thu, Jun 18, 2020 at 6:07 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 18 Jun 2020, Arnd Bergmann wrote:
> > >
> > > > On Thu, Jun 18, 2020 at 10:03 AM Lee Jones <lee.jones@linaro.org> w=
rote:
> > > > >
> > > > > The existing SYSCON implementation only supports MMIO (memory map=
ped)
> > > > > accesses, facilitated by Regmap.  This extends support for regist=
ers
> > > > > held behind I2C busses.
> > > > >
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > >
> > > > The implementation looks fine to me, but can you explain how this i=
s going to
> > > > be used, and what the advantage is over open-coding the devm_regmap=
_init_i2c()
> > > > in each driver that would use this?
> > >
> > > Does Regmap let you register/initialise an I2C address more than once=
?
> > >
> > > When I attempt it, I get:
> > >
> > > [    0.522988] i2c i2c-0: Failed to register i2c client tmp105 at 0x3=
2 (-16)
> > > [    0.523341] i2c i2c-0: of_i2c: Failure registering /bus@4000000/mo=
therboard/iofpga@7,00000000/i2c@16000/temp@32
> > > [    0.523691] i2c i2c-0: Failed to create I2C device for /bus@400000=
0/motherboard/iofpga@7,00000000/i2c@16000/temp@32
> > >
> > > > Is this about using proper locking through the regmap framework for
> > > > shared i2c clients, or to reduce memory consumption when lots of dr=
ivers
> > > > access the same regmap?
> > >
> > > All of those things are valid.
> > >
> > > My use-case is regarding MFDs sharing an I2C interfaced address space
> > > with their children.
> >
> > Is that an issue with the standard mfd + regmap pattern?
>
> There is no relationship between MFD and Regmap.  It is not more
> closely related to Regmap than it is any other public API provided
> within the kernel.  *Some* parent drivers initialise one large,
> encompassing Regmap address space and pass it to their children, but
> this isn't suitable in all cases.
>
> > For the AXP20x PMICs, we register the regmap in the parent mfd driver [=
1],
> > and store that in dev_data for child drivers to fetch [2]. You could
> > easily just fetch the regmap with dev_get_regmap() and a pointer to the
> > parent device.
>
> Remember, not all use-cases are the same.  Just because your H/W fits
> well within the current framework, doesn't mean all will.
>
> Initialising in the parent is no problem if the driver is meaningful
> in other ways, but what if that's all the parent driver does?  In
> these cases Syscon can be used instead, rendering the driver
> superfluous. Meaning it can (and *should*) then be omitted.

I'm guessing in your use case there isn't a need for a parent driver,
and you are looking for something like "simple-mfd", but for listing
sub-devices within an I2C slave device? In that case I understand.

> > > > My impression of the existing syscon code is that the main value-ad=
d over
> > > > other ways of doing the same is the syscon_regmap_lookup_by_phandle=
()
> > > > interface that gives other drivers a much simpler way of getting th=
e
> > > > regmap just based on the DT node. Are you planning to add something
> > > > like that here as well? An ideal driver interface might allow
> > > > syscon_regmap_lookup_by_phandle() to work for both mmio and i2c
> > > > based syscons, or additional ones as well, but implementing this wo=
uld
> > > > be rather tricky when the i2c core is a loadable module.
> >
> > The current MMIO syscon is decoupled from the DM, and there is no way
> > for drivers to export or register a syscon, meaning I have to open code
> > syscon_regmap_lookup_by_phandle() [3] if I want to only expose certain
> > registers and not the full address range, or if I want to share the
> > regmap with the existing driver (for locking purposes), or both [4].
>
> Not sure I understand the problem.
>
> Could you explain why the current implementation doesn't work for you?
>
> Open coding your own implementation of Syscon is non-optimal.

For the DWMAC Ethernet controllers, the platform glue almost always has
a register for tuning the delays of the TX and RX clocks. In almost all
later Allwinner chips, this is in a separate area, which we use a syscon
for. However in one hybrid chip, this is located in the clock controller.
We deemed it risky to also have the whole clock controller address range
mapped as a syscon, and so we export a custom regmap.

The Ethernet driver has to deal with both cases.

Looking at it again, since syscon still has a platform driver, maybe I
should just use the dev_get_regmap() route for both cases.

> > Maybe there's room for improvement here? The same applies to the new
> > I2C case, and likely any other future syscon variants.
> >
> > IMHO people are getting it wrong if they have both a syscon and a drive=
r
> > for the same device.
>
> Syscon is just a means to obtain a group of registers either a)
> without a dedicated driver OR b) to share amongst more than 1,
> potentially unrelated, user.  So in the case of a) which appears to
> sit well with-in your use-case and expectations, you are correct.
> Whereas in the case of b) you are not.
>
> I hope that helps clarity the situation somewhat.

The concern was mostly due to the commit message of

    bdb0066df96e mfd: syscon: Decouple syscon interface from platform devic=
es

which mentions

   there is a need to have a dedicated driver for such system controller
   but also share registers with other drivers. The latter is where the
   syscon interface is helpful.

But does not provide any sort of coordination between the dedicated driver
and the syscon. I suppose the intention might have been that the driver
would get a syscon using its own device node. We avoided that but I wonder
if the extra code is worth it or not. Other platforms seem to do ok.

Thank you for helping me clear things up.


Regards
ChenYu

> > > I expect the API would be expanded to cover other use-cases.  This is
> > > a bare bones implementation which has been kept as atomic as possible
> > > for ease of review.
> >
> > Regards
> > ChenYu
> >
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/mfd/axp20x-i=
2c.c#L43
> > [2] https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinc=
trl-axp209.c#L433
> > [3] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet=
/stmicro/stmmac/dwmac-sun8i.c#L1093
> > [4] https://elixir.bootlin.com/linux/latest/source/drivers/clk/sunxi-ng=
/ccu-sun8i-r40.c#L1333
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
