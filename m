Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3395F2D2237
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgLHEp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgLHEp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:45:29 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D8C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:44:48 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b62so14789721otc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S839lFMHy0MANqMX7LWPsNoTjUegKOQvqUVMPavlC6U=;
        b=cPp45lFN7EuWl0/lks1tVaMwk5uWFdxivYWhaGF4067O3UY2TYPjybuRmrsoFtp181
         jyFkty98xB+dpDH/Zp5SKoBL3wi8wGd0kGbMVsZhtxnf0137Ty1SPv9l09C1H5VPQwp9
         HRiG7CAvk+PSumHqbQbwSCBlSFG8ubvb4arPsbJvxl2JESREVz14KEqYdpolVA64eHFH
         1FPJZ1ZiDhom6U4BDoehZBcOfU9UYbmqB/93NBcpYMGXD4TCxISBD9h6SOjDxKV8+RYP
         +wB9YGUsEaQ0lwqvvJTniFX0s2sEo176ugxVzL9gG51AsKz1nxAHyJm3LJzR1W1eWBmH
         8Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S839lFMHy0MANqMX7LWPsNoTjUegKOQvqUVMPavlC6U=;
        b=HBDSb0jHpmTZAu0fIgQB//D5w0f6LLcxOpU/Wy0YUP/bfffidmuYgBbzkQTYV0eDEf
         l7xNjAW2YKOum+XuNGUVAdgBf0hmmiN4t2lz5lydnquayQV5ERjqwGbOZR7Nf/rBjM3E
         M4OJAaP2OD52CWVc9J9TYQgJiLn7uTMn1aOadUCE6s4v478ZREpqTOt6hm1ToknXimyU
         GfF5eP/U+V2DNdzXA80zZXumBCaBagakaEODRpvUZke6RCx7yhJiyL2sWIrkfLgyPx6o
         WzyGDo3fgy2ov+C03Vb+9yG1hMzIVb7NB4AlI9pD8oDpvYNPqzP3I5P657dNQFnyfEOY
         TZFw==
X-Gm-Message-State: AOAM530b6Xb8t6bTlmn1+V27PDzRcVZb5M+JupcFIlcFSCs0k2/I/gfT
        mMSfA2dVlnUJodEhsczXE+koaw==
X-Google-Smtp-Source: ABdhPJyQpX+x8CsyAIpk0UarS+sOy31K736OMAOfCChjfjOwQ4qoP3bt78faRAsycAlt5uSGYTG+vg==
X-Received: by 2002:a05:6830:11cc:: with SMTP id v12mr16250268otq.363.1607402688364;
        Mon, 07 Dec 2020 20:44:48 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c19sm3171921otn.59.2020.12.07.20.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:44:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/panel: Make backlight attachment lazy
Date:   Mon,  7 Dec 2020 22:44:46 -0600
Message-Id: <20201208044446.973238-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge, provides
means of generating a PWM signal for backlight control of the attached
panel. The provided PWM chip is typically controlled by the
pwm-backlight driver, which if tied to the panel will provide DPMS.

But with the current implementation the panel will refuse to probe
because the bridge driver has yet to probe and register the PWM chip,
and the bridge driver will refuse to probe because it's unable to find
the panel.

Mitigate this catch-22 situation by allowing the panel driver to probe
and retry the attachment of the backlight as the panel is turned on or
off.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/drm_panel.c | 47 +++++++++++++++++++++++++++----------
 include/drm/drm_panel.h     |  8 +++++++
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f634371c717a..7487329bd22d 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -43,6 +43,34 @@ static LIST_HEAD(panel_list);
  * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
  */
 
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
+static int drm_panel_of_backlight_lazy(struct drm_panel *panel)
+{
+	struct backlight_device *backlight;
+
+	if (!panel || !panel->dev)
+		return -EINVAL;
+
+	backlight = devm_of_find_backlight(panel->dev);
+
+	if (IS_ERR(backlight)) {
+		if (PTR_ERR(backlight) == -EPROBE_DEFER) {
+			panel->backlight_init_pending = true;
+			return 0;
+		}
+
+		return PTR_ERR(backlight);
+	}
+
+	panel->backlight = backlight;
+	panel->backlight_init_pending = false;
+
+	return 0;
+}
+#else
+static int drm_panel_of_backlight_lazy(struct drm_panel *panel) { return 0; }
+#endif
+
 /**
  * drm_panel_init - initialize a panel
  * @panel: DRM panel
@@ -161,6 +189,9 @@ int drm_panel_enable(struct drm_panel *panel)
 			return ret;
 	}
 
+	if (panel->backlight_init_pending)
+		drm_panel_of_backlight_lazy(panel);
+
 	ret = backlight_enable(panel->backlight);
 	if (ret < 0)
 		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
@@ -187,6 +218,9 @@ int drm_panel_disable(struct drm_panel *panel)
 	if (!panel)
 		return -EINVAL;
 
+	if (panel->backlight_init_pending)
+		drm_panel_of_backlight_lazy(panel);
+
 	ret = backlight_disable(panel->backlight);
 	if (ret < 0)
 		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
@@ -328,18 +362,7 @@ EXPORT_SYMBOL(of_drm_get_panel_orientation);
  */
 int drm_panel_of_backlight(struct drm_panel *panel)
 {
-	struct backlight_device *backlight;
-
-	if (!panel || !panel->dev)
-		return -EINVAL;
-
-	backlight = devm_of_find_backlight(panel->dev);
-
-	if (IS_ERR(backlight))
-		return PTR_ERR(backlight);
-
-	panel->backlight = backlight;
-	return 0;
+	return drm_panel_of_backlight_lazy(panel);
 }
 EXPORT_SYMBOL(drm_panel_of_backlight);
 #endif
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 33605c3f0eba..b126abebb2f3 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -149,6 +149,14 @@ struct drm_panel {
 	 */
 	struct backlight_device *backlight;
 
+	/**
+	 * @backlight_init_pending
+	 *
+	 * Backlight driver is not yet available so further attempts to
+	 * initialize @backlight is necessary.
+	 */
+	bool backlight_init_pending;
+
 	/**
 	 * @funcs:
 	 *
-- 
2.29.2

