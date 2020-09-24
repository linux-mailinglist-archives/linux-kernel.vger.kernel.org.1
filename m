Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372E1276EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIXKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:41:51 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55484 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:41:51 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AEF841C0BDE; Thu, 24 Sep 2020 12:41:48 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:41:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Greg KH <greg@kroah.com>
Cc:     linus.walleij@linaro.org, lenaptr@google.com, will@kernel.org
Subject: [PATCH 4.4] pinctrl: devicetree: Avoid taking direct reference to
 device name string
Message-ID: <20200924104148.GC30460@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

commit be4c60b563edee3712d392aaeb0943a768df7023 upstream.

When populating the pinctrl mapping table entries for a device, the
'dev_name' field for each entry is initialised to point directly at the
string returned by 'dev_name()' for the device and subsequently used by
'create_pinctrl()' when looking up the mappings for the device being
probed.

This is unreliable in the presence of calls to 'dev_set_name()', which may
reallocate the device name string leaving the pinctrl mappings with a
dangling reference. This then leads to a use-after-free every time the
name is dereferenced by a device probe:

  | BUG: KASAN: invalid-access in strcmp+0x20/0x64
  | Read of size 1 at addr 13ffffc153494b00 by task modprobe/590
  | Pointer tag: [13], memory tag: [fe]
  |
  | Call trace:
  |  __kasan_report+0x16c/0x1dc
  |  kasan_report+0x10/0x18
  |  check_memory_region
  |  __hwasan_load1_noabort+0x4c/0x54
  |  strcmp+0x20/0x64
  |  create_pinctrl+0x18c/0x7f4
  |  pinctrl_get+0x90/0x114
  |  devm_pinctrl_get+0x44/0x98
  |  pinctrl_bind_pins+0x5c/0x450
  |  really_probe+0x1c8/0x9a4
  |  driver_probe_device+0x120/0x1d8

Follow the example of sysfs, and duplicate the device name string before
stashing it away in the pinctrl mapping entries.

Cc: Linus Walleij <linus.walleij@linaro.org>
Reported-by: Elena Petrova <lenaptr@google.com>
Tested-by: Elena Petrova <lenaptr@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20191002124206.22928-1-will@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe04e748dfe4..6c0c84cb2601 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -40,6 +40,13 @@ struct pinctrl_dt_map {
 static void dt_free_map(struct pinctrl_dev *pctldev,
 		     struct pinctrl_map *map, unsigned num_maps)
 {
+	int i;
+
+	for (i =3D 0; i < num_maps; ++i) {
+		kfree_const(map[i].dev_name);
+		map[i].dev_name =3D NULL;
+	}
+
 	if (pctldev) {
 		const struct pinctrl_ops *ops =3D pctldev->desc->pctlops;
 		ops->dt_free_map(pctldev, map, num_maps);
@@ -73,7 +80,13 @@ static int dt_remember_or_free_map(struct pinctrl *p, co=
nst char *statename,
=20
 	/* Initialize common mapping table entry fields */
 	for (i =3D 0; i < num_maps; i++) {
-		map[i].dev_name =3D dev_name(p->dev);
+		const char *devname;
+
+		devname =3D kstrdup_const(dev_name(p->dev), GFP_KERNEL);
+		if (!devname)
+			goto err_free_map;
+
+		map[i].dev_name =3D devname;
 		map[i].name =3D statename;
 		if (pctldev)
 			map[i].ctrl_dev_name =3D dev_name(pctldev->dev);
@@ -81,11 +94,8 @@ static int dt_remember_or_free_map(struct pinctrl *p, co=
nst char *statename,
=20
 	/* Remember the converted mapping table entries */
 	dt_map =3D kzalloc(sizeof(*dt_map), GFP_KERNEL);
-	if (!dt_map) {
-		dev_err(p->dev, "failed to alloc struct pinctrl_dt_map\n");
-		dt_free_map(pctldev, map, num_maps);
-		return -ENOMEM;
-	}
+	if (!dt_map)
+		goto err_free_map;
=20
 	dt_map->pctldev =3D pctldev;
 	dt_map->map =3D map;
@@ -93,6 +103,11 @@ static int dt_remember_or_free_map(struct pinctrl *p, c=
onst char *statename,
 	list_add_tail(&dt_map->node, &p->dt_maps);
=20
 	return pinctrl_register_map(map, num_maps, false);
+
+err_free_map:
+	dev_err(p->dev, "failed to alloc struct pinctrl_dt_map\n");
+	dt_free_map(pctldev, map, num_maps);
+	return -ENOMEM;
 }
=20
 struct pinctrl_dev *of_pinctrl_get(struct device_node *np)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2x37AAKCRAw5/Bqldv6
8qkZAKC9dWwc97Pl/GLmfkCVElewKsmzIACdGHscbamgAyV0ffBqD3sXDC3fSdg=
=dg3p
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
