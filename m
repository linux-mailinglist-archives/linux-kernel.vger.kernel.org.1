Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D772CA8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392130AbgLAQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:55:33 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:10638 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392037AbgLAQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606841556;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=61Pj8+ULDC/9CQt8Dl+J/sb0n6Xqryjx4clI8Aq1YQw=;
        b=PHaBePEEKF03EQjcRx1LFgAAb2k7Nkbr+zd+RHiYF5ol+NLC6u8h//9pib+cD/8/Y6
        2OuvsQaJ8L0AyGJ8vJXzoiZtRabY2RZcsLhL03Wm8Cvkwz00m+TDV+OT3rcicr/DONZ4
        zDFIseuoz2eq/XxjJGdlHRMDnizqTrPm7ev0ELQpgZBEvqfxNgFF43IQ+PPSF7KlrlK5
        BDzqjNikZYPrWekxpwFpP7+O7wTsOCkZDT2yOeccT1eNpoewdbpo8NZwVxOP2Zt0lE4L
        YZmNnx9AEfsStYOOORXaoYJ73sAZSRItlxZSRCC4xIb0pKkavAEoEUZLedmV9UFpJe3I
        JcPQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1GqYVYJ
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 17:52:34 +0100 (CET)
Subject: Re: [Letux-kernel] [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20201201174433.2000c8a3@aktux>
Date:   Tue, 1 Dec 2020 17:52:34 +0100
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F0CED75-9EB2-401E-80E7-C1CD29D699F0@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <20201201174433.2000c8a3@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 01.12.2020 um 17:44 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Tue, 1 Dec 2020 11:10:49 -0500
> Sven Van Asbroeck <thesven73@gmail.com> wrote:
>=20
>> Nikolaus,
>>=20
>> On Tue, Dec 1, 2020 at 9:38 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>> Let's work on a fix for the fix now.
>>>=20
>>=20
>> Are you quite sure the chip-select of the tpo,td028ttec1 panel
>> is active-high? A quick google produced a datasheet which
>> seems to indicate that XCS is active-low?
>>=20
> Schematics is here:
> https://projects.goldelico.com/p/gta04-main/downloads/48/
>=20
> The display connector P204-LCD indicates some inversion at the XCS and
> XRES pins.
>=20
> This patch fixes things for a boot where the display was not
> touched by the bootloader
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
> index c8745bc800f7..003202d12990 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -124,7 +124,6 @@
>                        spi-max-frequency =3D <100000>;
>                        spi-cpol;
>                        spi-cpha;
> -                       spi-cs-high;

BTW: that is what I had planned to try next...

>=20
>                        backlight=3D <&backlight>;
>                        label =3D "lcd";
>=20
> So if that one is really active-low, why did it ever work?!
>=20
> Regards,
> Andreas

