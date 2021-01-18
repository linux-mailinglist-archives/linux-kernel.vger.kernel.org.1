Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A9E2FA4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393115AbhARPiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:38:14 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44187 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405848AbhARPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:33:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3DD6A5806D8;
        Mon, 18 Jan 2021 10:32:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Jan 2021 10:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Xzr7TivAzMC37jEbdiY5yCBTlnd
        X/w6i4c7bmvz68ew=; b=N8JL4nEVZlGYfJc8Ut+oe8MAM0Ws2eCWVuqJ1N2uRlz
        W4UrF9nOFhPI2eghR7pU4VXaNExy9mFfbs+GP44QnmMvOzPJNT0Tm1XF2F1q26sg
        hh1g2qnEBmY5t95iW5d5ZZkwvGl/I73v/zBqtngCj0H9cS04VXErvCRBX6WFm0iM
        DfVT+71OBAtS5YtzftoN53pqs9THXwIKXu0ga9vV7Qza4fdWIuG4YR8OOLHCKOFO
        5e4HKpkkhCLabbSxv8+TrMbgkrc3YaIU2tRFXNZYRfTVXcYtP8IxgymT/UZSr6cn
        cvOrjsuKJP/nJYmV5EiJG7gukEswc55dq1BS5fjYrPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Xzr7Ti
        vAzMC37jEbdiY5yCBTlndX/w6i4c7bmvz68ew=; b=BbXgA9KJ08hHHNvUq1bdHD
        l+5htAg9ZdNM/CmG14HdBRgCROauL43aYSvzekaiFr9A2XKxN4fYiferqBSlMHYM
        VJYAw8MK6F85ta4fxJ0YSfRYjSthDDm1van9BuMtf2qLccdFrd1qlXLujEWC4arJ
        KNVBj//L9YEQUvvMhHZdFa1JOhSF+gwrkRgg7uqa6O2xJfTt06nb2Y6Zfc2lcZzJ
        lfx/VrtESf/TR5AspcrhcpCliDTlR3mh7GcqkhK8P7SMl3ptebLnTc3l4UYxrY4T
        Co95LjJkJwYHLIvZtdHzhIMHxxC2kwBFsXeaIYcGR8lwNrFs0c6dyPlh2lIkLQyQ
        ==
X-ME-Sender: <xms:C6oFYNrHqvAmXbBoMhVk1EuVACG1FWpjpizQvnMWINBhIsu7C035ig>
    <xme:C6oFYE79O0CBWAI9L-DVnBFFG3-t2IUM_J9I7PR0ajzXp4sG2uFStQvOuHUMPBmFU
    Eaoduh0blTvhkqcO6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:C6oFYL6Nmj_feR6Cg09qCuOiOVFe2vqlhenZRkdXsD-2Oiyl10lXNQ>
    <xmx:C6oFYBEEmJOyqyaVAvBGmh5y9eBXm7Rg6XfLD-DNviUpMETII-cHFQ>
    <xmx:C6oFYERK5xAo9vmElfeKo1H013UKf6F8sy7tU4lcHtbQ3paPs7cWoQ>
    <xmx:DaoFYNvItQ3-rJKtIqft0eMUB-CYOLuqIYhsHageeBknDmPtsLB9vw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8707B240064;
        Mon, 18 Jan 2021 10:32:27 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:32:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 13/21] phy: sun4i-usb: Rework HCI PHY (aka.
 "pmu_unk1") handling
Message-ID: <20210118153226.3qthltiknhjggdlq@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-14-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pqgdlaxdbu6tssef"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-14-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pqgdlaxdbu6tssef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:08:40AM +0000, Andre Przywara wrote:
> As Icenowy pointed out, newer manuals (starting with H6) actually
> document the register block at offset 0x800 as "HCI controller and PHY
> interface", also describe the bits in our "PMU_UNK1" register.
> Let's put proper names to those "unknown" variables and symbols.
>=20
> While we are at it, generalise the existing code by allowing a bitmap
> of bits to clear, to cover newer SoCs: The A100 and H616 use a different
> bit for the SIDDQ control.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

maxime

--pqgdlaxdbu6tssef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWqCgAKCRDj7w1vZxhR
xcbsAP9TwrjweNf+Pb49jnnhspbSAKEDPVbjl51uEuE/KYOpuAEAgi9QIlVrNs71
7VP8kIixtlUEeJFvDXJ74Aq643qmiAM=
=hfin
-----END PGP SIGNATURE-----

--pqgdlaxdbu6tssef--
