Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B062D9988
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440030AbgLNONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:13:20 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37803 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgLNONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:13:20 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id AAE91580264;
        Mon, 14 Dec 2020 09:12:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 09:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oPI5HgnVfN7c7xc2RC5PhDz4rdE
        fvl2DDBtK4UExMW4=; b=ET4gdNm3wukJ27HyFZde/XQSFbT1fP+rwoXRooGD6vw
        qIVImpYo4EY71ON7gzZzBs2jFRdFrA639vOgGBIH/DghTA7mhBKQzmQGEY2swlON
        gX/NDO7zk+2e3r+/FnHvjp1pDffOJtiyeAPy73f3DDAQqF9lsQiwyKmXeG/qHg9Q
        fDW99Tg6JcnqReGlf5xlyvd7DPMN49HpWf4kpdM9t4oBOhYcTNfiOT0FUZ5HJaB0
        zhenrW8aptxuQ+CPeOA/ARb2UrYnYExv/AweLhHhEaemTJBy1+4xW25E3Mdr17So
        AwuNFP6FQ0FO35Dfk553/5KulSjZdcXwk3COcp/w5EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=oPI5Hg
        nVfN7c7xc2RC5PhDz4rdEfvl2DDBtK4UExMW4=; b=X700nfHOOwF8Fcblg6tXnW
        NVZEbmR8WECEvZlIjR8J7nEdx++Zd85CF+EHr6xyS5KfvIibWtLDffW+5X06TlA8
        jmP3hmkn7Z1nXocXlsjmiewYscJ249vwQVNQTumK+zQkMHV4Pt57pBHxnYt/J5pd
        I/FT3MRy+rRy4e0EM8vANavVE/XIggsSc6eqZXHCGgtdmCjfzbogjJ8Y6ogN3e5z
        1FQN9c+5DCNnURhV64DWGIHzjtmlJ4nkw5ZuALRT1vKFNhdHeKSSGjvGduDkfSPw
        m5P/SALBy0ZxIcJf9ayfLSUItcmQ10rPgooEYA1dNde/l7DaGHsu8yKN3Z9qWxGg
        ==
X-ME-Sender: <xms:u3LXX-J0K9zoqU4PtH8LRk36W1xFFbs6fst3YA4DXKQSvR4zGZEW3w>
    <xme:u3LXX2Ls0c335bCS7iuYgKEXCw93lWQsoEXWr_0iuYCzuKSFhNFNClGO512sHNhlw
    yFQzNIgLenQWQJFwVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:u3LXX-sJehq8yx3-NQspCB-owcRnYxgcsVbC5U7srdSQiOX4Jsa2RA>
    <xmx:u3LXXzbHZh7N3ouMeqcTdZtU2zR_2JvnRRSX_02O7v5zelHAh24Qeg>
    <xmx:u3LXX1Yayf5Yk4SHArv9yXXO7J6ZBrocGQLMB-djFw_h4CCbxGc16Q>
    <xmx:vXLXXyTuogJnWTizq8_nzlsyoIgmZFA31Fr86Pg16m-BkHiZI0v6jw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FF8724005D;
        Mon, 14 Dec 2020 09:12:10 -0500 (EST)
Date:   Mon, 14 Dec 2020 15:12:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 19/21] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20201214141209.xky5dn42dkrv4vvm@gilmour>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-20-andre.przywara@arm.com>
 <20201214095831.j63nks3fqxlaw75w@gilmour>
 <20201214125343.0cd1bc6a@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4tjwk5mvzqfd55qc"
Content-Disposition: inline
In-Reply-To: <20201214125343.0cd1bc6a@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4tjwk5mvzqfd55qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2020 at 12:53:43PM +0000, Andre Przywara wrote:
> On Mon, 14 Dec 2020 10:58:31 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
> > On Fri, Dec 11, 2020 at 01:19:32AM +0000, Andre Przywara wrote:
> > > +	reserved-memory {
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <2>;
> > > +		ranges;
> > > +
> > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31)
> > > */
> > > +		secmon_reserved: secmon@40000000 {
> > > +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> > > +			no-map;
> > > +		};
> > > +	}; =20
> >=20
> > This should still be set by the firmware
> >=20
> > > +		mmc0: mmc@4020000 {
> > > +			compatible =3D "allwinner,sun50i-h616-mmc",
> > > +				     "allwinner,sun50i-a100-mmc";
> > > +			reg =3D <0x04020000 0x1000>;
> > > +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu
> > > CLK_MMC0>;
> > > +			clock-names =3D "ahb", "mmc";
> > > +			resets =3D <&ccu RST_BUS_MMC0>;
> > > +			reset-names =3D "ahb";
> > > +			interrupts =3D <GIC_SPI 35
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +			pinctrl-names =3D "default";
> > > +			pinctrl-0 =3D <&mmc0_pins>;
> > > +			status =3D "disabled";
> > > +			#address-cells =3D <1>;
> > > +			#size-cells =3D <0>;
> > > +		}; =20
> >=20
> > Somewhat related: we shouldn't set the MMC speed flags in the drivers.
> > This is biting us on the already supported SoCs, so it would be great
> > to not repeat the same mistake with the new ones
>=20
> Do you mean to list the "sd-uhs-sdr50" and friends properties here in
> the DT?
> What is the best practice here in terms putting them in the .dts vs.
> the .dtsi? Surely the controller has limits, but bad traces on a board
> could impose further restrictions, right?
>
> Though that's probably rare, so it sounds like a lot of churn to list
> them in every board DT. So can we list everything in here (.dtsi), then
> delete in those affected boards only?

Yeah, I completely agree :)

Maxime

--4tjwk5mvzqfd55qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9dyuQAKCRDj7w1vZxhR
xfOmAQDAUlEjonuvKgzrcKb89bymLb1GtDfICxmZo8pcsDYFkAEAymQgz1ZZR/ev
9cwmWik25ODTVmrSb0Mf+AKo6XJ2eQM=
=8BAy
-----END PGP SIGNATURE-----

--4tjwk5mvzqfd55qc--
