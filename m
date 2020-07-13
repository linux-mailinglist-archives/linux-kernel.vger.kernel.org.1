Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C38219459
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGHXdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 19:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34792 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbgGHXdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594251214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaE/bgVY27cEeWKGYQCTywLFI4G1w38fi5rvZfEqvys=;
        b=URapwdiTe5JJdxise2zwS+I4k8TU10ZThZ3XKgXU49b1IjUpOTxdX8IttwL8w64a2rDVXP
        +fNDlkk6mm7w40F72tIudC5cCyRGAxuuGEH0BpNTCBNxfHnHfDM14hCli9ranBoks1f9MZ
        v1XX5AUsBm8tdiMOPk2N8wjkpEgxoHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-WTNheZBBOoOdwrSqrFCx-A-1; Wed, 08 Jul 2020 19:33:30 -0400
X-MC-Unique: WTNheZBBOoOdwrSqrFCx-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E858C7467;
        Wed,  8 Jul 2020 23:33:28 +0000 (UTC)
Received: from Whitewolf.redhat.com (unknown [10.10.115.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47672C0062;
        Wed,  8 Jul 2020 23:33:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Lee Shawn C <shawn.c.lee@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Cooper Chiou <cooper.chiou@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/i915/mst: filter out the display mode exceed sink's capability
Date:   Wed,  8 Jul 2020 19:33:11 -0400
Message-Id: <20200708233311.200024-3-lyude@redhat.com>
In-Reply-To: <20200708233311.200024-1-lyude@redhat.com>
References: <20200708233311.200024-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Shawn C <shawn.c.lee@intel.com>

So far, max dot clock rate for MST mode rely on physcial
bandwidth limitation. It would caused compatibility issue
if source display resolution exceed MST hub output ability.

For example, source DUT had DP 1.2 output capability.
And MST docking just support HDMI 1.4 spec. When a HDMI 2.0
monitor connected. Source would retrieve EDID from external
and get max resolution 4k@60fps. DP 1.2 can support 4K@60fps
because it did not surpass DP physical bandwidth limitation.
Do modeset to 4k@60fps, source output display data but MST
docking can't output HDMI properly due to this resolution
already over HDMI 1.4 spec.

Refer to commit <fcf463807596> ("drm/dp_mst: Use full_pbn
instead of available_pbn for bandwidth checks").
Source driver should refer to full_pbn to evaluate sink
output capability. And filter out the resolution surpass
sink output limitation.

Changes since v1:
* Using mgr->base.lock to protect full_pbn.
Changes since v2:
* Add ctx lock.
Changes since v3:
* s/intel_dp_mst_mode_clock_exceed_pbn_bandwidth/
  intel_dp_mst_mode_clock_exceeds_pbn_bw/
* Use the new drm_connector_helper_funcs.mode_valid_ctx to properly pipe
  down the drm_modeset_acquire_ctx that the probe helpers are using, so
  we can safely grab &mgr->base.lock without deadlocking
Changes since v4:
* Move drm_dp_calc_pbn_mode(mode->clock, bpp, false) > port->full_pbn
  check
* Fix the bpp we use in drm_dp_calc_pbn_mode()
* Drop leftover (!mgr) check
* Don't check for if full_pbn is unset. To be clear - it _can_ be unset,
  but if it is then it's certainly a bug in DRM or a non-compliant sink
  as full_pbn should always be populated by the time we call
  ->mode_valid_ctx.
  We should workaround non-compliant sinks with full_pbn=0, but that
  should happen in the DP MST helpers so we can estimate the full_pbn
  value as best we can.

Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Cooper Chiou <cooper.chiou@intel.com>
Co-developed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 55 ++++++++++++++-------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index bdc19b04b2c10..a2d91a4997001 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -639,39 +639,60 @@ static int intel_dp_mst_get_modes(struct drm_connector *connector)
 	return intel_dp_mst_get_ddc_modes(connector);
 }
 
-static enum drm_mode_status
-intel_dp_mst_mode_valid(struct drm_connector *connector,
-			struct drm_display_mode *mode)
+static int
+intel_dp_mst_mode_valid_ctx(struct drm_connector *connector,
+			    struct drm_display_mode *mode,
+			    struct drm_modeset_acquire_ctx *ctx,
+			    enum drm_mode_status *status)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct intel_dp *intel_dp = intel_connector->mst_port;
+	struct drm_dp_mst_topology_mgr *mgr = &intel_dp->mst_mgr;
+	struct drm_dp_mst_port *port = intel_connector->port;
+	const int min_bpp = 18;
 	int max_dotclk = to_i915(connector->dev)->max_dotclk_freq;
 	int max_rate, mode_rate, max_lanes, max_link_clock;
+	int ret;
 
-	if (drm_connector_is_unregistered(connector))
-		return MODE_ERROR;
+	if (drm_connector_is_unregistered(connector)) {
+		*status = MODE_ERROR;
+		return 0;
+	}
 
-	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
-		return MODE_NO_DBLESCAN;
+	if (mode->flags & DRM_MODE_FLAG_DBLSCAN) {
+		*status = MODE_NO_DBLESCAN;
+		return 0;
+	}
 
 	max_link_clock = intel_dp_max_link_rate(intel_dp);
 	max_lanes = intel_dp_max_lane_count(intel_dp);
 
 	max_rate = intel_dp_max_data_rate(max_link_clock, max_lanes);
-	mode_rate = intel_dp_link_required(mode->clock, 18);
+	mode_rate = intel_dp_link_required(mode->clock, min_bpp);
 
-	/* TODO - validate mode against available PBN for link */
-	if (mode->clock < 10000)
-		return MODE_CLOCK_LOW;
+	ret = drm_modeset_lock(&mgr->base.lock, ctx);
+	if (ret)
+		return ret;
 
-	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
-		return MODE_H_ILLEGAL;
+	if (mode_rate > max_rate || mode->clock > max_dotclk ||
+	    drm_dp_calc_pbn_mode(mode->clock, min_bpp, false) > port->full_pbn) {
+		*status = MODE_CLOCK_HIGH;
+		return 0;
+	}
+
+	if (mode->clock < 10000) {
+		*status = MODE_CLOCK_LOW;
+		return 0;
+	}
 
-	if (mode_rate > max_rate || mode->clock > max_dotclk)
-		return MODE_CLOCK_HIGH;
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
+		*status = MODE_H_ILLEGAL;
+		return 0;
+	}
 
-	return intel_mode_valid_max_plane_size(dev_priv, mode);
+	*status = intel_mode_valid_max_plane_size(dev_priv, mode);
+	return 0;
 }
 
 static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *connector,
@@ -700,7 +721,7 @@ intel_dp_mst_detect(struct drm_connector *connector,
 
 static const struct drm_connector_helper_funcs intel_dp_mst_connector_helper_funcs = {
 	.get_modes = intel_dp_mst_get_modes,
-	.mode_valid = intel_dp_mst_mode_valid,
+	.mode_valid_ctx = intel_dp_mst_mode_valid_ctx,
 	.atomic_best_encoder = intel_mst_atomic_best_encoder,
 	.atomic_check = intel_dp_mst_atomic_check,
 	.detect_ctx = intel_dp_mst_detect,
-- 
2.26.2

