Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2500E2C9B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgLAJGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:06:16 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:31414 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388732AbgLAJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606813197;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/wFU109K6enzxYP0SRDcYv2BvlfcVrn1By3HhQXXwLw=;
        b=bV68+X7+i9/4M9YsEkirVCAWQntltSQBsJk/WbWe5tAcIlk1qR3Ui5mI1Wkjl1LkaB
        mEH2w/oXMDcf4N8wxX+7dvGhx+u4NEo74HCsKjvzGmfpaS7bSlNyWxu2wpq2iGKvXShb
        aeHfwWV4fG4XqPWldnoF3rvyNHPNRT4XFO09pcvl0xQnHaLez9cvmjovjNB6de222szm
        Ucp9+D+wMd3OO12xSSmtwCC2maHNoaIe77j1RMEcFpww/9T9Y1/HbnGHjjs+MsDQAZXP
        4EHbKXO8Gs3Ua8SwSNFQXaN8Ndh+evzd3+agoabapXSEjzbbo8u65Pk72dPBF+SgpX0c
        ar1A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB18xhSXr
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 09:59:43 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
Date:   Tue, 1 Dec 2020 09:59:43 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

> Am 30.11.2020 um 21:13 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> Hi Nikolaus, thank you for reaching out !
>=20
> On Mon, Nov 30, 2020 at 2:06 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> But reverting your patch brings back the display. So it appears as if =
it does not
>> fix a breakage, rather breaks a previously working setup.
>=20
> The patch in question fixes an important breakage: before the patch, =
literally
> hundreds of SPI drivers no longer worked - only if the SPI bus master
> driver was using gpio descriptors.
>=20
> We knew that there was a chance that our fix would break something =
else.
> But hopefully "it fixes more than it breaks"

Then it should not have been applied to mainline but fully worked out =
and tested.

>=20
>>=20
>> What should we do?
>>=20
>=20
> Can you try the following patch ?

Unfortunately it doesn't seem to fix it. And combined with the second =
proposed fix also not.

BR and thanks,
Nikolaus

my combined change:

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 7ceb0ba27b755c..ec2da62716a279 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -208,8 +208,8 @@ static void spi_gpio_chipselect(struct spi_device =
*spi, int is_active)
        if (spi_gpio->cs_gpios) {
                struct gpio_desc *cs =3D =
spi_gpio->cs_gpios[spi->chip_select];
=20
-               /* SPI chip selects are normally active-low */
-               gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? =
is_active : !is_active);
+               /* SPI chip select polarity handled by gpiolib*/
+               gpiod_set_value_cansleep(cs, is_active);
        }
 }
=20
@@ -226,8 +226,7 @@ static int spi_gpio_setup(struct spi_device *spi)
        if (spi_gpio->cs_gpios) {
                cs =3D spi_gpio->cs_gpios[spi->chip_select];
                if (!spi->controller_state && cs)
-                       status =3D gpiod_direction_output(cs,
-                                                 !(spi->mode & =
SPI_CS_HIGH));
+                       status =3D gpiod_direction_output(cs, false);
        }
=20
        if (!status)

