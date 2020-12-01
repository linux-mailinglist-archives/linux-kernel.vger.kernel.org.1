Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E282CA880
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgLAQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:43:19 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:22204 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLAQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:43:18 -0500
X-Greylist: delayed 11185 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 11:43:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606840766;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=F9OEZ/4wExuM13YosgjA9lOc+idfvAEF031dldFZwYs=;
        b=R9UBl7mSOsonQBc8ZVGRntXI+2MbMtxJfRgl00JwUaQDTsG6Uke90dJ+YszMmzuQV2
        fvQKHInxA5GBHv11c2RViodE48lAxJUcVMz9udcfUAQ7YxVCHCIh2y1MiAO50wsby8y3
        t+ylecJo+f3VT0j2emo1M+Fyjmr8LThQ6E8IJENuwWYWphf2HR3snDrR0JvdteZb2/41
        SOJpF+6BFxiBH3hurtwWIdax2+ir4LW3kUfFE/412rs3WALWC5yY5HTxlvlchHA1KFuL
        njBku8b0yfJPb/dO8CBALKBrGinB7SydS7qbtIaqcMjHSvFLJ4d3I6AlrsXhhT7aU5tZ
        18eA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1GdCVVd
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 17:39:12 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
Date:   Tue, 1 Dec 2020 17:39:11 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 01.12.2020 um 17:10 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> Nikolaus,
>=20
> On Tue, Dec 1, 2020 at 9:38 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Let's work on a fix for the fix now.
>>=20
>=20
> Are you quite sure the chip-select of the tpo,td028ttec1 panel
> is active-high? A quick google produced a datasheet which
> seems to indicate that XCS is active-low?
>=20
> See page 17 here:
> http://www.lcd-source.com/datasheet/TPO/TD028TTEC1.pdf
>=20
> It is of course possible that you are driving that line behind
> some inverting circuitry. Hardware designers seem to do that
> all the time, if they need to go from one voltage domain to
> the other, etc.

You are right. It is active low.

But that is the start of a long story...

It was introduced in DT by c2e138bc8ed80ae
with cs-gpios =3D <&gpio1 19 0>;

because the third parameter did not have any meaning
back then, AFAIR. It was ignored and drivers did initialize
gpios with inversion if needed.

Missing spi-cs-high; did define active low back then for spi-gpio.

In 3a637e008e542b8ebdc2ceed616b229af0462b14
the "0" was replaced by the constant=20
cs-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;

keeping the DTB unchanged and compatible.

This did work because there was still no spi-cs-high;

Then came 6953c57ab172 which mixed cs-gpios and spi-cs-high;
and made use of the now wrong GPIO_ACTIVE_HIGH;
A special logic converted GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW
in case of spi-cs-high; being present.

A long discussion revealed that the only solution to
stay compatible with old and new DT/kernels was to
add spi-cs-high; and keep the wrong <&gpio1 19 GPIO_ACTIVE_HIGH>;

f1f028ff89cb0d3 did "fix" this by adding spi-cs-high to the DT.

Please note that apparently we were already confused about what
the right value should be (ACTIVE_HIGH or ACTIVE_LOW) in 2019 but
the result was working until your new patch appeared.

Yes, it could be that the problem introduced by 6953c57ab172
is just coming up again with your new change.

On the other hand I remember from the old discussion that changing
a DT is "forbidden" if it is not upwards compatible with earlier
kernels. The driver must take what it gets from (legacy) DT.

BR,
Nikolaus

