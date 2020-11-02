Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129942A3296
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKBSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgKBSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:11:51 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:11:51 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b3so11836425pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wmiepruc3iCJr4t5GLBvdMshT7V+umkWxaVmydO1lC4=;
        b=fVmd9hMhFPFDmgKxG8aw6065UP1hSU/+jbR6rqxTwx/DSXw79TIDaPRljmz6icQrm1
         uBRIf71eV6DvEk8ouKaza4Ltfyj22EVXwwWA2zQjQlUyW4XzOjYRXhGZGjJ6ftKq4IVW
         bXWL44Dc7D4VkY/mAwUA2eutPQ29fy5+u89qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wmiepruc3iCJr4t5GLBvdMshT7V+umkWxaVmydO1lC4=;
        b=T3xmCjKBjxRE8ZSacxD4YIW50zFk1htwyVwW9r2RWMpxm3vGYuau26csA6M3FL0hxP
         R7o8APF74mTIyeMWVuSVLNtH4WM+vmS+uUHMCqDYJ0zKzIosWe9s55d+qXC/1ii4fixX
         60HpMZuqJWmvRoeW6cGRxdvY8MklePf9NHV7waLp66CSTGGcCj/qUqXX99B0kqX0Uyup
         7liQY+wOVPjrbyolySAVOuisl4E7Y0md4IY9ovz9+TlUHhEcNs2sh5i4SrH9JlEIPPYn
         AYcNurBtYpJFkrVKlQb30kfANGCL9X1MTvl2GLBdzk7pfrmnFf++b/NivYTlN7n3VYWh
         ZoQA==
X-Gm-Message-State: AOAM530NgVSzLmqJKeMtAxXtV36TUo1w+/u9uWZ3U9lhKcad4shPzEyS
        /lldHILzHaFfxklYbLafpQcd+A==
X-Google-Smtp-Source: ABdhPJwO3c4Yqrm1FRtcJ/zbXYcRSTGx9Oc3tVdBrijhZfe5jOUT/yxF5wd9HV8D0noQX6iFg1QgHw==
X-Received: by 2002:a63:a1d:: with SMTP id 29mr14072488pgk.162.1604340710699;
        Mon, 02 Nov 2020 10:11:50 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b17sm13175640pgb.94.2020.11.02.10.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:11:50 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v3 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
Date:   Mon,  2 Nov 2020 10:11:43 -0800
Message-Id: <20201102181144.3469197-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102181144.3469197-1-swboyd@chromium.org>
References: <20201102181144.3469197-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DDC connection to read the EDID from the eDP panel instead of
relying on the panel to tell us the modes.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 8276fa50138f..6b6e98ca2881 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -119,6 +119,7 @@
  * @debugfs:      Used for managing our debugfs.
  * @host_node:    Remote DSI node.
  * @dsi:          Our MIPI DSI source.
+ * @edid:         Detected EDID of eDP panel.
  * @refclk:       Our reference clock.
  * @panel:        Our panel.
  * @enable_gpio:  The GPIO we toggle to enable the bridge.
@@ -144,6 +145,7 @@ struct ti_sn_bridge {
 	struct drm_bridge		bridge;
 	struct drm_connector		connector;
 	struct dentry			*debugfs;
+	struct edid			*edid;
 	struct device_node		*host_node;
 	struct mipi_dsi_device		*dsi;
 	struct clk			*refclk;
@@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
 static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 {
 	struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
+	struct edid *edid = pdata->edid;
+	int num, ret;
+
+	if (!edid) {
+		pm_runtime_get_sync(pdata->dev);
+		edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
+		pm_runtime_put(pdata->dev);
+	}
+
+	if (edid && drm_edid_is_valid(edid)) {
+		ret = drm_connector_update_edid_property(connector, edid);
+		if (!ret) {
+			num = drm_add_edid_modes(connector, edid);
+			if (num)
+				return num;
+		}
+	}
 
 	return drm_panel_get_modes(pdata->panel, connector);
 }
@@ -1245,6 +1264,7 @@ static int ti_sn_bridge_remove(struct i2c_client *client)
 	if (!pdata)
 		return -EINVAL;
 
+	kfree(pdata->edid);
 	ti_sn_debugfs_remove(pdata);
 
 	of_node_put(pdata->host_node);
-- 
Sent by a computer, using git, on the internet

