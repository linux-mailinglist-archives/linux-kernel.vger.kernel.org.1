Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86429252C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgJSKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:08:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60801 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbgJSKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:08:44 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0571A5C013A;
        Mon, 19 Oct 2020 06:08:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Oct 2020 06:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=34lTEUkxXEEYOk9ylxSpTaMMgwC
        XAUNQHtvP3Fum2F4=; b=VTKh39gHTt5XWAP90IKuZVnwpbrTDT1UIoMTQtyqzxm
        41j5dCMov0Lp9A8Cy5WOqC5G0DwHPAGAAqxdvfJ6Da7segfCZvoc2hiC70W9KcRl
        KuhpyHrwSqcFytyKSvwF/KcBuVNOWH2CRVSY0C5qALlsYV3ZPhfP8z/2mPeuyCuu
        g8HODwX9e4slObjPpKMXU5MZGT74hEShfldvkkHg+JU85jUg7xUvuwUtmEyPb97l
        3HDKFWJrbc0XIsMHEal629ZuozEbFdyOE4CQSCovn3+9hnHnUT6YReDQmtOGcC8a
        jV4E8ZGd+MqB68QNwASCUUAya1VRXgTY/IT307vrzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=34lTEU
        kxXEEYOk9ylxSpTaMMgwCXAUNQHtvP3Fum2F4=; b=GThO5QCNeq/XNEnpHUQ7Sr
        YsyeWqfjkQFN2KRmGVr7uDUHPm2aoFbQhJVopcJVmPQ7RPXDQ+qwnnxu4D1Nof/3
        3IPjrulq5hzAN70peDvUkfIsm/iCzZIQPeg0cuLBmi6M9/+pMvyt+dZAW/sXIpTY
        0Z9Eyg6utbFc6lmJrWryITh3YoZh01bw/FfFFQ0HOrSXuz15/Svl2v3uK6U1wjos
        WhXuGFwa6OnCx9qk9TpDVgdRDEfAkMIPysqqjOb7LszQx+HCfQyWxLdlYv3GE7Ck
        Bv5y00mRyXmqyuGvZ1AMtgE8ZaiVqAVh26VAE5cI5k0mWf+dDrAiA1XS06RWXuVg
        ==
X-ME-Sender: <xms:qmWNXw_9W9BvqnWLWJK8x0D3CeopReW7hjMIfvPGlVbGnFlPrX9bHA>
    <xme:qmWNX4tVUPDYfjldAVPiUq0H8fsP6vUkC--N76R3D4zxTjqv5oyDkscoxt9NYUQYp
    JfnMP9zQ4vusZX6w04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvfefftedvuddvkeekteeiudefhfettdetleefieefhefhieduudekueettefh
    tdenucffohhmrghinhepohhrrghnghgvphhirdhorhhgpdgsohhothhlihhnrdgtohhmne
    cukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qmWNX2Cmk9yHW0AvEi9NS0EhpRvBqjmnFIrc22hSlXsujiQGiG-tiw>
    <xmx:qmWNXweDu3eRZnRfU52WltTO9SiK3EJrppupqa28GmA7sXXpICLr1w>
    <xmx:qmWNX1PYRovQ_U0-Mxs4h5yJywx13TPADcpOQoGpm9xY3h8Sjwu-1A>
    <xmx:qmWNX2rbrVkyk9zHRZnR-o9Tw0OOrX34txKsI8oKEgdSGc2zVAY4Sg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6173328005D;
        Mon, 19 Oct 2020 06:08:41 -0400 (EDT)
Date:   Mon, 19 Oct 2020 12:08:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201019100840.vntpu7d2eiun3zek@gilmour.lan>
References: <20200929083025.2089-1-msuchanek@suse.de>
 <20201008151315.v3geykbs6musl4wq@gilmour.lan>
 <20201008160219.GM29778@kitsune.suse.cz>
 <20201008171454.qixrcjmhzko766su@gilmour.lan>
 <20201008174044.GN29778@kitsune.suse.cz>
 <20201012153507.ft77jgaprpendpne@gilmour.lan>
 <20201012170325.GS29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pdudt7bfmn67gt2h"
