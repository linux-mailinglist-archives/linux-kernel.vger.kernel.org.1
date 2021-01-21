Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9BC2FF356
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbhAUSjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbhAUSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611254214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iEp9yhRV3TAomGX+OUwUrA360x2NLkKWINR0znFf8iw=;
        b=Ok+gL0/jHu9ICtpaUINu2j1u9CT953ysBlvbZBDiOTDUHi0ZXaW1vBdU9tUmbR2p3DwnVG
        XnGfVtv8o4ZDTxXvL0Xq7kg9TccvWPiGH8iTGb+zFM8adQQ7/RThGOU9EFEwDTZUTTh48o
        VRmOMUQFumXb+RuNo8/CnJDLIdUVlno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-r7t-k8FePFqQro3tNqjn5A-1; Thu, 21 Jan 2021 13:36:52 -0500
X-MC-Unique: r7t-k8FePFqQro3tNqjn5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CFD7107ACE6;
        Thu, 21 Jan 2021 18:36:49 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-132.rdu2.redhat.com [10.10.120.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6370E50A8B;
        Thu, 21 Jan 2021 18:36:47 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915/dp: Don't use DPCD backlights that need PWM enable/disable
Date:   Thu, 21 Jan 2021 13:36:43 -0500
Message-Id: <20210121183644.2627282-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We haven't yet implemented support for backlights that need to be
enabled/disabled via PWM instead of AUX, which means we'll break things if
we enable DPCD backlight control on these machines. Luckily though since
most of these machines work fine just using the plain PWM backlight
controls anyway, there shouldn't be any issue with just leaving DPCD
backlight controls disabled in such situations.

This should fix the issues with PWM being left on that were being observed
on fi-bdw-samus.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 4a8d79901d5b ("drm/i915/dp: Enable Intel's HDR backlight interface (only SDR for now)")
Testcase: igt/gem_exec_suspend/basic-s0 # fi-bdw-samus
Cc: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 31a478f63d52..651884390137 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -586,9 +586,14 @@ intel_dp_aux_supports_vesa_backlight(struct intel_connector *connector)
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
 
 	/* Check the eDP Display control capabilities registers to determine if
-	 * the panel can support backlight control over the aux channel
+	 * the panel can support backlight control over the aux channel.
+	 *
+	 * TODO: We currently only support AUX only backlight configurations, not backlights which
+	 * require a mix of PWM and AUX controls to work. In the mean time, these machines typically
+	 * work just fine using normal PWM controls anyway.
 	 */
 	if (intel_dp->edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP &&
+	    (intel_dp->edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) &&
 	    (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
 		drm_dbg_kms(&i915->drm, "AUX Backlight Control Supported!\n");
 		return true;
-- 
2.29.2

