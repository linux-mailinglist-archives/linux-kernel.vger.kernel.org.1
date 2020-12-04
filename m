Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697392CF6E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLDWhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607121388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrvtERJoRmvnbpu3LkaF6nDk6NlkQ8DPL0iY0dT7cFI=;
        b=EgNBjgMkSbJTi+j75jC2dXLVrkhAx3SxADCb8t2CINitqISPt9dX9mKs08erOzGEXC1rbJ
        x1y1err6hkprp8bErJboOSOu8r1PUs8sF9qBRJWIZUHeGVRYwaCFFhk2L8IDparq6sqAuP
        YaTQZGvr+ZLRemLPSXin/iE5B4B4bDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-f5CKJwWXOWSgjRjZf_IdLQ-1; Fri, 04 Dec 2020 17:36:26 -0500
X-MC-Unique: f5CKJwWXOWSgjRjZf_IdLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 927EE180A089;
        Fri,  4 Dec 2020 22:36:23 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAB421349A;
        Fri,  4 Dec 2020 22:36:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Dave Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>, thaytan@noraisin.net,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Airlie <airlied@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/9] drm/i915: Rename pwm_* backlight callbacks to ext_pwm_*
Date:   Fri,  4 Dec 2020 17:35:56 -0500
Message-Id: <20201204223603.249878-3-lyude@redhat.com>
In-Reply-To: <20201204223603.249878-1-lyude@redhat.com>
References: <20201204223603.249878-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: thaytan@noraisin.net
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 36b7693453ae..da8f7c12ae22 100644
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
@@ -2061,12 +2061,12 @@ static const struct intel_panel_bl_funcs pch_funcs = {
 	.hz_to_pwm = pch_hz_to_pwm,
 };
 
-static const struct intel_panel_bl_funcs pwm_funcs = {
-	.setup = pwm_setup_backlight,
-	.enable = pwm_enable_backlight,
-	.disable = pwm_disable_backlight,
-	.set = pwm_set_backlight,
-	.get = pwm_get_backlight,
+static const struct intel_panel_bl_funcs ext_pwm_funcs = {
+	.setup = ext_pwm_setup_backlight,
+	.enable = ext_pwm_enable_backlight,
+	.disable = ext_pwm_disable_backlight,
+	.set = ext_pwm_set_backlight,
+	.get = ext_pwm_get_backlight,
 };
 
 static const struct intel_panel_bl_funcs vlv_funcs = {
@@ -2125,7 +2125,7 @@ intel_panel_init_backlight_funcs(struct intel_panel *panel)
 		panel->backlight.funcs = &pch_funcs;
 	} else if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
 		if (connector->base.connector_type == DRM_MODE_CONNECTOR_DSI) {
-			panel->backlight.funcs = &pwm_funcs;
+			panel->backlight.funcs = &ext_pwm_funcs;
 		} else {
 			panel->backlight.funcs = &vlv_funcs;
 		}
-- 
2.28.0

