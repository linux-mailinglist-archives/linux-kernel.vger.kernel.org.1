Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C627243F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgIUMyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:54:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43254 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:54:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LCs3rg104245;
        Mon, 21 Sep 2020 07:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600692843;
        bh=qFpjHmcHk59IcPNluAVxwXpj8uIrlUPZIWnbDd1Te4Q=;
        h=Date:From:To:CC:Subject;
        b=y+qoS+kEz1snkJcbo3LrOxH1LEW2yCxUUntr5kU+vt0RAuJB34D+kuXI/VaTw2vI4
         MZ8uEEln75MnNLHrFV3bH4rrjWU9oVhGYoLO3+v7n8a7F25Kbv1C4KY4p4qXo20YhM
         mcOtOHdjnxizf8h4dfyQ1BVpNSbVaV28MMF7QnEA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LCs29C109519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 07:54:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 07:54:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 07:54:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LCs2Ui118354;
        Mon, 21 Sep 2020 07:54:02 -0500
Date:   Mon, 21 Sep 2020 07:54:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <peda@axentia.se>, Roger Quadros <rogerq@ti.com>,
        <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arm64: dts: ti k3 fixes for v5.9
Message-ID: <20200921125402.mtwypblhb45a6ssh@akan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4d5rvlxkmc7uz6ux"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4d5rvlxkmc7uz6ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is a single patch PR with for 5.9 to fix dts include introduced
during 5.9-rc1. I had to base on 5.9-rc3 given the changes that took
place post 5.9-rc1.

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-dt-fixes-for-v5.9

for you to fetch changes up to c65176fd49f45bd5a5ffaa1790109745d1fa462c:

  arm64: dts: ti: k3-j721e: Rename mux header and update macro names (2020-=
09-21 07:17:20 -0500)

----------------------------------------------------------------
Tag fix up for TI serdes mux definition introduced in 5.9

----------------------------------------------------------------
Roger Quadros (1):
      arm64: dts: ti: k3-j721e: Rename mux header and update macro names

 .../boot/dts/ti/k3-j721e-common-proc-board.dts     | 11 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 13 ++--
 include/dt-bindings/mux/mux-j721e-wiz.h            | 53 ----------------
 include/dt-bindings/mux/ti-serdes.h                | 71 ++++++++++++++++++=
++++
 4 files changed, 84 insertions(+), 64 deletions(-)
 delete mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
 create mode 100644 include/dt-bindings/mux/ti-serdes.h
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--4d5rvlxkmc7uz6ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAl9oomMACgkQ3bWEnRc2
JJ0Q/hAApesCuEpnWP4br1wccsN3Lcm7A8VxH3b1kW1T14wAHQCYljefz0v9Y++q
lnhALivgYOdabxNolVKiy8NFWsKi/m+y6nZKlGVSEaPLBNFVaVm06JDPAep2MmsE
w3bpY8N100LXQjonkYcRdoXTRat2lpEbnsEBEO6be69eY9V3vE/syAXvWyGc1Scb
w8q5ZDh+kEdKWRjBrM+fx8g2cjMLUO6IyLvEPMjeb7t+buHNjLhBF6oHh7MSxgWV
E729seZqPewTj50E8nb4LgtqY855bD1sPN6hcICaa9Wb98AlBdIvKg/hHMHWZmvb
+ocKixXpFzB28b2LL13uELFT5K5EsDhHMhGv+EjlY09V/M0KGqTXH6t0zsv5WQVG
DT7+4CMwhiiUeqlgNaesFYK4A1FwL5TNvZoOzaNsnZleZjmbu3jAU+vmxuAzMeSB
CR7dzq3BVNjlXnbGg5vLwutd4/IJqJ8mA1Ge8u9YsrVEGZVFEqvFqsl7yNsrNhkC
RMYquCmNHWOrUwv9VGRxmTmbrnHbFOe7JbzwVHweoKnj+uqaOt/TtfS+8oMKHQSD
rDVERAPqnCOl9wM0Pljb2jvNC2DrUPiIOIUandV6dPnWZE5WM1Bc7UCk9GyqeOsD
HEksbT7bCE8Wt0RRv4g8vUMrH1O4n7bFWS+EZC4s8j1rwK+XRDY=
=UH4k
-----END PGP SIGNATURE-----

--4d5rvlxkmc7uz6ux--
