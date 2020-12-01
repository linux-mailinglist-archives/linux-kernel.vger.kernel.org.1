Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97692CA519
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgLAOIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:08:16 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27935 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLAOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606831524;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=J7AKPx0mAAtqxKULqYMJrpgQMcWGlg7fBLA8fAfxJ9o=;
        b=GJTaJk0j9J0DtjTbt1Ypi5NKK7gqDBO2tS4+/AgN7xPpKAZTzmYFAdwtol4Ip/Uuvn
        Y5jIP9PRLkBIJYWA3r6oJ2qySAuRigyT92cMWeUNcbp3zciHVm++4foKdCvPfpWiQyJ2
        ugBUTcIEDeWr8CswTBLlAj7/WwivUZ6JVWaj2UfArALyUsMG+2O+NKYds0g6XkAY/7Lq
        DbZLBdx0T0zYLeSx4qBp3t0rQ6we4Q8y6+9aRTJfKFQOnU8KQdSAeyH/IOW988SNg/Qs
        g0L6zauKeujcv1y1cpaNDB1tJal7u0KwZ1mQ5H9o34zYOS3ymNtYZo0q4bxWTLd058ib
        BmHA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCz0tZci65gKwSHSOzPCVVBaQfKyHICBNIH6DBKP"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:26a9:5c00:580e:6fc8:ca54:f161]
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id N02faawB1E5FUcP
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 15:05:15 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20201201121620.GB5239@sirena.org.uk>
Date:   Tue, 1 Dec 2020 15:05:14 +0100
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 01.12.2020 um 13:16 schrieb Mark Brown <broonie@kernel.org>:
>=20
> On Tue, Dec 01, 2020 at 09:59:43AM +0100, H. Nikolaus Schaller wrote:
>>> Am 30.11.2020 um 21:13 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
>>> We knew that there was a chance that our fix would break something =
else.
>>> But hopefully "it fixes more than it breaks"
>=20
>> Then it should not have been applied to mainline but fully worked out
>> and tested.
>=20
> If you want to see better testing of things in mainline please
> contribute to the various kernel testing efforts that are out there,

> there's a huge range of systems out there using the kernel and it's
> simply not realistic to expect that they'll all be covered, the =
testing
> effort for the kernel is very much a community effort.  If there are
> things that are particularly important to you the best way to ensure
> that they are tested is to provide that testing yourself.


Well, having a working display of a portable device that has mainline
Linux support for many years is particularly important...

BTW, I am already part of this testing efforts out there. Because I test
almost all -rc when they arrive. So I just did what you propose,

And if I can locate the commit of a regression I write bug reports
like this one.

The only thing I could have done differently is to always test based
on linux-next but that is a less structured testing environment and has
its own pitfalls. But that would have revealed the issue only earlier
but not with less effort or with a quicker fix.

I am not sure if =C3=ADt is realistic to dream of some way of =
informing/contacting
the potentially affected driver authors/maintainers to run a quick test
before it is merged upstream.

To be clear: I do not expect that there are no bugs at all (for that I =
know
Linux and software far too long). But I do not expect regression of the
type hopefully "it fixes more than it breaks".

Well, for me it (apparently) breaks more than it fixes. So the easiest =
fix
for me would be to revert the patch. But I am sure that then you are not
happy with it...

So let's set out for a better solution.

BR and thanks,
Nikolaus

