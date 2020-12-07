Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24C32D09E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgLGFDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgLGFDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:03:32 -0500
Date:   Mon, 7 Dec 2020 10:32:47 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607317371;
        bh=zCKdzTL9OZD52TXq3GAPOSeWA9SpSFCtm6e8PYYUszI=;
        h=From:To:Cc:Subject:From;
        b=XPYWrl2wfnp1tPts0/qvtB0Ke9x1jKEfa7niK72xV4DT3cEnkcsZRme9gDQ9K7NZ+
         YwMd7xBKoJXIpx8oX6PaXnSWbhPrf56oHrzH0ovEHQ+Bc2QRYGo9+bDWq55PQKd8eJ
         FLR/RfYSg+AR9OkCWNnvNZtdTXPu4oDhAAR2v1hsbd4zpZI3Du96ZKj8qoYzF/PtUp
         2Z+qVz3oOUUsCAugAOc2ndKmAxtZkuJhLlEgXMFVVh9Tn+Ac4ckvBZ2k+guzNfx7IX
         Xr/ujKSjFDKQHhjMsLnaenvDF2Gq1PHyC5xObSXBiFPg3BTuMclmqlFoH4UQ6Et1/0
         Pu39VIDXohlPg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.11-rc1
Message-ID: <20201207050247.GC8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive updates for v5.11 as detailed below:

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.11-rc1

for you to fetch changes up to 17e0da0b8979a53977f684813f5c9db817d170e2:

  soundwire: intel: fix another unused-function warning (2020-12-05 13:11:5=
4 +0530)

----------------------------------------------------------------
soundwire updates for 5.11-rc1

Updates for last PR for this year contain:
- Improvements from Intel for port interrupt handling
- SDCA cascade interrupt support
- runtime pm for master device

----------------------------------------------------------------
Arnd Bergmann (1):
      soundwire: intel: fix another unused-function warning

Pierre-Louis Bossart (7):
      soundwire: SDCA: detect sdca_cascade interrupt
      soundwire: bus: add comments to explain interrupt loop filter
      soundwire: bus: reset slave_notify status at each loop
      soundwire: registers: add definitions for clearable interrupt fields
      soundwire: bus: only clear valid DP0 interrupts
      soundwire: bus: only clear valid DPN interrupts
      soundwire: master: use pm_runtime_set_active() on add

Srinivas Kandagatla (1):
      soundwire: Fix DEBUG_LOCKS_WARN_ON for uninitialized attribute

Vinod Koul (1):
      soundwire: qcom: Fix build failure when slimbus is module

 drivers/soundwire/bus.c                 | 55 +++++++++++++++++++++++++++--=
----
 drivers/soundwire/intel.c               |  8 ++---
 drivers/soundwire/master.c              | 14 +++++++++
 drivers/soundwire/qcom.c                |  2 +-
 drivers/soundwire/sysfs_slave_dpn.c     |  1 +
 include/linux/soundwire/sdw.h           |  4 +++
 include/linux/soundwire/sdw_registers.h | 11 +++++++
 7 files changed, 79 insertions(+), 16 deletions(-)

Thanks
--=20
~Vinod

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl/Nt3cACgkQfBQHDyUj
g0cFlw/+J/8pjIoVZrTgHIBOO9GQxMYlNpZtPEK5dXhLREmtZS0O1ZM/mq5vCSTH
aVu1R/tsk2S3JBXjqz3nsRt5K4IFayRJkiB9JFP9neD7LVMc/N0+Z34FZMyAMtex
iPFtzz3PAk4Z0Sh4d8AWthWy9MNS4dH3flG57x4cVfEYDCWXXIq4lrk+FtmKazgK
H/gNTOpUoGJS9prfr3jCqERvLz0D8ADkpydGFtmRyT1R9LUF6sqwcsXdJTiiwVE4
s2ZzOZiSVBy1F3Dy42a6LQ9FAdq2Ebjvl1Rp7xuocMHjVzHcbFjoiii4QutEsd5L
BJUhJ/e/AeRZ+OKipFn7Z8efq4O1RiC4owAkefmlmtgBSjEUCYbqqeiQW3/MuBad
eOZeQaIgKbQAH2Aa8/9/Wwcqs6yQiY0LeKnZflitlST6q81GnoGaaIQhZ9lATumV
F0whAz5TFf+01EuGkZOkASONjJj2ZHf7vSYWioffVBjBKpCRLfE4fmYHpK5TSf8w
QL0Krsz/fXwGO48qkLsdxq86ZG0H6VQWkdU9nfI57vQQxG3e1GZt5iniFy77DClq
ceR1lhcgphhxmk1/QCHuwUIejUzzJeLDq0WsvDZ5kbsuYVCG9xS3oUjIagppyI3c
XSEfi9YksBF/Vt2FzWjTK+Wp9hSMCACIE4U96HogNQaDv5+7Jj4=
=N4Cf
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
