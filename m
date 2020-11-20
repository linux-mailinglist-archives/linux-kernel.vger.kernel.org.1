Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A05F2BAEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgKTPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:24:51 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51799 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728503AbgKTPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:24:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 267755C00C4;
        Fri, 20 Nov 2020 10:24:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Nov 2020 10:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UaoxLfN7wRJfSNyGLfSNLFU9/o5
        5mjdfEsw0wlHPgV8=; b=KxGtUuA8uFNlGXoldryWeW2jsmxPDTHiNnZ4W0FB9GM
        WbNBJu3f3VLJfxTUMsAenrw9b2WlsMgFh07f7XIUVubJdsBij2hZzftK7yrhTCHX
        H1Zg3IEQ1V+nUE7kKOVpyxJJfaCJjBXb7iIRhSElav0cjQH9B+xF8x6LQKlztOvo
        3EWuo7SgLlG+j6LbNJrMB/sHAq9jcXq5WjXqJEQZPt7Ugyukt1Xut8yidY+4Hugv
        eoBbNqSC9DYKKPSa3axwxLRL7AxBP/VjqzWwbbo3UMNTPAWTA/8Hzu0/DTTDcVXr
        HpAJ4tR4ApkxPqupHIscvlBIrfl1AyXDP6H23I5Y9Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UaoxLf
        N7wRJfSNyGLfSNLFU9/o55mjdfEsw0wlHPgV8=; b=FGEpp27Gf/TYzfjC6JAPTE
        CyhKhhOfU0wFjuNnQpygGm6qOniCM9U4ntLrBDCULjN9OdEJhGRLa50wGMCXxdP6
        Hml2hixrnLRM0Da1uyXkTsRqU4hROTfOg2xeGUHiZlMwAcFbVdeW+EHH5ONdPrPV
        /49IVO74jabTyzaOQuwBLHn13J+MQNirF8aD7X5FtBa/w9waftWNl0zEgNdAMWtX
        +UDmEr7Wl97owoIJx3G7wpikxqFN8itKiMAEszoLemJuVUaD3DskzsndKpTjVKQM
        pXwCIc7oGq+QNO4G6MW3q6722q0N0Jel8cHHiythxF5kq6nxtGL9XPnqgY4KIP6Q
        ==
X-ME-Sender: <xms:wN-3X9Of4geDOHYMcBgO_HHq1JgGgHTcILg05wO9FTRM3-Gc2Q2sTw>
    <xme:wN-3X_-6j489esxjAoP_qwREhTlMLkwcrt1mDKKfDJVz3pVu8vYf3JO46vD6BnItS
    gsDTyaS0TT1OyRgRPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wN-3X8QQqL7YvUOKuGZg_W5oMsTRS1_LwV_kagJpMV1V6uOfg_7MeQ>
    <xmx:wN-3X5unMt43ZZRwj-X8qV0lETHfaioswzW8eBaQS2WnaUdqqcvggg>
    <xmx:wN-3X1djTke61wki3-6sU9kDU9pGRdDuq23BVxtPBaMKv_Ge0rbOlA>
    <xmx:wt-3X-F1Xzt2NNqz07oAONyqOiujHJ3DlXF9Kk-UeMUOTRXoEDHrXw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF1CC3064AAF;
        Fri, 20 Nov 2020 10:24:47 -0500 (EST)
Date:   Fri, 20 Nov 2020 16:24:46 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH 1/2] clk: sunxi-ng: a64: disable dividers in PLL-CPUX
Message-ID: <20201120152446.qk7lfeq7lsoylnma@gilmour>
References: <20201109053358.54220-1-icenowy@aosc.io>
 <20201109053358.54220-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3nf5hzcf5bhrpdqk"
