Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404C82B8C28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKSHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:15:30 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35589 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKSHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:15:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E55D5C00F8;
        Thu, 19 Nov 2020 02:15:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 02:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=r9ogtAo3XhfvKOKYsNolAmPWauE
        4G+aRWIG5cjlau9o=; b=es0ai3aq8pOXMVmRuENaonI2JWLjAOBKco8Cv4DwkwX
        h9q8JNFNftOmJavzFrbscuE+UgYZRV9vzJUNTcqT95iL7B4ja+c/7IuK8EP0OMSz
        /eaFZn2pB01T/4ZiF5Z/alGzARAWLfGS+0QIAPUcAsYTdVgWKfhpv8QZNyR6y354
        LOigE1yOVcKtLw6vaYoyfSC6WrovsfzpvrrzZBElvjD2hd7TtgqNtxo8wWb69nIs
        mCRsFYZ3aXLUlyOsJ0/PDzpFSUhZCN8GykyTSckPnMjNUDXryWwhUfKxFOFSZOQ4
        eXr3Pvbg02MzRaC1lpWRUSeSmMQJ6CIxLxLWfYGqlfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=r9ogtA
        o3XhfvKOKYsNolAmPWauE4G+aRWIG5cjlau9o=; b=SJ82YAG53QJFraaLcVVu1h
        KHOBrfGNxSpFreUpquBtfRVt/UKqlGhct2LIayUBUPnXb/b2zsTr3gPfKqo6ffzC
        vhJVdI1aj0YR2m3ADAw1WK5xA+KeAvz9idf8U+sKoVlbw/xYz+oaXfePQ0Uv68dj
        PGpuIF51i1j/XUcZE4crC3IrSAQ0m89wqdEIvslnj4fzXeLYKUuQVrffYe6Z/RBd
        nr7W535Gr8APXdts3/M/WlpMKKEFuj2d0GycUXt1xGZBacIwgEAQMQ84CryCfWjQ
        5IvO/f8RI169M7y6cnAlt4bTikMvv1yDoDBfRvRk8v2aeEIVu9puVDTuxOZWaQqA
        ==
X-ME-Sender: <xms:jRu2X85JxG0AyleH1oNl7YCRGZYUPvH4WwUHEjMca4QKy1eTBmCIVw>
    <xme:jRu2X96cwAxb_zFaZivUlTvJmYKA9OE0HZ_wHkslY5gI9UPg4Ew88tfKjp8iH1O90
    1cOLWPeXtCj1SjaYaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleff
    gfejvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdeike
    drjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jRu2X7eW-pJq58UcIcDI4JeII0TqK1renNJ8APNwv9M1Sb2ec6Yxrw>
    <xmx:jRu2XxICsp-_WgcEKnjPlZmB2FiJ-e5ZMD15ZZn0s9ClvFoNjggBYQ>
    <xmx:jRu2XwLSgq1XSNqSH3vKEXfX5QTNww_wFPdpxIdD8_rQ6akM4sgufw>
    <xmx:jxu2X6h2SJC1ponELYdm5pTTtjxNf1d0HuBMYWkDvBhXk6jsKo1q_Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 853D9328005E;
        Thu, 19 Nov 2020 02:15:25 -0500 (EST)
Date:   Thu, 19 Nov 2020 08:15:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
 <20201118203624.7221ba8b@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yffm423zihwi5zdg"
Content-Disposition: inline
In-Reply-To: <20201118203624.7221ba8b@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yffm423zihwi5zdg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 08:36:24PM +0100, Wilken Gottwalt wrote:
> On Wed, 18 Nov 2020 16:37:33 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
> > Hi Wilken,
> >=20
> > On Wed, Nov 18, 2020 at 11:02:40AM +0100, Wilken Gottwalt wrote:
> > > Adds the sunxi_hwspinlock driver and updates makefiles/maintainers.
> > >=20
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >=20
> > A more descriptive commit log would be welcome here, for example
> > containing on which SoC this driver can be used, and on which it was
> > tested.
>=20
> can you help me here a bit? I still try to figure out how to do patch sets
> properly. Some kernel submitting documentation says everything goes into =
the
> coverletter and other documentation only tells how to split the patches. =
So
> what would be the right way? A quick example based on my patch set would =
be
> really helpful.

