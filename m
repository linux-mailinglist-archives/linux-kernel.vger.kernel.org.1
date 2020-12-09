Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567252D3DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgLIIsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:48:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:8295 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgLIIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607503520;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=Php6UbWO3LXsLeMNj2vpYHNEMmvf8nM4PJMlcMYMu+s=;
        b=miXG//Oim8SR5Ah990LHF9HwdbV/cLsP45c/ZYssAncLnrcOU2ab9vLPyKmIupJFqG
        s3a2tUpW8ZBjjYN+1H7ucuAIAZTBUSBKDfoC7FEDghRgVwBYNM4AfRGXgAVsa5pyr1Vx
        d8UxKBXJQMbWxaYCaI5gdvwlmE3fmDheUJAoP2evH3g72GqDv7WIJ63p+5aiZUsmEqOL
        b7K1qZysxXGyLOY8scDbiF35xNeks4h83aK8HRzJo/+JmI19Wmu6AiE5GitKGDRkJCKf
        Qt72k2wqB+9jOg8fTkLg3vE8mr5v642DgwzcweeeWsufF1GRBP2yX1ua/205v2E0Mjm6
        Ng5A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlafXAoNHQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 908871wB98j54lV
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 09:45:05 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkdYbGBT1gYZ06W7G-tjx9J4YG1bi1g2GOAUAH0tzH8YbNw@mail.gmail.com>
Date:   Wed, 9 Dec 2020 09:45:04 +0100
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1D5D5B7-72AB-42F7-A460-9B61932C869B@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com> <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com> <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com> <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com> <CACRpkdYgu+fyYm8aSCRuPeVe0EieyboZsWC=XsrRs5Tubog6nA@mail.gmail.com> <ED67B0A3-1098-4B4C-A4F4-EE52B0E5F1E3@goldelico.com> <CACRpkdYbGBT1gYZ06W7G-tjx9J4YG1bi1g2GOAUAH0tzH8YbNw@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> Am 09.12.2020 um 09:38 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> On Sat, Dec 5, 2020 at 8:07 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> I find it interesting that so far nobody wants to take responsibility
>> for a decision
> (...)
>=20
>=20
>>> What I can do is to provide just a skeleton for the table that you =
or Linus
>>> can fix/fill in and make a patch out of it. Is attached and the ??? =
is
>>> something you should discuss and define.
>>=20
>> Please take the attached diff, comment it here and define the =
question marks
>> according to your intention and then make a patch for the YAML =
bindings out
>> of it. (I can't do because I don't know your intentions and what to =
write into
>> the commit message).
>=20
> I'll comment what I know, then you can send a proper patch to
> Mark. But you really need more people than me to look at this.
>=20
>> +      device node     | cs-gpio       | CS pin state active | Note
>> +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D
>> +      spi-cs-high     | -             | H                   |
>> +      -               | -             | L                   |
>> +      spi-cs-high     | ACTIVE_HIGH   | H                   |
>> +      -               | ACTIVE_HIGH   | L (or H ???)        | 1
>=20
> When using GPIO descriptors it will be enforced to ACTIVE_LOW (L) with =
an
> explicit warning in dmesg, see drivers/gpio/gpiolib-of.c

Ok, so in this line the L is ok.

>=20
> When using legacy GPIOs, will be enforced ACTIVE_LOW by the SPI
> core.
>=20
>> +      spi-cs-high     | ACTIVE_LOW    | H (or L ???)        | 2
>=20
> When using GPIO descriptors it will be enforced to ACTIVE_HIGH (H) =
with an
> explicit warning in dmesg, see drivers/gpio/gpiolib-of.c

Ok, so my assumption about H is right and not the part in parenthesis =
with ???.

>=20
>> +      3) Effectively this rule defines that the ACTIVE level of the
>> +         gpio has to be ignored
>=20
> Nr 3 isn't tagged in the table.

Well, it was thought as a third but general note. Maybe should have been =
a *)
or omitted since the table stands for itself.

>=20
> Yours,
> Linus Walleij

So let me prepare a patch with fixes for this.

BR and thanks,
Nikolaus

