Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE72F09B1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhAJUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:20:40 -0500
Received: from mailoutvs31.siol.net ([185.57.226.222]:50872 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbhAJUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:20:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 025435217B9;
        Sun, 10 Jan 2021 21:19:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EZhK8rYayemS; Sun, 10 Jan 2021 21:19:57 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B9256521749;
        Sun, 10 Jan 2021 21:19:57 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4D9BF5212A4;
        Sun, 10 Jan 2021 21:19:55 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, irlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/3] drm/sun4i: csc: Rework DE3 CSC macros
Date:   Sun, 10 Jan 2021 21:19:45 +0100
Message-Id: <20210110201947.3611649-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110201947.3611649-1-jernej.skrabec@siol.net>
References: <20210110201947.3611649-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework DE3 CSC macros to take just one coordinate instead of two. This
will make its usage easier in subsequent commit.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c   | 2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index 781955dd4995..5c6ad643dae2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -194,7 +194,7 @@ static void sun8i_de3_ccsc_set_coefficients(struct re=
gmap *map, int layer,
 		return;
 	}
=20
-	base_reg =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, layer, 0, 0);
+	base_reg =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, layer, 0);
 	regmap_bulk_write(map, base_reg, table, 12);
 }
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 7576b523fdbb..145833a9d82d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -50,10 +50,8 @@
 #define SUN8I_MIXER_BLEND_CK_MIN(base, x)	((base) + 0xe0 + 0x04 * (x))
 #define SUN8I_MIXER_BLEND_OUTCTL(base)		((base) + 0xfc)
 #define SUN50I_MIXER_BLEND_CSC_CTL(base)	((base) + 0x100)
-#define SUN50I_MIXER_BLEND_CSC_COEFF(base, layer, x, y) \
-	((base) + 0x110 + (layer) * 0x30 +  (x) * 0x10 + 4 * (y))
-#define SUN50I_MIXER_BLEND_CSC_CONST(base, layer, i) \
-	((base) + 0x110 + (layer) * 0x30 +  (i) * 0x10 + 0x0c)
+#define SUN50I_MIXER_BLEND_CSC_COEFF(base, layer, x) \
+	((base) + 0x110 + (layer) * 0x30 +  (x) * 4)
=20
 #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK	GENMASK(12, 8)
 #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
--=20
2.30.0

