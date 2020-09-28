Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56227A724
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1F4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 01:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1F4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:56:04 -0400
Received: from localhost (unknown [122.179.43.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10C6207E8;
        Mon, 28 Sep 2020 05:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601272563;
        bh=qlnBxz6Z2Lauf7/9BU8Jivkibjlg1y08OjFnfsAoXAo=;
        h=Date:From:To:Cc:Subject:From;
        b=HojW9nObZlGYVaOKU0Rr4wcOEhiAKDC+TP10XKX4GsG4zblCWvT6iDyYkrs5APfAM
         VDzejmVrBMtcSPV6wV9bmaQLvgAYZow7IczJib/ae2+XAqR1bLVKaXiTcrGIlJOjUK
         covUKVoK93ERShWEKjvOx5Vf8dZFZ8B3meOlMqQA=
Date:   Mon, 28 Sep 2020 11:25:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic PHY fixes for v5.9
Message-ID: <20200928055540.GJ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

We have a leak fix for TI driver, please consider for v5.9

The following changes since commit ad7a7acaedcf45071c822b6c983f9c1e084041c9:

  phy: omap-usb2-phy: disable PHY charger detect (2020-08-31 14:30:59 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-2-5.9

for you to fetch changes up to 850280156f6421a404f2351bee07a0e7bedfd4c6:

  phy: ti: am654: Fix a leak in serdes_am654_probe() (2020-09-08 16:23:09 +=
0530)

----------------------------------------------------------------
phy: Second round of fixes for 5.9

*) Fix of leak in TI phy driver

----------------------------------------------------------------
Dan Carpenter (1):
      phy: ti: am654: Fix a leak in serdes_am654_probe()

 drivers/phy/ti/phy-am654-serdes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


--=20
~Vinod

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl9xetwACgkQfBQHDyUj
g0eTFw/+Ng26JKTOLmtR8y0ThGjfnhT8+Sh/9vrrlk6UsTPK3WAA23S+1dLWd9aU
dWKLzJ+ujmcLJPfTPevsUTmjBfplpicnUrQcpTzo9dxTMHmVthQQHeF9o/vWQlQ9
kuygQ8jB3Kd7J3DNIZo6etiueFMej043uwLdBtSOZMK5ug5N7aQrYZWw/zjl23NG
TAE5NoutAH+kMRyyqZATX24lmRZkEfPk1g36AdTOc5YMdKlstpPXzzcBXpt73LXP
dKr9acNAKL68Pd5D0Ntnnf+gqfZ7n7rVuxAdKzJ/A27iUv2MXm2VS0/g4H7hu0Zg
D1GhG42x6Snf/mqFoE63JuO72ez2mZ+89qeSNC4Vr2WbnRpuRzCI3r+/GMyxpDoj
QlAiz/B2FfK9Z+D2gPlG5hUZzxwk3YbxN0Lw6+0Ryn7s3md4Hv3a0R6gE4pImO54
/U2yKxKSkUBfbjI3T83NAqZwIWxlDFDeBsCEolYuMDQtWvjWsaihINd+jtlya6qL
lUeV839NF0qL6m03ybVjUjtjYEjcNFZZWzJgcobQgxmWZS9r3F1nr+klJMcB2H41
H9hMBMRQGR8BQYdg2HpfQ+FYApPgKZ4PiN3ch8D769xsqadLBoSwrYPpwnFAhKmc
o6dR7c8gMFAhN6HWldVyrg+56XnErfLCvKpvDbZOxx1uIjMl3Tg=
=Pwhq
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
