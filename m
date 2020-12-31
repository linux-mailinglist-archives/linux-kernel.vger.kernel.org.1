Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2E2E822D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgLaWG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 17:06:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:60485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgLaWG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609452289;
        bh=LLg5+dBODLBTU0omru6oOcMgKkMNMcIm10u+qvBP/5s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Ya+1GxtDIQKmdnGnnxLOYUX49IguTuo/demHBmQIFKkdwtWYUq1Dh+456ldH2+Y7O
         efUXHDKs2j3mFpdKk14Pd06PB8tDgjv6mBsas69nvT7WQhmnXrUS+qTLpE1Z0dlo7I
         Zlp2U0oOHAuSQAAOslTKy9YNrguOi5vzCJCh3ezc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1kafX92TWc-00KQMW; Thu, 31
 Dec 2020 23:04:49 +0100
Date:   Thu, 31 Dec 2020 23:04:48 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: checkpatch.pl: Bogus case of DT_SPLIT_BINDING_PATCH
Message-ID: <X+5LAFw7AHvAXJaK@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2nvqc0kNWltf5Qkb"
Content-Disposition: inline
X-Provags-ID: V03:K1:oxUVUZMUYVJDeqCpnPB2mSWJ7wJJ1YjhsZX4JVxoJ+44MgRsbpj
 pT1ptSFOvV/kmyN3GCnJzJ+9BZHSw7CRKE/eUCEb4g9Mrwj/gakpEjcqcpgcOEDr0JX/ZNw
 Ab1iDgHOeGxy/f2FibNj9haMEn0W1urYCMBwWnB7Eldg9R41YqtszKtbaLuZs6wk40uaHgq
 44GYWIXdnXF2mWEdkBo4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0q+t5ypCRwg=:0u1w3313QbDfTxW5Bhj6nd
 JQRZJdM/t5cP1D4HjeZI7qkoPj99aVPO5ooqbwIPhRJoBCBiys6+jqmGwKsNPaqgPnYtuU+4u
 b8+1kGYXMRtTH0xpKrUd6cAEYYAOzaxxWUmqJLoErIahA055TMMoawx2o2MapusR6eOoislyU
 Vd2Fm/DCmZLSYUnaWdPBILxNSifWDJNR10ISHGGuDsRqYkqDq8Ah66XYVLnFnhwGjoTWew5mb
 79grFMT4C/kpAXhr7FTYR5u4BHPQZFqxFQ5RJdIPr4DBIFhDmKOaFpcNLfUeJaWV7+ovA1ncM
 JBP1K7tylXkxu08Lrb6yrB35xq2R35zi9Ve9NmpEUdvHn6rsGIjJNrEjacvIX6PFXTATxdugb
 GTY/eBF3Yi/TiiDwb4K0iKYQq3FOTM+ecen9Y7hbNoKFQugN6aErjCWVQmBvnuMatPjanl/ol
 zDtAYlyP5BE5XhwYhnDI/F1yz9Iy5bsT2ST3LfEQIeU82o2I2Oqipqh3Ja/fyNxg/QjgkV4yK
 /2oeORMWeWC5BBflXC2mtnhxjvv/OJ/7Sq9DcNER+flCm2J8ZPX5LkFYSJXSt7O6vjKBw1azx
 Q4yfHjtasVxVHFEvMnsu89qbS9hFzTNmjVz4ivdK0g/CDLKSAPs1MenVmrW0J50vg03w2TsS1
 bVCno4p2eVaLKvttRprPJkdnIcTPAnYkRVluyEjiEfKF2Dp3hFKH5ywJwQNvqy+pf+qCn7QGC
 rLTMRhmPFuq48RF8NRsx4hTNoDDGdG7V0kbBMExKeqI/tLz4T0T4T+s9J175SFGh1s/jXWEwV
 tWoaIrTr0K1uWgeYtbGlV3c2pGhJm14QM7PEXHHOQ0G6bF6VcxAsrkVOjIbTRJTRpfP/GhDMA
 mHuFetcHWXFjgw+yG1fA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2nvqc0kNWltf5Qkb
Content-Type: multipart/mixed; boundary="ESYGnOEREAsA8eQo"
Content-Disposition: inline


--ESYGnOEREAsA8eQo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've encountered a case where the DT_SPLIT_BINDING_PATCH warning was
emitted even though I didn't change anything outside of Documentation/
devicetree/bindings. I just converted a binding from plain text to YAML.

Here's a transcript of checkpatch (from Linux 5.11-rc1)'s output:

  $ scripts/checkpatch.pl --strict patches-wpcm/0001-dt-bindings-arm-Conver=
