Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E962CA956
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgLARN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:13:26 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:13730 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLARN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606842633;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9uwy9r0lap3FWY5ONB/pGHuCCG4C6X6wgSE7++21aQ8=;
        b=fLxDdh9TyQlY5uIsA1j7YHuoQ893mBQspnLM3pc42o0LJBy56Ttbaxztx2JxbRetFy
        L/a86eDOsXwq7uZsVGavB7VBBCjrxxEKnV7TwLDKhWfYWh46kVMF0sHtf+Zst1QwCidN
        54qaXzL/IwH/2gZ9MloWMQVyVRI48twgLzg7Wvl0Mbx29Sy4lmSdCH0p1XophzsxLJhG
        PGFyf1O5V8MWMJCo6uWW6jo6B7+3BfJfFccZbcVMj+yJMg/cxGXemdJm/IQiwIpnr1cD
        kwIEbTpX9/HUvvcnltfngpAxWw17xI1fhDMNsAA977Uv6dwc+ff6/4Vy+nHHS5vrz5Dv
        G2jQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1HAIVcK
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 18:10:18 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
Date:   Tue, 1 Dec 2020 18:10:17 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

> Am 01.12.2020 um 17:53 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> Hi Nikolaus,
>=20
> On Tue, Dec 1, 2020 at 11:43 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> You are right. It is active low.
>>=20
>=20
> In that case, we have a very simple solution, just remove the =
spi-cs-high,
> and things will work.

We originally had it that way and because there was a change in gpiolib =
we had
to introduce it.

See: f1f028ff89cb0d3

where we were forced to introduce it although I had preferred to not =
change DT.

I am not sure if DT maintainers accept that we revert a DT change just =
to
handle some change in a driver. Usually they insist on fixing a driver =
and
live with the DT. DT is carved in stone or could be ROM...

So you could try to submit a revert of f1f028ff89cb0d3 with a =
description
why it is needed. And please make sure that it is also applied where =
your
patch is backported to stable. So it should have some

Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO =
descriptors")

>=20
> In case of SPI CS gpios, the current kernel ignores all
> GPIO_ACTIVE_HIGH/LOW
> flags, and uses the presence/absence of spi-cs-high instead, to
> determine active high / active low.

So you mean you are just restoring the behaviour before

	6953c57ab172

was introduced?

The alternative is that you restore the cs-gpios + spi-cs-high semantics
as defined by 6953c57ab172 and everything is fine without touching (our)
DTS (again).

BR and thanks,
Nikolaus