Content-Disposition: inline
In-Reply-To: <20201109053358.54220-2-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3nf5hzcf5bhrpdqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 01:33:57PM +0800, Icenowy Zheng wrote:
> According to the user manual, PLL-CPUX have two dividers, in which P is
> only allowed when the desired rate is less than 240MHz. As the CCU
> framework have no such feature yet and the clock rate that allows P is
> much lower than where we normally operate, disallow the usage of P
> factor now.
>=20
> M is not restricted in the user manual, however according to the BSP PLL
> setup table (see [1]), it's not used at all. To follow what the BSP
> does, disable this factor too.
>=20
> Disabling the dividers will make it possible to remove the need to
> switch to osc24M when doing frequency scaling on PLL-CPUX.
>=20
> In order to prevent boot-time usage of dividers (current known mainline
> U-Boot implementation use m =3D 2), tweaking of the factors are done when
> probing CCU driver.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 79 ++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
> index 5f66bf879772..6108d150a0e3 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> @@ -23,13 +24,14 @@
> =20
>  #include "ccu-sun50i-a64.h"
> =20
> +#define SUN50I_A64_PLL_CPUX_REG		0x000
>  static struct ccu_nkmp pll_cpux_clk =3D {
>  	.enable		=3D BIT(31),
>  	.lock		=3D BIT(28),
>  	.n		=3D _SUNXI_CCU_MULT(8, 5),
>  	.k		=3D _SUNXI_CCU_MULT(4, 2),
> -	.m		=3D _SUNXI_CCU_DIV(0, 2),
> -	.p		=3D _SUNXI_CCU_DIV_MAX(16, 2, 4),
> +	.m		=3D _SUNXI_CCU_DIV_MAX(16, 2, 1),
> +	.p		=3D _SUNXI_CCU_DIV_MAX(0, 2, 1),
>  	.common		=3D {
>  		.reg		=3D 0x000,
>  		.hw.init	=3D CLK_HW_INIT("pll-cpux",
> @@ -215,6 +217,7 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_clk, "pll=
-ddr1",
>  				   BIT(28),	/* lock */
>  				   CLK_SET_RATE_UNGATE);
> =20
> +#define SUN50I_A64_CPUX_AXI_REG		0x050
>  static const char * const cpux_parents[] =3D { "osc32k", "osc24M",
>  					     "pll-cpux", "pll-cpux" };
>  static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
> @@ -954,6 +957,78 @@ static int sun50i_a64_ccu_probe(struct platform_devi=
ce *pdev)
> =20
>  	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
> =20
> +	/* Disable any possible dividers on PLL-CPUX */
> +	val =3D readl(reg + SUN50I_A64_PLL_CPUX_REG);
> +	if (val & (GENMASK(17, 16) | GENMASK(1, 0))) {
> +		unsigned int n, k, m, p;
> +
> +		n =3D ((val & GENMASK(12, 8)) >> 8) + 1;
> +		k =3D ((val & GENMASK(5, 4)) >> 4) + 1;
> +		m =3D (val & GENMASK(1, 0)) + 1;
> +		p =3D 1 << ((val & GENMASK(17, 16)) >> 16);
> +
> +		/*
> +		 * Known mainline U-Boot revisions never uses
> +		 * divider p, and it will only use m when k =3D 3 or 4.
> +		 * Specially judge for these cases, to satisfy
> +		 * what will most possibly happen.
> +		 * For m =3D 2 and k =3D 3, fractional change will be
> +		 * applied to n, to mostly keep the clock rate.
> +		 * For m =3D 2 and k =3D 4, just change to m =3D 1 and k =3D 2.
> +		 * For other cases, just try to divide it from N.
> +		 */
> +		if (p >=3D 2) {
> +			n /=3D p;
> +			p =3D 1;
> +		}
> +
> +		if (m =3D=3D 2) {
> +			if (k =3D=3D 3) {
> +				k =3D 2;
> +				n =3D n * 3 / 4;
> +				m =3D 1;
> +			}
> +			if (k =3D=3D 4) {
> +				k =3D 2;
> +				m =3D 1;
> +			}
> +		}
> +
> +		if (m >=3D 2) {
> +			n /=3D m;
> +			m =3D 1;
> +		}

I'm not sure we should rely on the behavior of U-Boot there, and ideally
we should move that code to a function of its own, but on principle I'm
fine with that code.

Maxime

--3nf5hzcf5bhrpdqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7ffvgAKCRDj7w1vZxhR
xd28AQD9w1xokupfQdYriTJcn9l3o+Q7XBMp/B63TSz5v6fQuAD/TXna8QEDRCcW
bhI9SqhKPRexFI7avDFLV4TT/KsGGwA=
=NH26
-----END PGP SIGNATURE-----

--3nf5hzcf5bhrpdqk--
