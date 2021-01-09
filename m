Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E919C2EFEB2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAIIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbhAIIzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:55:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D383B20B1F;
        Sat,  9 Jan 2021 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610182467;
        bh=KRPIZSgYgsy9SB6GotoJDSh27J5xHqj849MRk9PTSvs=;
        h=Date:From:To:Cc:Subject:From;
        b=pyAh1J927XhGTh6N6o8hvOVdvh1SwViXYfK2Ht0V+tID9/9AaC1AtuugY7vgp3CpV
         O+vgAKfxiUdPzrM2PhSFcJx5tLwa0OlH1J/2slQ+2zMmp72RwFCtGJD/99/tD5yJtB
         +pvjixh7D6WBN/p+qzFybnonEHPIpjfJNaE1M+AtT6AvVsKjzVK4s5oFTUD0w2j+zv
         jDOr6KxMTBGXxZCi6vti4KkJQybpL2/CBw25sc5izt8egUueLAYB0uFamsLA1aCs8J
         UCQd7JHZGHK76iR6UbwyZlWY6z2w7aZ0c9aY0aUPXt4KPzIY8Jx7CWtW9ip/WX+MgE
         kLlzSAsoS/zAQ==
Date:   Sat, 9 Jan 2021 14:24:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: Generic phy fixes for v5.11
Message-ID: <20210109085423.GX2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please pull to receive couple of driver fixes for generic phy subsystem.
All these are in linux-next

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-5.11

for you to fetch changes up to d092bd9110494de3372722b317510b3692f1b2fe:

  phy: mediatek: allow compile-testing the dsi phy (2021-01-04 13:00:54 +05=
30)

----------------------------------------------------------------
phy: fixes for 5.11

*) Fix Ingenic driver build
*) Warning fix for cpcap-usb
*) Compile test enabling for mediatek phy

----------------------------------------------------------------
Alexander Lobakin (1):
      PHY: Ingenic: fix unconditional build of phy-ingenic-usb

Arnd Bergmann (1):
      phy: mediatek: allow compile-testing the dsi phy

Tony Lindgren (1):
      phy: cpcap-usb: Fix warning for missing regulator_disable

 drivers/phy/ingenic/Makefile         |  2 +-
 drivers/phy/mediatek/Kconfig         |  4 +++-
 drivers/phy/motorola/phy-cpcap-usb.c | 19 +++++++++++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

--=20
~Vinod

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl/5bz8ACgkQfBQHDyUj
g0cDFw//T96rzErMyoyb/9jx8LbyLSe6gA3e9bFEuhR3Uzk4OWP1MGRhsZs8qcBJ
Z2ZcUNkki07XNoN8ZycgFY1AkiHWRDo7jBx9GxunOZb+zwyhosSgInGVGLZf2GMK
u8Q7DWxmmMy5wITZuqbenEpdS8DP40c51X/2gb4n3VVRleImIWQNSWy8GwiUjXN5
qUNGIdMLfwVQdZEtw5K0RhScbXj+ULN54s24KSlLdCq1VOMiGnUQ5MxzFRYnvXRM
OXTMjjete0tzKmNKPHyg5FJcQNDhNa2YM4kEQzSPC3AzWNLCH5SQYi+Lk5d4nPor
1/rvMk3wEWn3woDb/lfy5+Xzv7V2YProX1nF5TiBFlOz92zQCORJEITnvkkKihhx
8ACUY5hedrGR4ZFhNL+ilJGEWsgwmBaPdyn30yq1Bpc1o7t0a/Px5qEeL8TwgAjj
0iMnUSH/EvXXhPvVFb4Vbba1A7wjWCqIhzQm7EirMsI8B+MdcDpO+8B7aWWwa0b4
moCsoB7wytPtC/zTNDv1OYjM1SfmDFmDQa7+tA0q8OY76fi599ThzvNg+j+kf3S8
/CjDpwMvZhXDhzohIgRjc9LWyPIyy6W4odyxyo8yYWCgJsuNcQys1E9l9RBig2V8
NLCNQy0kSe6MMZ1WInN+LoWGRPzsKCLIMk2EKLbhHAxItXkR8js=
=qAdY
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
