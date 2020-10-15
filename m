Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43B728EF71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbgJOJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:35:50 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35943 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbgJOJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:35:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 42A237C8;
        Thu, 15 Oct 2020 05:35:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 15 Oct 2020 05:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ibu+1PUER9AANYGGIJFs1bRW7pg
        gTkYRUTQDX7a5JXE=; b=sfkuyoDpmZCq7xjeTEUFvN+8YBvvHT2kIZ99H1K/fM2
        75Y3Ur1VKCaXUHg3EaSRJaPy+0846JtolSb9AY+GvPizvA2OPhwDTDP8hmBM+9Pu
        5SZDAe9RaJLydKLUVEmAwDVjqvc4RiL6AsMQW+HtWQkPFZkmhulBTEQqTLdqHt0F
        JWCb89aj7QvZwt+33cDmWYmlUy+TO8hFitq3grcceW136lgq1iXyKnbVFEEU8WTY
        DlGhnaEvONG4NUjAoMZdjm3UJzDlfidKwddzA/MTN4e370JjMKVRUZZpKPQfPTBv
        Vq9rxeWHa618stXxQg7JrPgQ39fw86vus/ammRPayVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ibu+1P
        UER9AANYGGIJFs1bRW7pggTkYRUTQDX7a5JXE=; b=p8fUgCcIrtQiAO4LdpNmoh
        xccMlbDZvgDGMZt4BRy6SqHo+3wdkUku24aEWRCuHkUvMoByEA5zUJ6t5xBHkwd0
        YNdpVVCU78EsFFDePgs4rIWaic6wpqCZ9dwk6XH8DirrGz3Asl8Y+O+p/F4cODhD
        W8AqFb/djR1jeV1K12f/3tAA0+ZMMyONpTD5iBfKTHyW2L8ZZw8wph+7oK37u7CE
        xwPpkLoz96OAnfW62kg8auRRlrxGOX/Ro1ju7FxKisVn0ewGfhNu2WaA5+FZJLAk
        0shiwofuh4sXpGcLAWZbbXrGBusc+O7ZF3u4KVUNO6FRPYg0XnHOpSaEvRiLyrEA
        ==
X-ME-Sender: <xms:8heIX1771Q_QemB30VHWPJTpKBhL0BYxHSGeHpyGcLUtaMWK0UjsXA>
    <xme:8heIXy6XkIR-ppfJIDmN31KIa6I-XW-M_TaFUdR1xNh-edA9qvg5vUi8bcE-oeAif
    8oteyurz9WuaQVybDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieefgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduleefveduuddtteejgeegfedvteevfedtjeetveeiffdufeegjeelgeetkeeg
    veenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8heIX8cKLJMZlaBhhybFIlZq7FTqoMB7drhEv3Xz3gSt4p20E676zg>
    <xmx:8heIX-LMxgFSIqtAIBGuG6C5DYHWuZylasf53qZmr53sBjyFlkcUjw>
    <xmx:8heIX5IMVHbK4GtGOjBVJJChxqXF68-x839yayaIg6pcRcBdI3vNbg>
    <xmx:8heIX3hIjBgnb6sYOzfWsq98f3p36pfWXmlCNtLbpDQzA67lJMFPjQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B946D328005D;
        Thu, 15 Oct 2020 05:35:45 -0400 (EDT)
Date:   Thu, 15 Oct 2020 11:35:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property
 for Beelink GS1
Message-ID: <20201015093544.zwxjzwmu77jz55d7@gilmour.lan>
References: <20201003092001.405238-1-peron.clem@gmail.com>
 <CAJiuCcf8rk4t2GrS3+ANEuCtRmXoCMyzP+-x_rKrAfR-FaMaWA@mail.gmail.com>
 <20201009073651.izvvjpqiqiivhknl@gilmour.lan>
 <2745255.UFgyrzHpml@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhkwnjfp2ntjybhi"
Content-Disposition: inline
In-Reply-To: <2745255.UFgyrzHpml@kista>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhkwnjfp2ntjybhi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 11:27:33PM +0200, Jernej =C5=A0krabec wrote:
> Dne petek, 09. oktober 2020 ob 09:36:51 CEST je Maxime Ripard napisal(a):
> > On Thu, Oct 08, 2020 at 10:00:06PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > > Hi Maxime,
> > >=20
> > > Adding linux-sunxi and Jernej Skrabec to this discussion.
> > >=20
> > > On Thu, 8 Oct 2020 at 17:10, Maxime Ripard <maxime@cerno.tech> wrote:
> > > >
> > > > Hi Cl=C3=A9ment,
> > > >
> > > > On Mon, Oct 05, 2020 at 08:47:19PM +0200, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > > > On Mon, 5 Oct 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wr=
ote:
> > > > > >
> > > > > > Hi Cl=C3=A9ment,
> > > > > >
> > > > > > On Sat, Oct 03, 2020 at 11:20:01AM +0200, Cl=C3=A9ment P=C3=A9r=
on wrote:
> > > > > > > Sunxi MMC driver can't distinguish at runtime what's the I/O=
=20
> voltage
> > > > > > > for HS200 mode.
> > > > > >
> > > > > > Unfortunately, that's not true (or at least, that's not related=
 to=20
