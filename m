Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90D32AD3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgKJKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:39:29 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49603 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgKJKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:39:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D7A45C0281;
        Tue, 10 Nov 2020 05:39:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Nov 2020 05:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qqTmEswesQaUa1Ejdzm843JqNc5
        QZvhJ/SFzOnyIPnQ=; b=oaufrWieGntS+q2L4ekr7pmu+Z5M1uCZ+ubJO/aCjRD
        RVWkPdDVoQTeK5zw9Eb9R5lOCfl5qGrCLjLJEDwjrEiJkktXXTM0WKKWpG0dhagi
        6MqwNcmRMvGqVi/B8ZAC4hMrmwjFBPwgjLUFX2J98cTJL8VC1QpoAANL2OoyGnAB
        O20jU7RmjO9b+oLUEu1tEN4sDHOeRBuWnbFKDWRhIB5ikRfPIVZFFW8o/GO8kXQ5
        q//7HAjMATPoNlEprpR1zbS3iso+ndZklKA5vDRPSuF20HW+6Py7j7IDDnuyuP0A
        jWwZZIowQuIfehm1cKceaFI4MzIvLIq4QAqxRaJT+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qqTmEs
        wesQaUa1Ejdzm843JqNc5QZvhJ/SFzOnyIPnQ=; b=o++pQlK2ErBuwNlIOP+JQE
        9VOp/nN2/ZaCy9n7aMp/zmO63A8OTIWXqEzT9gIEoYg7+N5EVetiQrQlAx3J9c/f
        1PWDBZziJHjdrk6qsh/1bUijfLfUUXsIQruZscDlfb6bnWkig/CnnVP2UftRBxra
        GHmqRvSTtAVZOZtmsGR1xFdBXak6EzL1k1Yj+P15OjDujilYiui6BryJu8vqtxHJ
        iZ04U+B46Vsr5AN5k26GgDK7LKEfEMt+OMJWaYzYlUu5kxAgvwoUE1WaPfxfGur1
        5rSsRUb3NGolMuMhcrWwL75yNxQnAZ3XavIvVDjGf9CzSN08ZKOeX0NCEGP3yYpQ
        ==
X-ME-Sender: <xms:322qX0C--ycVGAmQ3M6BIQWLNMLiEn82MKmWwxmm01-Hbs-74-Ui_g>
    <xme:322qX2idE149gHMX4LBCc3LJ9Kt4kCBqwU8unz83w_1dW84L1CU30JvDlggWZW_bE
    Ir_ms5XuRYDIM8RR1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:322qX3nNBfFTPigBSx4w9dUGlGRbPkO-wSfIc47DGJkQpdwb6RkL_w>
    <xmx:322qX6yegnT9mogVhOJJ0sSe6xXd5UVsBZgxwY50DYAJtXsC7nkBBQ>
    <xmx:322qX5Tb_6CWm7GRu7N9RPV_1xQ8aye1dSZ9T_j7x13miwB84M_JIQ>
    <xmx:322qXyKQI73NZnB3L4BEMw5GyhazinNDCrz1PfcMUScf-D2FktcBXQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 008D53280060;
        Tue, 10 Nov 2020 05:39:26 -0500 (EST)
Date:   Tue, 10 Nov 2020 11:39:25 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab
 developer sample
Message-ID: <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
References: <20201107124958.2222253-1-icenowy@aosc.io>
 <20201107125332.2223197-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tw2akg5odesxcwje"
Content-Disposition: inline
In-Reply-To: <20201107125332.2223197-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tw2akg5odesxcwje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2020 at 08:53:32PM +0800, Icenowy Zheng wrote:
> Some developers received PineTab samples that used an old LCD panel.
>=20
> Add device tree for these samples.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../dts/allwinner/sun50i-a64-pinetab-dev.dts  | 28 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.=
dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index 211d1e9d4701..a221dcebfad4 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.0.=
dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.1.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab-dev.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts b/a=
rch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> new file mode 100644
> index 000000000000..3a4153890f3e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc.io>
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-a64-pinetab.dts"
> +
> +/ {
> +	model =3D "PineTab Developer Sample";
> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
> +};

Changing the DT and the compatible half-way through it isn't ok. Please
add a new DT with the newer revision like we did for the pinephone

Maxime

--tw2akg5odesxcwje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6pt3QAKCRDj7w1vZxhR
xTCTAQDCOG/0gK+OrCoQt4SNvxx+XWYRAcc5e9VkpT85FmJ7mgEAjxG3P7JwlMDi
FXlbUKjptAzkKVdllmfbAHGIlUO/JAk=
=fiYB
-----END PGP SIGNATURE-----

--tw2akg5odesxcwje--