Content-Disposition: inline
In-Reply-To: <20201012170325.GS29778@kitsune.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pdudt7bfmn67gt2h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 07:03:25PM +0200, Michal Such=E1nek wrote:
> > > >=20
> > > > > Also the boards that do not have the flsh are either broken or
> > > > > obsolete.
> > > >=20
> > > > Making general statements without arguments doesn't really make it =
true
> > > > though. Plenty of boards to have flash and are neither broken nor
> > > > obsolete.
> > >
> > > Cannot parse this.
> >=20
> > "Plenty of boards do not have flash and are neither broken nor obsolete"
> The product description of Orange Pi Zero clearly states there is a
> flash memory: http://www.orangepi.org/orangepizero/
>=20
> When you order an Orange Pi Zero it comes with a flash memory. That is
> not what the device tree describes. The device tree is supposed to
> descrbe the hardware. If it does not it is broken.
>=20
> If you have a board without a flash memory I do not know what it is but
> it is clearly not an Orange Pi Zero because it comes with one.

If you're buying it today, yes. If you take a random Orange Pi Zero that
has been sold at any point in time, you cannot make that statement.

> > > >=20
> > > > > So most of the time enabling the flash chip is the right thing.
> > > > >=20
> > > > > Or do we need two DTBs like sun8i-h2-plus-orangepi-zero.dts and
> > > > > sun8i-h2-plus-orangepi-zero-no-spi-nor.dts
> > > >=20
> > > > No, you need sun8i-h2-plus-orangepi-zero plus an overlay for the
> > > > SPI-NOR.
> > >
> > > The flash is part of the board.
> >=20
> > Not always though.
> No, it always comes with one. You must be speaking of a different board
> then.
> >=20
> > > There is no need for an overlay.
> >=20
> > Overlays are here to deal with the "not always though" situation...
>
> There are no overlays in the kernel. Please show me tho code in the
> kernel for handling overlays.

You're the one that mentioned the kernel here, but here you are:
https://elixir.bootlin.com/linux/v5.9.1/source/include/linux/of.h#L1455

And a driver using it:
https://elixir.bootlin.com/linux/v5.9.1/source/drivers/gpu/drm/rcar-du/rcar=
_du_of.c#L44

> > > And overlays don't exist.
> >=20
> > If you want to believe that, please go ahead.
> >=20
> > But there's support for it in libfdt, and you can either apply them
> > directly through the U-Boot command line, or bundle them in a FIT image.
>
> And as you state the user ususally does not know which version of the Pi
> they have. How are they supposed to know that they should apply an
> overlay through u-boot commandline (if they even get to see one)

Documentation?

> bundle them in a FIT image (if they are even using a FIT image).

That would be the distro's job, not the user's.

> I am doing neither. I boot a standard distribution kernel from EFI
> grub.
>=20
> I understand that it would be nice to support two almost identical
> boards with a single device tree. However, if an error about missing
> flash memory is not acceptable, and the kernel does not support
> enabling the flash memory dynamically we need two device trees then.

You keep moving the goalposts, but U-boot is perfectly able to apply an
overlay automatically at boot without the user's intervention. We're
already making it select various DTs for the pine64 and pine64+ to have
a single image for both, or for the pinephone variants.

Maxime

--pdudt7bfmn67gt2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX41lqAAKCRDj7w1vZxhR
xejPAP0XzhVecdEKFAwu1TUIo43F0qYib6ce1Ozlu2eyGCuNpAEA+3RTWPJzgs3f
3nRfBMDryEuhjb4QzXqcDzI60l+GoQU=
=AOh6
-----END PGP SIGNATURE-----

--pdudt7bfmn67gt2h--
