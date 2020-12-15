Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B62DADF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLONZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgLONYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:24:52 -0500
Date:   Tue, 15 Dec 2020 13:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608038651;
        bh=3qQoBFFuPirOF/52LC+83ykwfdKtbxAU+odgQo0yl0A=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH9fhsJZqtPuEKdbu/mobNlP1qSJDVc2XDnAIIbV+WT6ACQQlP0w/UkjErAf+8MK3
         NsR3dNNFL4LhlqHynl3VgHXZm0guI6OG2zhdZ/WTAP1VOUhdWqB8m0xdTcc1qqqoWi
         rGAiKjcSXwuFWnvKcESkZVwi4CLzh5BNkHW1Q7x41PJm4Akzwyz2XQNjsaQDcTL3qo
         JesHsvLA9NiVydZ/tah0sr3NaZDq+or6pqnROvWVy9dGgkP1zWt04Y2+Kird4xnZ+y
         UBmUcn4nV8qAj3tBPdv0beY6NTIDUky8nI5orV3tyQVTV1MnpO+s8dn++0GlsjQqN4
         lgf69sz0fD94Q==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
Message-ID: <20201215132400.GE4738@sirena.org.uk>
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
 <20201215130622.GD4738@sirena.org.uk>
 <CABkfQAEAe0XGj16CkmH7xMNxgdQ+SRq0BYzvP+V5PdDqVbyAAw@mail.gmail.com>
 <CAOMZO5A_Gtwn=AFwJXf_wpC4k902Hg=tCMWpcFUGNWOg9me6_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <CAOMZO5A_Gtwn=AFwJXf_wpC4k902Hg=tCMWpcFUGNWOg9me6_w@mail.gmail.com>
X-Cookie: In specially marked packages only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2020 at 10:20:02AM -0300, Fabio Estevam wrote:
> On Tue, Dec 15, 2020 at 10:16 AM Adrien Grassein
> <adrien.grassein@gmail.com> wrote:

> > Could you please tell me where this driver was merged?
> > I checked the main kernel Linux and I can find out this one.

> It is in the linux-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers?h=next-20201215&id=d3795d6321ecaa55d94dc24c3b1e3cce608aabd6

Coming to there from my for-next branch - it's also already been sent in
a pull request to Linus so will hopefully be hitting his tree soonish.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/YuPAACgkQJNaLcl1U
h9CPmAf/eKV2OidvhHUcIbNxUtY+hbuBOcTMkhaO1UXnfkmmNMFfOGRfD8mJpUaB
XkK36q7TFoE/TxOdDHRH5wTA/hb7Y/dy28AaZqvGJjQr7D3g5D5cWVvEgK/yFZHE
gjRt9GkyZGu8gFFGvGDcZzVA2br3PjAzZVS2w0gFWQAZECNTdxW9+DUJduRgCd71
4C2tW08VIYouEoPuKNFhUlOuMEkSVtvoddTe5KvgwE1T9WX53Fi8w/koY0LfR5u4
5KyMjKRQCZxw74sHOXs3OaINytshUlV4d2p+ddM2zPjOZl+za5P1LR/3ZkNr5lzN
DF29tuAR+Hq1OQ7Gbj/jrmmWBUMq5g==
=DXB3
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
