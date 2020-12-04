Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58382CEBE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgLDKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:11:16 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:16278 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgLDKLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607076502;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NUKU4zmJ3d5bkwtRSPd5QNRzGlv208KeCuDju9QIXgw=;
        b=Ajt4jpw/obgtYd7Ieu9Y00d9RJxzmUNw4w3gKTAe/QGEPeAVlEjFl1QLn+CjRCZBRR
        mklyYdPau36+MqkaF5hwqLjYdDdy2lOIDRu+nhaR6MnrScziCbwE0XOVdqOESBJ5hD5K
        l3lb5tyubcWKltYLT4WTiTKZeAG/dbaMpdszyWs+lMpHznkUHXUNPpK10EXYh5pEAdbg
        /r7Fw3T8ntjn18/HwWVYqPOxza2nW8xkB8OTlchRKV/e4sk5Gt4tuhY5SKW1nfjG77lP
        +/jMQr6cvWCeOvlU/qIbskkFYo+hIM3jCIOlxIzbozXE+5HKgEd3nNZXh9F25cwc+0J7
        8lJA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMnw47pB1A="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB4A85gpE
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 4 Dec 2020 11:08:05 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
Date:   Fri, 4 Dec 2020 11:08:05 +0100
Cc:     Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com> <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven and Linux,

> Am 01.12.2020 um 19:43 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> Hi Nikolaus,

I was about to submit two patches. One that reverts our "spi-cs-high"
and one that actively sets the GPIO_ACTIVE_LOW because that seems
to be the right thing. It would work with v5.10, but is it really
the right thing?

Before submitting I would like to clarify the rules.

Especially since it is the same discussion as before:

https://lkml.org/lkml/2019/3/23/131
https://lkml.org/lkml/2019/3/24/2

> On Tue, Dec 1, 2020 at 12:13 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>> Am 01.12.2020 um 17:53 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>>> On Tue, Dec 1, 2020 at 11:43 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>>=20
>>>> You are right. It is active low.
>>>>=20
>>>=20
>>> In that case, we have a very simple solution, just remove the =
spi-cs-high,
>>> and things will work.
>>=20
>> We originally had it that way and because there was a change in =
gpiolib we had
>> to introduce it.
>=20
> The current rules re. spi chip-selects in devicetrees are here:
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpio/gpiolib-of.c?h=3Dv5.10-rc6#n191

Yes, there is

				/*
				 * SPI children have active low chip =
selects
				 * by default. This can be specified =
negatively
				 * by just omitting "spi-cs-high" in the
				 * device node, or actively by tagging =
on
				 * GPIO_ACTIVE_LOW as flag in the device
				 * tree. If the line is simultaneously
				 * tagged as active low in the device =
tree
				 * and has the "spi-cs-high" set, we get =
a
				 * conflict and the "spi-cs-high" flag =
will
				 * take precedence.
				 */

It is not complete and a formulated a little in reverse.
A table would would be more precise.

And it is not the complete rule:

=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpio/gpiolib-of.c?h=3Dv5.10-rc6#n175

       /*
        * Legacy handling of SPI active high chip select. If we have a
        * property named "cs-gpios" we need to inspect the child node
        * to determine if the flags should have inverted semantics.
        */

This seems to indicate that the gpio flags can invert spi-cs-high. There =
are
only two options: invert if they are GPIO_ACTIVE_LOW or =
GPIO_ACTIVE_HIGH.

This makes IMHO much sense. But it seems that it was not implemented =
that way.

>=20
> This is the way I see things:
> - according to the current rules, your devicetree describes a spi =
panel with
>  an active-high chip select

I have now tested all 4 combinations of GPIO_ACTIVE_LOW/HIGH and =
missing/present
"spi-cs-high" with v5.4.79.
This leads to the following definition:

a) general SPI controller or if no cs-gpios available in spi-gpio

device node     | CS pin state active
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
spi-cs-high	| H
-		| L

This was the single (legacy) rule until v4.18 effectively ignoring any =
gpio flags.

