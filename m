Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6461F2057
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFHT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:57:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42199 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgFHT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:57:12 -0400
Received: from 118-166-128-180.dynamic-ip.hinet.net ([118.166.128.180] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cyrus.lien@canonical.com>)
        id 1jiNtL-0005uT-4T; Mon, 08 Jun 2020 19:57:07 +0000
From:   Cyrus Lien <cyrus.lien@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: add support for min horizontal rate equal to max horizontal rate
Date:   Tue,  9 Jun 2020 03:57:04 +0800
Message-Id: <20200608195704.29841-1-cyrus.lien@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to EDID spec, table 3.26, byte #6 and #8, which said "Minimum
rate value shall be less than or equal to maximum rate value". The minimum
horizontal/vertical rate value is able to be equal to maximum horizontal/
veritcal rate value.

This change check if h/v-sync excess maximum horizontal/vertical rate if
hmin equal to hmax or vmin equal to vmax.

Signed-off-by: Cyrus Lien <cyrus.lien@canonical.com>
---
 drivers/gpu/drm/drm_edid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index fed653f13c26..23878320eabd 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2674,6 +2674,9 @@ mode_in_hsync_range(const struct drm_display_mode *mode,
 	    hmax += ((t[4] & 0x08) ? 255 : 0);
 	hsync = drm_mode_hsync(mode);
 
+	if (hmax == hmin)
+		return (hsync <= hmax);
+
 	return (hsync <= hmax && hsync >= hmin);
 }
 
@@ -2691,6 +2694,9 @@ mode_in_vsync_range(const struct drm_display_mode *mode,
 	    vmax += ((t[4] & 0x02) ? 255 : 0);
 	vsync = drm_mode_vrefresh(mode);
 
+	if (vmax == vmin)
+		return (vsync <= vmax);
+
 	return (vsync <= vmax && vsync >= vmin);
 }
 
-- 
2.25.1

