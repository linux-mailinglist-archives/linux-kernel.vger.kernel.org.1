Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D012AC9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgKJBB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKJBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:01:24 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DA1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:01:24 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f27so5261758pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XE/eiLRe0EzKnuEmtXJpsdCg0RCwLO38rEooTfIDQMk=;
        b=kgeSNd5r6y7VySLvrEJTmSPLzVgGC6xx35IcjWvlWgHWDJ4SkpKEau64eZsz44+mS+
         SCfIp23Q5KYBhtN/oiUR+rO7G9SQF5GT4JP+5fcp0QvER5G+tQ/4Tvc4fnSLD1PH2stX
         e66j57JoOIRxUmySAFCWJqJ8dKnjWVipFRyqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XE/eiLRe0EzKnuEmtXJpsdCg0RCwLO38rEooTfIDQMk=;
        b=Q5yPKLsbZ0A+rPzyREMyi5sqRc1wB3/PcMsiYtTP26osXkuBle/nh8eCFfjfieSnsN
         8w2L5pEBQUmZXqKlPCHJCAfpb76ylsifaMXqT9t9ClZYoxX4Ldq38JTYX8XpG0gIGs1G
         6wv25EkQTnLf2vi9hkoqS08TAPYnZjntT0std5BrvjaUl/RSaQOUBsG2TWpx+iNqyPDt
         2b1rktnwR4yR1ULNieZNdTbe99xwLt/JfeO/QlUHsDsIe/aSa1tH7ojW+dCN2wL4K751
         RvaxwcxwBf7N3xaWhH3g9YBCFqPzZtNzdlg/FjP8ZGQfUY/u1OQZwT5zMB6B0bLy9ZzV
         MbEw==
X-Gm-Message-State: AOAM530pKIyZJwID3ergORJPd2whOjdzesGnwbBm1VMVbEy+srV9GNy1
        O/lZnowATJIpxVFa4cHsA3VRtg==
X-Google-Smtp-Source: ABdhPJx21BjRHTr9ChM8FxvchE8RAGw5VpEQWBVRK6i4W9u11UzmSxyOBdWYlGtt19JFENBzEI8Wqw==
X-Received: by 2002:a05:6a00:158b:b029:18b:fd84:956d with SMTP id u11-20020a056a00158bb029018bfd84956dmr7826261pfk.22.1604970083550;
        Mon, 09 Nov 2020 17:01:23 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id u197sm7283233pfc.127.2020.11.09.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:01:23 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] drm: panel: simple: Allow specifying the delay from prepare to enable
Date:   Mon,  9 Nov 2020 17:00:57 -0800
Message-Id: <20201109170018.v4.3.Ib9ce3c6482f464bf594161581521ced46bbd54ed@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the panel I'm looking at, there's an 80 ms minimum time between HPD
being asserted by the panel and setting the backlight enable GPIO.
While we could just add an 80 ms "enable" delay, this is not ideal.
Link training is allowed to happen in parallel with this delay so the
fixed 80 ms delay over-delays.

We'll support this by logging the time at the end of prepare and then
delaying in enable if enough time hasn't passed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Split ("Allow timing constraints, not fixed delays") into 2 patches.
- Fixed kerneldoc.

 drivers/gpu/drm/panel/panel-simple.c | 44 ++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4bc61d71f068..a54f42cb3adc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -93,6 +93,36 @@ struct panel_desc {
 		 */
 		unsigned int hpd_absent_delay;
 
+		/**
+		 * @delay.prepare_to_enable: Time between prepare and enable.
+		 *
+		 * The minimum time, in milliseconds, that needs to have passed
+		 * between when prepare finished and enable may begin. If at
+		 * enable time less time has passed since prepare finished,
+		 * the driver waits for the remaining time.
+		 *
+		 * If a fixed enable delay is also specified, we'll start
+		 * counting before delaying for the fixed delay.
+		 *
+		 * If a fixed prepare delay is also specified, we won't start
+		 * counting until after the fixed delay. We can't overlap this
+		 * fixed delay with the min time because the fixed delay
+		 * doesn't happen at the end of the function if a HPD GPIO was
+		 * specified.
+		 *
+		 * In other words:
+		 *   prepare()
+		 *     ...
+		 *     // do fixed prepare delay
+		 *     // wait for HPD GPIO if applicable
+		 *     // start counting for prepare_to_enable
+		 *
+		 *   enable()
+		 *     // do fixed enable delay
+		 *     // enforce prepare_to_enable min time
+		 */
+		unsigned int prepare_to_enable;
+
 		/**
 		 * @delay.enable: Time for the panel to display a valid frame.
 		 *
@@ -131,10 +161,10 @@ struct panel_desc {
 
 struct panel_simple {
 	struct drm_panel base;
-	bool prepared;
 	bool enabled;
 	bool no_hpd;
 
+	ktime_t prepared_time;
 	ktime_t unprepared_time;
 
 	const struct panel_desc *desc;
@@ -297,14 +327,14 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
 
-	if (!p->prepared)
+	if (p->prepared_time == 0)
 		return 0;
 
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 
 	regulator_disable(p->supply);
 
-	p->prepared = false;
+	p->prepared_time = 0;
 	p->unprepared_time = ktime_get();
 
 	return 0;
@@ -342,7 +372,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
 	int err;
 	int hpd_asserted;
 
-	if (p->prepared)
+	if (p->prepared_time != 0)
 		return 0;
 
 	panel_simple_wait(p->unprepared_time, p->desc->delay.unprepare);
@@ -381,7 +411,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
 		}
 	}
 
-	p->prepared = true;
+	p->prepared_time = ktime_get();
 
 	return 0;
 }
@@ -396,6 +426,8 @@ static int panel_simple_enable(struct drm_panel *panel)
 	if (p->desc->delay.enable)
 		msleep(p->desc->delay.enable);
 
+	panel_simple_wait(p->prepared_time, p->desc->delay.prepare_to_enable);
+
 	p->enabled = true;
 
 	return 0;
@@ -562,7 +594,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 		return -ENOMEM;
 
 	panel->enabled = false;
-	panel->prepared = false;
+	panel->prepared_time = 0;
 	panel->desc = desc;
 
 	panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
-- 
2.29.2.222.g5d2a92d10f8-goog

