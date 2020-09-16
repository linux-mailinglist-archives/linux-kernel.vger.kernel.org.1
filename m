Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1926CB43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgIPUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726945AbgIPR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTE9cJznhR6LaB3O2iqpAeyWXzykJ8nKiYtplo0vYS8=;
        b=Oy+WJuJe+UBkrDnQj5w7b6Er1sIwGPsO8L1yZ1WZM+3/89HTpwv90wE48KqIe1drNa4p5B
        nyERCZ3yBSTthSYWwchqiTsiPzLtWR7qOusSMwt9aOldF7U/dzu/BB3pmbEtcpuk8q1lPe
        j3fUIecpBEBX+0wIoaUemcCEG6vMx7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-9a4H02IqNi-qBXHalpQL9Q-1; Wed, 16 Sep 2020 13:19:34 -0400
X-MC-Unique: 9a4H02IqNi-qBXHalpQL9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5EC880EF8C;
        Wed, 16 Sep 2020 17:19:30 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-66.rdu2.redhat.com [10.10.120.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E88BA1C4;
        Wed, 16 Sep 2020 17:19:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        thaytan@noraisin.net, Vasily Khoruzhick <anarsoul@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 1/8] drm/i915/dp: Program source OUI on eDP panels
Date:   Wed, 16 Sep 2020 13:18:48 -0400
Message-Id: <20200916171855.129511-2-lyude@redhat.com>
In-Reply-To: <20200916171855.129511-1-lyude@redhat.com>
References: <20200916171855.129511-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

v2:
* Add careful parameter to intel_edp_init_source_oui() to avoid
  re-writing the source OUI if it's already been set during driver
  initialization

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: thaytan@noraisin.net
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4bd10456ad188..7db2b6a3cd52e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3424,6 +3424,29 @@ void intel_dp_sink_set_decompression_state(struct intel_dp *intel_dp,
 			    enable ? "enable" : "disable");
 }
 
+static void
+intel_edp_init_source_oui(struct intel_dp *intel_dp, bool careful)
+{
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+	u8 oui[] = { 0x00, 0xaa, 0x01 };
+	u8 buf[3] = { 0 };
+
+	/*
+	 * During driver init, we want to be careful and avoid changing the source OUI if it's
+	 * already set to what we want, so as to avoid clearing any state by accident
+	 */
+	if (careful) {
+		if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf, sizeof(buf)) < 0)
+			drm_err(&i915->drm, "Failed to read source OUI\n");
+
+		if (memcmp(oui, buf, sizeof(oui)) == 0)
+			return;
+	}
+
+	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui, sizeof(oui)) < 0)
+		drm_err(&i915->drm, "Failed to write source OUI\n");
+}
+
 /* If the sink supports it, try to set the power state appropriately */
 void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
 {
@@ -3443,6 +3466,10 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
 	} else {
 		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
 
+		/* Write the source OUI as early as possible */
+		if (intel_dp_is_edp(intel_dp))
+			intel_edp_init_source_oui(intel_dp, false);
+
 		/*
 		 * When turning on, we need to retry for 1ms to give the sink
 		 * time to wake up.
@@ -4607,6 +4634,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
 	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
 		intel_dp_get_dsc_sink_cap(intel_dp);
 
+	/*
+	 * If needed, program our source OUI so we can make various Intel-specific AUX services
+	 * available (such as HDR backlight controls)
+	 */
+	intel_edp_init_source_oui(intel_dp, true);
+
 	return true;
 }
 
-- 
2.26.2

