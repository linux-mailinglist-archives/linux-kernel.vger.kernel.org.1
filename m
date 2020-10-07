Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBDD2858E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgJGG7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:59:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39982 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:59:35 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQ3Q5-00076b-Je; Wed, 07 Oct 2020 06:59:26 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/i915/dpcd_bl: Skip testing control capability with force DPCD quirk
Date:   Wed,  7 Oct 2020 14:58:20 +0800
Message-Id: <20201007065915.13883-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP DreamColor panel needs to be controlled via AUX interface. However,
it has both DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP and
DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP set, so it fails to pass
intel_dp_aux_display_control_capable() test.

Skip the test if the panel has force DPCD quirk.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index acbd7eb66cbe..acf2e1c65290 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -347,9 +347,13 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
 	struct intel_panel *panel = &intel_connector->panel;
 	struct intel_dp *intel_dp = enc_to_intel_dp(intel_connector->encoder);
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+	bool force_dpcd;
+
+	force_dpcd = drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
+				      DP_QUIRK_FORCE_DPCD_BACKLIGHT);
 
 	if (i915->params.enable_dpcd_backlight == 0 ||
-	    !intel_dp_aux_display_control_capable(intel_connector))
+	    (!force_dpcd && !intel_dp_aux_display_control_capable(intel_connector)))
 		return -ENODEV;
 
 	/*
@@ -358,9 +362,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
 	 */
 	if (i915->vbt.backlight.type !=
 	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
-	    i915->params.enable_dpcd_backlight != 1 &&
-	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
-			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
+	    i915->params.enable_dpcd_backlight != 1 && !force_dpcd) {
 		drm_info(&i915->drm,
 			 "Panel advertises DPCD backlight support, but "
 			 "VBT disagrees. If your backlight controls "
-- 
2.17.1

