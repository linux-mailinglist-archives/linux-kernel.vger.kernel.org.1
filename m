Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4E2D998E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439091AbgLNOPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:15:11 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46879 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438848AbgLNOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:15:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9864A580264;
        Mon, 14 Dec 2020 09:14:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 09:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=RCeXuv10zP/8MzcFIhLlQWXE0aB
        CI5Zj/Gl0vxB5cPU=; b=mv6C5ng9UTV+bK262jts9CRIusaO9oQ/eaPF3BsoisA
        WAzRSnEO3mG1QEoJgl+4GQtmdH7Po6EfTQMgSef0vdorC/F7Kurjv6UWXmRS0WTh
        uUp7o8QH/Fy0d6i6zP+sqysxh9Q/+rkCqsaxoigd++Q9q9XjwQ71nZEEaXCjwTZy
        vptPpb0dI5X6MHxAVN50RKPC9FA99qNF6G7QHyh+vzpo4kzn+/WOB2DZaSMZt2+o
        Mp3S+ZpKdg6yx/1J6nqSQHAHPLtiaEWd5kMitUowICSjMMmGacpKo+HyXAX2U7T7
        UHEL8l73SaPLvSJ8TJe2KE7rDctQAsuIWxmRbaupeIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RCeXuv
        10zP/8MzcFIhLlQWXE0aBCI5Zj/Gl0vxB5cPU=; b=KkonWNVg0AnbvVwKToZx/F
        UsrUvT7Nzc8UnYIQWiH7ySfg3NVtB1ADi0eRnybrtLkRSJwamcwBQsBvBaaafyaH
        /S6WBWVnukEhXxYNmfz+Tnkn4Kh9eXBgn2bjmxnGmJFvVyOzJ37HjZbXx65GHU8C
        ZrldTSIeEpBifVcaeHRWUBoDYVt3b1UC9WRwX9Ly9UYtpGEJmZide06TnMKD2xJd
        fsyYNqioJ4Pt6DZohBpsRqYgIc5AWXEFcDATUJQokzY/sfA5lHixcxtoWG+WNVGM
        suw9rW1oHjRFOjhDBzPfCBHJl0Bred/6C6MRiTN6+OiU8RLTOd0ROYaAr6TcPz0Q
        ==
X-ME-Sender: <xms:KnPXX2BL7dRAMX62EshOv6iL4UttJ1yg62m-cxpemNaLkt795VZ9dg>
    <xme:KnPXXwh0N98RPT9DBsS97UtdJy2irB_WqMlj6JcopNv9eBHqGukSCjTrfLXggP7dy
    jxvqET0LX8xECSAxyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KnPXX5nvm7uQDEUQgB_bRXpamrbYvwR5u0AOJS2QbrqU9b-rzZGqCQ>
    <xmx:KnPXX0zml86MUIx71PaOPKW3tDqwN_9ofbOkraaJZ3ANdrN3sr1zuQ>
    <xmx:KnPXX7Qa6eEOYMTaBFRhJ834pmLSWMnQHKbImGPyichkhCbeQpuEmQ>
    <xmx:LHPXXwLCW1g3NtC-WM-kWV_8yPTJre-wRjrJ3Vi13e6GRnqCjQOrbA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 801E4108005C;
        Mon, 14 Dec 2020 09:14:02 -0500 (EST)
Date:   Mon, 14 Dec 2020 15:14:00 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 19/21] arm64: dts: allwinner: Add
 Allwinner H616 .dtsi file
Message-ID: <20201214141400.des3jwfhmbnxd7xe@gilmour>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-20-andre.przywara@arm.com>
 <20201214095831.j63nks3fqxlaw75w@gilmour>
 <20201214125343.0cd1bc6a@slackpad.fritz.box>
 <CAGb2v677X7h_Xo3L6gP0Ws4P0ROmZ0LhwNStZk-zcL7XtTRCLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64zcwd4wdxdwsyj3"
Content-Disposition: inline
In-Reply-To: <CAGb2v677X7h_Xo3L6gP0Ws4P0ROmZ0LhwNStZk-zcL7XtTRCLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64zcwd4wdxdwsyj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2020 at 09:28:36PM +0800, Chen-Yu Tsai wrote:
> On Mon, Dec 14, 2020 at 8:53 PM Andre Przywara <andre.przywara@arm.com> w=
rote:
> >
> > On Mon, 14 Dec 2020 10:58:31 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > > On Fri, Dec 11, 2020 at 01:19:32AM +0000, Andre Przywara wrote:
> > > > +   reserved-memory {
> > > > +           #address-cells =3D <2>;
> > > > +           #size-cells =3D <2>;
> > > > +           ranges;
> > > > +
> > > > +           /* 512KiB reserved for ARM Trusted Firmware (BL31)
> > > > */
> > > > +           secmon_reserved: secmon@40000000 {
> > > > +                   reg =3D <0x0 0x40000000 0x0 0x80000>;
> > > > +                   no-map;
> > > > +           };
> > > > +   };
> > >
> > > This should still be set by the firmware
> > >
> > > > +           mmc0: mmc@4020000 {
> > > > +                   compatible =3D "allwinner,sun50i-h616-mmc",
> > > > +                                "allwinner,sun50i-a100-mmc";
> > > > +                   reg =3D <0x04020000 0x1000>;
> > > > +                   clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu
> > > > CLK_MMC0>;
> > > > +                   clock-names =3D "ahb", "mmc";
> > > > +                   resets =3D <&ccu RST_BUS_MMC0>;
> > > > +                   reset-names =3D "ahb";
> > > > +                   interrupts =3D <GIC_SPI 35
> > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > +                   pinctrl-names =3D "default";
> > > > +                   pinctrl-0 =3D <&mmc0_pins>;
> > > > +                   status =3D "disabled";
> > > > +                   #address-cells =3D <1>;
> > > > +                   #size-cells =3D <0>;
> > > > +           };
> > >
> > > Somewhat related: we shouldn't set the MMC speed flags in the drivers.
> > > This is biting us on the already supported SoCs, so it would be great
> > > to not repeat the same mistake with the new ones
> >
> > Do you mean to list the "sd-uhs-sdr50" and friends properties here in
> > the DT?
> > What is the best practice here in terms putting them in the .dts vs.
> > the .dtsi? Surely the controller has limits, but bad traces on a board
> > could impose further restrictions, right?
> > Though that's probably rare, so it sounds like a lot of churn to list
> > them in every board DT. So can we list everything in here (.dtsi), then
> > delete in those affected boards only?
>=20
> The driver will most certainly already have the basic high speed modes
> enabled. Or we can list them in the .dtsi file.

I'd list them all in the DTSI, trying to be smart has bitten us already
so I'd like to avoid it as much as possible.

And if we find a better way, we can set it in the driver if it's in the
DTSI already. doing the opposite would be harder

Maxime

--64zcwd4wdxdwsyj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9dzKAAKCRDj7w1vZxhR
xYxQAQD05F90JhDUdr3GvaKEJQquCi8Tn5R6I8mNQHN9twlqtAEA/M9pX42neqt3
LRIEV6YkIcUb/12pIeA4eDNUBy27sgk=
=gQPC
-----END PGP SIGNATURE-----

--64zcwd4wdxdwsyj3--