> your patch).
> > > > > >
> > > > > > > Add a property in the device-tree to notify MMC core about th=
is
> > > > > > > configuration.
> > > > > > >
> > > > > > > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Be=
elink=20
> GS1 board")
> > > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-
> gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > > > index 049c21718846..3f20d2c9bbbb 100644
> > > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > > > @@ -145,6 +145,7 @@ &mmc2 {
> > > > > > >       vqmmc-supply =3D <&reg_bldo2>;
> > > > > > >       non-removable;
> > > > > > >       cap-mmc-hw-reset;
> > > > > > > +     mmc-hs200-1_8v;
> > > > > > >       bus-width =3D <8>;
> > > > > > >       status =3D "okay";
> > > > > > >  };
> > > > > >
> > > > > > I'm not really sure what you're trying to fix here, but as far =
as MMC
> > > > > > goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes=
 up=20
> until
> > > > > > HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher sp=
eed=20
> modes
> > > > > > (HS200 and HS400) supporting 1.8V and 1.2V.
> > > > >
> > > > > Some users report that the eMMC is not working properly on their
> > > > > Beelink GS1 boards.
> > > > >
> > > > > > The mmc-hs200-1_8v property states that the MMC controller supp=
orts=20
> the
> > > > > > HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is =
set=20
> up at
> > > > > > 1.8V then otherwise, the MMC core will rightfully decide to use=
 the
> > > > > > highest supported mode. In this case, since the driver sets it,=
 it=20
> would
> > > > > > be HS-DDR at 3.3V, which won't work with that fixed regulator.
> > > > > >
> > > > > > I can only assume that enabling HS200 at 1.8V only fixes the is=
sue=20
> you
> > > > > > have because otherwise it would use HS-DDR at 3.3V, ie not actu=
ally
> > > > > > fixing the issue but sweeping it under the rug.
> > > > > >
> > > > > > Trying to add mmc-ddr-1_8v would be a good idea
> > > > >
> > > > > Thanks for the explanation, this is indeed the correct one.
> > > > > So It looks like the SDIO controller has an issue on some boards =
when
> > > > > using HS-DDR mode.
> > > > >
> > > > > Is this patch acceptable with the proper commit log?
> > > >
> > > > If HS-DDR works, yes, but I assume it doesn't?
> > >=20
> > > After discussing with Jernej about this issue, I understood that:
> > > - Automatic delay calibration is not implemented
> > > - We also miss some handling of DDR related bits in control register
> > >=20
> > > So none of H5/H6 boards should actually work.
> > > (Some 'lucky' boards seem to work enough to switch to HS200 mode...)
> > >=20
> > > To "fix" this the H5 disable the HS-DDR mode in sunxi mmc driver :
> > > https://github.com/torvalds/linux/blob/master/drivers/mmc/host/sunxi-=
mmc.c#L1409
> >=20
> > I find it suspicious that some boards would have traces not good enough
> > for HS-DDR (50MHz in DDR) but would work fine in HS200 (200MHz in SDR).
> > If there's some mismatch on the traces, it will only be worse in HS200.
>=20
> FYI, similar situation is also with Tanix TX6 board. Mine works well in H=
S-DDR=20
> mode, but some people reported that it doesn't work for them. The only=20
> possible difference could be different eMMC IC. I'll try to confirm that.
>=20
> Anyway, I did some tests on OrangePi 3 board which also have eMMC. Both m=
odes=20
> (HS-DDR and HS200) are supported and work well.

The Orange Pi 3 has an HS400-capable eMMC ?!

That's really good news, I've initially done the HS200 support on a
custom board I had to give back and couldn't find any board with
HS200/HS400 since.

> Interesting observation is that speed test (hdparm -t) reported 80.58
> MB/sec for HS-DDR mode and 43.40 MB/sec for HS200. As it can be seen
> here, HS-DDR is quicker by a factor of 2, but it should be the other
> way around. Reason for this is that both modes use same base clock and
> thus HS-DDR produces higher speed. If I change f_max to 150 MHz (max.
> per datasheet for SDR @ 1.8 V) then naturally HS200 mode is faster
> (124.63 MB/sec) as HS-DDR as it should be.

If it work fine on the H6, we should set the max-frequency property on
the DT, just like I did on the A64.

> This would be actually correct test for problematic boards but
> unfortunately I don't have it. I also hacked in support for HS400
> (~143 MB/s) and this mode is the only one which really needs
> calibration on my board.
>=20
> Two observations from BSP driver:
> 1. Module clock is disabled before adjusting DDR bit and afterwards it's =
re-
> enabled . That could fix some kind of glitches.
> 2. SDMMC peripheral runs on higher clock than on mainline.
>=20
> > And for the delay calibration, iirc, that's only necessary for HS400
> > that we don't support?
>=20
> According to BSP driver and its DT, HS200 also needs calibration. However=
, it=20
> seems that using it on lower speed it isn't needed.

Which calibration do you mean? IIRC, the data strobe signal is only used
(optionally) in HS400. The controller might have some internal
calibration for other modes though.

Maxime

--mhkwnjfp2ntjybhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4gX8AAKCRDj7w1vZxhR
xSExAQCHOsqyN6FMqDcrieLXfnK712XMkFqYxTjb8KMHTQankAEAxvik9vj3Z0Q+
nfUXfEU5OHRno2yn42WwPSETP3ffbgQ=
=RY3/
-----END PGP SIGNATURE-----

--mhkwnjfp2ntjybhi--
