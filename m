Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4221F283380
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJEJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:40:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57895 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgJEJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:40:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B75045C0078;
        Mon,  5 Oct 2020 05:40:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UHNtaHVM18Po1ku1s/cSW2/azyD
        NvLkXptM713fZpLg=; b=jwhSFG1tDF9gh7ZxtoLOKxRhdQ2ock/dA6wLnl5xidw
        cSBvEYnQL/kcYtk4a6GBNj2EcHBEjbC0iGFP6f+xD+sI9oPafaDjcno8VrEx1n1t
        6TGn2tyNcByTpcn1blg6JOlCBbeggHS9Yoos+5P1/XoLwO+YnKI1dVevzjRJm/Gy
        t7gDHI48ADWNF8sc70Ycbo/k7GvkLg9QJWG+dx1DaCCt/T3EO3WloWrr4ZO92vhB
        hPrJr7ONaPMSdTI9QaxiLYOGDxef8OvkCg1y1rXiHscqgiRYAWTXLzstRtXHGj2B
        C+QI2eBAo+TXlTrmg7uzXZtCGTV2kyWvP8o4Lx1M5kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UHNtaH
        VM18Po1ku1s/cSW2/azyDNvLkXptM713fZpLg=; b=dtIMLXwNtRFO/gyQVk2RF9
        FGDxP7WraMZOWtkqFECPGQV1PmSUBogX0hjEF/9aUmLDeFRXdJTdzG2nYmTWd8mT
        Tt3VXDOJNbSWpERX9vC31rAy9jbWVcwwFPjMRJs7Jl5dIgM7BN5y9j4SEu9Y6p0u
        lNwhNkvQEZ9l6AChr/Yv5s9PBn2ggJnbYPpUsJEgdVjD+ZYJ8nbRPqPkQEmuRhur
        jC1Q93ENc8lGrjpYTCJwwCV9M7dMztAr8kPlGGfyAjEm6zUAcNIhfcrZMPKXz2Oz
        ywV7ePBejI7ecEsTZ7WMDqeg5PsgbJum6IzOpfnRpdnwI66iWk0oNYpkOZQFu9IA
        ==
X-ME-Sender: <xms:Bup6X7nrX_0xamNBV9M3BJ4yypdqR7vdOTz_M8Z5lLt_Z-FolUcUkA>
    <xme:Bup6X-2vIRSz5mSVSiYPxpBj-LDh7xT84mBwXesKLuIHcnOBEkgDO7e6-ryRw9zSA
    rur15yqtio8pjU2UbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:B-p6XxouQ4JjjjCXfnrlo9LowjBK020ydakbMxObREqw1bRmRHR7Mg>
    <xmx:B-p6Xzlp4SL05zHOe77kWwTc8HUfolZ-25sROUrtM-He_fUIDgiU0g>
    <xmx:B-p6X53HUgmpzRPmawEyRuF1WtzcChyfRdDBJY2x7Ozg6qlQTpg9wg>
    <xmx:B-p6XyzIn4Nw_EoPKBiAVUTPU04ME0312s7y5hNepVP3nitwvpjKDQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B10033280063;
        Mon,  5 Oct 2020 05:40:22 -0400 (EDT)
Date:   Mon, 5 Oct 2020 11:40:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun4i-a10: fix cpu_alert temperature
Message-ID: <20201005094021.czx5nryu7hcwckni@gilmour.lan>
References: <20201003100332.431178-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kqznxsxruwtsckix"
Content-Disposition: inline
In-Reply-To: <20201003100332.431178-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kqznxsxruwtsckix
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2020 at 12:03:32PM +0200, Cl=E9ment P=E9ron wrote:
> When running dtbs_check thermal_zone warn about the
> temperature declared.
>=20
> thermal-zones: cpu-thermal:trips:cpu-alert0:temperature:0:0: 850000 is gr=
eater than the maximum of 200000
>=20
> It's indeed wrong the real value is 85=B0C and not 850=B0C.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks!
Maxime

--kqznxsxruwtsckix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rqBQAKCRDj7w1vZxhR
xdmEAQDyTGVDxFy25Vpmyy+kWvmeXSoWDz5mYJpdfsbIRprvXwD9EMsyGefobgSn
soA5/dC86PLdMGChzMmdBd8WiK7WdA4=
=NljJ
-----END PGP SIGNATURE-----

--kqznxsxruwtsckix--
