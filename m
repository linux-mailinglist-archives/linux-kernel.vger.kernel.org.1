Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541A52F88B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbhAOWpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbhAOWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:45:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FBC061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:51 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g15so6925003pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6Pt2T+moXOluPwTG075i+/xaDz4gJsnvkS14avcQFI=;
        b=c0GZ3s1oOTDja47NPFLVziyxh5BFbEBRpCpy0pc1SDTQlJOgmoO5w5VFUKRK+rucm3
         dwGTZdsg3Afg5sVTGxta3YVN3cUa47W4shyBGEuFkXsqNT7iEGjOwFts7HC8z0K9RWnW
         x9xkhQWhn2tM95JSe5A9cu8ag6cWljeTRqpRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6Pt2T+moXOluPwTG075i+/xaDz4gJsnvkS14avcQFI=;
        b=kA/xFLL/rMNtnPnxUvCWfUlsJLU/yo35SjI+CPx6wb6+wxGPYoEqbkZwkq3iyyInyL
         rGBjFYwZG5VPuG9jB7xHn/8G3OS16a5QziQddALRc2tIWV06Clbo+b+GZZdSpVLkf+8B
         zLomJltOLHDqocidca/8ob7WC9xQwAwB8G4aChknHBjkLPvMbXEoF2bCy9f3yUZjDsQM
         J30dfWm8xgMpLnEXqWq1xUOtrxsfvSXKAHV5X5QrdsLyokf8B2uWbqmD8LccwYLVitIh
         BD8S4CEMFu/3hYG6UQaPqvdMDIgnSfP36rInQ98BwBRXwuJmCpWiTlZgKYrGUgoi2vaJ
         JTBw==
X-Gm-Message-State: AOAM5328EIS1+oDRHzlF1Q1B1AVyyXcluNANsZXKgdi+Zs+/BjseE+ip
        k0I9br2OKU8FjpmddQeJYxOWMg==
X-Google-Smtp-Source: ABdhPJxM9ZU/ClJ9p7dKBQzIK0Me1DJnv9HnNDHUPT1N+V3eZkVciWLx8AilmJ4PpupEX1oqJQe23w==
X-Received: by 2002:a63:464a:: with SMTP id v10mr15010409pgk.393.1610750690991;
        Fri, 15 Jan 2021 14:44:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q16sm9131100pfg.139.2021.01.15.14.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:50 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] drm/panel-simple: Retry if we timeout waiting for HPD
Date:   Fri, 15 Jan 2021 14:44:18 -0800
Message-Id: <20210115144345.v2.3.I6916959daa7c5c915e889442268d23338de17923@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
References: <20210115224420.1635017-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an Innolux N116BCA panel that I have in front of me, sometimes HPD
simply doesn't assert no matter how long you wait for it. As per the
very wise advice of The IT Crowd ("Have you tried turning it off and
on again?") it appears that power cycling is enough to kick this panel
back into a sane state.

From tests on this panel, it appears that leaving it powered off for a
while stimulates the problem. Adding a 6 second sleep at the start of
panel_simple_prepare_once() makes it happen fairly reliably and, with
this delay, I saw up to 3 retries needed sometimes. Without the 6
second sleep, however, the panel came up much more reliably the first
time or after only 1 retry.

While it's unknown what the problems are with this panel (and probably
the hardware should be debugged), adding a few retries to the power on
routine doesn't seem insane. Even if this panel's problems are
attributed to the fact that it's pre-production and/or can be fixed,
retries clearly can help in some cases and really don't hurt.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("drm/panel-simple: Retry if we timeout waiting for HPD") new for v2.

 drivers/gpu/drm/panel/panel-simple.c | 32 +++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 30842cf6d414..823177d89d1b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -376,7 +376,7 @@ static int panel_simple_get_hpd_gpio(struct device *dev,
 	return 0;
 }
 
-static int panel_simple_prepare(struct drm_panel *panel)
+static int panel_simple_prepare_once(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
 	unsigned int delay;
@@ -422,8 +422,9 @@ static int panel_simple_prepare(struct drm_panel *panel)
 			err = hpd_asserted;
 
 		if (err) {
-			dev_err(panel->dev,
-				"error waiting for hpd GPIO: %d\n", err);
+			if (err != -ETIMEDOUT)
+				dev_err(panel->dev,
+					"error waiting for hpd GPIO: %d\n", err);
 			goto error;
 		}
 	}
@@ -440,6 +441,31 @@ static int panel_simple_prepare(struct drm_panel *panel)
 	return err;
 }
 
+/*
+ * Some panels simply don't always come up and need to be power cycled to
+ * work properly.  We'll allow for a handful of retries.
+ */
+#define MAX_PANEL_PREPARE_TRIES		5
+
+static int panel_simple_prepare(struct drm_panel *panel)
+{
+	int ret;
+	int try;
+
+	for (try = 0; try < MAX_PANEL_PREPARE_TRIES; try++) {
+		ret = panel_simple_prepare_once(panel);
+		if (ret != -ETIMEDOUT)
+			break;
+	}
+
+	if (ret == -ETIMEDOUT)
+		dev_err(panel->dev, "Prepare timeout after %d tries\n", try);
+	else if (try)
+		dev_warn(panel->dev, "Prepare needed %d retries\n", try);
+
+	return ret;
+}
+
 static int panel_simple_enable(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

