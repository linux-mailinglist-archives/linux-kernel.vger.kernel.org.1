Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5350F2EB7B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAFBgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:36:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbhAFBgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609896891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RX1UuLQFPq3ZqAOOWLS2Mko0D0uVpjqKd6LcvEGcbIc=;
        b=RtNxKsDI+5LQ+p1ZAt/k1k80Q0xI3gr1ApsOjfLt6amEZMe4nz+287OJ8yk8pcJtZnZ/nT
        eBK0SIiWZYARv03QIP6++1yYE3F63zRaevUyRbDIyXa53g2yZLV2E7X0x318K1BNUyAAax
        78iDFXcTeUQv34eAoSCZdXcLCtmUPe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-bZQG0CagMr-Ux0bBrSmoTA-1; Tue, 05 Jan 2021 20:34:48 -0500
X-MC-Unique: bZQG0CagMr-Ux0bBrSmoTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78958801FD7;
        Wed,  6 Jan 2021 01:34:45 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-112-235.rdu2.redhat.com [10.10.112.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C938871CA1;
        Wed,  6 Jan 2021 01:34:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>, thaytan@noraisin.net,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/4] drm/i915/dp: Allow forcing specific interfaces through enable_dpcd_backlight
Date:   Tue,  5 Jan 2021 20:34:07 -0500
Message-Id: <20210106013408.271217-4-lyude@redhat.com>
In-Reply-To: <20210106013408.271217-1-lyude@redhat.com>
References: <20210106013408.271217-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now support controlling panel backlights through DPCD using
both the standard VESA interface, and Intel's proprietary HDR backlight
interface, we should allow the user to be able to explicitly choose
between one or the other in the event that we're wrong about panels
reliably reporting support for the Intel HDR interface.

So, this commit adds support for this by introducing two new
enable_dpcd_backlight options: 2 which forces i915 to only probe for the
VESA interface, and 3 which forces i915 to only probe for the Intel
backlight interface (might be useful if we find panels in the wild that
report the VESA interface in their VBT, but actually only support the
Intel backlight interface).

v3:
* Rebase

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: thaytan@noraisin.net
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c | 45 +++++++++++++++++--
 drivers/gpu/drm/i915/i915_params.c            |  2 +-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 5eb472eb304f..94a9e3b1f24c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -611,15 +611,54 @@ static const struct intel_panel_bl_funcs intel_dp_vesa_bl_funcs = {
 	.get = intel_dp_aux_vesa_get_backlight,
 };
 
+enum intel_dp_aux_backlight_modparam {
+	INTEL_DP_AUX_BACKLIGHT_AUTO = -1,
+	INTEL_DP_AUX_BACKLIGHT_OFF = 0,
+	INTEL_DP_AUX_BACKLIGHT_ON = 1,
+	INTEL_DP_AUX_BACKLIGHT_FORCE_VESA = 2,
+	INTEL_DP_AUX_BACKLIGHT_FORCE_INTEL = 3,
+};
+
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
 {
 	struct drm_device *dev = connector->base.dev;
 	struct intel_panel *panel = &connector->panel;
 	struct intel_dp *intel_dp = enc_to_intel_dp(connector->encoder);
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+	bool try_intel_interface = false, try_vesa_interface = false;
 
-	if (i915->params.enable_dpcd_backlight == 0)
+	/* Check the VBT and user's module parameters to figure out which
+	 * interfaces to probe
+	 */
+	switch (i915->params.enable_dpcd_backlight) {
+	case INTEL_DP_AUX_BACKLIGHT_OFF:
 		return -ENODEV;
+	case INTEL_DP_AUX_BACKLIGHT_AUTO:
+		switch (i915->vbt.backlight.type) {
+		case INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE:
+			try_vesa_interface = true;
+			break;
+		case INTEL_BACKLIGHT_DISPLAY_DDI:
+			try_intel_interface = true;
+			try_vesa_interface = true;
+			break;
+		default:
+			return -ENODEV;
+		}
+		break;
+	case INTEL_DP_AUX_BACKLIGHT_ON:
+		if (i915->vbt.backlight.type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
+			try_intel_interface = true;
+
+		try_vesa_interface = true;
+		break;
+	case INTEL_DP_AUX_BACKLIGHT_FORCE_VESA:
+		try_vesa_interface = true;
+		break;
+	case INTEL_DP_AUX_BACKLIGHT_FORCE_INTEL:
+		try_intel_interface = true;
+		break;
+	}
 
 	/*
 	 * A lot of eDP panels in the wild will report supporting both the
@@ -628,13 +667,13 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
 	 * and will only work with the Intel interface. So, always probe for
 	 * that first.
 	 */
-	if (intel_dp_aux_supports_hdr_backlight(connector)) {
+	if (try_intel_interface && intel_dp_aux_supports_hdr_backlight(connector)) {
 		drm_dbg_kms(dev, "Using Intel proprietary eDP backlight controls\n");
 		panel->backlight.funcs = &intel_dp_hdr_bl_funcs;
 		return 0;
 	}
 
-	if (intel_dp_aux_supports_vesa_backlight(connector)) {
+	if (try_vesa_interface && intel_dp_aux_supports_vesa_backlight(connector)) {
 		drm_dbg_kms(dev, "Using VESA eDP backlight controls\n");
 		panel->backlight.funcs = &intel_dp_vesa_bl_funcs;
 		return 0;
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 7f139ea4a90b..6939634e56ed 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -185,7 +185,7 @@ i915_param_named_unsafe(inject_probe_failure, uint, 0400,
 
 i915_param_named(enable_dpcd_backlight, int, 0400,
 	"Enable support for DPCD backlight control"
-	"(-1=use per-VBT LFP backlight type setting [default], 0=disabled, 1=enabled)");
+	"(-1=use per-VBT LFP backlight type setting [default], 0=disabled, 1=enable, 2=force VESA interface, 3=force Intel interface)");
 
 #if IS_ENABLED(CONFIG_DRM_I915_GVT)
 i915_param_named(enable_gvt, bool, 0400,
-- 
2.29.2

