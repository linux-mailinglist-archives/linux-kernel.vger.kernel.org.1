Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638C82DEC35
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 01:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgLRX7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 18:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgLRX7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 18:59:53 -0500
Date:   Sat, 19 Dec 2020 00:59:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608335953;
        bh=P4Z0pkJ9/Dkinhi9fgAOvOmBiWOWNe1uIrjKFyME8Y4=;
        h=From:To:Cc:Subject:From;
        b=Tznb9YBZRFL2qFzyNDnyA/R+9ENtb3zzYc/ahHaCvqLIssHfgw067Te7qiSohJQHs
         pcb5JxAE1t5ErYm+jCbfHmIkwWugBDQWWLPzzpR9Es7snz7e0dYWr644nGwSwUrdpI
         bWIP1SiCrIV1d2gsb3t896Li7FcdrVuiE+WwPMZXO+f++33pqBGc5MjvVeVkA8Mg8a
         bMPM1qVL+uh0FZxB5djWC8oCdQnpHP3cC2VOAan4fhMvWjKk5l+TmwYs19wN1F45mA
         j6IlvNFilnxB+jq8mxNbT2Mgw9eYEfmLYPwk3zK/QL6qYad2y/AU3IGGTRV54+wFcQ
         Aad1+gF57uscA==
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for 5.11
Message-ID: <20201218235910.6tjqvzaxl7kne4cl@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="we4w3f2mp6th3jpt"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--we4w3f2mp6th3jpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.11

for you to fetch changes up to 8a77ed6d1fdda752f6b3203391a099f590a9454f:

  HSI: core: fix a kernel-doc markup (2020-12-02 22:35:44 +0100)

----------------------------------------------------------------
HSI changes for the 5.11 series

* misc. cleanups

----------------------------------------------------------------
Jing Xiangfeng (1):
      HSI: omap_ssi: Don't jump to free ID in ssi_add_controller()

Mauro Carvalho Chehab (1):
      HSI: core: fix a kernel-doc markup

 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 drivers/hsi/hsi_core.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--we4w3f2mp6th3jpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/dQkYACgkQ2O7X88g7
+pqveBAAohYKqXXJDAgCZQzLV0DuQiQuBMo0v2oMgqTdBfTUzt/CUI+yBM/LoLS1
kTWKqU4YjOD46n4yvxOf9uEXBURCCbnZ3joQ/EqWcREgOZH7H+iG8jmlb7rmezDp
lIV3CvFbARh1hS01ZF8YyQdW/KNSy97UdejWWED2nZlyFHJrcEj0+YnpKWUYZO2e
oCi3DxoE4mVBpS0B/8r3APIHOVOqgHn9b0iXK00HWH1uX4vzJtQ9fFcdb1qQTsGM
8yP8+OCcniFXmNKf93Sk2wWA8gBzJWI/IuSn1fi3jtCB3E19+NejlnNkdKHoymPD
ZqQoSwdp6NAXR17PWv0jQVNR7EKl29nmr2niRFx221Yf5ydAGgHOGf5yLe3w/LsF
KsPBhphor3OpCDLn0Obsgo1gBi0mn3/Rg78YVfvE/e1b3F6HmLncDYrYZ23JRsfD
hesoR4m0QhGLGA+SXrlmfVy+SlHWXj17kcXwp1hRavfP8OlzE3fu6gmF7An+MJD1
a7KRr46ZVXPyiab0volW21idZATPkp/aiCIQxJirPvCEVpZAcsv8NSy9EBdP+5ae
ECr9URDrxIIgCQfbQ50HSJ9RHvmoGpmkldwT/yRwXjQjgypbcJ3dJhITssJ03wFc
u2naQPi4dTCYCWSnP05WsuVEj7p93EaXnuGb5Gy5B8a6uRm4+9Q=
=3rsy
-----END PGP SIGNATURE-----

--we4w3f2mp6th3jpt--