I mean, the split between your patches and so on is good, you got that right

The thing I wanted better details on is the commit log itself, so the
message attached to that patch.

> > This is the third attempt at that driver, and you can find the previous
> > versions here:
> > https://patchwork.kernel.org/project/linux-arm-kernel/cover/20200210170=
143.20007-1-nborisov@suse.com/
> > https://lore.kernel.org/patchwork/patch/706512/
> >=20
> > Most of the comments on those series still apply to yours.
>=20
> Oh, I wrote my driver 2-3 years ago and just prepared it for mainline. I
> wasn't aware of other attempts. I really should have checked this. Though,
> I really want to get to the point where this driver is good enough for
> mainline. Hmmm, it is interesting how similar these drivers are. Looks li=
ke
> the other developers also got inspired by the already existing hwspinlock
> drivers. :D

Yeah, it looks like you all got the same inspiration :)

> > Most importantly, this hwspinlock is used to synchronize the ARM cores
> > and the ARISC. How did you test this driver?
>=20
> Yes, you are right, I should have mentioned this. I have a simple test ke=
rnel
> module for this. But I must admit, testing the ARISC is very hard and I h=
ave
> no real idea how to do it. Testing the hwspinlocks in general seems to wo=
rk
> with my test kernel module, but I'm not sure if this is really sufficient=
=2E I
> can provide the code for it if you like. What would be the best way? Gith=
ub?
> Just mailing a patch?
>=20
> The test module produces these results:
>=20
> # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinlock_te=
st.ko=20
> [   45.395672] [init] sunxi hwspinlock test driver start
> [   45.400775] [init] start test locks
> [   45.404263] [run ] testing 32 locks
> [   45.407804] [test] testing lock 0 -----
> [   45.411652] [test] taking lock attempt #0 succeded
> [   45.416438] [test] try taken lock attempt #0
> [   45.420735] [test] unlock/take attempt #0
> [   45.424752] [test] taking lock attempt #1 succeded
> [   45.429556] [test] try taken lock attempt #1
> [   45.433823] [test] unlock/take attempt #1
> [   45.437862] [test] testing lock 1 -----
> [   45.441699] [test] taking lock attempt #0 succeded
> [   45.446484] [test] try taken lock attempt #0
> [   45.450768] [test] unlock/take attempt #0
> [   45.454774] [test] taking lock attempt #1 succeded
> [   45.459576] [test] try taken lock attempt #1
> [   45.463843] [test] unlock/take attempt #1
> .
> .
> .
> [   46.309925] [test] testing lock 30 -----
> [   46.313852] [test] taking lock attempt #0 succeded
> [   46.318654] [test] try taken lock attempt #0
> [   46.322920] [test] unlock/take attempt #0
> [   46.326944] [test] taking lock attempt #1 succeded
> [   46.331729] [test] try taken lock attempt #1
> [   46.335994] [test] unlock/take attempt #1
> [   46.340021] [test] testing lock 31 -----
> [   46.343947] [test] taking lock attempt #0 succeded
> [   46.348749] [test] try taken lock attempt #0
> [   46.353016] [test] unlock/take attempt #0
> [   46.357040] [test] taking lock attempt #1 succeded
> [   46.361825] [test] try taken lock attempt #1
> [   46.366090] [test] unlock/take attempt #1
> [   46.370112] [init] end test locks

That doesn't really test for contention though, and dealing with
contention is mostly what this hardware is about. Could you make a small
test with crust to see if when the arisc has taken the lock, the ARM
cores can't take it?

Maxime

--yffm423zihwi5zdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7YbiwAKCRDj7w1vZxhR
xdXCAPsFBDsW3OHbhbbI7loRjGxv7uBsvLF7Jq40jw6ghi4k2QEAns3rMbeYvoYF
8qGfZklCDZTF45RlndqxO0I+yHIXLQc=
=4ZUC
-----END PGP SIGNATURE-----

--yffm423zihwi5zdg--
