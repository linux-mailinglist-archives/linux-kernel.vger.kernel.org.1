Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D82CC98F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbgLBWXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgLBWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:23:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D1C061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:22:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id f190so654527wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRXtGtQx0V38uULFsTPi/qjTFIKnBLoKo8MU7obqjyU=;
        b=E06twwEMJ8K66tEsIJl1OyT2WbCBwVJRU0XbGlu1c/FOLMDuP3vUOkSGVgbowqMHOz
         N/4X85VeDi4KiWUjgpqymbeiDaMUoRzV48Eq9g6JsAEv+32InsBV2CRj2jV/MoiKqSQ2
         J1k9Dl5ovU1lCA1ZFl+VcjBnSq6njDdIMb5a3t3k73L1v9Dt0xnPktb/3UaBxVIQiN2x
         iJpCeEnGOrC2rH0JJj4JE8/PRR6tH6bf9c3CWqBJLgYWi+w7saeego0T/SEHOyP9uFyw
         MDD9uWQYGrfCSc0VYP4Qh7tw2WDIeKsVigxQLadb+LtQp+nuwqzhrtooTwahCxvqUTRU
         ahMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRXtGtQx0V38uULFsTPi/qjTFIKnBLoKo8MU7obqjyU=;
        b=KWp2/iF1Kz6iHKJO1WmxB1gQQQ7/Pbbj1gVAcyjTZe1n/pMtPA2lDTVBmLYYE1S7J8
         KFpKI7mS/MyTBn1pUjSv8AuX8AqguqtcgpbBiZa4cT7l97KoFix6i6SnRIGBOu8PXWHc
         g/80VwUq97I5XT4wVo/4WR8fAJPkxWMmeIlxVnbvBnYffB9tjulOTswdi7FC1vVIcjg/
         ll795x7fToFDCxsrB/0G7HcUEXV+HUHhR81a9E6A8w70CUh1Ie3M3Sl5UrtzZZlkyEUw
         oa0/06RSBwJ/1+rASxsbZSrE5tpi8sfrc7D2JFUSzGBUfT9Hyf5CBC+g/KqRNV9dEvUn
         /DyA==
X-Gm-Message-State: AOAM531VCP9XGoGIwms+rhZ5eNaerT6BiLWMIALO5gGxWZ2+1Ob8+3+c
        0f49UvxiJ/rNqxdw1LeLpIHqtA==
X-Google-Smtp-Source: ABdhPJxEXBGOGhTXe1z3x/CCv0w83dkticJSyr3zsDqEThZZ1//azfGM8xR1Q0czXAwVi3/x/sHB+A==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr104009wml.33.1606947752953;
        Wed, 02 Dec 2020 14:22:32 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2])
        by smtp.gmail.com with ESMTPSA id s8sm63672wrn.33.2020.12.02.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:22:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] platform/x86/drivers/acerhdf: Check the interval value when it is set
Date:   Wed,  2 Dec 2020 23:22:12 +0100
Message-Id: <20201202222212.2313242-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202222212.2313242-1-daniel.lezcano@linaro.org>
References: <20201202222212.2313242-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code checks the interval value when the temperature is
read which is bad for two reasons:

 - checking and setting the interval in the get_temp callback is
   inaccurate and awful, that can be done when changing the value.

 - Changing the thermal zone structure internals is an abuse of the
   exported structure, moreover no lock is taken here.

The goal of this patch is to solve the first item by using the 'set'
function called when changing the interval. The check is done there
and removed from the get_temp function. If the thermal zone was not
initialized yet, the interval is not updated in this case as that will
happen in the init function when registering the thermal zone device.

I don't have any hardware to test the changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/platform/x86/acerhdf.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 19fc8ff2225c..084005841d56 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -334,7 +334,10 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 		}
 		if (verbose)
 			pr_notice("interval changed to: %d\n", interval);
-		thermal->polling_delay = interval*1000;
+
+		if (thermal)
+			thermal->polling_delay = interval*1000;
+
 		prev_interval = interval;
 	}
 }
@@ -349,8 +352,6 @@ static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, int *t)
 {
 	int temp, err = 0;
 
-	acerhdf_check_param(thermal);
-
 	err = acerhdf_get_temp(&temp);
 	if (err)
 		return err;
@@ -823,8 +824,19 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
 
+int interval_set_uint(const char *val, const struct kernel_param *kp)
+{
+	ret = param_set_uint(val, kp);
+	if (ret)
+		return ret;
+
+	acerhdf_check_param(thz_dev);
+
+	return 0;
+}
+
 static const struct kernel_param_ops interval_ops = {
-	.set = param_set_uint,
+	.set = interval_set_uint,
 	.get = param_get_uint,
 };
 
-- 
2.25.1

