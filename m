Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9344D2F6F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbhAOAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbhAOAZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:25:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F14C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:24:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j1so3794172pld.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TdmAjjbtJF5wRzKvda9PeyjyQtoU5kLYZsHj/4RXnp0=;
        b=LFiz0CTZdFAddJ+lU674UMUx1/MzoDbGQpOw7YhY8Je4hPxYNsARPQe/QoatXncRSF
         QtfOsBOR/A/czQM1P2NgAMk4r3QtJnfnV7mSl0JznADYpRkL9BjF0/QYJQvJQ+To8iC3
         mbbru/+09+oYLgzqsRf+BUqb32C9X1whNEFEEQjdXJvskmpo5+YyZ2zN5Adq8GPc7wUh
         ccoOgqOP3Pk0QN/sGct1tzrLMFkNgXdhHqydhTdEWpGzq7W4hqy54Aww5EquaQmL5re8
         SaHtFb0WdPh6Ocv79F8bW1+4lAJmT8U0nRBEahiibbs3tpw1n9+quKGW9HoRiGPi1oFg
         R5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdmAjjbtJF5wRzKvda9PeyjyQtoU5kLYZsHj/4RXnp0=;
        b=YlTiZxo4drLvT46FqcafkuwDHaAHBqSE6G6Lnm/6IEIcOx8BUolpzy2jwAJikG1TJR
         m3l+qMl4UAY2IqqnPp4OlSYRQI3r2tqYhFrZN8EYhTGBoxGeH8gNQqJTYUajTSYPQqDc
         WBN4LkQ6OB4x9aBCAP2b+jHjQyZJqZ7JiV/lddcx2GIU3KPdZSJH195Zwvvsp7yHvlQr
         NKdacTrPl3hUDK3D0r/x7b7cH6rNJd+g7Q7CAsSavmNZPj77cVIhvORyBrfFhSzTbFJf
         yHU5sc6jpOvZYHgUboC4W0jJlGFmfIFtg4EAXSiQSJh0mAGGIMX9uHKgkWf/suZNE0Wl
         rGIQ==
X-Gm-Message-State: AOAM533AooA4cL/zFB3dskCphov70ZGg6Dx78xFYKLJVXOGi3gkXrlct
        LFnHgY1FANCusm/ZLo8dzW4=
X-Google-Smtp-Source: ABdhPJyo1BXqBjy0dKt1TTK+2/IN5a9CH0CrSpJDxSInw1O0MWq2FBRWkqwJnP9Kj0EdpwV9IDhRxg==
X-Received: by 2002:a17:90a:bc49:: with SMTP id t9mr5254511pjv.95.1610670270588;
        Thu, 14 Jan 2021 16:24:30 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id p17sm6093072pfn.52.2021.01.14.16.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 16:24:29 -0800 (PST)
Date:   Fri, 15 Jan 2021 09:24:18 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <YADgsq8p/4TNLPIM@shinobu>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
 <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
 <CAHp75Ve3QqLqe2sQhNgdrDfKm2uSwXFwMr5_GgGf3tiuCp2DBQ@mail.gmail.com>
 <CAHp75VceqwbfQ=z34K=soKu4-qvLVEtobFg1sO4jukRcT7BXBg@mail.gmail.com>
 <6437080014a3a9af63f2c50b620f389c1f104e91.camel@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p87OY6suqwpoDpIz"
Content-Disposition: inline
In-Reply-To: <6437080014a3a9af63f2c50b620f389c1f104e91.camel@petrovitsch.priv.at>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p87OY6suqwpoDpIz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 01:03:14AM +0100, Bernd Petrovitsch wrote:
> On Wed, 2021-01-13 at 14:21 +0200, Andy Shevchenko wrote:
> [...]
> > WRT x86 I run the search
> > https://pc104.org/product-search-results/?kw=3Dx86&post_tag=3D&product_=
type=3D&specifications=3D&pc-bus-technology=3D&user=3DFilter+by+Member+Comp=
any
> > seems like all of them are based on Vortex86DX.
>=20
> There are some real/true PC104 boards left -
> still in production - with boards (though
> they tend to loose features like
> "memory-mapping over the ISA-bus").
>=20
> One is a - according to /proc/cpuinfo - a
> "Intel(R) Atom(TM) CPU  E3825  @ 1.33GHz".
>=20
> Sry, I cannot get the product name.
>=20
> MfG,
> 	BErnd
> --=20
> Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
> There is no cloud, just other people computers. - FSFE
>                      LUGA : http://www.luga.at

That's part of the Bay Trail generation isn't it? Are those processors
still manufactured? My worry is that although there are boards still in
production, they might be simply using up an old stock of parts. The
question becomes whether these will still be produced in the near
future, or whether the companies are just using up the rest of their
supply.

William Breathitt Gray

--p87OY6suqwpoDpIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAA4J8ACgkQhvpINdm7
VJId9w/6A+DGCMkWJ5alXd/m1Qnkwc6qTnTh940LvNunOvTtFKwcc2KoCbVzXnAB
5r43kdSNqMwHqf5RShAmF5NpqQeU01h7D/V4MKzssVdtoVBfstzF9yblp02YF7Ko
kyml39BudfZ3MMqB5rQ2a4Chuej/WhHjQAoSMps7KPD43vr3YOw3n1PVaEeMtJKZ
rMNEA+yyU36joa2HrzjuQhfnYwK81oeJMY7+2P/aQg+4I0oOYNSwy4S6+8XL9+9Q
SPLMzRRPrM1x9go2zZyVPAWqbee6k4ci3Qb/bwQE140lG8T74J2lX/irhQtX1vru
OYtiablV8j+PqruOpShxEOCyokpH9YauNzs15cQpgrhVHDrkVV5XWO18w/twKgOU
P9goc7zzUOmlDbBipySiHcpLzdv+8Q/aesXz+AGfKiOZOeA44LrpBwcoi5NRAWzH
+A0lmPshYNC5djSOPYtTKy8KeDP55GMRbRbeDVnBaJrLhEY+lD0U3LVb69JV19lu
rb1DY5/WRuHdp1MoCwE0KS6CBwanzSRaT0BKjA4eBONrw5bu/YcZenA4S18rwP66
waSre1h262DNQ8sJlLcas29/qMEWHjIUeyvjP5wp3GtHQC7ojBRDGu5TfzIGBr7+
AYcpn5kCKKAXucug+yDi9vWcVbujclH+KCe6PpoYN3N2JPcnhak=
=dpc8
-----END PGP SIGNATURE-----

--p87OY6suqwpoDpIz--
