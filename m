Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17B22CF645
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgLDVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:34:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:11870 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgLDVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607117509;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Obbg1LLArFKyBR5Ma2dGukPbI+QAe9kyM+NVnQjJJ9M=;
        b=g9ZJsvyYAFFy3dJPfTT2GExI7cg6iUR46zg3ewRtsH1N/grR3JMZYnKucbqkyCE61Y
        2t1+N6o56QMrQ89BDCqOuhW2bnCQQr78i/Y0tLNAmxDPGI+Q3IdVnDKORZq4V4E9o/Mv
        QKdZvKxS/sy0SoIGHPe2etFw3oeYHNtN8jHE1hdeiYFykc7ZxErvIP5CKJ+FOXIRpopR
        /GG5caquu7N2xHGI/iojydJaMcWYLnCXcHsfGaa+F9gbjSMfew5ZvGmqnDLPO5iHJUav
        ccWMetWIu/mfgj5Hqja7rQXdwB1Ib2xaoxa3tUxzMFWCAOv07g5j3oMx1ItU898gtoy7
        /qrQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMnw47pB1A="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB4LVej8f
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 4 Dec 2020 22:31:40 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiXWKgu+RKvbUWCSy2pDktc8Uj6+PtWi0oc8tAgiDgoUFw@mail.gmail.com>
Date:   Fri, 4 Dec 2020 22:31:40 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <077C7A16-61D6-41E5-81F3-792B6B5CEC5E@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com> <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com> <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com> <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com> <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com> <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com> <CAGngYiXWKgu+RKvbUWCSy2pDktc8Uj6+PtWi0oc8tAgiDgoUFw@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 04.12.2020 um 20:19 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> On Fri, Dec 4, 2020 at 11:52 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>>>> Anyways it is debatable if this is a bug at all. It is just a =
definition.
>>>=20
>>> I respectfully disagree. Prior to the fix, your panel's active-low =
chip select
>>> needed to be described in the devicetree with 'spi-cs-high'. That =
sounds
>>> very much like a bug to me.
>>=20
>> It could have been described by ACTIVE_LOW without spi-cs-high but =
that did
>> emit a nasty and not helpful warning on each boot.
>=20
> That will not work, try it out. You will see that without the bugfix, =
your chip
> select is consistently inverted, no matter how you formulate it in the
> devicetree.

I have.

But please show me which line in my analyses table of my mail 12 hours =
ago
is wrong. Then I can repeat the test and we can discuss the reasons.

>=20
>>=20
>> I'd prefer if you or maybe Linus could submit such a patch and I am =
happy to review it.
>=20
> I cannot help you with that, I'm sorry.


Come on...

BR and thanks,
Nikolaus

