Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A537D26CB35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgIPUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbgIPR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KmpGUz07S1kEC6Lv/GqNsvz6Oagt4W0GdZaxFjJ1dY=;
        b=DLxSjfNaDxo5Jzvzt990LZKbf8QoL8Anh9ZpcmwaRt62XjQF5ukTF/CAHNulF1ds32Urue
        1gNpKUP1kV45c+fTIN8bEcnwl6sN6BGligWg2FvLo+n8Be2vJQTugwx0xLEXUMj2/af+lp
        1HNq+tFTowGUNW3Kt/ogveY0TZM8o6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-NswoB5QcPLW2a1wzBINXNg-1; Wed, 16 Sep 2020 13:19:45 -0400
X-MC-Unique: NswoB5QcPLW2a1wzBINXNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 150628015C6;
        Wed, 16 Sep 2020 17:19:44 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-66.rdu2.redhat.com [10.10.120.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC4301C4;
        Wed, 16 Sep 2020 17:19:42 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, thaytan@noraisin.net,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 5/8] drm/i915/dp: Add register definitions for Intel HDR backlight interface
Date:   Wed, 16 Sep 2020 13:18:52 -0400
Message-Id: <20200916171855.129511-6-lyude@redhat.com>
In-Reply-To: <20200916171855.129511-1-lyude@redhat.com>
References: <20200916171855.129511-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes yet, this just adds definitions for all of the
known DPCD registers used by Intel's HDR backlight interface. Since
we'll only ever use this in i915, we just define them in
intel_dp_aux_backlight.c

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: thaytan@noraisin.net
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index f601bcbe8ee46..c1e8e8b166267 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -25,6 +25,59 @@
 #include "intel_display_types.h"
 #include "intel_dp_aux_backlight.h"
 
+/*
+ * DP AUX registers for Intel's proprietary HDR backlight interface. We define
+ * them here since we'll likely be the only driver to ever use these.
+ */
+#define INTEL_EDP_HDR_TCON_CAP0                                        0x340
+
+#define INTEL_EDP_HDR_TCON_CAP1                                        0x341
+# define INTEL_EDP_HDR_TCON_2084_DECODE_CAP                           BIT(0)
+# define INTEL_EDP_HDR_TCON_2020_GAMUT_CAP                            BIT(1)
+# define INTEL_EDP_HDR_TCON_TONE_MAPPING_CAP                          BIT(2)
+# define INTEL_EDP_HDR_TCON_SEGMENTED_BACKLIGHT_CAP                   BIT(3)
+# define INTEL_EDP_HDR_TCON_BRIGHTNESS_NITS_CAP                       BIT(4)
+# define INTEL_EDP_HDR_TCON_OPTIMIZATION_CAP                          BIT(5)
+# define INTEL_EDP_HDR_TCON_SDP_COLORIMETRY_CAP                       BIT(6)
+# define INTEL_EDP_HDR_TCON_SRGB_TO_PANEL_GAMUT_CONVERSION_CAP        BIT(7)
+
+#define INTEL_EDP_HDR_TCON_CAP2                                        0x342
+# define INTEL_EDP_SDR_TCON_BRIGHTNESS_AUX_CAP                        BIT(0)
+
+#define INTEL_EDP_HDR_TCON_CAP3                                        0x343
+
+#define INTEL_EDP_HDR_GETSET_CTRL_PARAMS                               0x344
+# define INTEL_EDP_HDR_TCON_2084_DECODE_ENABLE                        BIT(0)
+# define INTEL_EDP_HDR_TCON_2020_GAMUT_ENABLE                         BIT(1)
+# define INTEL_EDP_HDR_TCON_TONE_MAPPING_ENABLE                       BIT(2) /* Pre-TGL+ */
+# define INTEL_EDP_HDR_TCON_SEGMENTED_BACKLIGHT_ENABLE                BIT(3)
+# define INTEL_EDP_HDR_TCON_BRIGHTNESS_AUX_ENABLE                     BIT(4)
+# define INTEL_EDP_HDR_TCON_SRGB_TO_PANEL_GAMUT_ENABLE                BIT(5)
+/* Bit 6 is reserved */
+# define INTEL_EDP_HDR_TCON_SDP_COLORIMETRY_ENABLE                    BIT(7)
+
+#define INTEL_EDP_HDR_CONTENT_LUMINANCE                                0x346 /* Pre-TGL+ */
+#define INTEL_EDP_HDR_PANEL_LUMINANCE_OVERRIDE                         0x34A
+#define INTEL_EDP_SDR_LUMINANCE_LEVEL                                  0x352
+#define INTEL_EDP_BRIGHTNESS_NITS_LSB                                  0x354
+#define INTEL_EDP_BRIGHTNESS_NITS_MSB                                  0x355
+#define INTEL_EDP_BRIGHTNESS_DELAY_FRAMES                              0x356
+#define INTEL_EDP_BRIGHTNESS_PER_FRAME_STEPS                           0x357
+
+#define INTEL_EDP_BRIGHTNESS_OPTIMIZATION_0                            0x358
+# define INTEL_EDP_TCON_USAGE_MASK                             GENMASK(0, 3)
+# define INTEL_EDP_TCON_USAGE_UNKNOWN                                    0x0
+# define INTEL_EDP_TCON_USAGE_DESKTOP                                    0x1
+# define INTEL_EDP_TCON_USAGE_FULL_SCREEN_MEDIA                          0x2
+# define INTEL_EDP_TCON_USAGE_FULL_SCREEN_GAMING                         0x3
+# define INTEL_EDP_TCON_POWER_MASK                                    BIT(4)
+# define INTEL_EDP_TCON_POWER_DC                                    (0 << 4)
+# define INTEL_EDP_TCON_POWER_AC                                    (1 << 4)
+# define INTEL_EDP_TCON_OPTIMIZATION_STRENGTH_MASK             GENMASK(5, 7)
+
+#define INTEL_EDP_BRIGHTNESS_OPTIMIZATION_1                            0x359
+
+/* VESA backlight callbacks */
 static void set_vesa_backlight_enable(struct intel_dp *intel_dp, bool enable)
 {
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
-- 
2.26.2

