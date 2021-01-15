Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB78D2F88B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbhAOWpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbhAOWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:45:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3746C061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p15so5796047pjv.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDHPk7JANOuofXo//uyQamPz+seSLXpO5Xv0qoPNlbw=;
        b=Qc+B5q9O+2fWa+TSZw8zhoS5aVrF5nF4tujkRDTi6eOOhWaqdFNj6G5xRR2TY4v5Un
         qs/Q/uUaoq+bsv26QmjXezvSrDrO0Vc1bRd+OrM75YX5OTgtnWNkV85c4VvAE0ae870O
         0S0ZtYPvbdeJHdIU2/7hM1BgVWgnH5t81hOZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDHPk7JANOuofXo//uyQamPz+seSLXpO5Xv0qoPNlbw=;
        b=tM/4ewYb7Vz4QAr7tBYlLu8HzLHscbHrFhufq1DZlZ54zKbPj9ZzyXRSsGh1mUqNmn
         D2+Z1QIQ9VI3YMMj0Be+EmBS4n8HvXVYDVtUh3WAIwIlTl5mF+aHWDkmADriLaenF1ML
         ocsN33nrsphVRi99yTxc/uXsakaMSnUzGMC7nbJ/qGpnrg2wZ9oL7bM5GKEIw57UL9Kz
         15xcX8pM1Faa0SDlw51m/JPmCVABAfsMTNTCPG+gAN4jpaAxYHeezAM8g7pY1os39Ygi
         8sHkZ9xcMdhRHLlkx2Law57rEu+2gr+xj43mEP7oCbcpO+mXx9L+t8Fy0E7FPQI+0Aip
         VUrg==
X-Gm-Message-State: AOAM533EZxPVtzz8RAaMqMkOv5ZCV4JTX0tms3lEPtuTy+kf6ukoIGc7
        U6DQ4cePQhAxWxoomoTyfAZ/EQ==
X-Google-Smtp-Source: ABdhPJw8Oi8GnQQgpwj7t/wOBKjCGXLyC2Rv6QWB2CfwV4PvIFvHUjuWJuKEjD1ugabirHxb7MBU1A==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr13141654pjt.108.1610750688320;
        Fri, 15 Jan 2021 14:44:48 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q16sm9131100pfg.139.2021.01.15.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:47 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm/panel-simple: Undo enable if HPD never asserts
Date:   Fri, 15 Jan 2021 14:44:16 -0800
Message-Id: <20210115144345.v2.1.I33fcbd64ab409cfe4f9491bf449f51925a4d3281@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
References: <20210115224420.1635017-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the HPD signal never asserts in panel_simple_prepare() and we
return an error, we should unset the enable GPIO and disable the
regulator to make it consistent for the caller.

At the moment I have some hardware where HPD sometimes doesn't assert.
Obviously that needs to be debugged, but this patch makes it so that
if I add a retry that I can make things work.

Fixes: 48834e6084f1 ("drm/panel-simple: Support hpd-gpios for delaying prepare()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Stephen: I didn't take your Reviewed-by tag since I made a small
change.  If you're OK with this change please re-add.

Changes in v2:
- Set the "unprepared_time" so if we retry we give the proper delay.

 drivers/gpu/drm/panel/panel-simple.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 71ae200ac48a..581ab6810b70 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -406,7 +406,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
 		if (IS_ERR(p->hpd_gpio)) {
 			err = panel_simple_get_hpd_gpio(panel->dev, p, false);
 			if (err)
-				return err;
+				goto error;
 		}
 
 		err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
@@ -418,13 +418,20 @@ static int panel_simple_prepare(struct drm_panel *panel)
 		if (err) {
 			dev_err(panel->dev,
 				"error waiting for hpd GPIO: %d\n", err);
-			return err;
+			goto error;
 		}
 	}
 
 	p->prepared_time = ktime_get();
 
 	return 0;
+
+error:
+	gpiod_set_value_cansleep(p->enable_gpio, 0);
+	regulator_disable(p->supply);
+	p->unprepared_time = ktime_get();
+
+	return err;
 }
 
 static int panel_simple_enable(struct drm_panel *panel)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

