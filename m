Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6812F09B3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbhAJUUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:20:46 -0500
Received: from mailoutvs23.siol.net ([185.57.226.214]:50936 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727027AbhAJUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:20:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9C3D05217D7;
        Sun, 10 Jan 2021 21:20:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 922D92QtKVk1; Sun, 10 Jan 2021 21:20:02 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4FD4A521513;
        Sun, 10 Jan 2021 21:20:02 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 0E5595217D7;
        Sun, 10 Jan 2021 21:20:00 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, irlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 3/3] drm/sun4i: Add support for BT2020 to DE3
Date:   Sun, 10 Jan 2021 21:19:47 +0100
Message-Id: <20210110201947.3611649-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110201947.3611649-1-jernej.skrabec@siol.net>
References: <20210110201947.3611649-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE3 supports 10-bit formats, so it's only naturally to also support
BT2020 encoding.

Add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c      | 12 +++++++++++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index 1d10714e417e..9bd62de0c288 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -69,7 +69,7 @@ static const u32 yuv2rgb[2][2][12] =3D {
  * c20 c21 c22 [d2 const2]
  */
=20
-static const u32 yuv2rgb_de3[2][2][12] =3D {
+static const u32 yuv2rgb_de3[2][3][12] =3D {
 	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
 		[DRM_COLOR_YCBCR_BT601] =3D {
 			0x0002542A, 0x00000000, 0x0003312A, 0xFFC00000,
@@ -80,6 +80,11 @@ static const u32 yuv2rgb_de3[2][2][12] =3D {
 			0x0002542A, 0x00000000, 0x000395E2, 0xFFC00000,
 			0x0002542A, 0xFFFF92D2, 0xFFFEEF27, 0xFE000000,
 			0x0002542A, 0x0004398C, 0x00000000, 0xFE000000,
+		},
+		[DRM_COLOR_YCBCR_BT2020] =3D {
+			0x0002542A, 0x00000000, 0x00035B7B, 0xFFC00000,
+			0x0002542A, 0xFFFFA017, 0xFFFEB2FC, 0xFE000000,
+			0x0002542A, 0x00044896, 0x00000000, 0xFE000000,
 		}
 	},
 	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
@@ -92,6 +97,11 @@ static const u32 yuv2rgb_de3[2][2][12] =3D {
 			0x00020000, 0x00000000, 0x0003264C, 0x00000000,
 			0x00020000, 0xFFFFA018, 0xFFFF1053, 0xFE000000,
 			0x00020000, 0x0003B611, 0x00000000, 0xFE000000,
+		},
+		[DRM_COLOR_YCBCR_BT2020] =3D {
+			0x00020000, 0x00000000, 0x0002F2FE, 0x00000000,
+			0x00020000, 0xFFFFABC0, 0xFFFEDB78, 0xFE000000,
+			0x00020000, 0x0003C346, 0x00000000, 0xFE000000,
 		}
 	},
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 76393fc976fe..8cc294a9969d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -543,6 +543,8 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct=
 drm_device *drm,
=20
 	supported_encodings =3D BIT(DRM_COLOR_YCBCR_BT601) |
 			      BIT(DRM_COLOR_YCBCR_BT709);
+	if (mixer->cfg->is_de3)
+		supported_encodings |=3D BIT(DRM_COLOR_YCBCR_BT2020);
=20
 	supported_ranges =3D BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
 			   BIT(DRM_COLOR_YCBCR_FULL_RANGE);
--=20
2.30.0

