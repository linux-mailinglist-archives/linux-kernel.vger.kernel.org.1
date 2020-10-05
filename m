Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68476283518
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJELjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:39:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34053 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJELjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:39:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 088575C012C;
        Mon,  5 Oct 2020 07:39:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=weqS5lxewny8DqfssrSq/R//xlr
        2DLh+OVQqRJJwUMM=; b=i3UXj9Shf04SVVIgvF4ndbKiFjxyZtuvSJ9LL+jVmyZ
        5NZHMN7sP2nafb5nN/8y8G0Z+fK1vjWLAR+/yyQq4SyxnLAlTzLpQwCktwXFuk7j
        Arynh05DXHQq8NiN0t+u8wS7CuAvzcboqRrM3CwUsk1Z5u8gfHuhNmLEaKaPm0b0
        ENcEmWQGTz8auDKd9l4cae5rVGo5S9yOprPUhHsrn0iUHa1/c7OCuStSpujpfaQ2
        xy5zdyh61lz25h0sP8QQ4LQqDFI2hd9/p7w3opnIqLzZjUNfqe9jftSW8qNCku3q
        1XLD1ayEKhbRYTv43d09O6tkQ1Xc+CQxKdrltg/RdBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=weqS5l
        xewny8DqfssrSq/R//xlr2DLh+OVQqRJJwUMM=; b=IuFQG2uCrMsNf+8fC31lym
        J4EkA+Szk1UoREKqRaCgN8jev3gVdnymuRDgH8D2+scwE4LClDRrtt9bi0/9YiDo
        a6oxLeFNaF8qs2aBX8+0y+aUKNfVuvtY+49QXKGvclCQNvMhDyg0CuwKXQwFOz+c
        cG41V5di1mmRTQpNS2JQ+9zC9KYgco1OSR8R8YdsJLXRmCPmPNIIG1rrAioZKUQB
        G76AFleLKkzszl0LmyW3YmLYJzmuiCHBgHh7XV/+V/ID7i9joRGRUWbvtc8ZGI5V
        Eu02ZyevjmHcrk2QIDoDNZm7EnHvxpWiYJyIrN3vc8QPeYeyc4Pe9BviOjnihMMQ
        ==
X-ME-Sender: <xms:3QV7X9uJ0dR8m_KQeNZi0Dopy5TfXUZEjXHOngLEZ4dOrmVJZxHVKw>
    <xme:3QV7X2eQ7CbjQCmKOxrFlNEfTmdoeLCKnar8L62oXG41Y6qu56Unc8zBZqT_B40L8
    DGDFdBR4BdApvRnCMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3QV7XwxeyoS4B_9AfxUaJ5QMMLzsla3SE4M3TaE0pEO-yy_F0bN4DA>
    <xmx:3QV7X0M_nLo-ZYJr80aX7-r5oEf54SQb0fkOJaxGf-yaCKoDxjEAhA>
    <xmx:3QV7X9_lZH17x7tsZ2a_ojOzHImMhuKcdq1ukgbEAbzZE4XCyHaW_Q>
    <xmx:3wV7X2MCR7zk6tt-xOJl158tCqFGmy8MolyxbXW3F6mxzV_VP8uZVw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35BE33280059;
        Mon,  5 Oct 2020 07:39:09 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:39:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/25] ASoC: sun8i-codec: Enforce symmetric DAI parameters
Message-ID: <20201005113907.tov27ifqon6s3eje@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-17-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fpdfnc3qlyjpag2x"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-17-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpdfnc3qlyjpag2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:39PM -0500, Samuel Holland wrote:
> The AIFs have a single register controlling DAI parameters in both
> directions, including BCLK/LRCK divisor word size. The DAIs produce only
> noise or silence if any of these parameters is wrong. Therefore, we need
> to enforce symmetry for these parameters, so starting a new substream
> will not break an existing substream.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--fpdfnc3qlyjpag2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sF2wAKCRDj7w1vZxhR
xetcAP0ZMIQdr14FfISHa24wiVN1sZD7ZEmNUIsZQrFp+AeP8wEAqZdUkpXypixX
AVbOASy2ODp2UNkAFDT/jG/pABr1fwg=
=x+Qh
-----END PGP SIGNATURE-----

--fpdfnc3qlyjpag2x--
