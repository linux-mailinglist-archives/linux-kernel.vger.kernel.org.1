Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8C2A8478
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKERKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:10:55 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43185 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbgKERKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:10:55 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 18A36CB3;
        Thu,  5 Nov 2020 12:10:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Nov 2020 12:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5jxJjZ05MEHIANgmApYUmyWu0vB
        OAbf8q73SX8dSjVo=; b=sTqb2lod+jH9Lf64STrSRmL1IV4y1PQJgq7jUeBDYb0
        9t1MG0fTqj9ZSk/Ypj+8zUuSl4RaBtDuKpNriDeDvNUkeGnjhorBZJaRXfMtOMc7
        AGOvSUwocttyQ1ktvrgEBw55RC+sLdOvcZ004AV91gnxFIaIS0oSENIVQEDqe/6/
        AXB4+hYfpOZlHM6PON9M6fXYMQYnP0qE5PpBmlrr25ozjAMsbF3ufIvqzrKP5PW6
        mdBiQWRhZTtSp8mbFkfI8dli1jTpe7onFzUxqoACrYY4wm2qLQG+cWJ7jZgKZgUq
        OzpCJ5XvTkYPoYgZsoqpR1OxAZgPvh/0guNOduvMbJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5jxJjZ
        05MEHIANgmApYUmyWu0vBOAbf8q73SX8dSjVo=; b=ZXp4Cxd5vfaYwErZWnkZgu
        t4wuTG1admJdfBTe4z8OC21YoY9yt01dc/p12PwsLg9Htvs/Sk6kSbwgFK6cxyfQ
        x7F/2HZ/6jUOBLMY9yo/kKnlK5JxS3w2gwOQ2LnCrzBBITVd2Ip+1fbUJ5geV7fT
        Zy4Uxyu5/8U9pzwWHXq+9RKRlcdcdnQVsY9gbRA6UQ8F/+ahWmCGtXWiNwZ72y3L
        VcP+fAzWSHuHTIQ0FGoyOcbJSnGW+yIffFt5ynFhl2+d0DCcrrtzmdFtM/Ml9kFx
        PwMAciLH/foLN1Dbw6xfnkNBbTocAU/wk1FBa2IM3pEOeRXVxCSE3dGeKxuLGydg
        ==
X-ME-Sender: <xms:HDKkX8eh2j0u7mYxzVcnZLvkQr6FYGollwFmf8Z4kSuX8wLEGYkUEA>
    <xme:HDKkX-PH2cC7U5Ra48-2nk_FlPUuL17POVN4i7jHE5W0XzFDz_8bTTmusU9yKJQBo
    MRyoZETmwNtLT-Dg8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:HDKkX9hl9Nw6c7j4HSZTR0YtR3Xw3jSxc6CoTe18qQ0Ei1iyjObpYg>
    <xmx:HDKkXx_Zkh9XOtWuKgztgZqwLKiMpae2zikllMilKlKN1_NteyDQ1w>
    <xmx:HDKkX4sQcKeRhqLI5ZfJM59X1UvNuGpI5M3Tg32yUGWRXY9tslqcwQ>
    <xmx:HTKkX0I-JDQdaLk8GO7fXDio1gD60FIWDuyQuueFWs45mevJ0PrVjg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 865403280393;
        Thu,  5 Nov 2020 12:10:52 -0500 (EST)
Date:   Thu, 5 Nov 2020 18:10:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Message-ID: <20201105171051.ducvxcdj5jfarmgn@gilmour.lan>
References: <20201102100157.85801-1-mtwget@gmail.com>
 <20201102100157.85801-2-mtwget@gmail.com>
 <20201103113743.5764tj2ryrht4dfs@gilmour.lan>
 <CAHRgzyOao=w6Yyqqvi1Z26=rfJgumkzDbWLxD+_5uaLmyAWiQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmawvi2wmpsvk5t4"
Content-Disposition: inline
In-Reply-To: <CAHRgzyOao=w6Yyqqvi1Z26=rfJgumkzDbWLxD+_5uaLmyAWiQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hmawvi2wmpsvk5t4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2020 at 04:07:48PM +0800, Yu-Tung Chang wrote:
> > > +&uart1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart1_pins>;
> >
> > This should be already set in the DTSI
> >
> uart0 as the debugging interface, uart1 as the external uart port,
> uart3 as the bluetooth.

What I mean is that since it's the only muxing option, the pinctrl
properties should already be set in the DTSI, so it's redundant to put
them in the DTS.

Maxime

--hmawvi2wmpsvk5t4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6QyGwAKCRDj7w1vZxhR
xeBNAQCVB/qARdv0RwBjl6dfLEq2diwyT9786Lf3YpJlgpQH6AEAlINTtnwGkvjJ
FL6ZIn2CEQ4GwRqfC83S/fJFuZDhIwE=
=WiD2
-----END PGP SIGNATURE-----

--hmawvi2wmpsvk5t4--
