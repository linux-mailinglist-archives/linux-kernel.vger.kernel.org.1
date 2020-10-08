Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C072876D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgJHPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:10:27 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44903 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbgJHPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:10:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BA220930;
        Thu,  8 Oct 2020 11:10:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Oct 2020 11:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=CYp5ghx+QtfEEdC8D3FnT9Gr2l7
        5Zs9nCKJ6vvBPBA8=; b=NJs463Cl2k75FyBpOEe87GraNWLZI1Qp/iHmmB3/uZf
        9ER2rIvYo5D9QDryYsJmcTwhfgr92cDUFyP8dXevyV/ySguG+4fbGF+OYu4lycBj
        L9zW70TPj7FZX2itdaKOgPIHuSGG5heaT+r3WkU4dMTuqi2CWVQq7vu3gitRvFZc
        Ic4KTSfyj31fejvjGPiXV14qqkyENsD+r8V4v00cv2OwNoZLIZgESNe+9q4KmcI7
        MMnZYIEVneskhzF8gV3izlp5ZSXSc/21xau8Q4DDtGaP62KBhJuGUT/8Hv44OwrH
        srIVyFkJmxH+NtwIhs1XqcsD+oRIkUkG+VGTgmBL4tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CYp5gh
        x+QtfEEdC8D3FnT9Gr2l75Zs9nCKJ6vvBPBA8=; b=NQtEwLpxkgkaOc0SgkoAxi
        Wu7lNchjbfXI6VwMHxkdR2r5OkPi3Oog+y9rufQqYyLtfkTg8Pysx2Z4LCPOi4yL
        OboGf7w2WmMryFOcJh4BdyHdP4lU2C4NdwGGAkSHDSuZaCjVvbFjz6PqMGsvPMNA
        kndcxCLVHV3kRlq1LmRC/McnmQJM8TwF8Xe/PAVjbWWrOYUA58vd7+NSh1dmol70
        GfIoPUNF2hctL0NGhv2QadFB7f9GTigDgIKeiL7JaFAAD/3Aq1f7sbdgy27NZ/zG
        LuIKd5kyGy6AK2yDlMlt5o6LgewfRHQjRVBAdbnATO+LUKEKexwJyzw827lAI9hw
        ==
X-ME-Sender: <xms:4Ct_X2Gu2FfYFb-JUeQr1Gi9xKSVkced_SLcL1qwpddDdXPeeGaQzA>
    <xme:4Ct_X3WBTzu7iu3ilSDGJn7V7iNSOGqy05NDRXdxJlvJOsPbVwqZw88fcPO5XTBcc
    DtzM9b4IXt-B9H9GMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeelgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4Ct_XwKVZXQUF-Li7ob9QfqIEtChMgQ2vGhQ3rBGxrMxTgWSlHpLXg>
    <xmx:4Ct_XwGq2zEmWj_SE_Cn-OEqFYZGRgwm0igwvXrY22Gz3Ss1-2riBg>
    <xmx:4Ct_X8UMdGgI4mdDvAZNp2JmkF1_aWuHzG_vSr2zU3kXQm9RilPLJw>
    <xmx:4St_XzRjY9MjzlSVSEAeHKaR-stqyHiq5qru11eWH8v2sB3mBjGEgg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1C773064680;
        Thu,  8 Oct 2020 11:10:23 -0400 (EDT)
Date:   Thu, 8 Oct 2020 17:10:22 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property
 for Beelink GS1
Message-ID: <20201008151022.ryhijbj42y7kgzvb@gilmour.lan>
References: <20201003092001.405238-1-peron.clem@gmail.com>
 <20201005092145.wdu4m4pwxydv76ou@gilmour.lan>
 <CAJiuCcfydz4GS3fUTampBLkDC4f6xVWmRpSRJ55TiDStdRCFmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="khuprv2dwhmyhqpu"
Content-Disposition: inline
In-Reply-To: <CAJiuCcfydz4GS3fUTampBLkDC4f6xVWmRpSRJ55TiDStdRCFmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--khuprv2dwhmyhqpu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Cl=E9ment,

On Mon, Oct 05, 2020 at 08:47:19PM +0200, Cl=E9ment P=E9ron wrote:
> On Mon, 5 Oct 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi Cl=E9ment,
> >
> > On Sat, Oct 03, 2020 at 11:20:01AM +0200, Cl=E9ment P=E9ron wrote:
> > > Sunxi MMC driver can't distinguish at runtime what's the I/O voltage
> > > for HS200 mode.
> >
> > Unfortunately, that's not true (or at least, that's not related to your=
 patch).
> >
> > > Add a property in the device-tree to notify MMC core about this
> > > configuration.
> > >
> > > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS=
1 board")
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > index 049c21718846..3f20d2c9bbbb 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > @@ -145,6 +145,7 @@ &mmc2 {
> > >       vqmmc-supply =3D <&reg_bldo2>;
> > >       non-removable;
> > >       cap-mmc-hw-reset;
> > > +     mmc-hs200-1_8v;
> > >       bus-width =3D <8>;
> > >       status =3D "okay";
> > >  };
> >
> > I'm not really sure what you're trying to fix here, but as far as MMC
> > goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes up until
> > HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher speed modes
> > (HS200 and HS400) supporting 1.8V and 1.2V.
>=20
> Some users report that the eMMC is not working properly on their
> Beelink GS1 boards.
>=20
> > The mmc-hs200-1_8v property states that the MMC controller supports the
> > HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is set up at
> > 1.8V then otherwise, the MMC core will rightfully decide to use the
> > highest supported mode. In this case, since the driver sets it, it would
> > be HS-DDR at 3.3V, which won't work with that fixed regulator.
> >
> > I can only assume that enabling HS200 at 1.8V only fixes the issue you
> > have because otherwise it would use HS-DDR at 3.3V, ie not actually
> > fixing the issue but sweeping it under the rug.
> >
> > Trying to add mmc-ddr-1_8v would be a good idea
>=20
> Thanks for the explanation, this is indeed the correct one.
> So It looks like the SDIO controller has an issue on some boards when
> using HS-DDR mode.
>=20
> Is this patch acceptable with the proper commit log?

If HS-DDR works, yes, but I assume it doesn't?

Maxime

--khuprv2dwhmyhqpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX38r3gAKCRDj7w1vZxhR
xZ4uAQCJ3on/eN6AHLyOtjc+8pwcalO/OPJf5gAoITFQbxkrIQD/RjH7slcvyMYj
DDSh2+7H0QmZsrML4fpPZsN8H1vKxwQ=
=yedp
-----END PGP SIGNATURE-----

--khuprv2dwhmyhqpu--
