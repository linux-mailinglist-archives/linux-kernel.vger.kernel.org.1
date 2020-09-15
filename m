Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F342726AC77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgIOSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727586AbgIORaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600191003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=04+TiwbT5jJwo2O4cAAW4KPKyUOr/nEVAtPPLejpYmE=;
        b=H9nmxONR8CFWbqAqyEiC5fbdng1B993W9Q6egvjj0ZmncQpRJJTHJLDvW2aPPfBLgPFHw8
        MXLS5BhU7Yp2dzs/zz5p/m9n7Xi5e56Ip3U9JdhzMPgYGPHcWEnM503lfdwAPKcXQOlkmF
        VUgap0b2aHuidU2Q10+W2dbVH4VDeEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-BwdTzHixPnCJo5xXDuAUbQ-1; Tue, 15 Sep 2020 13:29:59 -0400
X-MC-Unique: BwdTzHixPnCJo5xXDuAUbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D8210BBEC3;
        Tue, 15 Sep 2020 17:29:54 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE49A61473;
        Tue, 15 Sep 2020 17:29:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     thaytan@noraisin.net, Vasily Khoruzhick <anarsoul@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 1/5] drm/i915/dp: Program source OUI on eDP panels
Date:   Tue, 15 Sep 2020 13:29:35 -0400
Message-Id: <20200915172939.2810538-2-lyude@redhat.com>
In-Reply-To: <20200915172939.2810538-1-lyude@redhat.com>
References: <20200915172939.2810538-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're about to start adding support for Intel's magic HDR
backlight interface over DPCD, we need to ensure we're properly
programming this field so that Intel specific sink services are exposed.
Otherwise, 0x300-0x3ff will just read zeroes.

We also take care not to reprogram the source OUI if it already matches
what we expect. This is just to be careful so that we don't accidentally
take the panel out of any backlight control modes we found it in.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: thaytan@noraisin.net
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4bd10456ad188..b591672ec4eab 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3428,6 +3428,7 @@ void intel_dp_sink_set_decompression_state(struct intel_dp *intel_dp,
 void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
 {
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+	u8 edp_oui[] = { 0x00, 0xaa, 0x01 };
 	int ret, i;
 
 	/* Should have a valid DPCD by this point */
@@ -3443,6 +3444,14 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
 	} else {
 		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
 
+		/* Write the source OUI as early as possible */
+		if (intel_dp_is_edp(intel_dp)) {
+			ret = drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, edp_oui,
+						sizeof(edp_oui));
+			if (ret < 0)
+				drm_err(&i915->drm, "Failed to write eDP source OUI\n");
+		}
+
 		/*
 		 * When turning on, we need to retry for 1ms to give the sink
 		 * time to wake up.
@@ -4530,6 +4539,23 @@ static void intel_dp_get_dsc_sink_cap(struct intel_dp *intel_dp)
 	}
 }
 
+static void
+intel_edp_init_source_oui(struct intel_dp *intel_dp)
+{
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+	u8 oui[] = { 0x00, 0xaa, 0x01 };
+	u8 buf[3] = { 0 };
+
+	if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf, sizeof(buf)) < 0)
+		drm_err(&i915->drm, "Failed to read source OUI\n");
+
+	if (memcmp(oui, buf, sizeof(oui)) == 0)
+		return;
+
+	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui, sizeof(oui)) < 0)
+		drm_err(&i915->drm, "Failed to write source OUI\n");
+}
+
 static bool
 intel_edp_init_dpcd(struct intel_dp *intel_dp)
 {
@@ -4607,6 +4633,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
 	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
 		intel_dp_get_dsc_sink_cap(intel_dp);
 
+	/*
+	 * Program our source OUI so we can make various Intel-specific AUX
+	 * services available (such as HDR backlight controls)
+	 */
+	intel_edp_init_source_oui(intel_dp);
+
 	return true;
 }
 
-- 
2.26.2

