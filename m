Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5D2CA890
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgLAQou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:44:50 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:27478 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgLAQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606840917;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Pnd9RyOkaw5mK5HLX0+EUHATeM6rpD28J4eLpJ4iBb0=;
        b=e427UWmKAIjAebUsji6LShlrpMdBLHOddM79UGQG5RG7RyO2aDTzOhlZOspd1vKwSC
        PE9JoFsO4qGKhrCqrkn7cWUT1X3ECGWvMHvlt18uYLvQxcB4LW5SInunkEE0iDA7jNk/
        PjYagA+cG+5nC2SXj+L1QCP8IEwk3G11IhmxpuR5FnDLsA/YJNo3Orxm1KAi6m7BtAxO
        JuZaUvHQ52EHC+hTZE3tmrTGXiJ/p5K3KvanIbl5KjBcthj801vclDtKm5McejEVhQ8F
        5BY6DaZslRMU1Y4Wk7vzM4dY6JqvjlDSEOhaz1AZ64bCMEfq5IXjcW1V+996ztf6jPnd
        E+/Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1GftVWA
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 17:41:55 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20201201162035.GK5239@sirena.org.uk>
Date:   Tue, 1 Dec 2020 17:41:54 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D0E8CDA-96EA-4900-B5B2-0AD371EAD046@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <20201201162035.GK5239@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 01.12.2020 um 17:20 schrieb Mark Brown <broonie@kernel.org>:
>=20
> On Tue, Dec 01, 2020 at 03:20:12PM +0100, Linus Walleij wrote:
>=20
>> The reason why I shoot in the dark to convert all SPI
>> drivers to use GPIO descriptors instead of the global
>> GPIO numberspace is detailed in drivers/gpio/TODO
>> so I will not repeat it here.
>=20
>> I don't know if much can be done about it other than
>> having better programmers than me at the task. Or
>> less tired when they write the patch. etc.
>=20
> I think the problem here is more to do with where we started than =
where
> we're going or how we got there - things have been glued together or
> happened to work in ways that mean I'm not sure we reasonably =
understand
> the situation we started from or all the requirements it has.  As you
> say I'm not sure anything beyond throwing the API away and starting
> afresh would really help here, but that's not really how we tend to do
> things for a bunch of very good reasons.

I think the key problem is GPIO_ACTIVE_HIGH 0 and GPIO_ACTIVE_LOW 1
in device tree blobs. But that is so fundamental that we have to live =
with it.
So I guess that even a new API from scratch wouldn't improve that.=
