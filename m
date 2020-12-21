Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A622DF85A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgLUEoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbgLUEoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:44:13 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC39C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:43:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x126so5767903pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiK3nNAapDck5oM0vIZvOeVHLmCqQzK2Pm1yBiPMxvk=;
        b=MYfuRDv0xeoTpKEakODc++27b6vEVH1g0l5TJlYzpxpAAiLCZyC5ub+fu9SZwatRY/
         uN6AZrg1hqw35V1DKBCzo5BB/TlQ7JqAtKWpLs3EwTcYydwqo3S0gVTnwvvfmdiDPYDY
         xr/bhuqwM3a3xMS+YALBzPwh+wQ6xhjPll/SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiK3nNAapDck5oM0vIZvOeVHLmCqQzK2Pm1yBiPMxvk=;
        b=q6+LwcvlbjjRRYVY3XRNwsYlm5gcbymT2waR3kGy162jkxbkxB9CaHIDq4TK1jv0UO
         ky5fL/SUYLlWodOOFUSH4jZE5osPBuSZ/sbzFNHDx2s02LT6y6fKdQo/8VhbraYH6RvD
         vlScB4cab3yWsCrTrvHsJtFiN75lyOvBYugROve4Ndn06FzMYjfuqTNifetED5sGzNDL
         h+22gOW6XM0K6v9hnwTD6YX3dYmiWBISWxBwphsIwt3Pt7yMdB3Ct0VEJ5ZDLx3dtFYS
         3Dr4xzAo+qWhnps06tLY3yO8a0BuHVmjln+RJ/7OmR6eDgIQtC8o2QPGds0W6VN8QJp0
         VdIw==
X-Gm-Message-State: AOAM5338qKKvMc3EjwYPj3iMyy/w0xSh2PeaBQTV2POH1OgmirVcyjfH
        XBWRXEixl3pYqixDNlxEkj/Rs3pX1VYJE6Eg
X-Google-Smtp-Source: ABdhPJzgIGT3T5mdCCHdZfKVgSZ2PeeNPXcJG/nmwkIc7RAFxC85BP7jQm6LxK1AAxDWtR/WWI+STw==
X-Received: by 2002:a05:6a00:804:b029:198:28cb:5564 with SMTP id m4-20020a056a000804b029019828cb5564mr13557326pfk.34.1608523960654;
        Sun, 20 Dec 2020 20:12:40 -0800 (PST)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id y19sm14823118pfp.211.2020.12.20.20.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 20:12:39 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_sysfs: Add cold-ap-off to sysfs reboot.
Date:   Mon, 21 Dec 2020 12:12:24 +0800
Message-Id: <20201221041231.14516-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221041231.14516-1-pihsun@chromium.org>
References: <20201221041231.14516-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cold-ap-off to ChromeOS EC sysfs reboot file option, corresponds to
the EC_REBOOT_COLD_AP_OFF flag, that will reset EC and keep AP off.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f521a5c65091..8210fb10e839 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -28,7 +28,7 @@ static ssize_t reboot_show(struct device *dev,
 	int count = 0;
 
 	count += scnprintf(buf + count, PAGE_SIZE - count,
-			   "ro|rw|cancel|cold|disable-jump|hibernate");
+			   "ro|rw|cancel|cold|disable-jump|hibernate|cold-ap-off");
 	count += scnprintf(buf + count, PAGE_SIZE - count,
 			   " [at-shutdown]\n");
 	return count;
@@ -46,6 +46,7 @@ static ssize_t reboot_store(struct device *dev,
 		{"cancel",       EC_REBOOT_CANCEL, 0},
 		{"ro",           EC_REBOOT_JUMP_RO, 0},
 		{"rw",           EC_REBOOT_JUMP_RW, 0},
+		{"cold-ap-off",  EC_REBOOT_COLD_AP_OFF, 0},
 		{"cold",         EC_REBOOT_COLD, 0},
 		{"disable-jump", EC_REBOOT_DISABLE_JUMP, 0},
 		{"hibernate",    EC_REBOOT_HIBERNATE, 0},
-- 
2.29.2.684.gfbc64c5ab5-goog

