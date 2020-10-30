Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5629629FA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJ3BRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ3BRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:17:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so2178968ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ha6d4m9hNhg8mJNd9NxPkdoxY0rDbWj+549lDc0BZvA=;
        b=Ut+GsZyCxsILcxGwO7EaUgN3ZFz36AhbzS7p6bMWyVXxYXeRaWfDLmMPEdSLGl8Odu
         tM5YV8rp0fXRZo4/F+E1vpbZh3UguCR74BN+HnNDJEd7Dret+Fbjjjl6LbbUVVLW5cad
         0bdPIb3Zf0Tu5xlOsuHrN33BGerd3aYHC05S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ha6d4m9hNhg8mJNd9NxPkdoxY0rDbWj+549lDc0BZvA=;
        b=nW3sP8V4mObYILZwjxZzP0/gWEF3/es7CwBL2zfB1W50NN9twpgbOlzL2tKBS/q1lh
         lTnLsK0ziKzpTpR18+fn0LsY82KILpGf8yQRu3JjtPU8vp9REhI5ksfntHTdJ+JJ09Ip
         Xz14qRyofSJY5DLaCiOU+Hp+MBC/Q+jUSpNy2rsijD/K9NC7qvJvCaN6D0YFRGMtMZVw
         hoOgjCSTMY7G/M5T+bUeo8R6QimyVjPB7vSi1IEdfmhtHpJAyAVscBWCSjHS65sD6LfY
         a2ZN9/6wjnQ3XfZiSYYhq+QF9xi0BL9+VeVv2HYmmSRf9VkklYnIWsjYea51M60Zz4hv
         wFag==
X-Gm-Message-State: AOAM530hTx+zQfBprDhpDlTcy4u4exw5FEaxpRLnxcoOHfP883bYnsv8
        ZlQW6uFI93EH94yIqMpG+2giNQ==
X-Google-Smtp-Source: ABdhPJytPUh5z4CQaRdmiFe7RWRR2zFupBli90bIKz8E1Hrrd7gN4yHewyUQ7ZAP+vOpstHmHVAAnA==
X-Received: by 2002:a17:902:9890:b029:d2:2f2a:584e with SMTP id s16-20020a1709029890b02900d22f2a584emr6729708plp.29.1604020664675;
        Thu, 29 Oct 2020 18:17:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z26sm4477854pfq.131.2020.10.29.18.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 18:17:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
Date:   Thu, 29 Oct 2020 18:17:37 -0700
Message-Id: <20201030011738.2028313-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201030011738.2028313-1-swboyd@chromium.org>
References: <20201030011738.2028313-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DDC connection to read the EDID from the eDP panel instead of
relying on the panel to tell us the modes.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index c77f46a21aae..f86934fd6cc8 100644
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

