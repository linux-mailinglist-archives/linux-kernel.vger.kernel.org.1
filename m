Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59882F491E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbhAMK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:57:43 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:57721 "EHLO
        smtpcmd02102.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbhAMK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:57:43 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 05:57:41 EST
Received: from ubuntu.localdomain ([146.241.213.249])
        by Aruba Outgoing Smtp  with ESMTPSA
        id zdgYkpGEuM8oXzdgYkw9Bi; Wed, 13 Jan 2021 11:47:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610534854; bh=9qQyXA1FoXtBqukZr+f9ZXHvisI/kRQH2J5vy5XyEIo=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=S6jzU0A7GrZFhi2GtlbrSsbkvCLBbMUPJBGLy9eOvomu6IVOFRuEIi7+GstCjiSgu
         dQKuh9WB6uahVhyCAKCtSbqD0OLpm+LAkIvoEFObsgd5HyjgUMSB1OhqG87CCBk2gE
         ZVNAvLSua84xAAmkJ3GpDdXU+hW1s1XbqNaiXpJR6nL9mmoAjY7E+DArWp+hS5v0Op
         097PnvKn5guAk0+6ZiX1BqFqYcZHQQ+Me89BWLYM7W6+GVPdRU1QkJG0rKoo0+neV1
         myVB3vGzF6m3tm8i2EOkzzHO1VTP0OHIuqstk7MPFgJltv1fGW5byZ/nWJwJoSVBza
         tkeNGlcYiTtXw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v4] drm/sun4i: tcon: fix inverted DCLK polarity
Date:   Wed, 13 Jan 2021 11:47:25 +0100
Message-Id: <20210113104725.770459-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113094214.5ijq3inmffticym6@gilmour>
References: <20210113094214.5ijq3inmffticym6@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKOmPT1i9gArIC10WEB2Cw3vWYQTurVk9+ZL0ZbFumP8RZ/5bgpdB6saoV83KQ0rIsKqA5WDklykap4YzgK76/u1D/biEoFBIitr6YQxxZl7/xY+WaHb
 5B6YDCYzVe51IP2JS0ezr+65FUu7Fnn7Czg6VAfddH8XRvcNIQjE9UMtnxyM0/MhLVbavdMxAhu6P4q9ieetTJk4XDNumZMKFvCYCkMqjwv/Xj58jrXRFMS9
 DqhitwiojBnu1j6sE/gZ9LvvJjiAzAq/icQwEa7T9LWiFoz3hjpQJvN/KYlEF0h2lEOtzVmArNd2Nkm2Q/j2xwWwccaJF05jccxvRPNLUVLkPZ805eXAm2Xn
 q5gWpTpBzc7CXEGUTqj4WVK5o9b7fsCASRiO4S0sJxIJzfOCfxzhQqv4VQKCsm75JJfuBgS/bibdSv6hjUsAHkYPuPB1gnprEDUUQwd9w3Y3IVvFJh8yy33D
 9UMWsD8uxlPMuFWhmhtw8zi8RPQ2aNig5/bdYVnXjmv90C/0lhhP7bynZdOiTtDzA3ugeOIbWhVkFjR7S9SvkWSf+iT+oylKKRuE8g==
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
V2->V3:
- squash 2 patches into 1
V3->V4:
- add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to regmap_update_bits()
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 21 ++-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eaaf5d70e352..6e454d316852 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -569,30 +569,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
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
 			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DCLK_POSITIVE |
 			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
 			   val);
 
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