b) with v4.19 and 6953c57ab172 ("gpio: of: Handle SPI chipselect legacy =
bindings") was introduced

it was apparently extended to (by code inspection of the patch):

device node     | cs-gpio       | CS pin state active
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
spi-cs-high	| -             | H
-		| -             | L
spi-cs-high     | ACTIVE_HIGH   | L (polarity inversion, no warning)
-               | ACTIVE_HIGH   | L + "enforce active low on chipselect =
handle"
spi-cs-high     | ACTIVE_LOW    | H + "GPIO handle specifies active low =
- ignored"
-               | ACTIVE_LOW    | H (no warning)

But I did test all 4 combinations with v5.4.79 and assuming CS pin
state L if the panel works gave me:

device node     | cs-gpio       | CS pin state active
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
spi-cs-high     | ACTIVE_HIGH   | L (panel works)
-               | ACTIVE_HIGH   | H (panel fails) + "enforce active low =
on chipselect handle"
spi-cs-high     | ACTIVE_LOW    | L (panel works) + "GPIO handle =
specifies active low - ignored"
-               | ACTIVE_LOW    | H (panel fails without comment)

This means there was some additional tweak to the rules effectively =
ignoring
the cs-gpio. Like before - but with opposite polarity.

Note that some legacy gpio flags are 0 (ACTIVE_HIGH) so it seems to make =
sense
for the ACTIVE_HIGH case like ours.

Therefore, only GPIO_ACTIVE_HIGH + "spi-cs-high" works without =
side-effects which
is the reason why we had modified our device tree and defined the wrong
"spi-cs-high" as a solution.

Anyways it is debatable if this is a bug at all. It is just a =
definition.
Which is not well documented anywhere.

c) now with v5.10 and 766c6b63aa04 ("spi: fix client driver breakages =
when using GPIO descriptors")

the spi driver does no longer rely on gpiolib to do the right thing but =
adds
its own rule effectively inverting things again. I hope I got it right =
because
the logic is now spread over several files:

device node     | cs-gpio       | CS pin state active
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
spi-cs-high	| -             | H
-		| -             | L
spi-cs-high     | ACTIVE_HIGH   | H	(breaks our panel with current =
DT)
-               | ACTIVE_HIGH   | L	(should print a warning about =
polarity inversion - because here it would be wise to switch to =
ACTIVE_LOW)
spi-cs-high     | ACTIVE_LOW    | H	(could print a warning about =
polarity inversion - because ACTIVE_LOW is overridden by spi-cs-high)
-               | ACTIVE_LOW    | L

The implementation with your fix now seems to completely ignore the gpio
definition since in the absence of spi-cs-high the panel works with =
either
ACTIVE_ definition.

Basically, we are back at a) i.e. the same as it was up to v4.18.

So in total there should be no automatic polarity inversion of the flags
by gpiolib at all. Only the spi driver should know that it has to invert
the parameter for ACTIVE_LOW to gpiod_set_value_cansleep() to really =
control
the CS pin state (H/L).

> - the actual chip select of your panel is active-low

Yes.

> - a spi/gpiod bug inverted the chip-select in many instances

Ok, there was another patch in between:

	138c9c32f090 ("spi: spidev: Fix CS polarity if GPIO descriptors =
are used")

Maybe this has introduced the bug - and we just didn't notice.
This is why I have added Lukas Wunner <lukas@wunner.de> to the =
discussion.

> - because of this bug, your devicetree happened to work before =
766c6b63aa04

IMHO it is debatable if it is a bug or what is the bug. In any case it
is a gap in clear and binding documentation.

> - 766c6b63aa04 ("spi: fix client driver breakages when using GPIO =
descriptors")
>  fixes this chip-select polarity bug
> - you now need to remove your devicetree work-around for this bug by =
reverting
>  f1f028ff89cb0d3

Before doing this I would like to see a table (like mine above) how it
should be. Definitively and finally. Agreed and approved by maintainers.

This table should then go somewhere to the .yaml definitions of gpiod or
spi or whereever it belongs to.

Then you can check if your code does what the table mandates and I can
check if our device tree does the right thing.

Otherwise we risk that I change the DT now and in 2 years someone else
finds that the definition is still not sane and tweaks SPI or gpiolib
again and I have to modify our DT once more (which costs a lot of time
to find the reasons of breakage and takes away a lot of work-time from
other nice things I would like to add to Linux).

What I especially wonder is why you fix that at all in drivers/spi/spi.c
if polarity inversion is handled in gpiolib.

BR and thanks,
Nikolaus

