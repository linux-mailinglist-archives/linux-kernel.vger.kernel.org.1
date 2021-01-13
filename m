Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB72F4BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbhAMM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbhAMM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:57:14 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A47AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:56:34 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id b19so1284662ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rNuzfDqixbucyJBfEEGrnaFqREzLCkBFSEs4SJxEKMs=;
        b=qFturJkJNfUn2NK6Viah8adjhzok9r0ySy5XTi5VV/Vs+1uLE7pJxN+WjFPxtutUfb
         GyDUHwVDmmvL/LtqS5USgvLjsYpIC13QRGuUQCetfOR+oZi9n5R2EFhaRN2aeJi2CwSn
         F2okYQYGGdodeyqtjGTjTpXbAfc8jtpCBW9i7JHTWlYQkOK7r7oU/Gu5Jkp3MWJy4AYe
         rQVVUskRhSl+R9OsHaUfO0pLb6rGz2VouwrgB1ctL6JbcnIO+j3hX7iQtzVRXwVcFkeE
         KjSqYVd0r46pmWpEjwvxdYg/EAYDOLgb3ue4a4E+IXpG0AHEMN9ylqiA0tPHrYNLSljZ
         VEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNuzfDqixbucyJBfEEGrnaFqREzLCkBFSEs4SJxEKMs=;
        b=eJIDM62YOkJENyCeM3fPB6FkTv6Uh7AmAoEWhm+NKVkzojUGMstUY3ZonBMHQVLosF
         4SW+/Ih16MNsNOPe3VeWcHbfDjz7D8itSf6hsYY71056qNdD8HmmTmKVqru/VPxo2b3/
         MvUfrrdC6oS9q47PoOQLkns0RlvwGg8eN6UVPqLxlKgNlxJfDMs0LFl6aweg88pZx74U
         vpE9M9q9pMa5TsseF0+PGVmMgodOG/9bOYQiOpQhpaG4LDBDDwyR6jNg+q4XniRJxPf5
         Rrgup+Co/xYsKQT7t7EUFu0WJ86tnPIvrlKQ6W0MTvB9RAkHSa7uu1GjR3N8jENO3FZ8
         AfHQ==
X-Gm-Message-State: AOAM532lYhupb+VZMrdB6qNVbRxVTwDugfx85E8rabV4P0C13BZiiRIf
        XuANBw38y/NtUB6tQAOwpvI=
X-Google-Smtp-Source: ABdhPJzX3PQaNhI5nlCoBhKjDbUvi60NuhSQuyjdAz6QRI9OtmUia/EwNsyeNY4iu7NJvzeztMGAZg==
X-Received: by 2002:a02:8790:: with SMTP id t16mr2305492jai.80.1610542593836;
        Wed, 13 Jan 2021 04:56:33 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id b12sm1545060ilc.21.2021.01.13.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:56:32 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:56:17 +0900
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
Message-ID: <X/7t8avSe3BmYmiC@shinobu>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
 <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
 <X/7n5JQLQrBLKGaf@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KyX+UA7rekpD9BtP"
