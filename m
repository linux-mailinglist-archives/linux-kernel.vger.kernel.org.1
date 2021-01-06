Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1FE2EC40D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbhAFThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:37:08 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:59240 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbhAFThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:37:01 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 75207B045F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 20:28:04 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:subject:subject:to:from:from; s=
        dkim; t=1609961284; x=1610825285; bh=UftPdzA1EyIkns95CWFTQClal8U
        woAcgD04vL1JUeRs=; b=QiRNs320Vy379ZUtt4s/9++oHqx9tMg4PmUHROfbmbI
        O+gQw0334nq1WGrHTaoq7rcurzl2cGtOaHOecJpr5RzI8wBufLxmzB24sYQRsx4q
        Mjag3qU98ETmTMEgl9xs1JCYHB7+rizQuEMiDBqvutAICh0r4r4/56M3Gok36kIU
        =
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9]
        autolearn=unavailable autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3PfTbeMJdw4b for <linux-kernel@vger.kernel.org>;
        Wed,  6 Jan 2021 20:28:04 +0100 (CET)
Received: from ubuntu.localdomain (146-241-198-163.dyn.eolo.it [146.241.198.163])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 66312B045D8;
        Wed,  6 Jan 2021 20:28:02 +0100 (CET)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/2] drm/sun4i: tcon: fix inverted DCLK polarity
Date:   Wed,  6 Jan 2021 20:27:59 +0100
Message-Id: <20210106192800.164052-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106192800.164052-1-giulio.benetti@micronovasrl.com>
References: <20210106192800.164052-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During commit "88bc4178568b8e0331143cc0616640ab72f0cba1" DRM_BUS_FLAG_*
macros have been changed to avoid ambiguity but just because of this
ambiguity previous DRM_BUS_FLAG_PIXDATA_(POS/NEG)EDGE were used meaning
_SAMPLE_ not _DRIVE_. This lead to DLCK inversion, so let's swap DCLK
phase to fix it.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eaaf5d70e352..52598bb0fb0b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -585,10 +585,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	 * and DOTCLOCK drivers.
 	 */
 	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
-		clk_set_phase(tcon->dclk, 240);
+		clk_set_phase(tcon->dclk, 0);
 
 	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
-		clk_set_phase(tcon->dclk, 0);
+		clk_set_phase(tcon->dclk, 240);
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
-- 
2.25.1

