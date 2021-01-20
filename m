Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15122FCE33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbhATKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:59 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34843 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730568AbhATKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:00:15 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CF4705C019E;
        Wed, 20 Jan 2021 04:59:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 20 Jan 2021 04:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=KD++98fmxbqoHnG4tp/j4XYmChQ
        7QOlWamvweXUDQ3Y=; b=WpPgrtKWICMsBBArlorjowKo2Byk6W+IVoFqktPctv0
        eaelRqEQ3rweZpoqzl841gXisG+FygUcn9DlxGSvJ39jxMEMEv0mZqlWod3dbCjg
        svOYOarKYQ9EHnOAgOJLNtOE63fEZxlcWX510d29B5htw05r2cnPqyqrUXzCf6+l
        6GJhSJqwZAt3ScfPxVnEP5bcZ/szD8zfRr+so+c3AkvC/wP2ss9a+gMWCEB75Uef
        NpfJpJ9hCQyNwD+TxuJEl78NaRNPnTaqCsFbMNkzAUfnUuR2tRbdtId9EIT83+qj
        yglqyQV/dOYLZss8gnpdgsZpKSRtRJeZ2lgqIskDHXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KD++98
        fmxbqoHnG4tp/j4XYmChQ7QOlWamvweXUDQ3Y=; b=kz6jQ9MAjXHG/qFfAQwH3d
        cx2/BkEtzIHznRTPcVkvCM/KOvctt3E1MCctQbWfI/f3ZY5oPmUb7BMEZP48I1HP
        UIW2vBd6IidoCotdU4fgsL00Oob+fWJpz9Fz8m9NckLdKsDFnLMZLUdjCzs5O/Ml
        yzqMrxIuADX0eJzdw2cf+GNxuWHYiZDvu4OuQQURjppZKdjaJkXpEc8INhMDSY2j
        yJuFC7Ht6YL9su6dLyXMOCvH7unMd2qYmZu1dz4k4Ud0/IpexLgL/TR0P8+aY0Q0
        +mK7HFojdI6tnZo7a9e2CnQa6U1yapGOHuhkGuEZMAZXIVk3nb9rhGcVd7qQRF8g
        ==
X-ME-Sender: <xms:5v4HYHm4GBZF2tUKk6MciFuk0c5gRbhTnxllg0DBrWc_zLZLfmyOTg>
    <xme:5v4HYK1dxePo9b1tm8D2uzFwlkKFg8rPaxrT0X0WE71lL7OdPkQfp-OUZm3hx9Bc7
    L0MBv7MujtRaK28iJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5v4HYNqoDqbJzRJmcGPmT0OQZ8MpEXHqFyRsPIoYjqKf-RH--vRDDw>
    <xmx:5v4HYPkszdnO3nHT_EVUIXXIkTGl5MkpNwyxcwzqH8hP2Ffje5imbw>
    <xmx:5v4HYF2gk7LIlFjg0IxTx1XauOB3KT0qlAd7TokSO6DPmHJevAl2Dw>
    <xmx:6v4HYPot-W8GxBfSkPArjR0HZUGQ0XKbMR0K52XeQSgIliwbwgTzPg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0765A24005B;
        Wed, 20 Jan 2021 04:59:01 -0500 (EST)
Date:   Wed, 20 Jan 2021 10:58:59 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/20] clk: sunxi: clk-mod0: Demote non-conformant
 kernel-doc header
Message-ID: <20210120095859.otg7npva5uzsleks@gilmour>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
 <20210120093040.1719407-19-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qufllwearrsrgr2d"
Content-Disposition: inline
In-Reply-To: <20210120093040.1719407-19-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qufllwearrsrgr2d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 09:30:38AM +0000, Lee Jones wrote:
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/sunxi/clk-mod0.c:24: warning: Function parameter or member '=
req' not described in 'sun4i_a10_get_mod0_factors'
>=20
> Cc: "Emilio L=F3pez" <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied all three sunxi patches

Maxime

--qufllwearrsrgr2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAf+4wAKCRDj7w1vZxhR
xXwVAQCTjlsSXUfuGpihRn+a4m0GtibT9giWyg0LX1gqqV8/QwD7BaKMxWHuXNOZ
nfhOS1R4EI0Vz40z2MJu9D2iNM4ikgk=
=m46P
-----END PGP SIGNATURE-----

--qufllwearrsrgr2d--
