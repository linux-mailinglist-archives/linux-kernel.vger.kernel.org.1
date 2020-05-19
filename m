Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619871D932D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgESJTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 05:19:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43731 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgESJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:19:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A9315C014D;
        Tue, 19 May 2020 05:19:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 19 May 2020 05:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=RjzoA5kxlUIi7c22hbhNakxq1i/
        NbiM1nWgOxKJ79PU=; b=L9XA01kPY5Bz457PeQ68LrOZf3JTP6TCPJRTBQsayR1
        MxW3vC7o0wYvTY2SBMf350kgIS9VSTAKKuc3f9PFrEDrhdsnoLEt84ChDp8c62W2
        2to8A7cxDTcoJ59SoAQhOvhVVV3PtcTHRu/YNidC+WvykbtV3SS64nhPIAy26/rl
        0lXPAwdYFyCVY31IisIvVVQfuSliVDVnowdCzHx+u6e/ceoOsYWZYYn9OfLG/bvu
        6UKeQeiigDGRfwZSYIgeGnJoK2jBlqUdiNpegeXuLvIkIO0Td1IZlm6aOrIIhjBj
        I4bNhsjxR81qD72a0F3lftECHlZkrofkfpPENYlzCNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RjzoA5
        kxlUIi7c22hbhNakxq1i/NbiM1nWgOxKJ79PU=; b=YnnKw8WqySzv8EpKdOJQhn
        S4BZ6dMvtgN4O3CWC6cMkAZYvP8sN5ExD2+6NeG/gPB4LE1cjLvsqnscphQqZrNT
        WjGNRZkgeiX8LwvBxQcWTmtHMBnrCPbWNl/20nzus5PwlylMkfvqZY9AMCuyNell
        ZqICMmlqSKckt+6gs8LqY4Y9CkQpTdE19ZN95WBnM5aRsmAqk9EmKBvhlbpK0E+t
        bhowuU0rM8dTMLv77e+tqdRW1WxXjArGbE1Gv4EPTdyiWSreHxzT0ZEnWoEfywLG
        qs3tUOPhtAJCKxeNrb03/u1EFqFlwgnLt+ffbm0fJEvQhh4EVC7B7YJQsDf/rZFA
        ==
X-ME-Sender: <xms:jaTDXhX74D2PtSH6Ed-MSz404V5g_hOOrfPFkqcwyA0_iGToAKra_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jaTDXhnisW_NY6g49Qwn0g2aV7aX08-pazdtmo77QzEDcTOMzASBNQ>
    <xmx:jaTDXtYSTHSlhuHoyuZpAyGP-ezIycnM4206cFt8LKTMzxK9ePKAMQ>
    <xmx:jaTDXkW1exOZHihzsbKK1UPGxxRc43yqGzQl8m01CiEwKDYjyNPGTg>
    <xmx:jqTDXmszpfbNE2BXbgDvDRnLjJXx1TeXPLyut1BYimM2fbQ920A5ZQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12776306642F;
        Tue, 19 May 2020 05:19:08 -0400 (EDT)
Date:   Tue, 19 May 2020 11:19:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] iommu/sun50i: Fix return value check in
 sun50i_iommu_probe()
Message-ID: <20200519091907.ulpo7mu5fsfqszcf@gilmour.lan>
References: <20200519091857.134170-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="74zdazyhkrmz3gaa"
Content-Disposition: inline
In-Reply-To: <20200519091857.134170-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--74zdazyhkrmz3gaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 09:18:57AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_platform_ioremap_resource() returns
> ERR_PTR() not NULL. The NULL test in the return value check must be
> replaced with IS_ERR().
>=20
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--74zdazyhkrmz3gaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXsOkiwAKCRDj7w1vZxhR
xVpwAP0TCPZzgy5kSKkqW1DtDNUXKg/Gg5CGSNLmLbi8KqlKGwD/XOjsUH9OEO/s
GMvet9K0RJJNvGd7XgptJpN3LKyLpA4=
=lJPX
-----END PGP SIGNATURE-----

--74zdazyhkrmz3gaa--
