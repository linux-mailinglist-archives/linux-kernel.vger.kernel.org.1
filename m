Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94742D9A26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438249AbgLNOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:40:43 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56683 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407382AbgLNOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:40:33 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C4FA4788;
        Mon, 14 Dec 2020 09:39:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 09:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=A08lNUVBDG1fIqSA/WcJBe1gCa3
        5qJ4SM7MLqAPYhRk=; b=pcd6dzQF94254RF6sJEL0xI9LH4OjopXfQ0ICPxQH2C
        +6DqPMsVJWeCncFZE73l+6aJiP1/5F+3ePYteSVdd+Hy2yUA2NaOEFTfYwzZgnFn
        nCie1olReJotTqRjESDEUGhNEnaq3Pa40+r21zwpH1TS6p6n3Logtg7RlhhoZpEV
        E6qDcPgqsXRHMrL83/ArP+itgtcX/FYklLy/1/Zs3M/8fJ6jYQFV0YHKZIMhAMEC
        zMcspdEAKBUwjisEAYBXZXoyeNWOYAlP1LbA4pBwb20Y3IINZDBXb5hheBO8MdFv
        CNS7heQHLcGHYM6rd7FnaGussGBhv71oHr6FbW5kAzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=A08lNU
        VBDG1fIqSA/WcJBe1gCa35qJ4SM7MLqAPYhRk=; b=nt4gqBY3kMmm/KVeH4vm9V
        Pv/mzAU+nzIRUlvLA/M+78xKI/lubtjf8E0GK+gSsofbrI7EoepBfC1iXLlYE6rb
        sNfVKDegj4LcUvE/bg1NzJFQ8k2esAJO34MTIiXzivVF7MQBkWZwURMEQ2xu1037
        SswUelA5OABduQp1+joKVwbVRrB7R5HCV+mw0f7erWFBXMnBzIBlM+iXo+WxH9NJ
        +6Hu8hw1zenGokxJuVj3BH4MxmYS402LTc+CTxzMd19PMEX73QVYq+hdSO+fOVMw
        KC4AnhuD0XZUY0zYzg0yH6F2s9uo0lonsZtUjH1G+AfnjyYGtbXovLpxmLmS5l0A
        ==
X-ME-Sender: <xms:HXnXX8bDUqwUheJBGLfmxBexZhcRaui1W8oRWE9AICnRHJKyBPkFMQ>
    <xme:HXnXX3ZbnzG0u_AKByP9J3eqw2RhJc1Ncde2blUlUUiM-WnpQ03nvvw7y47m4nlBe
    LBsNypzyFzwwJJ3Nw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HXnXX29NLulKKW6aaGyukt--uZHH1M_29cPrVD4pcN1J-0SAmZauLg>
    <xmx:HXnXX2oegMtzF6AuBq3jPVq_3cl2RDX01nFhn4K7Q8yf8oUuING-Uw>
    <xmx:HXnXX3rz2_JexrTUPQv1Vw8rFyUs1zNgz1Ewq0qczmOpK1_K_BRu1Q>
    <xmx:HnnXX4lxEVEsz3thUB0oUQzSMK0uVjSXccTSZiuEJiyNlLKkn4Pvbw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F38ED24005A;
        Mon, 14 Dec 2020 09:39:24 -0500 (EST)
Date:   Mon, 14 Dec 2020 15:39:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/12] ARM: dts: sun8i: add DTSI file for V831
Message-ID: <20201214143923.26rbsffwdxgq7max@gilmour>
References: <20201212040157.3639864-1-icenowy@aosc.io>
 <20201212051202.3645115-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="onevegrhfjzwg2d4"
Content-Disposition: inline
In-Reply-To: <20201212051202.3645115-2-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--onevegrhfjzwg2d4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 12, 2020 at 01:12:01PM +0800, Icenowy Zheng wrote:
> +		spi0: spi@5010000 {
> +			compatible = "allwinner,sun8i-v831-spi",
> +				     "allwinner,sun50i-h6-spi",
> +				     "allwinner,sun8i-h3-spi";

That's not the compatible you've documented in the binding

Maxime

--onevegrhfjzwg2d4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9d5GwAKCRDj7w1vZxhR
xTftAP46rAiffO3ienPFE5ZGSWhjx8xD8PxVemAiHauoDKzoIAEAzgHJmsMxW1FH
ZmJYhqDfMVr1qEtV2HkWgYc66uQ4MAM=
=TOgy
-----END PGP SIGNATURE-----

--onevegrhfjzwg2d4--
