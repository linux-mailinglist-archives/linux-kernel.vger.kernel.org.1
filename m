Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DE2CA8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgLAQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:50:05 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:32891 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbgLAQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606841231;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=i0/Gp1dKaGGObGUNczkbh0vey3aIfMJXXWm7ukUxAog=;
        b=OaswZ6gSzPj+gLIYGDZTGASWdGSehtxH103RxVTOFqiWsVu74b2COo5tFAFQT38Fvx
        zgf88ye0SkoyO7TUdXie4pDCcUvyUIIKapfw+XEALaBl9yR2/VkMXdwW5fVYGUO3fM3g
        XYFdhJVFUUi62gbfvAz75bqEAdn2NiM2Z8PDNB2nhuqAcrFO8yOCQPN6wCbD1zmYUNOx
        XLt0fzBXCDQ93UZVdQqmmNOHuRCVjbe5SMdwWCiRyHN00YYBz6wRD40BOBn2EaW53+Tt
        NgdmUJVLdd7i6ndUscXKxZmcdjAZq+Mg0J4q1t1J8WjdeWa/Z1AXlPsgcEOlE15MCk7W
        z0Fg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1GkuVXK
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 17:46:56 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiVd6d2pb3eOd5ZiCvTBOzZK6+dudRUVWj8neBRK0S42Pg@mail.gmail.com>
Date:   Tue, 1 Dec 2020 17:46:56 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF708A45-7325-49D5-B41E-7D54942F5E23@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiVd6d2pb3eOd5ZiCvTBOzZK6+dudRUVWj8neBRK0S42Pg@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 01.12.2020 um 16:52 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> Nikolaus,
>=20
> On Tue, Dec 1, 2020 at 9:38 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Let's work on a fix for the fix now.
>=20
> I tested spi-gpio on my system, by converting a built-in or hardware =
spi,
> to a spi-gpio. Interestingly, the patch has the opposite effect on my =
system:
> before the patch, spi-gpio did not work, but after it's applied, it =
does work.
>=20
> Can you tell me the idle status of your chip-select gpio in debugfs?
> # mount -t debugfs none /sys/kernel/debug
> # cat /sys/kernel/debug/gpio
> Look for something like this:
> gpiochip0: GPIOs 0-31, parent: platform/209c000.gpio, 209c000.gpio:
> gpio-17  (                    |spi5 CS0            ) out hi ACTIVE LOW

root@letux:~# mount -t debugfs none /sys/kernel/debug
root@letux:~# cat /sys/kernel/debug/gpio|fgrep spi
 gpio-179 (                    |spi4 CS0            ) out lo=20
root@letux:~#=20

That is after the panel driver did send the commands.

>=20
> Also, apply the following patch, and tell me
> a) does this dev_err() get called on your system, and

yes. Many times.=20

> b) what is the value when your chip is de-selected

root@letux:~# dmesg|fgrep td028
[   14.530456] panel-tpo-td028ttec1 spi4.0: spi->mode =3D 00000003
[   14.599212] panel-tpo-td028ttec1 spi4.0: gpiod disable
[   14.817871] panel-tpo-td028ttec1 spi4.0: spi->mode =3D 00000003
[   14.817871] panel-tpo-td028ttec1 spi4.0: gpiod enable

So it is disabled first and then enabled. Which appears to be the =
opposite
of what it should be.

BTW: I have added another dev_err to print the spi->mode and like
you describe it is (overwritten? by SPI_MODE_3.

I can check what value it has in the driver before it is set to =
SPI_MODE_3.

Maybe, there the spi-cs-high gets lost?

BR and thanks,
Nikolaus


> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 7e8804b02be9..b2f4cf5c9ffb 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -813,11 +813,12 @@ static void spi_set_cs(struct spi_device *spi,
> bool enable)
>=20
>        if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
>                if (!(spi->mode & SPI_NO_CS)) {
> -                       if (spi->cs_gpiod)
> +                       if (spi->cs_gpiod) {
> +                               dev_err(&spi->dev, "gpiod %s", enable1
> ? "enable" : "disable");
>                                /* polarity handled by gpiolib */
>                                gpiod_set_value_cansleep(spi->cs_gpiod,
>                                                         enable1);
> -                       else
> +                       } else
>                                /*
>                                 * invert the enable line, as active =
low is
>                                 * default for SPI.

