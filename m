Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C194B2CF262
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgLDQwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:52:31 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:15849 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbgLDQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607100574;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=trCMVr2z+gRs066SSFADblrnm+L01vIhG+pm8UbEmMs=;
        b=olECsPH83qN/uvK0UvKIi5cP09jKF35nYEnJZuAAP2ONFLw+7HExax6vyNGn2L8VJx
        ltGySziHytumE3mtZa9dl/D9bnN0ZCUnNfGJzL1SOevB4vZ+qTL+P4Ve2Ls7HATzb5Vo
        VvxGxa/2fh2PZ56cEIzQbsvJKeEVphPgZWDmjAqc1FRBP5/hvRpMT8WJgMN8z1qDv4dA
        kruV696/U0tFXwMPvcujyuE20FmP+Xn7DejrU2gmM60nueyMXLKdFpWfH9z8MwrhD8lY
        YGFeRS7khY2AB5iEOb8yth9IU8KsXIZs5Vu+juSYQxqjmnjJT4hAa+cjQGQdGO86vwnK
        UH2g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMnw47pB1A="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB4GnUicp
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 4 Dec 2020 17:49:30 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
Date:   Fri, 4 Dec 2020 17:49:29 +0100
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com> <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com> <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

> Am 04.12.2020 um 14:46 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> On Fri, Dec 4, 2020 at 5:11 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Anyways it is debatable if this is a bug at all. It is just a =
definition.
>=20
> I respectfully disagree. Prior to the fix, your panel's active-low =
chip select
> needed to be described in the devicetree with 'spi-cs-high'. That =
sounds
> very much like a bug to me.

It could have been described by ACTIVE_LOW without spi-cs-high but that =
did
emit a nasty and not helpful warning on each boot.

Well, there are of course better and worse definitions and I agree that
spi-cs-high to define an active-low chip select sounds strange. Still it
is just a definition.

But what I don't know is if I can omit spi-cs-high and have to keep
ACTIVE_HIGH (my revert patch) or also change to ACTIVE_LOW (my =
additional
patch). This is arbitrary and someone has to decide what it should be.

Then, the gpiolib / spi driver code should be adapted if necessary and a
unit-test or real-hardware test with all possible combinations would =
prove
it for all other devices as well. So testing against a specification =
does
not need /my/ hardware.

>=20
>> Which is not well documented anywhere.
>=20
> I agree that documentation can be improved here.
> Would you like to submit a patch that improves:
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/devicetree/bindings/spi/spi-controller.yaml?h=3Dv5.10-rc6#n28
> ?

Yes, that is the right location.

Basically it involves adding a table like in my previous mail to the =
comment
so that it also covers all cases where the second parameter is not 0.

I'd prefer if you or maybe Linus could submit such a patch and I am =
happy to review it.

The reason is that I am neither involved in gpiolib nor spi subsystem =
development
 so I neither know what your intended setup is. I may define a wrong =
table.

I just need a stable definition by the subsystem maintainers so that I =
can
finish the device tree I am responsible for.

What I can do is to provide just a skeleton for the table that you or =
Linus
can fix/fill in and make a patch out of it. Is attached and the ??? is
something you should discuss and define.

> This way, we also get Rob Herring involved, which may lead to more =
elegant
> documentation. He is more likely to respond to a patch than to a =
question.
>=20
>>=20
>> What I especially wonder is why you fix that at all in =
drivers/spi/spi.c
>> if polarity inversion is handled in gpiolib.
>=20
> The reason for that is described in the commit message of
> 766c6b63aa04 ("spi: fix client driver breakages when using GPIO =
descriptors")

IMHO it could have been fixed in the gpiolib alone. In my assumption, =
gpiolib
would know (or be informed) that the gpio is used by spi and could =
invert gpio_set_value()
if needed. Then any SPI code would simply use gpio_set_value(true) if =
spi-cs-high
is defined and gpio_set_value(false) if not to enable the chip.

The alternative would be that it is only done centrally in one place in =
the
spi subsystem.

But I may be wrong, because the real architecture of the spi and gpiolib =
code
is quite new to me. My focus is on very different things (e.g. camera =
driver,
drm panel drivers) which is already complex enough.

BR and thanks,
Nikolaus

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml =
b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1b56d5e40f1f..4f8755dabecc 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -42,6 +42,30 @@ properties:
         cs2 : &gpio1 1 0
         cs3 : &gpio1 2 0
=20
+      The second flag can be GPIO_ACTIVE_HIGH/0 or GPIO_ACTIVE_LOW/1.
+
+      There is special rule set for combining the second flag of an
+      cs-gpio with the optional spi-cs-high flag for SPI slaves.
+
+      Each table entry defines how the CS pin is physically driven
+      (not considering gpio inversions by pinmux):
+
+      device node     | cs-gpio       | CS pin state active | Note
+      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D
+      spi-cs-high     | -             | H                   |
+      -               | -             | L                   |
+      spi-cs-high     | ACTIVE_HIGH   | H                   |
+      -               | ACTIVE_HIGH   | L (or H ???)        | 1
+      spi-cs-high     | ACTIVE_LOW    | H (or L ???)        | 2
+      -               | ACTIVE_LOW    | L                   |
+
+      Notes:
+      1) should print a warning about polarity inversion
+         because here it would be wise to define the gpio as ACTIVE_LOW
+      2) could print a warning about polarity inversion
+         because ACTIVE_LOW is overridden by spi-cs-high
+      3) Effectively this rule defines that the ACTIVE level of the
+         gpio has to be ignored
+
   num-cs:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:


