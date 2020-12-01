Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942382CA411
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbgLANkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:40:52 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:23567 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387761AbgLANkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606829819;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=p09wCgfnFWECw5za2RIZ8yumoZ8WHAQjdDDc44v+u6o=;
        b=Ls1dnbweERfPhU4z2OJhk1QeVZhWnK6CR8TZmNzPH4EIcRdPkb/p2myeEv+E+F+JrX
        Pd6Ep1zE6rb5YVf+QaQfYwPjbPz1Tgd2SNiXCP9iuzdapqSkDUW/5hiNLit61mmTU83S
        ZfjoFf3Hlw8bldZhU772dW+qWB5CVDGH6MASwCNuAKQAos7yLCBCoqOU4Jx0RpukaC7d
        5IjnOu9jnOMcIHnqpJBdLc4t2wZO5HZNssF/D9R33wMA1Eyv54G5140FzAvnx34fi2Th
        0fzFvOyrS/16CPxSzxzGZ5wa4GeC2sUHQpHHIXWI2l+5dVorjQlYRhXeipwh/h0k1qGt
        Wibg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1DWkUP0
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 14:32:46 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiVoj4Gpid5W10pJfiE1FWY=294TJ4fE=CDG4=HwH0WrJw@mail.gmail.com>
Date:   Tue, 1 Dec 2020 14:32:45 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <460191B6-EDD3-46DE-A1ED-47F758F111E8@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <CAGngYiVoj4Gpid5W10pJfiE1FWY=294TJ4fE=CDG4=HwH0WrJw@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

> Am 01.12.2020 um 13:41 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> On Tue, Dec 1, 2020 at 4:04 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Then it should not have been applied to mainline but fully worked out =
and tested.

Well I only complain because you wrote that you knew that it may
break something else. So it is known to induces a regression.

But I did not know until I got a report from our own testing effort (we
run a vendor kernel and do tests all days over the week).

So I had to bisect what was going on. There could have been 100 reasons.
Took me several hours because I had to look at the display to see if
it is on or off after boot. There was no simple shell command to find =
out
and let the bisect run over night.

Maybe printing a "please check your spi setup" in spi_setup() with
a comment hinting at your patch would have saved me a lot of time.

>=20
> That would be a reasonable expectation of a product. But Linux
> isn't a product, it's a hugely complex, shared system, which may
> form the basis of your product. The core maintainers aren't
> superhuman, nor do they have access to the 1000s of configurations
> and devices where Linux runs or will run. They do their very best,
> but if every change had to be 100% tested in every possible
> configuration, then few things could ever change, and Linux
> would slow down to a snail's pace.

> When your product is based on Linux and you pull a newer version
> off kernel.org, it's not unreasonable to expect the occasional
> breakage. In my case, when I moved from 5.7 to 5.9, some of the
> things that broke were my network chip, and most SPI drivers. That
> was a bad day, most pulls are trouble-free.

If it were occasional it would be good.... It is not the first time
that I have to do bisect tests to find what did go wrong upstream.
Even in LTS kernels and some of my fixes were backported later.

> I believe LTSes are more stable than 'stable releases' which are in
> turn more stable than RCs. The choice involves a trade-off between
> features, security and stability.
>=20
> When you do run into a breakage, complaining on the mailing list
> is good, but posting a fix is better :)

I usually do - if I have the time to go the extra mile to fix something
what somebody else did break. But I need to have a lot of spare time
if I have no idea what made the regression for a device driver where I
know that it was not touched and have to study the details.

And for me it is much less effort (hours vs. seconds) to do a revert...
I could submit that as a quick fix :) But then you are not happy.

> This is my layman's understanding of the situation, I'm just a user
> and not a maintainer.

Me too...

Well, I am sort of maintainer of a vendor kernel that tries to
follow linus/master and fix things before we release an LTS.

That is why I need a solution and can not go back to some LTS or wait
for the next one...

Anyways, there is still time until v5.10.0 to fix it better than by
a revert.

>=20
>>>=20
>>>>=20
>>>> What should we do?
>=20
> Hopefully I have some time this week to look into your breakage,
> I may get overtaken by someone much more knowledgeable than
> me on spi-gpio.

Hm. Then we are already two of us who have not much knowledge about
spi-gpio...

Hope that you have an idea soon. I am happy to test any =
suggestions/patches/alternatives
better than a simple revert.

BR and thanks,
Nikolaus

