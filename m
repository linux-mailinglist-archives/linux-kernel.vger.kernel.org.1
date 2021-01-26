Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699B6304336
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404342AbhAZP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:58:23 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37579 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731383AbhAZPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:55:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 387118A2;
        Tue, 26 Jan 2021 10:54:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Jan 2021 10:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=WEhBWcXfYR0hSsHK9E0r3hiNKHR
        ePLjjhBxL3as/9sE=; b=JOEresn8MPDAspRi6prGDc+No1q7PVUbhDpq7HTLhQK
        JNhH5RHWDaPRXw9u7EHSqQ8P08wangpwIORfTPz+hSfWsh6mAiJRShPI4k19v3la
        0UzvqrKN3Z5JLnOW54DQV0oByrp7xPnAcwBNGnRjokO7ZeKhTcdVlOsNaYMeyJQj
        5ksTh96KeT9RVKs7YMI6XiYc980Urf7ThMHG1HV1F1vMS5t9h7U/nLSScvz8OUiX
        WrfZjyaDYu/C7YIKCbmGuvBqxjDS79KnsUETXoPhWPT+pufNvD95vgwWyeP0PChY
        jBYSh3EcVne0BgMhn7d8WVGFwSbyb1w34V1al2p04Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WEhBWc
        XfYR0hSsHK9E0r3hiNKHRePLjjhBxL3as/9sE=; b=XwanmoC3uY6llMW455zQRg
        UY9hFOH/7Dn6KoIe0Rmoy8az2yCtYiif70lB1aVY6DM+t1VtEUKBGZw/qMW0WFBl
        EtK2lH3JEbZY2N/ULCfFc2Cv8VITJC+qoOsIzI3o+FWGuHtoov+vkGS5IUJzr5KX
        Y2ZptQMyShDRUWGiu+rCENWU03qzSkLPRzzG53tJmOGR6xtOReP00W/owhEUe2Pl
        JHnuLZ6sWCJxCX1eTe8KwZNzwKm2Gxq7zOxt5nEvc1qS2Z7vv0ASTv7PkJUBJGWW
        UtQpB6FeihVv4CfDe6hYyQtpO6fuq6KjT/fQaaOK2BiRr0chVHrn2bpohq1y6I8Q
        ==
X-ME-Sender: <xms:ODsQYDyl7rcfWDo1hcxU_FA6YLDKLhYxrbc12-qCyuCtUz7xBP1nOQ>
    <xme:ODsQYLReVlzHXLNoV2aIih0J3Yb2K7IrAKJ2RLuYYEv0e45ttHQxnru2Wdo_OtDgE
    Ed8zrYACB-o5yOINbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeigddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ODsQYNViLEcViZFqy3zuhvIt0bSulyiPnXXaNGjKqtdXlGsu6CBfEg>
    <xmx:ODsQYNje8EXOJWtn7gj0DNeqt3glrKu6FS8Xns6WZPjuxDdqttLSFg>
    <xmx:ODsQYFC2KCtpoGkrwyq0NP62kwYFWT_VOIC2U-VlRvVLQuo0khlLOw>
    <xmx:OTsQYPD9pHqGOerf-T4a20UT96gDPLtcFfmcYRxGnZ-dSPScJzjB3A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 077C524005A;
        Tue, 26 Jan 2021 10:54:31 -0500 (EST)
Date:   Tue, 26 Jan 2021 16:54:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/21] clk: sunxi: clk-sun6i-ar100: Demote non-conformant
 kernel-doc header
Message-ID: <20210126155430.llxijnwf5i4z3end@gilmour>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-13-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qnn2dox7m5n4tnba"
Content-Disposition: inline
In-Reply-To: <20210126124540.3320214-13-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qnn2dox7m5n4tnba
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 12:45:31PM +0000, Lee Jones wrote:
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/sunxi/clk-sun6i-ar100.c:26: warning: Function parameter or m=
ember 'req' not described in 'sun6i_get_ar100_factors'
>=20
> Cc: "Emilio L=F3pez" <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/sunxi/clk-sun6i-ar100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-=
sun6i-ar100.c
> index e1b7d0929cf7f..54babc2b4b9ee 100644
> --- a/drivers/clk/sunxi/clk-sun6i-ar100.c
> +++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
> @@ -16,7 +16,7 @@
> =20
>  #include "clk-factors.h"
> =20
> -/**
> +/*
>   * sun6i_get_ar100_factors - Calculates factors p, m for AR100
>   *
>   * AR100 rate is calculated as follows

This is the sixth patch doing the exact same thing over the files in
that folder you sent. Please fix all the occurences at once

Maxime

--qnn2dox7m5n4tnba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBA7NgAKCRDj7w1vZxhR
xYO7APwOiVCyUAzi+H1ya3JfgPFkWNp8lSe27PibLsdTLuL4FAD8Cba36b3FZnYw
MHel4mag1MjL961Dlv0HLQVQRetMewM=
=L8vk
-----END PGP SIGNATURE-----

--qnn2dox7m5n4tnba--
