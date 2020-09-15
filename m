Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D018826AC75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIOSrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbgIORaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600191004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUMyB1rem1rvIb11Y4tpkZb1FY6sahhJeMSo+QpGOGA=;
        b=WFbqJOi+A4EYLl+yW+RFVmuZtTnSRGQYPycpxX3zhtld/MQG4ER9EmTKUV4JUeA7Cm9B9y
        U2ENv20abURuFbN7/tXPWHvGUujxUyWPWHe5JyojAvdNguGl8k2FAMAQRSuzEgkX1NUiYE
        egKvmzPSTYGdgQ88J/T+ENj85XMFk2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-vv6X4MxnO6iBl3tkWFPEjg-1; Tue, 15 Sep 2020 13:30:00 -0400
X-MC-Unique: vv6X4MxnO6iBl3tkWFPEjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1902710BBEC6;
        Tue, 15 Sep 2020 17:29:58 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46E025FC3B;
        Tue, 15 Sep 2020 17:29:56 +0000 (UTC)
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
        Chris Wilson <chris@chris-wilson.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 2/5] drm/i915: Rename pwm_* backlight callbacks to ext_pwm_*
Date:   Tue, 15 Sep 2020 13:29:36 -0400
Message-Id: <20200915172939.2810538-3-lyude@redhat.com>
In-Reply-To: <20200915172939.2810538-1-lyude@redhat.com>
References: <20200915172939.2810538-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to need to add a set of lower-level PWM backlight
control hooks to be shared by normal backlight controls and HDR
backlight controls in SDR mode, let's add a prefix to the external PWM
backlight functions so that the difference between them and the high
level PWM-only backlight functions is a bit more obvious.

This introduces no functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: thaytan@noraisin.net
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 9f23bac0d7924..c0e36244bb07d 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -589,7 +589,7 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
 			     BXT_BLC_PWM_DUTY(panel->backlight.controller));
 }
 
-static u32 pwm_get_backlight(struct intel_connector *connector)
+static u32 ext_pwm_get_backlight(struct intel_connector *connector)
 {
 	struct intel_panel *panel = &connector->panel;
 	struct pwm_state state;
@@ -666,7 +666,7 @@ static void bxt_set_backlight(const struct drm_connector_state *conn_state, u32
 		       BXT_BLC_PWM_DUTY(panel->backlight.controller), level);
 }
 
-static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
+static void ext_pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
 {
 	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
 
@@ -835,7 +835,7 @@ static void cnp_disable_backlight(const struct drm_connector_state *old_conn_sta
 		       tmp & ~BXT_BLC_PWM_ENABLE);
 }
 
-static void pwm_disable_backlight(const struct drm_connector_state *old_conn_state)
+static void ext_pwm_disable_backlight(const struct drm_connector_state *old_conn_state)
 {
 	struct intel_connector *connector = to_intel_connector(old_conn_state->connector);
 	struct intel_panel *panel = &connector->panel;
@@ -1168,8 +1168,8 @@ static void cnp_enable_backlight(const struct intel_crtc_state *crtc_state,
 		       pwm_ctl | BXT_BLC_PWM_ENABLE);
 }
 
-static void pwm_enable_backlight(const struct intel_crtc_state *crtc_state,
-				 const struct drm_connector_state *conn_state)
+static void ext_pwm_enable_backlight(const struct intel_crtc_state *crtc_state,
+				     const struct drm_connector_state *conn_state)
 {
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct intel_panel *panel = &connector->panel;
@@ -1890,8 +1890,8 @@ cnp_setup_backlight(struct intel_connector *connector, enum pipe unused)
 	return 0;
 }
 
-static int pwm_setup_backlight(struct intel_connector *connector,
-			       enum pipe pipe)
+static int ext_pwm_setup_backlight(struct intel_connector *connector,
+				   enum pipe pipe)
 {
 	struct drm_device *dev = connector->base.dev;
 	struct drm_i915_private *dev_priv = to_i915(dev);
@@ -2065,11 +2065,11 @@ intel_panel_init_backlight_funcs(struct intel_panel *panel)
 		panel->backlight.hz_to_pwm = pch_hz_to_pwm;
 	} else if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
 		if (connector->base.connector_type == DRM_MODE_CONNECTOR_DSI) {
-			panel->backlight.setup = pwm_setup_backlight;
-			panel->backlight.enable = pwm_enable_backlight;
-			panel->backlight.disable = pwm_disable_backlight;
-			panel->backlight.set = pwm_set_backlight;
-			panel->backlight.get = pwm_get_backlight;
+			panel->backlight.setup = ext_pwm_setup_backlight;
+			panel->backlight.enable = ext_pwm_enable_backlight;
+			panel->backlight.disable = ext_pwm_disable_backlight;
+			panel->backlight.set = ext_pwm_set_backlight;
+			panel->backlight.get = ext_pwm_get_backlight;
 		} else {
 			panel->backlight.setup = vlv_setup_backlight;
 			panel->backlight.enable = vlv_enable_backlight;
-- 
2.26.2

