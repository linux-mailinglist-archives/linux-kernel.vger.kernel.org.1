Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F622C101
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGXIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 04:41:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37428 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:41:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4E5861C0BD2; Fri, 24 Jul 2020 10:41:13 +0200 (CEST)
Date:   Fri, 24 Jul 2020 10:41:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] RDMA/mlx5: fix typo in structure name
Message-ID: <20200724084112.GC31930@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is user API, but likely noone uses it...? Fix it before it
becomes problem.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>


diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/m=
lx5_user_ioctl_cmds.h
index 8e316ef896b5..2d889df38df6 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -259,7 +259,7 @@ enum mlx5_ib_create_flow_attrs {
 	MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
 };
=20
-enum mlx5_ib_destoy_flow_attrs {
+enum mlx5_ib_destroy_flow_attrs {
 	MLX5_IB_ATTR_DESTROY_FLOW_HANDLE =3D (1U << UVERBS_ID_NS_SHIFT),
 };
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8anqgACgkQMOfwapXb+vJDugCfaYsiuj7DNwprSvQEpcgL6Ny3
ZI0An1SzQHO9yKKHkQOGUCxPcJlZh9JZ
=fHM/
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
