Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1572F1CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbhAKRrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:47:25 -0500
Received: from smtpcmd0757.aruba.it ([62.149.156.57]:44865 "EHLO
        smtpcmd15177.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731491AbhAKRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:47:25 -0500
Received: from ubuntu.localdomain ([146.241.213.249])
        by Aruba Outgoing Smtp  with ESMTPSA
        id z1GjkRGDyiSGyz1Gjkaavf; Mon, 11 Jan 2021 18:46:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610387178; bh=Ca6189y784Sxey3V9K1qguxyPzu74JGwy0/hBI3B9to=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=LNp1jR0jPyCGKBnVVpN95O6afp6gqj/UGJWncmWtQONYy0mV+bu5uTSjruxU2v5tF
         9jE0/7lYQPYTZficRPhGlTC11EZGRX6BWokg0OvxuTea8nyWOPLrp06A2TPNJdtheL
         WnvsMnakYYqN+PFt2/NAKmshJILXkQ7Xc9gL3wVJUh0hol6in8iNW/vHrFeAZFkyF+
         16BLW6Ps1BP1xDOMCXEuFupwUJ+IqLNRo/EetQEJ6zkBT4Y1d5gl+rq8P3fvDXRayx
         DvR9C0ZiYU7dj/d2J7UuPGLceUK3rQ7YMDmmZJyt6CL1uJnwNmaz1UtoAl1pu9b+0u
         aZQqTdg+8cokQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v3] drm/sun4i: tcon: fix inverted DCLK polarity
Date:   Mon, 11 Jan 2021 18:46:16 +0100
Message-Id: <20210111174616.904674-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111172052.7v522xam74xkq6se@gilmour>
References: <20210111172052.7v522xam74xkq6se@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDup+r40w/DVk1kX8+yAaIMrvruDTsL6bSVYHysQ+qH51PHBqAerYJz2xv2LvLOBlKINxaiuYF14IartUl3jr8NJsoHmf3BGfpc72sS8FwEqoiLjNu+A
 O3Iv8pPDbmBQ9Fdc1YmZV4tWYcg6H927yJzvX5ns83cStSHAYdgNmUa0eXg4jlJvsVLEB18JWL2Ux5RjxZZa3tIwrj7koz0wq+NsED3id3DTUVxJIipmRNvL
 kXbFpy0xbxq88aOYvEwMeWB96VNM9n+xCuyExKAjmulbCnMApbsXJe08zZDuSouJWOFguV/bYNXZcgEIDcD/WgQbs4V0mEto9+KwLNdOtNbwdUTcjki4XlZw
 nE5ERLzstZeJNCrucstlSJcTmPYmomrjE2WOoCFVz+NxhzYj1ffGGmIgOMpgskqfcIfnCW8goalkTeYsRN+d1RNlhEYgpENk7lFm/skG7W38b+zxwVG/SlZz
 gYfiuhQ4BmJWCsADAK1Oumy+7RzivPv4tM2goudcFuvwYmmos1k3GnLydRCsDcMKehQ/w2LGnktUntG8r50OGbM2tZc0gvAokxCV/w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

During commit 88bc4178568b ("drm: Use new
DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags") DRM_BUS_FLAG_*
macros have been changed to avoid ambiguity but just because of this
ambiguity previous DRM_BUS_FLAG_PIXDATA_(POS/NEG)EDGE were used meaning
_SAMPLE_ not _DRIVE_. This leads to DLCK inversion and need to fix but
instead of swapping phase values, let's adopt an easier approach Maxime
suggested:
It turned out that bit 26 of SUN4I_TCON0_IO_POL_REG is dedicated to
invert DCLK polarity and this makes things really easier than before. So
let's handle DCLK polarity by adding SUN4I_TCON0_IO_POL_DCLK_POSITIVE as
bit 26 and activating according to bus_flags the same way it is done for
all the other signals polarity.

Fixes: 88bc4178568b ("drm: Use new DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags")
Suggested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 20 +-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eaaf5d70e352..30171ccd87e5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -569,26 +569,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (info->bus_flags & DRM_BUS_FLAG_DE_LOW)
 		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
 
-	/*
-	 * On A20 and similar SoCs, the only way to achieve Positive Edge
-	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
-	 * By default TCON works in Negative Edge(Falling Edge),
-	 * this is why phase is set to 0 in that case.
-	 * Unfortunately there's no way to logically invert dclk through
-	 * IO_POL register.
-	 * The only acceptable way to work, triple checked with scope,
-	 * is using clock phase set to 0° for Negative Edge and set to 240°
-	 * for Positive Edge.
-	 * On A33 and similar SoCs there would be a 90° phase option,
-	 * but it divides also dclk by 2.
-	 * Following code is a way to avoid quirks all around TCON
-	 * and DOTCLOCK drivers.
-	 */
 	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
-		clk_set_phase(tcon->dclk, 240);
-
-	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
-		clk_set_phase(tcon->dclk, 0);
+		val |= SUN4I_TCON0_IO_POL_DCLK_POSITIVE;
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index cfbf4e6c1679..0ce71d10a31b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -113,6 +113,7 @@
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
 #define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
+#define SUN4I_TCON0_IO_POL_DCLK_POSITIVE		BIT(26)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
-- 
2.25.1

