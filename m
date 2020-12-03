Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8F2CD042
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgLCHSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgLCHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:18:34 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B23C061A4F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:17:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so748317wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuvCzwi9d1VbB+mo+4SzTyjN38s8O13gDmykxTZeoWk=;
        b=wKZQjoj619Sv4wKz5O1Me92SGc+uO7s0HJQq9BGjtyat8SJFtK9aFfbrzxVreMBBXx
         Psw0KYdLu12HGTAwD98Lj/CVNYWoMQYbimF3VgsWWXOnu9OjWrPMUCaBq5/sAn6gQRZH
         maM5qY32zSU3J+3P4itf+U4b4ZPldhbK7tP7Gp1Z6KQK6viskGkMy1WZzm9PZ9Umlv4I
         TK+LBpMFGeqVXUSsO1VUoL0FJr7UITW+H35EeDUW5WluV1LJq7ALb5+TQN3Ev7vTFDdV
         vJaYlEIHSn1Q4LiPSMTbak9h0cStx1rIrnuJ5D2Hi9/sbp9C0CCOU5lDrcjuCzj2e8oo
         qI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuvCzwi9d1VbB+mo+4SzTyjN38s8O13gDmykxTZeoWk=;
        b=mgoYmvdBoqycx/yNJ4vv4l3aY0ahNM7d618fPEw1JyuUvBe/FjEyiCObeo8lGbQNv0
         L2lqgjmeF0SVd66A4fD2dk++jxqublyGOURaQHvrBAHd64iJ5hn74XqW8eejBCSGG13A
         zfnrQLvPSeuGm6/lSxta8rIRP7g/yiSuwgRgK36CDdTR7JAk3pK/FsQBxk+m/bLEWNEg
         v8ejfRc3kD6LrYskYmqt4pWbVsKfSR6rB08uzu/84taOlvKCx/XNUFLAyr7DEMnLokJP
         QSrUCg+uxsDMYMAxihgSvWPJfad5zeOLlBNl65PmS2qqtcPzo04dCrhlVrZdODnD1iX7
         qPQA==
X-Gm-Message-State: AOAM532HVLGfD/lOZgqVtHFvJ0VfO52CBxuRBCiU9bfxBqndEeSDGwCs
        bPaduRXzVoPpt/MK4jR6ZpxlLQ==
X-Google-Smtp-Source: ABdhPJzZh+V5pKjg2HAUEkOxmeR3gJZ29Cv9mXSJdMijGxKH/V/XiRBFjoprjGu1YtM0K6HKKf11Iw==
X-Received: by 2002:adf:e912:: with SMTP id f18mr1943267wrm.79.1606979872859;
        Wed, 02 Dec 2020 23:17:52 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2])
        by smtp.gmail.com with ESMTPSA id s13sm230402wmj.28.2020.12.02.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 23:17:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, peter@piie.net, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] platform/x86/drivers/acerhdf: Check the interval value when it is set
Date:   Thu,  3 Dec 2020 08:17:38 +0100
Message-Id: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
References: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
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
 V2:
   - Fixed static function annotation
---
 drivers/platform/x86/acerhdf.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 19fc8ff2225c..b6aa6e5514f4 100644
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
@@ -823,8 +824,21 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
 
+static int interval_set_uint(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
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

