Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7E2EC82B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbhAGCli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:41:38 -0500
Received: from smtpcmd11116.aruba.it ([62.149.156.116]:48351 "EHLO
        smtpcmd11116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbhAGClf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:41:35 -0500
Received: from ubuntu.localdomain ([146.241.198.163])
        by Aruba Outgoing Smtp  with ESMTPSA
        id xL4LkiX9OkRIKxL4PkeM1d; Thu, 07 Jan 2021 03:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1609986637; bh=TsdBOWdkASmq0ug4ZNOIO/B3vCFbiRe6dDUb+k/UQ4E=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=mBzxjfQ2sku8+pC+vRYFNCnlDuKEX6L0W8ywr4Je/g3x17XR0tttSskK7ZBp1kCq6
         CgjVsGHs4SLLXdgjxRuBpLvVF7mQAGCyryzuH4HZ1QCMi3obxbiiAkd36l0sWSF+Hr
         Ulc3WfKZv1/xz+aNru8Oa7ttmBievwGle9YdsVDAQhIW3fE+AQVG4spJ5cxAGYnxpJ
         dq48yBq9Zb4ywoaZiMqbxSEdBDyErbK2HPxMu1IW2NHchjNH/POyZt/o0+hE6Kiwr1
         YcKLSUpAWZMoPTevdbimvG13iDbR9j/995Gl1n9L05sGRoBWCGY3ny1WKqgEUR7fvk
         ETHLZFan0AGxg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 2/2] drm/sun4i: tcon: improve DCLK polarity handling
Date:   Thu,  7 Jan 2021 03:30:32 +0100
Message-Id: <20210107023032.560182-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107023032.560182-1-giulio.benetti@benettiengineering.com>
References: <3685133.SLcexNTYsu@kista>
 <20210107023032.560182-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAiJ3v+tQqxZQm2L6MNuPUOmMXkyJgh41Q4J9f+nBGG2LDgpAgSXBGMzr/p67u+hk99UQ0KVAMFRmU2+lQK+F9LAuUjNqX725Tk2dJvTsix5pYBTFRFf
 To80IhdgB2N9FkcNVVTJiuJdzT/hTMScgbVaJkXY2NKXERyqzRDy6Q/7s+tfpVlPiZOflTVlnGJlgiCK19eBHsV7aIUw/zEk+/ICmSx3lkxE6cWUKawo/4Eo
 NhkbfK39gAjs8kyxhc5HwkiK06fXqu6j6mHV2qCJNwosXad3+/qscyiSh3xk7XC6zQjNRJ0591VK6S9YZWwVZ0dq4D7mW2zgNmXdcthqwuTUey8/r7sreux1
 +hvCRL3YyrM7bGGve480+86qMVPZe1s0aYQnUwuN7ySo9jbYUgZTsJESRn5qREVS66SxM4En5p/xyIrUE3pxhcQw5J+Hvo3ebH6HyPcptyH/Jew+xeq+BT/C
 yFhYF0nIqMkxO1xi2V4rVadpJFMN/h44qf+mPpPo97B6dE5+TX7r4RL/MewgeSCRgSxQSou+pPzr7EY8nRMgq0MNERn+qoUFsd6BEQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

It turned out(Maxime suggestion) that bit 26 of SUN4I_TCON0_IO_POL_REG is
dedicated to invert DCLK polarity and this makes thing really easier than
before. So let's handle DCLK polarity by adding
SUN4I_TCON0_IO_POL_DCLK_POSITIVE as bit 26 and activating according to
bus_flags the same way is done for all the other signals.

Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 20 +-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 52598bb0fb0b..30171ccd87e5 100644
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
-		clk_set_phase(tcon->dclk, 0);
-
-	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
-		clk_set_phase(tcon->dclk, 240);
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

