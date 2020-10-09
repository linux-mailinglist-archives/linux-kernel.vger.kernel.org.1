Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481C82883B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgJIHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:36:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45153 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731328AbgJIHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:36:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FB2F5C00F9;
        Fri,  9 Oct 2020 03:36:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 09 Oct 2020 03:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=DeUuxzkGc/PDj/8FcISImg2Zcr8
        Rv/oPyJJNhor4yTE=; b=io9PCzXK2CVWFa7sdYVq7bB+4BEhyG/VbPai4R+XHho
        /jlCWAG6JaZkYcj6lzdFNugxTdY9S3sZiuXvxNotc9fQr4UKaz9BPDNXAh82Xq6D
        jW+vf5R1OV9LsbEQwIK9eCmxXBoaxlm8Rmp8CpTd/oBpdfEcTLz6846ZIua5mQD0
        uYgpofnlu8nTdQ75/p9zhaqjGvLDCqyjxIz/IluSt4dfaf7uq2Y5xUqnKq/60VQF
        unXAZqJe2GQZBQdlJo3h1bA0Zi7bOwIbm2NTe5kjZh0KkbD8+/4OvIBBfWYB5uls
        8YPMdc4bbnnpb/nwHvgh25ljqnWmqMqZM38jIJroY/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DeUuxz
        kGc/PDj/8FcISImg2Zcr8Rv/oPyJJNhor4yTE=; b=pX8GdSEpaNDx2S5DLroMLN
        ppQP57mCcOxN0G6j9+h7Z21kR9R8qjvHsol5pcc6mwZbR74XjQ0/a3f7pg23/VSz
        LxcMRfMaDOsKgFiPHKo/Lm2x87tqcF/SS3cO5HXYIYQH+m/mPZvwls4AblFXZkVa
        CZMflrvQRIbHhHuOgt/Wh94Ftqvt+l0dmhM/UuCiRsFM7LRL/ygWf9HSlerA4Zm6
        fj0XeX7Gq49oZnZeEBpHSCii4NHQeJL5Vh6mGJPL2fxph9L1yjU9Q4kt/Nn+lesA
        g1Bvb9xyQe+DEXVfs04aQzfsg9SpMUpEMQQ931+Vh31plf+yQHAEMv+FYRNy1dcg
        ==
X-ME-Sender: <xms:FROAX8IhIEROl-SHwO8LtvJBXHt9Q4Jzcxyc_vtfGefhTef_viwWvQ>
    <xme:FROAX8LH0ILCRzhBZUXarireS3oqGhIojuieqXM-fwYSIKsonpjqlVN76aArU8jlE
    gyhwUF7DSNqXNIMBJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrhedtgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptefgjedtleegffffiedthfdtvdefieejffetleekhfelvdevgffgudejgeei
    gefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FROAX8uxlaCaIj11U5W_ibbb_44HdiAacW75P8Fzn5zODmJXBv9Exg>
    <xmx:FROAX5aBgBNsDF2YQKNTcVEBCI0iQG6g5N9w-Zj4Xf8SJUdBtcUXhQ>
    <xmx:FROAXza1r4jdGK2CuF4YRlkbViHKhGZX_UM0gu8TejSLVoXjJAVr_Q>
    <xmx:FxOAX-weSkd4ywxrai7fBLNrZSOc6BXu7BxkmxIM7V7iNAhjRtUObA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 686B6328005E;
        Fri,  9 Oct 2020 03:36:53 -0400 (EDT)
Date:   Fri, 9 Oct 2020 09:36:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property
 for Beelink GS1
Message-ID: <20201009073651.izvvjpqiqiivhknl@gilmour.lan>
References: <20201003092001.405238-1-peron.clem@gmail.com>
 <20201005092145.wdu4m4pwxydv76ou@gilmour.lan>
 <CAJiuCcfydz4GS3fUTampBLkDC4f6xVWmRpSRJ55TiDStdRCFmA@mail.gmail.com>
 <20201008151022.ryhijbj42y7kgzvb@gilmour.lan>
 <CAJiuCcf8rk4t2GrS3+ANEuCtRmXoCMyzP+-x_rKrAfR-FaMaWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cuc3il2vmfdnuxue"
