Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4C2B49FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgKPPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:52:56 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60883 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730557AbgKPPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:52:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7C4CDB5A;
        Mon, 16 Nov 2020 10:52:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Nov 2020 10:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=p1gTdXMAcXm0FtjvqTTU6HCLKnp
        PEdqqed02MjebAqo=; b=U/RQSm6zoTCQ/TFtjFulc6uuhtDXdzqQVdT06hyWhAN
        0/tS/oCIjtdGvSSfXyBY5B11fMvsDoc1oWOZlwGModuvqNKXoXFQOEhWR/C15i4R
        oFPERc4r2aVW3ykwdc2h1ZOz0DU0KQm6dEpoXRgqdeNMcBV4mcapDyJnQHpB+wFQ
        FFMVa+CsE8fbY7u3l31OdYSufZBqZ8/DkevEqzZkFMdcZfZlCVomu98FxrIfcRUt
        4pahS5qQw6FEZb+dyE9ebdEnwqFsNwqbkMdNC62BPT/C4WHOjrMCjXsdKCZUYOIr
        FVY3Iq/p4Ps3i7R2K0ImNrVK9ZT3QZILWsYmw0fV/Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=p1gTdX
        MAcXm0FtjvqTTU6HCLKnpPEdqqed02MjebAqo=; b=HQuCLLORTw/9dJwUhywtLv
        wk/+UI2YuTqRmFx+U3Dd347vFu8U2eF7BdJrRfPVNOXW4b3HqhVeNXugleV6oohT
        alyroEUU55X1rKGKcW8S2Hm2UX0wK8fTeLqZvWkr5GOoDstIE58iM2fI7dE8zy2H
        iy3LrZGqsmBLW0uZmHCBdxo7oMxOtkRl1G3OFDyuzZWljgbWA5TpFLTPDHtmc5bA
        TAaKbnnAVHEIW1tjb8BldLc33809xE3sqcsHtr6zdSYegCtwyb0ZomroCL7vYyca
        /nE+VpNUxzGkysuBePOGUGs1BJ8xkYBeNDuDD49ovGqoFIDNIu8skJrqwC0aL1TQ
        ==
X-ME-Sender: <xms:VqCyX4juA2dlbyXDSbNZutFng_1zu8nEywTxxoYhrQJuJgEIcDZNWw>
    <xme:VqCyXxDcUII0VmZg-Z1qLf9feQif76rO5bI47ODeOlOs90q9GDxdIaEY4AEKmq8NL
    KBu1CeJNCTr-LxMeWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuefgffdvteektddvgeelkeeffeevffdvieeuhfekteduhfdvffegteegjeef
    teejnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucfkphepledtrdekledrie
    ekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VqCyXwFrRNitadbnuZE4fX-5ayO6MEUJaj6VVfaAP1869dseHH9N2w>
    <xmx:VqCyX5ThE1Us42a5psKzOoNHxCt6gjEuXn_zGio_9JnmHwCAVzBKtg>
    <xmx:VqCyX1zI1Z41BoTcjcNTP9z4SENFhcCzuNLH_pM0AxhCfgAMfpHiUA>
    <xmx:V6CyX2oLZvLdX6svZakwBKazSfMQ_z44JgTjDPDyrOZ-rqEn9jT_FQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95C3E3064AAE;
        Mon, 16 Nov 2020 10:52:54 -0500 (EST)
Date:   Mon, 16 Nov 2020 16:52:53 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     wens@csie.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: BananaPi M2 support
Message-ID: <20201116155253.n3nuvzxup6izhh3m@gilmour.lan>
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ygnkvflvonkqsbx4"
Content-Disposition: inline
In-Reply-To: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ygnkvflvonkqsbx4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
> Hi,
>=20
> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have sav=
ed
> boot logs for both versions https://pastebin.com/DTRZi8R7=A0 and=A0
> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
> kernel with default config, u-boot v2020.10.
>=20
> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
> The versions 5.8.18 and above all fail (5.9 and 5.10).
>=20
> Could you look at the problem or provide an advice about further
> investigation, please ?

I'm not quite sure what the issue is exactly? How does it fail to boot?

Maxime

--ygnkvflvonkqsbx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7KgVQAKCRDj7w1vZxhR
xd19AQCmvv1IJr1rx8VxenrQzzZDco3SMG9HQ1qxRsRSlPw28AD+K298/hQGBd+f
uGoiOw/CcE1l2bFHcQRjq9IKYEYtTA0=
=1vrv
-----END PGP SIGNATURE-----

--ygnkvflvonkqsbx4--
