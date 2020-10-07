Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896AF2858E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgJGG7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:59:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39983 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgJGG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:59:35 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQ3Q9-00076g-HE; Wed, 07 Oct 2020 06:59:30 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/dp: HP DreamColor panel brigntness fix
Date:   Wed,  7 Oct 2020 14:58:21 +0800
Message-Id: <20201007065915.13883-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007065915.13883-1-kai.heng.feng@canonical.com>
References: <20201007065915.13883-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP DreamColor panel, which is used by new HP ZBook Studio, needs to use
DPCD to control brightness.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 092c8c985911..b3d0ea1b082b 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1321,6 +1321,7 @@ static const struct edid_quirk edid_quirk_list[] = {
 	 */
 	{ MFG(0x06, 0xaf), PROD_ID(0x9b, 0x32), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x06, 0xaf), PROD_ID(0xeb, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
+	{ MFG(0x30, 0xe4), PROD_ID(0x61, 0x06), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4c, 0x83), PROD_ID(0x47, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
-- 
2.17.1

