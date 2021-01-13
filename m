Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECA2F4F84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbhAMQGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:06:42 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:43151 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbhAMQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:06:41 -0500
Received: from ubuntu.localdomain ([146.241.213.249])
        by Aruba Outgoing Smtp  with ESMTPSA
        id zieJkU4CD5BgLzieJkLwdj; Wed, 13 Jan 2021 17:05:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610553934; bh=vVVA4Opin9OtrAi4JKFF69zz8U3z+kSm0iZZv2AXo0E=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=C8vaE1KcaPwamF1yndjEovf1ptF5PZIFv4880+ztpTxyOUqEL6AyODRy3kOxy2RZQ
         6UDgyeQZbNKu55pzl9EbkhywVz14j/ieB8osZYCXdCFgWBE6njH+1L5NCo/NrYhZA1
         HIa8HwoSvclNRLI229zA6euTFtPrmfUCmUVNg3VO/Gy1Cf2ViIohgZcE/NEkmnPde6
         DbSl6NlmCunbP7k9Z9xa2XKKiJkO7eRTFy+i1BfkSf9+YD+9dZzIAoofb+8cX/TpGj
         uPDmAQjpPalMIHuOi1k/6QR5GOxKFlDEw1HwoUBQi2iZZhALZ4xuU1RFcCS27xdoOO
         8xHuL0wCzTshQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v5] drm/sun4i: tcon: fix inverted DCLK polarity
Date:   Wed, 13 Jan 2021 17:05:26 +0100
Message-Id: <20210113160526.928766-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113104725.770459-1-giulio.benetti@benettiengineering.com>
References: <20210113104725.770459-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPHjKTt1umdvQBS37mgZ8A8jNdkItS6XleUm2Vrj7oIZQNMEu7RIrkrck8ANEZ/VyNbwxA7UzXqsfIpXinJ0DkgiSQNMcbskc30Ozi0vz1C4EuhPNf+x
 KYwN/yfo/M4iavqbBWlxbgNTvVRq+tUIYvwriIVNE5t+TN10cNw834AkAJyOuD8Gv6ATCu01CMJl7exSUQ3nAYgVSuIahlDchlKLzVoNsKli6Do5frNL4NNz
 EvYK9UcxbeZQXNuNGSVG2OF590S22rW09FnmvR9ydXr1xR1s3fWVUbY0u02a2ncSHC//CxFkKBmUfvXlBTkNvjofH0udhtW+tUJSVN6/0AZ8XBeg+X76hrPd
 vnn94DBkoVVMuJonw4NuSdnMH4fJwapE3LuyPqj6t9BoqJB7qVkp2ZLitTU1gOvHihhPzq6EL2IdPQ0fI+3AJSKAI11ZJL3FHJyIoJ/v3sxsIE+H5weUiWNn
 Zavh592HQNSGNedWDS01T14+9zOjcXDfbrsHg4SIqUciKkx+t30Jl6ntRfNRpewKhK2CVbSf0yWLdKmi4JVm3g9LfBHL8wAS0hsfkQ==
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
let's handle DCLK polarity by adding SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
as bit 26 and activating according to bus_flags the same way it is done
for all the other signals polarity.

Fixes: 88bc4178568b ("drm: Use new DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags")
Suggested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
V2->V3:
- squash 2 patches into 1
V3->V4:
- add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to regmap_update_bits()
V4->V5:
polarity is still wrong so:
- let's use SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE macro
  instead of _DCLK_POSITIVE(that would make sense only in realtion with DCLK)
- invert condition using _NEGEDGE instead of _POSEDGE and then matching with
  register bit SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
- correct commit log according to V4->V5 changes
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 21 ++-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eaaf5d70e352..c172ccfff7e5 100644
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
-	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
-		clk_set_phase(tcon->dclk, 240);
-
 	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
-		clk_set_phase(tcon->dclk, 0);
+		val |= SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE;
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
 			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGDGE |
 			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
 			   val);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index cfbf4e6c1679..c5ac1b02482c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -113,6 +113,7 @@
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
 #define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
+#define SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE		BIT(26)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
-- 
2.25.1

