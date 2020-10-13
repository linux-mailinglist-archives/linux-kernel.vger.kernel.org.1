Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C828C9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390623AbgJMIBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390591AbgJMIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:01:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93AC0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:01:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a17so1663593pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHUIn9W1x+5KlmekZkhiHQBGgSSK4eQqcPUC6t+lfRc=;
        b=NJoBFLThsczUbwkvrp7kZrvgmTGRNmb1Sil1e6gp0V7/Jrytl6je5a6cMug39yDVNc
         eJtOflG1IKbxzT0NaS0Z6IFsddksIW5hXejbBHY0KWuZf7IUTIFEfNI8E3GriO32yJIo
         eey5IHvSrLZWHWpJ2p43kLBrOmK4ZiBpVN6Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHUIn9W1x+5KlmekZkhiHQBGgSSK4eQqcPUC6t+lfRc=;
        b=q4vPpdib2ZNr4eeL5tclWqE6omzltd4QXQ6hEw4hwZ/tKAVPsNlGJSrQhLMCXEOsi4
         j7H0JoUB1E0LdDyRtIRpYfJrCkvtLWqf0XUqkMjT7rGMafwz795uk03u1EkCfZNTUbdZ
         P0Y2Miyv+iveKjS9CxnPOeG43VYh7PTF+rE5XvEf9fvXi4dj4GnZtkJoOxLSmqRxs1W1
         MLnZvlbmmngPLr4uAgY5KftOUSF8OstAqeCko9JLOi9f2IYLUFEJJ8AyYdUGLwO3ocT/
         jQPfsQtiq83DkNFSl9ixkTy6H0+9N+33Ipo5GVJbP/ntTQpnvjzwwAE9MGpE9JhRI0Pl
         AiHw==
X-Gm-Message-State: AOAM530/AP/x5JOkm9UiIZ6v333uwlECozZin6PV0wb9ny7QdIWZ0/X4
        qd+V/uhpBDO2aweKW4SB/kh+9Q==
X-Google-Smtp-Source: ABdhPJz191HpdE/vjX+LToftssVvpvCdV+wFU6xQmnXmYjzutm9Exh6Wi2eBL8fi0ndngxp3bHcTHA==
X-Received: by 2002:a17:902:eacc:b029:d3:b362:72c0 with SMTP id p12-20020a170902eaccb02900d3b36272c0mr26510337pld.23.1602576089722;
        Tue, 13 Oct 2020 01:01:29 -0700 (PDT)
Received: from alex-desktop.lan (c-73-63-253-164.hsd1.ca.comcast.net. [73.63.253.164])
        by smtp.gmail.com with ESMTPSA id y124sm14956924pfy.28.2020.10.13.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:01:29 -0700 (PDT)
From:   Alexandru Stan <amstan@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 1/3] backlight: pwm_bl: Fix interpolation
Date:   Tue, 13 Oct 2020 01:01:01 -0700
Message-Id: <20201013010056.v2.1.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013080103.410133-1-amstan@chromium.org>
References: <20201013080103.410133-1-amstan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever num-interpolated-steps was larger than the distance
between 2 consecutive brightness levels the table would get really
discontinuous. The slope of the interpolation would stick with
integers only and if it was 0 the whole line segment would get skipped.

Example settings:
	brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
	num-interpolated-steps = <16>;

The distances between 1 2 4 and 8 would be 1, and only starting with 16
it would start to interpolate properly.

Let's change it so there's always interpolation happening, even if
there's no enough points available (read: values in the table would
appear more than once). This should match the expected behavior much
more closely.

Signed-off-by: Alexandru Stan <amstan@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 70 ++++++++++++++------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index dfc760830eb9..3e77f6b73fd9 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -230,8 +230,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 				  struct platform_pwm_backlight_data *data)
 {
 	struct device_node *node = dev->of_node;
-	unsigned int num_levels = 0;
-	unsigned int levels_count;
+	unsigned int num_levels;
 	unsigned int num_steps = 0;
 	struct property *prop;
 	unsigned int *table;
@@ -260,12 +259,11 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	if (!prop)
 		return 0;
 
-	data->max_brightness = length / sizeof(u32);
+	num_levels = length / sizeof(u32);
 
 	/* read brightness levels from DT property */
-	if (data->max_brightness > 0) {
-		size_t size = sizeof(*data->levels) * data->max_brightness;
-		unsigned int i, j, n = 0;
+	if (num_levels > 0) {
+		size_t size = sizeof(*data->levels) * num_levels;
 
 		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
 		if (!data->levels)
@@ -273,7 +271,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 
 		ret = of_property_read_u32_array(node, "brightness-levels",
 						 data->levels,
-						 data->max_brightness);
+						 num_levels);
 		if (ret < 0)
 			return ret;
 
@@ -298,7 +296,13 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		 * between two points.
 		 */
 		if (num_steps) {
-			if (data->max_brightness < 2) {
+			unsigned int num_input_levels = num_levels;
+			unsigned int i;
+			u32 x1, x2, x, dx;
+			u32 y1, y2;
+			s64 dy;
+
+			if (num_input_levels < 2) {
 				dev_err(dev, "can't interpolate\n");
 				return -EINVAL;
 			}
@@ -308,14 +312,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 			 * taking in consideration the number of interpolated
 			 * steps between two levels.
 			 */
-			for (i = 0; i < data->max_brightness - 1; i++) {
-				if ((data->levels[i + 1] - data->levels[i]) /
-				   num_steps)
-					num_levels += num_steps;
-				else
-					num_levels++;
-			}
-			num_levels++;
+			num_levels = (num_input_levels - 1) * num_steps + 1;
 			dev_dbg(dev, "new number of brightness levels: %d\n",
 				num_levels);
 
@@ -327,24 +324,25 @@ static int pwm_backlight_parse_dt(struct device *dev,
 			table = devm_kzalloc(dev, size, GFP_KERNEL);
 			if (!table)
 				return -ENOMEM;
-
-			/* Fill the interpolated table. */
-			levels_count = 0;
-			for (i = 0; i < data->max_brightness - 1; i++) {
-				value = data->levels[i];
-				n = (data->levels[i + 1] - value) / num_steps;
-				if (n > 0) {
-					for (j = 0; j < num_steps; j++) {
-						table[levels_count] = value;
-						value += n;
-						levels_count++;
-					}
-				} else {
-					table[levels_count] = data->levels[i];
-					levels_count++;
+			/*
+			 * Fill the interpolated table[x] = y
+			 * by draw lines between each (x1, y1) to (x2, y2).
+			 */
+			dx = num_steps;
+			for (i = 0; i < num_input_levels - 1; i++) {
+				x1 = i * dx;
+				x2 = x1 + dx;
+				y1 = data->levels[i];
+				y2 = data->levels[i + 1];
+				dy = (s64)y2 - y1;
+
+				for (x = x1; x < x2; x++) {
+					table[x] = y1 +
+						div_s64(dy * ((s64)x - x1), dx);
 				}
 			}
-			table[levels_count] = data->levels[i];
+			/* Fill in the last point, since no line starts here. */
+			table[x2] = y2;
 
 			/*
 			 * As we use interpolation lets remove current
@@ -353,15 +351,9 @@ static int pwm_backlight_parse_dt(struct device *dev,
 			 */
 			devm_kfree(dev, data->levels);
 			data->levels = table;
-
-			/*
-			 * Reassign max_brightness value to the new total number
-			 * of brightness levels.
-			 */
-			data->max_brightness = num_levels;
 		}
 
-		data->max_brightness--;
+		data->max_brightness = num_levels - 1;
 	}
 
 	return 0;
-- 
2.28.0