Content-Disposition: inline
In-Reply-To: <X/7n5JQLQrBLKGaf@shinobu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KyX+UA7rekpD9BtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 09:30:28PM +0900, William Breathitt Gray wrote:
> On Wed, Jan 13, 2021 at 01:02:20PM +0100, Linus Walleij wrote:
> > On Wed, Jan 13, 2021 at 11:27 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.co=
m> wrote:
> >=20
> > > > basically 486 but have a few extra instructions - probably just cpu=
id
> > > > and (IIRC) rdtsc.
> > > > Designed for low power embedded use they won't ever have been suita=
ble
> > > > for a desktop - but are probably fast enough for some uses.
> > > > I'm not sure how much keeping 486 support actually costs, 386 was a
> > > > PITA - but the 486 fixed most of those issues.
> > >
> > > Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> > > (486 core + few i586 features).
> > > This is for the embedded world and probably not for powerful use.
> >=20
> > What is the status of PC/104?
> > https://en.wikipedia.org/wiki/PC/104
> >=20
> > I have three GPIO drivers for PC/104 machines and these are for
> > embedded industrial usecases. I am curious about what CPUs these
> > beasts run on in practice? Are they getting upgraded?
> >=20
> > Paging William, I think he work on these daily.
> >=20
> > Yours,
> > Linus Walleij
>=20
> I don't really see pure PC/104 systems around that much anymore, but
> there are still plenty of PC/104-Plus and PCI-104 setups in production.
> The PC/104 form factor is popular because users can stack PC/104
> compatible modules easily together to build custom solutions; see for
> example the diagram on this page:
> https://www.advantech.com/embedded-boards-design-in-services/embedded-sin=
gle-board-computers/pc104-and-pc104-plus
>=20
> As far as the CPU is concerned, these systems are typically for
> industrial applications and run CPUs geared for low-power consumption --
> you're looking at processor series such as the Intel Bay trail
> (https://www.winsystems.com/product/epx-c414/), DMP Vortex86DX
> (http://www.diamondsystems.com/products/helios), and AMD G-series
> (https://www.advantech.com/products/1-2jkltu/pcm-3356/mod_0706f4d5-2e44-4=
73a-a7b7-53bd1a7bd1a0).
>=20
> TLDR; PC/104 is certainly a niche market focused on industrial
> consumers, but the form factor and devices are still popular and
> upgraded reguarly.
>=20
> William Breathitt Gray

Oops, I misread what you were asking. If you mean, are the systems that
run these PC/104 stackable devices running older processor series, then
yes that's typically the case.

It seems like newer systems have migrated to the PCIe/104 form factor,
which although having the same dimensions as the PC/104 form factor
lacks compatibility with PC/104 devices; for example:
https://www.rtd.com/i7/default.htm

I suspect the general trend in the market is moving towards these PCIe
modules because PC/104 ISA communication just lacks the bandwidth
necessary for many applications.

William Breathitt Gray

--KyX+UA7rekpD9BtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/+7fEACgkQhvpINdm7
VJLxTg/+LfTS1FQw5xmPAPhIhJJgfudjaIlxNNbBOTyQ4eBlR6sZ8Bl4qXg4IJFP
2PpgYcit+Y9R46AUNStKihhw7m8i3KPR3l2500MHdlSFBRRQs8b/yReYRK+22Mmp
kf2vI0wzv5MbslLPaBM0OA2X962Bg0AB8pj55+YqkCIekmFG3PBSqWJFLdFHMS1b
zvZzCGgcNrTGtuZsOp2FvDWfYUTx31Y2L+Bskm9BehQa8jLC6V+FH/trA5YIauqd
k539LPyvkAGgsbDM5Nn3vaH+Ewibzzzj1STe7tAtHYf7T1km1SSsxN2NqLdf62Is
YYAIMd4j9JPAPY+1Or2bkEX4wUnlhrdITtMrwqZY9WmiOt1nZBv/22CHSChkBOhl
nETvONf8Bkw/qfLK1PwOBSwY4czlUK+aNfj48j6WHw27DkhheHdTL/2xrIZ02GkL
3E0K1TNWQ1A8JuO94til6pxhjnD63ChJM3eOJTL/i1VNB8JrZmrBVn8kj4vBZoK9
VYw5DV2UDyhoMus93fNAHRyFdbsxDpZ1mjCFFWjCuNsm6SqSPbgFRmoXhhYG3Vqw
JKxU7tF7JlVJf59zc5o+BVLw3l9rFaPbTiTAmHnW/b+NP8vT8i1A0qyvHIJyl2Tw
9fjQQm3CjFFdqSNMcVged+74RWRjRbwM6eesNG/9Yri2jxgrvz8=
=4PjK
-----END PGP SIGNATURE-----

--KyX+UA7rekpD9BtP--
