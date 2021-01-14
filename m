Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E842F5C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhANISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:18:51 -0500
Received: from smtpcmd02101.aruba.it ([62.149.158.101]:38711 "EHLO
        smtpcmd02101.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhANISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:18:51 -0500
Received: from ubuntu.localdomain ([146.241.213.249])
        by Aruba Outgoing Smtp  with ESMTPSA
        id zxp6kTFwPytJRzxp7k7D6v; Thu, 14 Jan 2021 09:17:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610612265; bh=q9tueK9HEveBIOB8QrMmLAUmWUHC2u5Y0+MdQPVjTIE=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=ewDfyysXYQny7iV4C97hOUvVlJ2OLe14AtC5hSFEgcteYN6eozPt3z5x2Co5jbgyk
         laP44spnPMwob+qJDmBdyj/RP0HPS8EvWHBnEzkbeheEdqaFAOLmIyD4xY8rFhlois
         kFmJHKNClAHG+bHxVsNJVRZVgKm3jslI38tW4FGZ5dp5TxvvkBGqJfVQdtuTQK3pIS
         afmsbAP9hAZ5qRWOeDnG3GImfCtzydZlUKxr/ZheN6jBErwOhNBHozchNf1ihFBFiy
         kgHVg88AV2U8OtX//wODjT/eXX4VubKekWWQTLRWU0Es2Cq6MHr1vfFuZ1EpY5bru3
         Ho8pU85ql+B2g==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v6] drm/sun4i: tcon: fix inverted DCLK polarity
Date:   Thu, 14 Jan 2021 09:17:32 +0100
Message-Id: <20210114081732.9386-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
References: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAGxm1wXP7WDU9n8Y3GoHjUuJw0ErOooXMnbt1lHUamPDJFDY73JmY397X+QMkzt+JIddcsWmy0ToiK6rYPYMssLsfK3GB0ODoH2uUhSe/jo65oJeKEa
 09jlDX+51JqJFmb30T5Yp+N3cf7pNvBlEEeeMm/TYHF551iAt/Gz7o2n9euV6CVgW3vpIMxP4NcuWo27vI9BjZhYNSdGJDY5lvLjJr0kJ6yi2XroP9TuR+0D
 McPqrX4AnQySdF04Hzxvd1fFnQFOi2JRVS9XY5TZdDIT2AAX6VvuzCratmHztgQ9yr+sQzqj5/02FV6mUSaNXMIaI+q3PMF0NNX4doArC1bmZo+CPh6WI3+p
 tix0d8/mzt8MWlk+vy/R28ssBmnNXWVOW6avcNKxO3V5M0XhqA6EO7mHdGH8WGMKh3Eh4GcsHdpILwpWivaE50j7l5GTw9V+NUQaQ4qGGHkq2s63e1bvWUTm
 D7EzNRjM/S0i3V5Nti+5tXAamTVWQejgrhNYbEpUQ4biIYIa8Nyzq/bL90WwYFyNIM5f3gvkIi2bAkvR0v14u7YkO443ispsdYLJ6w==
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
- add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to regmap_update_bits() as suggested by Maxime
V4->V5:
polarity is still wrong so:
- let's use SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE macro
  instead of _DCLK_POSITIVE(that would make sense only in realtion with DCLK)
- invert condition using _NEGEDGE instead of _POSEDGE and then matching with
  register bit SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
- correct commit log according to V4->V5 changes
V5->V6:
- fix typo in SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE as suggested by Marjan
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 21 ++-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eaaf5d70e352..6b9af4c08cd6 100644
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
+			   SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE |
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

