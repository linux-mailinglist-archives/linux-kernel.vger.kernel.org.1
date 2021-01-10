Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D32F09B2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbhAJUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:20:44 -0500
Received: from mailoutvs7.siol.net ([185.57.226.198]:50899 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbhAJUUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:20:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 68E195217C5;
        Sun, 10 Jan 2021 21:20:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RTN1oNalIV-q; Sun, 10 Jan 2021 21:20:00 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 09E9A5212A4;
        Sun, 10 Jan 2021 21:20:00 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id BF3985217C5;
        Sun, 10 Jan 2021 21:19:57 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, irlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] drm/sun4i: de2/de3: Remove redundant CSC matrices
Date:   Sun, 10 Jan 2021 21:19:46 +0100
Message-Id: <20210110201947.3611649-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110201947.3611649-1-jernej.skrabec@siol.net>
References: <20210110201947.3611649-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YUV to RGB matrices are almost identical to YVU to RGB matrices. They
only have second and third column reversed. Do that reversion in code in
order to lower amount of static data and redundancy.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c | 99 +++++++++++--------------------
 1 file changed, 34 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index 5c6ad643dae2..1d10714e417e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -46,33 +46,6 @@ static const u32 yuv2rgb[2][2][12] =3D {
 	},
 };
=20
-static const u32 yvu2rgb[2][2][12] =3D {
-	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
-		[DRM_COLOR_YCBCR_BT601] =3D {
-			0x000004A8, 0x00000662, 0x00000000, 0xFFFC8451,
-			0x000004A8, 0xFFFFFCC0, 0xFFFFFE6F, 0x00021E4D,
-			0x000004A8, 0x00000000, 0x00000811, 0xFFFBACA9,
-		},
-		[DRM_COLOR_YCBCR_BT709] =3D {
-			0x000004A8, 0x0000072B, 0x00000000, 0xFFFC1F99,
-			0x000004A8, 0xFFFFFDDF, 0xFFFFFF26, 0x00013383,
-			0x000004A8, 0x00000000, 0x00000873, 0xFFFB7BEF,
-		}
-	},
-	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
-		[DRM_COLOR_YCBCR_BT601] =3D {
-			0x00000400, 0x0000059B, 0x00000000, 0xFFFD322E,
-			0x00000400, 0xFFFFFD25, 0xFFFFFEA0, 0x00021DD5,
-			0x00000400, 0x00000000, 0x00000716, 0xFFFC74BD,
-		},
-		[DRM_COLOR_YCBCR_BT709] =3D {
-			0x00000400, 0x0000064C, 0x00000000, 0xFFFCD9B4,
-			0x00000400, 0xFFFFFE21, 0xFFFFFF41, 0x00014F96,
-			0x00000400, 0x00000000, 0x0000076C, 0xFFFC49EF,
-		}
-	},
-};
-
 /*
  * DE3 has a bit different CSC units. Factors are in two's complement fo=
rmat.
  * First three factors in a row are multiplication factors which have 17=
 bits
@@ -123,33 +96,6 @@ static const u32 yuv2rgb_de3[2][2][12] =3D {
 	},
 };
=20
-static const u32 yvu2rgb_de3[2][2][12] =3D {
-	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
-		[DRM_COLOR_YCBCR_BT601] =3D {
-			0x0002542A, 0x0003312A, 0x00000000, 0xFFC00000,
-			0x0002542A, 0xFFFE5FC3, 0xFFFF376B, 0xFE000000,
-			0x0002542A, 0x00000000, 0x000408D2, 0xFE000000,
-		},
-		[DRM_COLOR_YCBCR_BT709] =3D {
-			0x0002542A, 0x000395E2, 0x00000000, 0xFFC00000,
-			0x0002542A, 0xFFFEEF27, 0xFFFF92D2, 0xFE000000,
-			0x0002542A, 0x00000000, 0x0004398C, 0xFE000000,
-		}
-	},
-	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
-		[DRM_COLOR_YCBCR_BT601] =3D {
-			0x00020000, 0x0002CDD2, 0x00000000, 0x00000000,
-			0x00020000, 0xFFFE925D, 0xFFFF4FCE, 0xFE000000,
-			0x00020000, 0x00000000, 0x00038B43, 0xFE000000,
-		},
-		[DRM_COLOR_YCBCR_BT709] =3D {
-			0x00020000, 0x0003264C, 0x00000000, 0x00000000,
-			0x00020000, 0xFFFF1053, 0xFFFFA018, 0xFE000000,
-			0x00020000, 0x00000000, 0x0003B611, 0xFE000000,
-		}
-	},
-};
-
 static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
 				       enum sun8i_csc_mode mode,
 				       enum drm_color_encoding encoding,
@@ -157,21 +103,30 @@ static void sun8i_csc_set_coefficients(struct regma=
p *map, u32 base,
 {
 	const u32 *table;
 	u32 base_reg;
+	int i;
+
+	table =3D yuv2rgb[range][encoding];
=20
 	switch (mode) {
 	case SUN8I_CSC_MODE_YUV2RGB:
-		table =3D yuv2rgb[range][encoding];
+		base_reg =3D SUN8I_CSC_COEFF(base, 0);
+		regmap_bulk_write(map, base_reg, table, 12);
 		break;
 	case SUN8I_CSC_MODE_YVU2RGB:
-		table =3D yvu2rgb[range][encoding];
+		for (i =3D 0; i < 12; i++) {
+			if ((i & 3) =3D=3D 1)
+				base_reg =3D SUN8I_CSC_COEFF(base, i + 1);
+			else if ((i & 3) =3D=3D 2)
+				base_reg =3D SUN8I_CSC_COEFF(base, i - 1);
+			else
+				base_reg =3D SUN8I_CSC_COEFF(base, i);
+			regmap_write(map, base_reg, table[i]);
+		}
 		break;
 	default:
 		DRM_WARN("Wrong CSC mode specified.\n");
 		return;
 	}
-
-	base_reg =3D SUN8I_CSC_COEFF(base, 0);
-	regmap_bulk_write(map, base_reg, table, 12);
 }
=20
 static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int laye=
r,
@@ -180,22 +135,36 @@ static void sun8i_de3_ccsc_set_coefficients(struct =
regmap *map, int layer,
 					    enum drm_color_range range)
 {
 	const u32 *table;
-	u32 base_reg;
+	u32 addr;
+	int i;
+
+	table =3D yuv2rgb_de3[range][encoding];
=20
 	switch (mode) {
 	case SUN8I_CSC_MODE_YUV2RGB:
-		table =3D yuv2rgb_de3[range][encoding];
+		addr =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, layer, 0);
+		regmap_bulk_write(map, addr, table, 12);
 		break;
 	case SUN8I_CSC_MODE_YVU2RGB:
-		table =3D yvu2rgb_de3[range][encoding];
+		for (i =3D 0; i < 12; i++) {
+			if ((i & 3) =3D=3D 1)
+				addr =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE,
+								    layer,
+								    i + 1);
+			else if ((i & 3) =3D=3D 2)
+				addr =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE,
+								    layer,
+								    i - 1);
+			else
+				addr =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE,
+								    layer, i);
+			regmap_write(map, addr, table[i]);
+		}
 		break;
 	default:
 		DRM_WARN("Wrong CSC mode specified.\n");
 		return;
 	}
-
-	base_reg =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, layer, 0);
-	regmap_bulk_write(map, base_reg, table, 12);
 }
=20
 static void sun8i_csc_enable(struct regmap *map, u32 base, bool enable)
--=20
2.30.0

