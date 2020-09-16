Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2226C9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgIPTV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D383C061353
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f1so3714494plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hW2rx2qlWMb00+NZjVDOtwBqZo3cFuEztlDfxIo5LGk=;
        b=pe50ZNHfLR7enisj2deltRCUPVcMiupajZ1bdGgoLDVGoIFLLrvd/cgGsxMISC06Go
         OKHLb/RXGTyDwyZUqdYlwcXMTRLsdXG8KvvClJ/q1wy2rdmqRMCrSsEeavh2LEjNyZEk
         lEYQ3MQ7po7dKt9mvzNKduvx87rjAk3SCXdV9Q5b7gmwsJIYtVuKneP+9JAWNDpsykjA
         6rb3Tz0KijSlziIu+9XeYHzm+qKsBfTpWFPvsLkkIYn5yIrabg7lTLCqAGrP5X+Mv+N6
         3bKs/NWH4CqrKD1LuhxDYvuTYa+vxnSxFHdRyovhvkfAyNkO6WZpZKFN88KkfHFb1JK4
         /r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hW2rx2qlWMb00+NZjVDOtwBqZo3cFuEztlDfxIo5LGk=;
        b=VhP6E3DeDJKd56Wq7dCX+tZ7tAC+wkwJpEoDz/j6G8/e9xI98a+tMd5beJVTmlilTW
         GslL7yVmh277ig3CW/eC8ISYfeVwGLaafPLfN8Np0XIjhL4SC+Wb4uFy+9oMPhkov5P2
         NlVoOXnaQxpSlMSUcdjN+b2qbCtHDeS4gZ9MxZAm3V9+bC8OUjXj8oBv545bxvcER6U+
         WkrOPw9j/6Q48MK18cz+9MjwJu6EtGco4LtLc4gMlmcgNbAjkzrZBi5Jl+19GcOYMzFh
         Ds8NLAqsrkkRumxtkFtPagC1p5YBSI9VLDRYQVSyRlnUcaRwbKglHI+sHbl/6WMqt6FV
         xk2g==
X-Gm-Message-State: AOAM531D3/hz2JMjjohFHceWWOYoRMCRO5didW/m7UB5K6Q7OBXJfJyO
        ikw2fk+Dti4tJQYepUReS2O1raeSO/LDNw==
X-Google-Smtp-Source: ABdhPJzSbGhnR1NOlWyUYSHPjqf68ZvVCgirP9Y5ifby+wfXgSqO9diUbLaO9Ihm5EQ0NPOHxIit1g==
X-Received: by 2002:a17:902:ff02:b029:d0:89f3:28d2 with SMTP id f2-20020a170902ff02b02900d089f328d2mr24564215plj.14.1600283869636;
        Wed, 16 Sep 2020 12:17:49 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:49 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] coresight: cti: Write regsiters directly in cti_enable_hw()
Date:   Wed, 16 Sep 2020 13:17:30 -0600
Message-Id: <20200916191737.4001561-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Deadlock as below is triggered by one CPU holds drvdata->spinlock
and calls cti_enable_hw(). Smp_call_function_single() is called
in cti_enable_hw() and tries to let another CPU write CTI registers.
That CPU is trying to get drvdata->spinlock in cti_cpu_pm_notify()
and doesn't response to IPI from smp_call_function_single().

[  988.335937] CPU: 6 PID: 10258 Comm: sh Tainted: G        W    L
5.8.0-rc6-mainline-16783-gc38daa79b26b-dirty #1
[  988.346364] Hardware name: Thundercomm Dragonboard 845c (DT)
[  988.352073] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
[  988.357689] pc : smp_call_function_single+0x158/0x1b8
[  988.362782] lr : smp_call_function_single+0x124/0x1b8
...
[  988.451638] Call trace:
[  988.454119]  smp_call_function_single+0x158/0x1b8
[  988.458866]  cti_enable+0xb4/0xf8 [coresight_cti]
[  988.463618]  coresight_control_assoc_ectdev+0x6c/0x128 [coresight]
[  988.469855]  coresight_enable+0x1f0/0x364 [coresight]
[  988.474957]  enable_source_store+0x5c/0x9c [coresight]
[  988.480140]  dev_attr_store+0x14/0x28
[  988.483839]  sysfs_kf_write+0x38/0x4c
[  988.487532]  kernfs_fop_write+0x1c0/0x2b0
[  988.491585]  vfs_write+0xfc/0x300
[  988.494931]  ksys_write+0x78/0xe0
[  988.498283]  __arm64_sys_write+0x18/0x20
[  988.502240]  el0_svc_common+0x98/0x160
[  988.506024]  do_el0_svc+0x78/0x80
[  988.509377]  el0_sync_handler+0xd4/0x270
[  988.513337]  el0_sync+0x164/0x180

This change write CTI registers directly in cti_enable_hw().
Config->hw_powered has been checked to be true with spinlock holded.
CTI is powered and can be programmed until spinlock is released.

Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI devices")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
[Re-ordered variable declaration]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 24 +++++----------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index c4e9cc7034ab..47f3c9abae30 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -86,22 +86,16 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void cti_enable_hw_smp_call(void *info)
-{
-	struct cti_drvdata *drvdata = info;
-
-	cti_write_all_hw_regs(drvdata);
-}
-
 /* write regs to hardware and enable */
 static int cti_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
 	struct device *dev = &drvdata->csdev->dev;
+	unsigned long flags;
 	int rc = 0;
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock(&drvdata->spinlock);
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* no need to do anything if enabled or unpowered*/
 	if (config->hw_enabled || !config->hw_powered)
@@ -112,19 +106,11 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 	if (rc)
 		goto cti_err_not_enabled;
 
-	if (drvdata->ctidev.cpu >= 0) {
-		rc = smp_call_function_single(drvdata->ctidev.cpu,
-					      cti_enable_hw_smp_call,
-					      drvdata, 1);
-		if (rc)
-			goto cti_err_not_enabled;
-	} else {
-		cti_write_all_hw_regs(drvdata);
-	}
+	cti_write_all_hw_regs(drvdata);
 
 	config->hw_enabled = true;
 	atomic_inc(&drvdata->config.enable_req_count);
-	spin_unlock(&drvdata->spinlock);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 
 cti_state_unchanged:
@@ -132,7 +118,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 
 	/* cannot enable due to error */
 cti_err_not_enabled:
-	spin_unlock(&drvdata->spinlock);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 	return rc;
 }
-- 
2.25.1

