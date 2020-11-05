Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CC2A7CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgKELXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:23:25 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50711 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgKELXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:23:24 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 19966AD8;
        Thu,  5 Nov 2020 06:23:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Nov 2020 06:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=saApchnd9aN1F8QDQQZsmhefo66
        C5NpK5CQWBv8jLUM=; b=CnXXs4w/JaweKP68NtUEXG6JZIFR/BJ0MjWYNtGalD0
        0YetkSkyd1ik9YKAi/yH29FVvFKvdcnmKxANTXKW7Y8q0A17OXDwlWa4VvURdp+4
        lTdQD/iMKgBna/pqxBwo4fJv6ebUpaHlwQ5ACkASfa2I3ounz6Il7kli8fOWPGvA
        iQy8i9wwnyoAYPmrWu3LSNwg1LGobccEKY0R5pB9rNaJy44x+U4qVPDnR7E7A7vE
        X4ofiXWD7/7c0EkbF9dM9eDSR7CZsDEfjE84rlpd0p4aIXQ0YutMDNZ3ZL6fFJ/W
        WaPqxL+bF9uRLrdfEgnWLZIvgOTJMDZpdjY1dwcb8/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=saApch
        nd9aN1F8QDQQZsmhefo66C5NpK5CQWBv8jLUM=; b=bz3GifiSwXw9JO0EPAt1Xr
        DkT2eRjXmevE5ou8T/gzpKdf+CUIz+d5IvcJ4Alns1sfl4L4TtNfbnxvxFSPk+rN
        Sj8I9FQboYMUfSfPtVBcJs1NdOPwMGs5x2DeiLv0aTF1JLXORkrHBCHxkK0txpKV
        LG5LePVxRMcmJKKN6JHtKBV91RGxu2026ABhHVm2pVQUCQv0qopr3MelT/XUTZ53
        oTJk1sOmqUxeMnMvsNp6EKB//j7xTDDovMVsPCFFH5bbgb+FSs5fgNWfyJ5RFPtl
        bgfCKM0Gs4hHvJVmHyqZZsgHMlu4srKJYwRz9aEgaNeUHaZ9daMpQN5XfNcftx8g
        ==
X-ME-Sender: <xms:qeCjX1eqEQIZL01WT7RgkORr5d-rxamBCilDditRRI-Jx_ntPGqNAw>
    <xme:qeCjXzPNuYJQbp7NmJzwOMm-4JyXbHGzG1CJQOvMwnv8uE4aPyqsfSohW6uJSGzyR
    k_xlB1HeZvtqU_pcas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qeCjX-iI3PP-jkrvjiINI13ttpCB4T_g2RHeOUoFR5T3qLvTsaJJ1w>
    <xmx:qeCjX-8mqqKfS2iOfFeJC_QQaJ_RKJ_ziLp9XkR521JxqSUcVdptOA>
    <xmx:qeCjXxsSBYSHUhyK6KAls4p6gsrVYTW9JKh-4uUSS25mHDiBO_lnEA>
    <xmx:quCjX1hTqiQVjn_Wv74WenX6cJY9U4mGvE8hYilYN7fvqHh2rxGU5w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2640C328038D;
        Thu,  5 Nov 2020 06:23:21 -0500 (EST)
Date:   Thu, 5 Nov 2020 12:23:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH 4/6] arm64: dts: allwinner: pinephone: Add
 light/proximity sensor
Message-ID: <20201105112319.ic2gpb7bbsqn2ueh@gilmour.lan>
References: <20201105054135.24860-1-samuel@sholland.org>
 <20201105054135.24860-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="knxcwgcsvx5clfix"
Content-Disposition: inline
In-Reply-To: <20201105054135.24860-5-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--knxcwgcsvx5clfix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 04, 2020 at 11:41:33PM -0600, Samuel Holland wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> Pinephone has STK3311-X proximity sensor. Add support for it.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index e595a8262920..9544d7658794 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -160,6 +160,16 @@ lis3mdl: lis3mdl@1e {
>  		vddio-supply =3D <&reg_dldo1>;
>  	};
> =20
> +	/* Light/proximity sensor */
> +	stk3311@48 {
> +		compatible =3D "sensortek,stk3311";
> +		reg =3D <0x48>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <1 0 IRQ_TYPE_EDGE_FALLING>; /* PB0 */
> +		vdd-supply =3D <&reg_ldo_io0>;
> +		leda-supply =3D <&reg_dldo1>;
> +	};
> +

The node names should be the class of the device, not the model. The
other sensors here have a similar issue though, so I've applied it, but
could you send a subsequent patch fixing this?

Thanks!
Maxime

--knxcwgcsvx5clfix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6PgpwAKCRDj7w1vZxhR
xb4EAP40bgyEBW8OeoKMzjDfEITAHRSYuB1ae+OOUgKZ9xq3pAEAsAObBDHRV4NG
quljybM2usk4/ikTRfohfYgDfdr31QM=
=M/60
-----END PGP SIGNATURE-----

--knxcwgcsvx5clfix--
