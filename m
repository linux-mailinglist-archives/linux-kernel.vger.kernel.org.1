Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDF1EEBE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgFDUZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgFDUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:25:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E5C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:25:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a25so7514594ejg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp1xYo6k4Ed0Q77xnwXh8flp1gyMGXgNyJfMwsgW+Kg=;
        b=evhiSuNKpPTp+xlYhHPUN38Ox9A/NzzEV4h1KCTaNexej2sn7dmxexT5wPV6QE9RGz
         8s+clTM3p1CcSW8UaFOs+qvckgUkMZCWKQTkyDHU6S/fz724e8Vq0r4vnPsuXTIqOTMo
         ImpLlbekhGKaz1aCRFpAKp2RoYziWLrVBv+kPju1pOuBuubQ+yvuGmBZxTi0FgAL/xGs
         bstbfB866bgWjvF5BP1/Gb+lQVOxGlNCNdLiVkaiEjXFC1758lqtSdf2UsrBgT3xnK84
         kIqKVoUgb2UoS9fHTo26sqjDx8ivjPSW9RvxOOS99pfOPNahG8izNyr51/w+pRl6e4bJ
         3R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp1xYo6k4Ed0Q77xnwXh8flp1gyMGXgNyJfMwsgW+Kg=;
        b=OVWXytAl4nIno8KL+sobx3wiCKGWzC/VfFvAxSfl2oDI+h9MhFnqxcnO1pHu7Zqe8a
         p6Wq+e9coERbGwu1luRvnkrrkw/xNRD9kcjsOWTGCHTJESOBGzVWFhSJ2xTwxgLpCfIZ
         NLmL/plvPRhpFmXmPa79fH8qK+S4U6QIAhCz+8abUE6xugGD0cp2Nk3ik/BiuNQX/j+2
         ig6A4+lQ8z7+4Sv/cBGnzhq900BWQr7RpjIqxpiRe0znpCLoLanAwKKhTc1Gy2vguLWu
         zjA3UseeK4au+qBLnp4/tvb4YUlL4aERKrdf4YJVe5KP/vG//2Ute6e4DImutlzszKTf
         BcBw==
X-Gm-Message-State: AOAM530nGWtCUQWMGvUhG1wWRqtt4mcvNU0n+IRZ1AtKRSAGXzWbkNCM
        2+GAY7PbZgcqcy8teOmQ24ZPOw==
X-Google-Smtp-Source: ABdhPJy0rnfMZ1ArAXpFdTF1Mqx8GK4Oc26nrumSGoUgDRR2u9udOp68JVQC+ShGFy3J/lNOJiw52w==
X-Received: by 2002:a17:906:3844:: with SMTP id w4mr5771829ejc.313.1591302327676;
        Thu, 04 Jun 2020 13:25:27 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id gx8sm2792246ejb.86.2020.06.04.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:25:26 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, naresh.kamboju@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Fix wrong masking of status flags
Date:   Thu,  4 Jun 2020 22:25:20 +0200
Message-Id: <20200604202520.66459-1-maco@android.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In faf1d25440d6, loop_set_status() now assigns lo_status directly from
the passed in lo_flags, but then fixes it up by masking out flags that
can't be set by LOOP_SET_STATUS; unfortunately the mask was negated.

Re-ran all ltp ioctl_loop tests, and they all passed.

Pass run of the previously failing one:

tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
tst_device.c:88: INFO: Found free device 0 '/dev/loop0'
ioctl_loop01.c:49: PASS: /sys/block/loop0/loop/partscan = 0
ioctl_loop01.c:50: PASS: /sys/block/loop0/loop/autoclear = 0
ioctl_loop01.c:51: PASS: /sys/block/loop0/loop/backing_file =
'/tmp/ZRJ6H4/test.img'
ioctl_loop01.c:65: PASS: get expected lo_flag 12
ioctl_loop01.c:67: PASS: /sys/block/loop0/loop/partscan = 1
ioctl_loop01.c:68: PASS: /sys/block/loop0/loop/autoclear = 1
ioctl_loop01.c:77: PASS: access /dev/loop0p1 succeeds
ioctl_loop01.c:83: PASS: access /sys/block/loop0/loop0p1 succeeds

Summary:
passed   8
failed   0
skipped  0
warnings 0

Fixes: faf1d25440d6 ("loop: Clean up LOOP_SET_STATUS lo_flags handling")
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4212288ab157..ad63e4247868 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1390,7 +1390,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unfreeze;
 
 	/* Mask out flags that can't be set using LOOP_SET_STATUS. */
-	lo->lo_flags &= ~LOOP_SET_STATUS_SETTABLE_FLAGS;
+	lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
 	/* For those flags, use the previous values instead */
 	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
 	/* For flags that can't be cleared, use previous values too */
-- 
2.27.0.278.ge193c7cf3a9-goog

