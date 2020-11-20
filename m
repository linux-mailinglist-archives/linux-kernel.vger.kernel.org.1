Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6881F2BA16E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKTEXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:23:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34274 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKTEXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:23:52 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kaichuan.hsieh@canonical.com>)
        id 1kfxxX-0002VL-JF; Fri, 20 Nov 2020 04:23:44 +0000
From:   Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: Add dpcd backlight control for 0x4c83 0x4f41
Date:   Fri, 20 Nov 2020 12:23:40 +0800
Message-Id: <20201120042340.20044-1-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index deeed73f4ed6..6789e30a3cba 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1882,6 +1882,7 @@ static const struct edid_quirk edid_quirk_list[] = {
 	{ MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4c, 0x83), PROD_ID(0x47, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
+	{ MFG(0x4c, 0x83), PROD_ID(0x4f, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 };
 
 #undef MFG
-- 
2.25.1

