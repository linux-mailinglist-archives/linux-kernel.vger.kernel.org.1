Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154AC2CFA31
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLEHHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:07:22 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:16524 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607151869;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rb1iNJtZtqIe696Y0BSi+sRPb127OZ3/RYM4etoAKCI=;
        b=eND5+E4kdAwiqFL+btnhIBP9lrf62VtnJIp3wRDwVlyjKJXDReoPdhtm69oYrEcWOQ
        Yo8LaoTI7ECDI9FRx1pQjpkG+8B6LHyEsixwgzsedQ6RvtXgsZjubxo/724PiBY/hJKz
        ziQImiEJfKk4lDJojSoxC5luEldOIyz1d5WG7KwtjWAk8MMsenT1a/A96IyIhMP48HF5
        PNIkiYk0txKDrtbQC4okB4C93+hMB9qVQZonWtlNG6IaX6+oD/zK0aKdht6uZdtwP+bT
        /xKbRbz2cDAERPqQO+Ied2tQOdb3bIl+SZhYKNEvomU90I2RvU5y84As6X0xyW/4SQl+
        bt9Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGHPrtwDCrvXQ="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB574Qjfi
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sat, 5 Dec 2020 08:04:26 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkdYgu+fyYm8aSCRuPeVe0EieyboZsWC=XsrRs5Tubog6nA@mail.gmail.com>
Date:   Sat, 5 Dec 2020 08:04:25 +0100
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED67B0A3-1098-4B4C-A4F4-EE52B0E5F1E3@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com> <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com> <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com> <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com> <CACRpkdYgu+fyYm8aSCRuPeVe0EieyboZsWC=XsrRs5Tubog6nA@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> Am 05.12.2020 um 01:25 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> On Fri, Dec 4, 2020 at 5:52 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> But what I don't know is if I can omit spi-cs-high and have to keep
>> ACTIVE_HIGH (my revert patch) or also change to ACTIVE_LOW (my =
additional
>> patch). This is arbitrary and someone has to decide what it should =
be.
> (...)
>> I'd prefer if you or maybe Linus could submit such a patch and I am =
happy to review it.
>=20
> It seems really ill-advised to have me do that since I have not
> managed very well to deal with this. Clearly better developers
> are needed. But I can review a patch and see if it makes me
> smarter :)

I find it interesting that so far nobody wants to take responsibility
for a decision and to write down the behaviour really should be. Coding
is the second step then.

Anyways you did not cite the really important part of my mail. So let me
copy it back. Here it is again:

> What I can do is to provide just a skeleton for the table that you or =
Linus
> can fix/fill in and make a patch out of it. Is attached and the ??? is
> something you should discuss and define.

Please take the attached diff, comment it here and define the question =
marks
according to your intention and then make a patch for the YAML bindings =
out
of it. (I can't do because I don't know your intentions and what to =
write into
the commit message).

As soon as we have settled this, we can check if code is correct and =
really
define if my device tree fits and which change it needs exactly.

BR and thanks,
Nikolaus

[slightly edited]

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml =
b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1b56d5e40f1f..4f8755dabecc 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -42,6 +42,30 @@ properties:
        cs2 : &gpio1 1 0
        cs3 : &gpio1 2 0

+      The second flag of a gpio descriptor can be GPIO_ACTIVE_HIGH/0
+      or GPIO_ACTIVE_LOW/1.
+
+      There is a special rule set for combining the second flag of an
+      cs-gpio with the optional spi-cs-high flag for SPI slaves.
+
+      Each table entry defines how the CS pin is physically driven
+      (not considering potential gpio inversions by pinmux):
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


