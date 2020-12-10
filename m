Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F02D6449
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392945AbgLJSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390787AbgLJSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:00:50 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE5C06179C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:00:09 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b10so5380911ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQDKujR+0DMXhI8kbLJ9upg8lBZL3kVIZAc1oUCKXJc=;
        b=Y2SGHNCcaLGFOdsI2EP5dhMWUVbfOdZXowXQHVEozuIFBK9AsiD9xHN1/N7Vozewaj
         +Lgpwsg8YkryrHxfgEkeG9AqOact4ag8FERJIxCUvYeWWW1JsAkJrJE960XXY3r5Ppqz
         auoeNguRkkKLmBZbIHSmR8NHHZcl5ZzcpUOV1WhuaD9JVRLaGYp/64n7jECE06GSRRMA
         HzPu35kpMm5+Ai12YOi5ycZgMVkEzSS/0xrN10CMig480SM9U3+ebFuWC/88H1UXPm/7
         FXNZVzIIhk4SizW7slatQpaeueEHeodicOOYCfYRaXSazfxMWNL853xuPwTciNQ/GB/h
         3rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQDKujR+0DMXhI8kbLJ9upg8lBZL3kVIZAc1oUCKXJc=;
        b=FYuw0v3UtciAdUNv4ddxpzAHTPtAngQSKmaxTCwfsPIOq8WVJ4uwi/4dCBk9ykE3tm
         eNbyXlp3pMT2XXeBpQuzXgBAiWEokwUn7AEd+Bjjis/gCdJy7Vo+taMH86HIPfGkVoQA
         lFYBYKJeqyvPsROPG+2xBThcOZLHTSzZ5O9qNOwUJceg26KGlvyHYW+MbaCSFhaSQ1vv
         C6vY2g1NH0V4RwwuuJFks50xrWUc3D90tZi96JiW77zYVJt5Mr+i35aD8F/eubczQ1Zp
         fJimASCsa3Rq4utbxzuRPVHW+f8loWA70KneWuhT71oObDkdqoYCP7QQxqxyB7PggU0m
         I7tw==
X-Gm-Message-State: AOAM5305in0PLNge12IqOTbPa8i71pEI2pqcfh2qMjXBPwC2xhhjxxtw
        mogaOSjvCXsy8JLk8Qed8kjnoc95DskaAsFS
X-Google-Smtp-Source: ABdhPJzBHEtZXQH0iFqk3Tj+guS2CdszXEEmlw0IxtyFSpzYlR/dcamqRkF2gaPOCSdp3y8mqGakig==
X-Received: by 2002:a2e:50c:: with SMTP id 12mr3569690ljf.226.1607623208452;
        Thu, 10 Dec 2020 10:00:08 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x22sm432585lfe.277.2020.12.10.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:00:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mfd: ab8500: Drop bm disable parameter
Date:   Thu, 10 Dec 2020 19:00:03 +0100
Message-Id: <20201210180003.2447251-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is passing the module parameter to disable the
battery management portions so just drop this parameter.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab8500-core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 3b2276f04a98..f63a8e51d0e4 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -121,12 +121,6 @@
 static DEFINE_SPINLOCK(on_stat_lock);
 static u8 turn_on_stat_mask = 0xFF;
 static u8 turn_on_stat_set;
-static bool no_bm; /* No battery management */
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param here.
- */
-module_param(no_bm, bool, S_IRUGO);
 
 #define AB9540_MODEM_CTRL2_REG			0x23
 #define AB9540_MODEM_CTRL2_SWDBBRSTN_BIT	BIT(2)
@@ -1255,14 +1249,12 @@ static int ab8500_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!no_bm) {
-		/* Add battery management devices */
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-				      ARRAY_SIZE(ab8500_bm_devs), NULL,
-				      0, ab8500->domain);
-		if (ret)
-			dev_err(ab8500->dev, "error adding bm devices\n");
-	}
+	/* Add battery management devices */
+	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+			      ARRAY_SIZE(ab8500_bm_devs), NULL,
+			      0, ab8500->domain);
+	if (ret)
+		dev_err(ab8500->dev, "error adding bm devices\n");
 
 	if (((is_ab8505(ab8500) || is_ab9540(ab8500)) &&
 			ab8500->chip_id >= AB8500_CUT2P0) || is_ab8540(ab8500))
-- 
2.26.2

