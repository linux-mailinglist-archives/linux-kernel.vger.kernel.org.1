Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE831A08B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDGHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 03:54:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37437 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:54:04 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLj3V-0003AW-VD; Tue, 07 Apr 2020 07:53:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915: Force DPCD backlight mode for HP CML 2020 system
Date:   Tue,  7 Apr 2020 15:53:53 +0800
Message-Id: <20200407075353.12747-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's another Samsung OLED panel needs to use DPCD aux interface to
control backlight.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index c6fbe6e6bc9d..d0cfee3b7a65 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1299,6 +1299,8 @@ static const struct edid_quirk edid_quirk_list[] = {
 	 * only supports DPCD backlight controls
 	 */
 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
+	/* HP CML 2020 system */
+	{ MFG(0x4c, 0x83), PROD_ID(0x45, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	/*
 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
 	 * backlight control, and some only support AUX backlight control. All
-- 
2.17.1

