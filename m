Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5381828859E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbgJII6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:58:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52894 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732507AbgJII6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:58:11 -0400
Received: from [222.129.38.193] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1kQoE5-0002z4-8l; Fri, 09 Oct 2020 08:58:10 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, aaron.ma@canonical.com,
        mapengyu@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com,
        lyude@redhat.com, ville.syrjala@linux.intel.com
Subject: [PATCH 1/2] drm/i915/dpcd_bl: uncheck PWM_PIN_CAP when detect eDP backlight capabilities
Date:   Fri,  9 Oct 2020 16:57:49 +0800
Message-Id: <20201009085750.88490-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BOE panel with ID 2270 claims both PWM_PIN_CAP and AUX_SET_CAP backlight
control bits, but default chip backlight failed to control brightness.

Check AUX_SET_CAP and proceed to check quirks or VBT backlight type.
DPCD can control the brightness of this pannel.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index acbd7eb66cbe..308b14159b7c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -334,8 +334,7 @@ intel_dp_aux_display_control_capable(struct intel_connector *connector)
 	 * the panel can support backlight control over the aux channel
 	 */
 	if (intel_dp->edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP &&
-	    (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP) &&
-	    !(intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP)) {
+	    (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
 		drm_dbg_kms(&i915->drm, "AUX Backlight Control Supported!\n");
 		return true;
 	}
-- 
2.25.1

