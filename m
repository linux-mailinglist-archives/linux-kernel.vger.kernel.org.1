Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B146E2F47E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhAMJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:43:25 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41407 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727527AbhAMJnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:43:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1A7F5580586;
        Wed, 13 Jan 2021 04:42:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Jan 2021 04:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sVZ0Ztx5fNdK6Yp0rBrMipg88ee
        9YvaTdVl+dEFZNiw=; b=lyircXQnL3ZlZTqSl9Rnjh0HFim1x1RDvXqUKs9mUNX
        NunsMGruChk9EeIRa9QfNAD2FcAmh77ifVWaOy1VolhYuLZ6vdUnfKlVywpIStCl
        B7LeYLM80joNXTZlmo/4YnwUsOAdX24y/+v+o1d719Z0qaC0bFIxhHixNJpl77DM
        Fk4qhKRqqkpB3PpWll9T5L/iBXSv8/6tQOPsL7QNa3T77gY4BMc33kLfO8eokijO
        Top2jaiq8AIPeqoiNK96Wc7X9fFZp5t/REMqy7GVucKdPpb/F3kgLiVz2pbU1yCa
        X2OUb7EViuF7KoWTrc2O2oGLbRLwBBJq1K0GjI18lcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sVZ0Zt
        x5fNdK6Yp0rBrMipg88ee9YvaTdVl+dEFZNiw=; b=QJon1VjEvJDnJ7Z9NG7LQF
        uIQBTqKff688IJhFdIaVv4djYs3iKGFhs+P9YV2U6PaTlGIYpaLyjdOQPy+CyQbT
        mZizDN1y4XZI69dFr/tGXLqdus4MHOKhULhFB6ODJpONAuu9nBYNpzVjN631lCXl
        yyX9ohmjZzhtB9qKoRjMoqqw01qOACoA0vzyT14ErMZOUYlBQYUuTtsrHWjBu1P7
        +7M8xNHGgwLwSTAELuPaogRchPoqnTzK23islM98RXHwW2s4hSiHgWTQK9dL3DGV
        BWotFKOWKiVpikB9djHdcB+lpmX/SU7MUa7fLBAyyDQFGD8RwqPPIX86PAuQeA6A
        ==
X-ME-Sender: <xms:d8D-X3REvTWqTPAs7-ie20OFJlZ2BTfJFyM_7VfiJCMLogZIdBPe8A>
    <xme:d8D-X4x5_OdlCEd20Ity9W4nidYNzFt7p7L9q0Fy7aNYFMaaamgSlij4mq0HaIU_V
    Mz6PdlfZaU8mA3fDMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:d8D-X83gIwjv8X0xiNHAyOcOYU0NHKbsdqy9PWEsIshC088BzFyXMQ>
    <xmx:d8D-X3BRHvsiDPf9_SDm8bazgLRLnrX2bR5RwruyIR6ZA6TSIgofvA>
    <xmx:d8D-XwgRl5jSKhrJXJqJzsz5fGr9x6FwvtknGx-MsXJXb_4kUNjoUg>
    <xmx:ecD-X5WWcE1P6LVSmF_xBRhZFY4C-G5CEgTnUHjIs2-Rrr-bnb665w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F45924005C;
        Wed, 13 Jan 2021 04:42:15 -0500 (EST)
Date:   Wed, 13 Jan 2021 10:42:14 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH v3] drm/sun4i: tcon: fix inverted DCLK polarity
Message-ID: <20210113094214.5ijq3inmffticym6@gilmour>
References: <20210111172052.7v522xam74xkq6se@gilmour>
 <20210111174616.904674-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3pcmprkewkka3w63"
Content-Disposition: inline
In-Reply-To: <20210111174616.904674-1-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3pcmprkewkka3w63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 11, 2021 at 06:46:16PM +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>=20
> During commit 88bc4178568b ("drm: Use new
> DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags") DRM_BUS_FLAG_*
> macros have been changed to avoid ambiguity but just because of this
> ambiguity previous DRM_BUS_FLAG_PIXDATA_(POS/NEG)EDGE were used meaning
> _SAMPLE_ not _DRIVE_. This leads to DLCK inversion and need to fix but
> instead of swapping phase values, let's adopt an easier approach Maxime
> suggested:
> It turned out that bit 26 of SUN4I_TCON0_IO_POL_REG is dedicated to
> invert DCLK polarity and this makes things really easier than before. So
> let's handle DCLK polarity by adding SUN4I_TCON0_IO_POL_DCLK_POSITIVE as
> bit 26 and activating according to bus_flags the same way it is done for
> all the other signals polarity.
>=20
> Fixes: 88bc4178568b ("drm: Use new DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG=
)EDGE flags")
> Suggested-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 20 +-------------------
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>  2 files changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index eaaf5d70e352..30171ccd87e5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -569,26 +569,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tc=
on *tcon,
>  	if (info->bus_flags & DRM_BUS_FLAG_DE_LOW)
>  		val |=3D SUN4I_TCON0_IO_POL_DE_NEGATIVE;
> =20
> -	/*
> -	 * On A20 and similar SoCs, the only way to achieve Positive Edge
> -	 * (Rising Edge), is setting dclk clock phase to 2/3(240=B0).
> -	 * By default TCON works in Negative Edge(Falling Edge),
> -	 * this is why phase is set to 0 in that case.
> -	 * Unfortunately there's no way to logically invert dclk through
> -	 * IO_POL register.
> -	 * The only acceptable way to work, triple checked with scope,
> -	 * is using clock phase set to 0=B0 for Negative Edge and set to 240=B0
> -	 * for Positive Edge.
> -	 * On A33 and similar SoCs there would be a 90=B0 phase option,
> -	 * but it divides also dclk by 2.
> -	 * Following code is a way to avoid quirks all around TCON
> -	 * and DOTCLOCK drivers.
> -	 */
>  	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
> -		clk_set_phase(tcon->dclk, 240);
> -
> -	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
> -		clk_set_phase(tcon->dclk, 0);
> +		val |=3D SUN4I_TCON0_IO_POL_DCLK_POSITIVE;
> =20
>  	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>  			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |

You need to add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to the mask you're
going to change here too

Maxime

--3pcmprkewkka3w63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/7AdQAKCRDj7w1vZxhR
xQLGAP0X8oNPTVI87XmeOmU+YDgckqjJxAB9WYOy6S4UiDCqwQD/fK9mZpYgZ7X7
hB6CJ260O2sFzlshJPpkkTPLwNW7ego=
=Gijn
-----END PGP SIGNATURE-----

--3pcmprkewkka3w63--
