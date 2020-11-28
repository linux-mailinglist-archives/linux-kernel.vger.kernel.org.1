Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E502C725B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgK1VuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:19 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34293 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733153AbgK1SLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:11:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3390A9BB;
        Sat, 28 Nov 2020 05:40:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 28 Nov 2020 05:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Hq254jPPKxCC5RMUk78VI37BIcd
        /Qc5Ug03wP6lEyP8=; b=N1JGwbtP9OsrqES3Fuqr59oHPuf4krVuOcTJMK/Djgo
        Ul5GpbQZlByT0xPbgmQE/eWSHz64MtfB2sWF5CSXQwcqsFJWlcmuaY+4VWR1jknz
        hdV9p0jGIxXWjOp91NkjXuJ/G+STUHkxARShHMVXjaL3TdU2TkfgB1j8EjwhstSV
        erkWprwIXpIftvLDTSvSKQ4CzbmjtcHS6XK2kFHKk78ftqrtJuIrLtEuWk62VJuJ
        sTi++bNmFSxlP3A2JAGdlJeut5KWr1etzfUAwwaleILMLC7yKw0yvvKxSEgvB5Ah
        H+9lxv4IDAoOW/iJgX58mGBfKLOASbNzCdKBb5yMBUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Hq254j
        PPKxCC5RMUk78VI37BIcd/Qc5Ug03wP6lEyP8=; b=aIuexSNYLpnZb2jou1H6ih
        geR+FWulciiYaJO1ufW8D0hvmdCF3WghzgmnJfKUx+6CoEaPy9i3GtKxRKudYdBS
        bfjPaToT5SmiuPB67OL4pOWE5ZCYylpz2e8cnVYHgViG/BN/erXkDe9wPFS0Qyk0
        shBoJA0R2YrhntEBoiAgfYzKzcaYNZqNqnKAxC1OX/L7u3m4P1P7mFlFfXzG8vE1
        W7047cRX4IH5lRxXpbIB5qldnvi5T7tVf/PFJiluLRSMVSg9aqGVdpTdXzzh70p+
        w6mLatlMgJ5PIi+Hp7ZGD55vYVRjeyUw212HjEIv+1omg95duUX89bqp9DCKyoQA
        ==
X-ME-Sender: <xms:_yjCXySR4Gdi1HC5V4PYhnZSNnL5oEZNqE3LVRztp1AbbODb_gx1cA>
    <xme:_yjCX3xAKkrLnzi7lMRE-AwOMIor5CHKCLFGw-lwnr7Fds71UH9VcURQnw9ZOkPLZ
    cdP54uyQZxhBQcyE_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:_yjCX_00nXvlBjT2dkfVlC1-24nZhxEH38nTFqIU-nhv6w-c_RclLA>
    <xmx:_yjCX-BJqmPMhtxqdQiKL6Owg035oKrrwpwt-GYZVjqxI2sufPiGKw>
    <xmx:_yjCX7h4pAT0u09Uy2qHCqRVLWzcmDQk4FUEjbtzx6c_25zWeqpN7Q>
    <xmx:_yjCX4uj_7d5oXgcg2GvTXdJloVywCeE0wg0yP_KWgN7glNusNXglA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ABE53064AAA;
        Sat, 28 Nov 2020 05:39:59 -0500 (EST)
Date:   Sat, 28 Nov 2020 11:39:58 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 poweroff node to DT
Message-ID: <20201128103958.q6glewhhch7vtczr@gilmour>
References: <20201124131933.2l2go6z6ltar5fpa@gilmour>
 <20201124133633.672259-1-michael@fossekall.de>
 <20201124142656.wz6ipwa2xayn433x@gilmour>
 <20201124223159.GA2865084@a98shuttle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="stejl7vgq72gqvys"
Content-Disposition: inline
In-Reply-To: <20201124223159.GA2865084@a98shuttle.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--stejl7vgq72gqvys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 11:31:59PM +0100, Michael Klein wrote:
> On Tue, Nov 24, 2020 at 03:26:56PM +0100, Maxime Ripard wrote:
> > On Tue, Nov 24, 2020 at 02:36:33PM +0100, Michael Klein wrote:
> > > Add poweroff node to allow the board to power itself off after shutdo=
wn
> > > by disabling the SYSTEM and CPUX regulators (U5 resp. U6).  The RST
> > > button can be used to restart the board.
> > >=20
> > > Signed-off-by: Michael Klein <michael@fossekall.de>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
> > >  1 file changed, 5 insertions(+)
> >=20
> > You should have a summary of the changes between versions here
> >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/a=
rch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > > index 4c6704e4c57e..ea2fa48a1647 100644
> > > --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > > +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > > @@ -46,6 +46,11 @@ sw4 {
> > >  		};
> > >  	};
> > >=20
> > > +	poweroff {
> > > +		compatible =3D "gpio-poweroff";
> > > +		gpios =3D <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
> > > +	};
> > > +
> >=20
> > Like I said in the previous version, this should really be modelled as a
> > regulator instead of just a GPIO
>=20
> Please excuse my ignorance, do you mean something like this?
>=20
>        reg_vdd_sys: vdd-sys {
>                compatible =3D "regulator-fixed";
>                regulator-name =3D "vdd-sys";
>                regulator-min-microvolt =3D <1200000>;
>                regulator-max-microvolt =3D <1200000>;
>                regulator-always-on;
>                regulator-boot-on;
>                enable-active-high;
>                gpio =3D <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
>                vin-supply =3D <&reg_vcc5v0>;
>         };
>=20
> With this, the board still draws 60mA (cheap USB ampere meter) after
> shutdown, presumably because of "regulator-always-on".  Without this
> property the board powers off shortly after booting up.

Yes, because you're only describing the regulator itself here, but
you're not telling linux that it needs to shut it down to power-down the
board.

You'd need a driver similar to gpio-poweroff, using a regulator instead,
and calling regulator_force_disable to shut it down

Maxime

--stejl7vgq72gqvys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8Io/QAKCRDj7w1vZxhR
xXyaAP9dhQ6ZoKWFbs6dcJc5Sqvox9mY6u0YvG1VjDCv//w7bgEAnAvV7LTYzXcP
gvqQIqZAI1Y6fd0YSrdnwif+0yfjhgI=
=lHji
-----END PGP SIGNATURE-----

--stejl7vgq72gqvys--
