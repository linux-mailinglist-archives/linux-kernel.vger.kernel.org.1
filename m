Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C923B2F4B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAMMb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbhAMMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:31:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FEC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:30:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r9so3646295ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qy2n0EEDF/FIPv3Pjpgkrjv/e7EmHyQ07JOMBlAK9gc=;
        b=gWIe/OZx+ut9emsJYi4FUSOeyMRsbSg1TgDmmceyc5HZwcopY6Ze9fXZBLextW/X+D
         UeCeFrR2FszDUAQiwRKRnrKXs/f0S4oTC3ura65e0NMnX25fYf272bUsmxfy8Hka7vg+
         2Mkx1ro66wsrp7Y8VWsBxkpmfjEaE+fQ6xDhORYvpDe7yO0MDCEO0Xik3ANSvvTcxaRB
         omxuvkfYbbS3X9irycc2dwvGf6AIDb911TmDHP+EJ0G4FsAE80hxOSSnl9FptW62UFEC
         jYDpUEo2OJMP+3DQnJmoBx4aNAk6Qskh3xllJn5xm9nKNw2dfq8ES954fBOp4oiA5GdZ
         i2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qy2n0EEDF/FIPv3Pjpgkrjv/e7EmHyQ07JOMBlAK9gc=;
        b=IDkdPOSy9+Iqsgm/FN7SQBNLXyfoL1Z5G28yyCQPeaOEI8hRso50YQciJOHINtG45D
         dqVc1Mbku+B7ROHrS8O6v3oatTb7nv0W83SxDToI92WwBS8hmEMrcjrsGe76lMcCZipa
         gQuNPaduu6xePGfw88RLJoA97QiLJS2HmvuO28+Jekqf6K9Lf6vabzuUOV2F15ZRD7jr
         awXIfLj0OzoQ71Jc3/h4f16desKNJwyHdn5V5QF8c0SnGkmdPAgKGPcSizrYxp83qEii
         vF+k8bx/M2MCrqWk0VztHhH1C0f9alW2if/DHxEXXAORL/WXRzWMhfmPi/7NadYFgsAu
         XkKA==
X-Gm-Message-State: AOAM530UwLYjyqtldmYEftwelKCnU4D/wWaOti6MUfgnuJLdhIx8QYC5
        Vd7AH4t8tbDvVt4yFulthJM=
X-Google-Smtp-Source: ABdhPJw3CfCDPyXHI9c7glMB6li8HciyUIXwUkOxRUfs7DHf4hBFHnUmdCstrIQBWU4VQucFnjqpxQ==
X-Received: by 2002:a6b:db01:: with SMTP id t1mr1546900ioc.10.1610541044564;
        Wed, 13 Jan 2021 04:30:44 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id t17sm1142070ioc.8.2021.01.13.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:30:43 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:30:28 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
Message-ID: <X/7n5JQLQrBLKGaf@shinobu>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
 <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UmhiVe9cN4Tq8lpv"
Content-Disposition: inline
In-Reply-To: <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UmhiVe9cN4Tq8lpv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 01:02:20PM +0100, Linus Walleij wrote:
> On Wed, Jan 13, 2021 at 11:27 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.com>=
 wrote:
>=20
> > > basically 486 but have a few extra instructions - probably just cpuid
> > > and (IIRC) rdtsc.
> > > Designed for low power embedded use they won't ever have been suitable
> > > for a desktop - but are probably fast enough for some uses.
> > > I'm not sure how much keeping 486 support actually costs, 386 was a
> > > PITA - but the 486 fixed most of those issues.
> >
> > Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> > (486 core + few i586 features).
> > This is for the embedded world and probably not for powerful use.
>=20
> What is the status of PC/104?
> https://en.wikipedia.org/wiki/PC/104
>=20
> I have three GPIO drivers for PC/104 machines and these are for
> embedded industrial usecases. I am curious about what CPUs these
> beasts run on in practice? Are they getting upgraded?
>=20
> Paging William, I think he work on these daily.
>=20
> Yours,
> Linus Walleij

I don't really see pure PC/104 systems around that much anymore, but
there are still plenty of PC/104-Plus and PCI-104 setups in production.
The PC/104 form factor is popular because users can stack PC/104
compatible modules easily together to build custom solutions; see for
example the diagram on this page:
https://www.advantech.com/embedded-boards-design-in-services/embedded-singl=
e-board-computers/pc104-and-pc104-plus

As far as the CPU is concerned, these systems are typically for
industrial applications and run CPUs geared for low-power consumption --
you're looking at processor series such as the Intel Bay trail
(https://www.winsystems.com/product/epx-c414/), DMP Vortex86DX
(http://www.diamondsystems.com/products/helios), and AMD G-series
(https://www.advantech.com/products/1-2jkltu/pcm-3356/mod_0706f4d5-2e44-473=
a-a7b7-53bd1a7bd1a0).

TLDR; PC/104 is certainly a niche market focused on industrial
consumers, but the form factor and devices are still popular and
upgraded reguarly.

William Breathitt Gray

--UmhiVe9cN4Tq8lpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/+58sACgkQhvpINdm7
VJI8BRAArRPORTMYpY/tyUB0frIrCrrKW42Iu8h+qE4a9snxWF+5V6Iul58auY9e
AQXFU1TUYcFHKcNglXb5YzGJ8zoafXl7RPAE7DKIcPIzIS8MAh3+rEXvRFdTcJ2s
KE9bwo0+uBg3qu3YqKccWbTKT7gAKIZmAGKOYGQpxmRGYfiYqXb5Fb0VPD/ColAk
b38WMUIBhXAo11DmHuGsGgah1Cz9H4blRU4fmUkw2jyhtGiTYRnTytv0Q76ZV+LY
1zH2eGPsd6RFsKeE3TWJQx6jDZI26DLvPFYmam6R2acNUdYGgH69izmRpAkVa/JJ
3ZIuWVctVUpm58JjjJ9rjekzZAHIOiw9wIRajHV3NCMjNBdJgDqYNVZjRFvF0WCZ
s3kMhpxwURkefPUecHkQV7SY0NKZQH9noH44aRw0+M9FDSASwtJLDhOAaMSbgSA+
YCr4DsDe94I5HxpJNIAiBhAKq28NISSAorOlFFbtvDbXuzB4DHBsogiDCv1BbBCV
jce3c2eRO/eB1fOgybtozGAizkPu0HloKgpOui0yPwjkowM4v/SZP9CX5T/GgxMA
qt3c5y2wr19F1e9GEcjbObPW/hiYFRGkKxUCcQYZpdpsh4chNBJZDGUwvl6pjjtQ
uTrqZyRll7sjCFcqE6FnNEOe6G+QL+fwQ5DlVnhVDQC6YiSgX04=
=c68M
-----END PGP SIGNATURE-----

--UmhiVe9cN4Tq8lpv--
