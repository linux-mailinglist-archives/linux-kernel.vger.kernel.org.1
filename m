Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D224728BB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbgJLOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:47:58 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:49253 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388334AbgJLOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:47:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 33D30580169;
        Mon, 12 Oct 2020 10:47:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Oct 2020 10:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=68fNMKuhDwvNU+hlvuTUPY95xCS
        2IO9kUuqjP1wwUVc=; b=MwUuWacS1ehx2hYAb88sc/13QO1iVYstxAlXFn/B+f/
        mGBtfPFVg6MFyPZWHS2YfhBqreR/MCA2B27JJhP30Cbfjui5VIkHmMwQYwWv27Sv
        kkwNbA7aQCoQPWId4pvH/HqNmzOMCCDssLiPFE8jjzOZSoPDYocQTZI/zL+l/YGP
        QjBBp6BlKTT5FOnO53foInEAuRdk1NcNKnvakCTtlk8sjIHhobcPCOjlqPyLdKHX
        1iP3DHExf4DCN1PdAcQDVLc2mcKGup0h1AVEUNaHhdaPrsUp5q9dF5ylLgZj+dxh
        Cu/5dnzgiGjTlV072IvNrO+/phthRbk7HguaqrqMrYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=68fNMK
        uhDwvNU+hlvuTUPY95xCS2IO9kUuqjP1wwUVc=; b=g/MM7BjX4gX9jaupDi+GDP
        UP0WH3nJR2uNQ20pmswFGkyXJjZGpG5IPi8sxBnnfJxESTWZ/iPQmzvCAG9WZiRW
        owaAZo8Qj0TaTi8KB55f4lpuPSZnAkgPrmXHurq2V9IoAvO7TBFRVZCIbfHewScv
        9afy1jwbG3GmkI+NUI9E1je/79U0cOZhXHffyTwh5noXgbHu3y7hIzUhxQOHBCvU
        KPTRaEVHYqgdE4rJQDS+FkLPDxItjIfUqGWwcXsf/wactYednKcxPWCWleEapwyy
        UdwKdWFqZaVrQy4tq4CfMHlVztLojOyzIvXlv6uxaCxDyWL5KHfvSdoOA0iqGEmQ
        ==
X-ME-Sender: <xms:m2yEX5-Wcqt5JCeDx_yuMgHK1CAAcG_T80PRuGeQ7hwSCmxa7VGDLg>
    <xme:m2yEX9sXp_feexzIIvRMrllLC2d9AerxJhfB9HKTkLbe3TWrtFxX3jU8de_f-lSWO
    twRycXjXngWdvQCmI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:m2yEX3BC2HCaG4v47f4XaxnHY0oGxeH4hHMWO49SMFiqDlWiS99NsQ>
    <xmx:m2yEX9dV6PtnSzOG9O86qhrnclef3fvMG6fFja4s3mDDVBaVAQv8dA>
    <xmx:m2yEX-N6g8_Klj8re7gCi-1bZ1rm-cBDsNDFmTLy_PqPP1fqc9N07Q>
    <xmx:nWyEX1qaKmkyiwcDRjFMT50m2Y5krOmyA5gpgb1CZiJ5HdMp-ewiFg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A21973280063;
        Mon, 12 Oct 2020 10:47:55 -0400 (EDT)
Date:   Mon, 12 Oct 2020 16:47:53 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Bastian Germann <bage@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: Fix Orange Pi Zero bindings
Message-ID: <20201012144753.mdxdacp7ctxxhhl2@gilmour.lan>
References: <59f7b5c566825838bbb62b778e05c514fe355e74.1602182270.git.msuchanek@suse.de>
 <e657976d8bb1bb627c983321fe9c61de5bc003b7.1602182270.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4546wxmdgvjefd4w"
Content-Disposition: inline
In-Reply-To: <e657976d8bb1bb627c983321fe9c61de5bc003b7.1602182270.git.msuchanek@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4546wxmdgvjefd4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 08:40:06PM +0200, Michal Suchanek wrote:
> There are two models of Orange Pi zero which are confusingly marketed
> under the same name. Old model comes without a flash memory and current
> model does have a flash memory. Add bindings for each model.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Unfortunately, changing a compatible or a DT filename is not an option

Maxime

--4546wxmdgvjefd4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4RsmQAKCRDj7w1vZxhR
xVklAQDmRyk2xPUw+OtcmxtYmeZzWnoH+PAMfHIoXAQ5b2UjDgD+Peqjz8Kx0Dh1
k+xjm8jBIcKs+gmpseIiVVv05wJ4CQU=
=nu/s
-----END PGP SIGNATURE-----

--4546wxmdgvjefd4w--
