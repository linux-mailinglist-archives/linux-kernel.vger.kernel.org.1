Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14E1A6E93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbgDMVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 17:51:46 -0400
Received: from saul.pp3345.net ([163.172.111.124]:56730 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389228AbgDMVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:51:42 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id D38089A420B;
        Mon, 13 Apr 2020 23:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1586814196; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=0Dd50Aj7Tm41xdkXFsIgBzwtxqD7/pPkBoUkuy2w2PM=;
        b=lp0mI9+pg396qWyQOxDdLw778E9nXBjvlymgaeLMbaINrUjEBK9zn6HzoEmVmFQh6AZLCZ
        et9rJfDCTAqy6+iFUQIhnyCK+3236NwyiAqdMByBUfIml0DITtcGbPI1cDZb7i1VUic1H2
        D/m1ooJIIetw+U8O0zmi3/BOuTc8iqzJjJviBeQky63I+uY0XyHMMr44aVromVXvSpYOaw
        aeOMeecNj2awTkdi4j1m72atjYphNZjX7/aSA15ytKlarXOYoRfybXL//iL3RH6kW57hoi
        uIXSqbbLza5nQuEXytXdJ8gm1RJiejv5RWqhNQ/3y5OLOmoAigqc/9GCaHhkNA==
From:   Yussuf Khalil <dev@pp3345.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH 3/5] drm: Add drm_connector_state_select_rgb_quantization_range() helper
Date:   Mon, 13 Apr 2020 23:40:24 +0200
Message-Id: <20200413214024.46500-4-dev@pp3345.net>
In-Reply-To: <20200413214024.46500-1-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper can be used to determine the appropriate RGB quantization range
based on a connector's "RGB quantization range" property and a mode.

Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
 drivers/gpu/drm/drm_connector.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index e60d3b6e5e56..d5a46bbf284e 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2187,6 +2187,37 @@ int drm_connector_set_panel_orientation_with_quirk(
 }
 EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
 
+/**
+ * drm_connector_state_select_rgb_quantization_range - find RGB quantization
+ * range appropriate for a connector's state and mode
+ *
+ * @state: state of the connector for which to determine the range
+ * @mode: mode for which to determine the range
+ *
+ * For a given connector state (i.e., RGB quantization range property) and a
+ * given mode, determine which RGB quantization range should be used.
+ *
+ * Returns:
+ * A constant from the HDMI quantization range enum.
+ */
+enum hdmi_quantization_range drm_connector_state_select_rgb_quantization_range(
+	const struct drm_connector_state *state,
+        const struct drm_display_mode *mode)
+{
+	switch (state->rgb_quantization_range) {
+	default:
+		WARN_ON(1);
+		/* fallthrough */
+	case DRM_MODE_RGB_QUANTIZATION_RANGE_AUTOMATIC:
+		return drm_default_rgb_quant_range(mode);
+	case DRM_MODE_RGB_QUANTIZATION_RANGE_FULL:
+		return HDMI_QUANTIZATION_RANGE_FULL;
+	case DRM_MODE_RGB_QUANTIZATION_RANGE_LIMITED:
+		return HDMI_QUANTIZATION_RANGE_LIMITED;
+	}
+}
+EXPORT_SYMBOL(drm_connector_state_select_rgb_quantization_range);
+
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f605e0fbcc0e..43ce305d882f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -42,6 +42,7 @@ struct drm_property_blob;
 struct drm_printer;
 struct edid;
 struct i2c_adapter;
+struct drm_display_mode;
 
 enum drm_connector_force {
 	DRM_FORCE_UNSPECIFIED,
@@ -1621,6 +1622,9 @@ int drm_connector_set_panel_orientation_with_quirk(
 	int width, int height);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
+enum hdmi_quantization_range drm_connector_state_select_rgb_quantization_range(
+	const struct drm_connector_state *state,
+	const struct drm_display_mode *mode);
 
 /**
  * struct drm_tile_group - Tile group metadata
-- 
2.26.0