t-nuvoton-npcm750-binding-to-Y.patch
  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #31:
  deleted file mode 100644
 =20
  WARNING: DT binding docs and includes should be a separate patch. See: Do=
cumentation/devicetree/bindings/submitting-patches.rst
 =20
  WARNING: DT binding docs and includes should be a separate patch. See: Do=
cumentation/devicetree/bindings/submitting-patches.rst
 =20
  total: 0 errors, 3 warnings, 0 checks, 21 lines checked
 =20
  NOTE: For some of the reported defects, checkpatch may be able to
        mechanically convert to the typical style using --fix or --fix-inpl=
ace.
 =20
  patches-wpcm/0001-dt-bindings-arm-Convert-nuvoton-npcm750-binding-to-Y.pa=
tch has style problems, please review.
 =20
  NOTE: If any of the errors are false positives, please report
        them to the maintainer, see CHECKPATCH in MAINTAINERS.


I attached the patch, for reference.


Best regards,
Jonathan Neusch=C3=A4fer

--ESYGnOEREAsA8eQo
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable

=46rom 3aaf23345633070909e23a05a9f92748e445b3b3 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Jonathan=3D20Neusch=3DC3=3DA4fer?=3D <j.neuschaefer@gmx=
=2Enet>
Date: Mon, 28 Dec 2020 01:09:31 +0100
Subject: [PATCH 01/11] dt-bindings: arm: Convert nuvoton,npcm750 binding to
 YAML
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The general trend is to have devicetree bindings in YAML format, to
allow automatic validation of bindings and devicetrees.

Convert the NPCM SoC family's binding to YAML before extending it.

The nuvoton,npcm750-evb compatible string is introduced to keep the
structure of the binding a little simpler.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---

If someone else (e.g. Brendan Higgins) wants to be listed as the
maintainer, please let me know.
---
 .../devicetree/bindings/arm/npcm/npcm.txt     |  6 ------
 .../devicetree/bindings/arm/npcm/npcm.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.txt b/Document=
ation/devicetree/bindings/arm/npcm/npcm.txt
deleted file mode 100644
index 2d87d9ecea85b..0000000000000
--- a/Documentation/devicetree/bindings/arm/npcm/npcm.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-NPCM Platforms Device Tree Bindings
------------------------------------
-NPCM750 SoC
-Required root node properties:
-	- compatible =3D "nuvoton,npcm750";
-
diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml b/Documen=
tation/devicetree/bindings/arm/npcm/npcm.yaml
new file mode 100644
index 0000000000000..3ecd00803c003
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NPCM Platforms Device Tree Bindings
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: NPCM750 based boards
+        items:
+          - enum:
+            - nuvoton,npcm750-evb           # NPCM750 evaluation board
+          - const: nuvoton,npcm750
--=20
2.29.2


--ESYGnOEREAsA8eQo--

--2nvqc0kNWltf5Qkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/uSvkACgkQCDBEmo7z
X9vgsg//Wcpmagto1fiQX6J6uVVXuffSZXSEfHlKd/QSTSfJpx1mDOlEQrvUht7w
Xvk9jmHhm3nM2S6B1afrVR+ygW4g0TBwXcc3JmPeKK2/80Z8BWzW8wUPdusxOpoX
bgOQVdt7X3BGZCR/5gbIydTJ7uBMl/sdBsmIykPP6m8nCorD5aIc1UAa/49KnnHU
K5NnX1m9f2Ye6tJSn47mBajNP+lCeKyn6rXzJFvbD0b8EMOm40/I7CQdNWnzJRRq
GfkbCJD0C8uoqTY0bvGQQSwv69DJc5DcU7dgz2uByRvIg7XFfucUvknwOlmKM1DL
Bwn1e2+QqjTZhy5T68s3Xs6bDbo2uJ9di6UahF+0Mvrj230pXtJsLG6MH0esQHfS
j9av7rAi+ZDjnUjX9gQu1t7uoEBXp9VI59pwf2HukFOftCp/V0iXsvodl3arARbn
+oZN4tmduz+9WgoJWoau4vUwF5l4Pz4C7y3uPj5w8x2lEi9Ds2aVgNiF6xoVweqQ
8kgPPBmaURBEVAcCtjZ+lCbg2pXkEqblXUgIbzYMA1+4hI1cOXC58eqUG11WiliW
QEn7O43F6fm/Z+g6z4abV19Zj6S4rsJ+c03pHvzUF/tCneaO4ymYcDxjLUfgI46M
IFv79L16aH2OJ33gFW9Dt4ehVL6SXiznTrZ/O3SFxiGE0yfu9nQ=
=snBh
-----END PGP SIGNATURE-----

--2nvqc0kNWltf5Qkb--