Content-Disposition: inline
In-Reply-To: <CAJiuCcf8rk4t2GrS3+ANEuCtRmXoCMyzP+-x_rKrAfR-FaMaWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cuc3il2vmfdnuxue
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 10:00:06PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Maxime,
>=20
> Adding linux-sunxi and Jernej Skrabec to this discussion.
>=20
> On Thu, 8 Oct 2020 at 17:10, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi Cl=E9ment,
> >
> > On Mon, Oct 05, 2020 at 08:47:19PM +0200, Cl=E9ment P=E9ron wrote:
> > > On Mon, 5 Oct 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
> > > >
> > > > Hi Cl=E9ment,
> > > >
> > > > On Sat, Oct 03, 2020 at 11:20:01AM +0200, Cl=E9ment P=E9ron wrote:
> > > > > Sunxi MMC driver can't distinguish at runtime what's the I/O volt=
age
> > > > > for HS200 mode.
> > > >
> > > > Unfortunately, that's not true (or at least, that's not related to =
your patch).
> > > >
> > > > > Add a property in the device-tree to notify MMC core about this
> > > > > configuration.
> > > > >
> > > > > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelin=
k GS1 board")
> > > > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.=
dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > index 049c21718846..3f20d2c9bbbb 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > @@ -145,6 +145,7 @@ &mmc2 {
> > > > >       vqmmc-supply =3D <&reg_bldo2>;
> > > > >       non-removable;
> > > > >       cap-mmc-hw-reset;
> > > > > +     mmc-hs200-1_8v;
> > > > >       bus-width =3D <8>;
> > > > >       status =3D "okay";
> > > > >  };
> > > >
> > > > I'm not really sure what you're trying to fix here, but as far as M=
MC
> > > > goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes up =
until
> > > > HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher speed =
modes
> > > > (HS200 and HS400) supporting 1.8V and 1.2V.
> > >
> > > Some users report that the eMMC is not working properly on their
> > > Beelink GS1 boards.
> > >
> > > > The mmc-hs200-1_8v property states that the MMC controller supports=
 the
> > > > HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is set =
up at
> > > > 1.8V then otherwise, the MMC core will rightfully decide to use the
> > > > highest supported mode. In this case, since the driver sets it, it =
would
> > > > be HS-DDR at 3.3V, which won't work with that fixed regulator.
> > > >
> > > > I can only assume that enabling HS200 at 1.8V only fixes the issue =
you
> > > > have because otherwise it would use HS-DDR at 3.3V, ie not actually
> > > > fixing the issue but sweeping it under the rug.
> > > >
> > > > Trying to add mmc-ddr-1_8v would be a good idea
> > >
> > > Thanks for the explanation, this is indeed the correct one.
> > > So It looks like the SDIO controller has an issue on some boards when
> > > using HS-DDR mode.
> > >
> > > Is this patch acceptable with the proper commit log?
> >
> > If HS-DDR works, yes, but I assume it doesn't?
>=20
> After discussing with Jernej about this issue, I understood that:
> - Automatic delay calibration is not implemented
> - We also miss some handling of DDR related bits in control register
>=20
> So none of H5/H6 boards should actually work.
> (Some 'lucky' boards seem to work enough to switch to HS200 mode...)
>=20
> To "fix" this the H5 disable the HS-DDR mode in sunxi mmc driver :
> https://github.com/torvalds/linux/blob/master/drivers/mmc/host/sunxi-mmc.=
c#L1409

I find it suspicious that some boards would have traces not good enough
for HS-DDR (50MHz in DDR) but would work fine in HS200 (200MHz in SDR).
If there's some mismatch on the traces, it will only be worse in HS200.

And for the delay calibration, iirc, that's only necessary for HS400
that we don't support?

> I'm not sure about A64 but it looks like the property "mmc-hs200-1_8v"
> for the PineBook shows the same issue.
>=20
> The proper way would of course be to implement the missing feature
> mentioned above.
> But this could take some time and as the eMMC driver is actually
> broken wouldn't it be better to disable the HS-DDR for H6 in the mmc
> driver like it's done for H5 ?

Have you tested with only the mmc-ddr-1_8v property?

Maxime

--cuc3il2vmfdnuxue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4ATEwAKCRDj7w1vZxhR
xTVaAQCIC4GxG0AMpq4aBg6dskIOx+bHvQ1lIysXG++6SLpYiQEA8QTiPrmBS0bg
fAqGPBKbgt3exqy0mc6357vdFILjggE=
=kH8r
-----END PGP SIGNATURE-----

--cuc3il2vmfdnuxue--
