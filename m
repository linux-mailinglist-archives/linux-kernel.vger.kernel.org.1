Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54154285361
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgJFUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgJFUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:46:01 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63842C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:45:59 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j13so141306ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfGJntOuX6tZ4E9Gsy4tU3pdus6QhKS2Hy9ZQJbvD3s=;
        b=ORaLJjP93exZOnhidqhMHCXhF2sxqmZ84r2eyK3JudO4d1CBJAtROPyjATuHbIr2IO
         Lqoe1cH/5wnsmnhZShjQOxsitOkXvDaicUKDeJupAEaOyEK4KY7DmEqLSN64KLz+EBu4
         SKTyxLoaOR/6vES+AJvwkXFQia1a5aGwIc1bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfGJntOuX6tZ4E9Gsy4tU3pdus6QhKS2Hy9ZQJbvD3s=;
        b=QCI3VDUNrPKeDUvfIBnKUZxUmBrDRXt7rpJmYR49zdSd5AYM2eeg7azpaabvmqZN3A
         rHdOwgB/fGWoZ96m7sKw2v8YclCmvLjgit+FyEc1Fv3pNc22S78xs1J9MXTiH1nMyjl2
         xxwoh1T4oxZ85T32bO1fWkXO1m5rM8i+f65kV5UgeHhYuUvi8g+cliLhFnSOEnAvp6Y6
         wJfARLFZz1jd4xzyQl4F3xl5HOn+PkynoEPYafqh0gUWzmh3HZa9FwMxeaxC75OgavVx
         YcXUNroPQxP0QKdsZgTb5Csw7YY17x4AMCd2jEaRL0hjqhopSAV8RTu5gFHeMdZ94H7+
         s6KA==
X-Gm-Message-State: AOAM531SYBqdQUtUQ3M6jpjoxce2KNuiIbsKQjjCQ2xtv7+b7r48i2rQ
        bLt5bTFnXGXlcw7cWhonoXpLhQ==
X-Google-Smtp-Source: ABdhPJx6ID3poIvgRAMw6Zf82C8ZUH056XA4QppC4qz+CYZw/9qd7Xm0cbKgojYLaWbkQSuCgaH1tA==
X-Received: by 2002:a92:5882:: with SMTP id z2mr2268ilf.137.1602017158708;
        Tue, 06 Oct 2020 13:45:58 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:45:58 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] drivers/base/test/test_async_driver_probe: convert to use counter_atomic32
Date:   Tue,  6 Oct 2020 14:44:39 -0600
Message-Id: <7a259f1710f621a95d6e683308e55bd74bba2a2f.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used to count errors, warns, keep track of timeout,
and async completion are counters.

Unsure overflow is a concern for timeout and async completion, and there
are no checks for overflow to hold them to upper bounds. Overflow and
wrap around doesn't impact errors, and warns.

Convert them to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/test/test_async_driver_probe.c | 23 ++++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 3bb7beb127a9..e969c1b09426 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -14,11 +14,12 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <linux/counters.h>
 
 #define TEST_PROBE_DELAY	(5 * 1000)	/* 5 sec */
 #define TEST_PROBE_THRESHOLD	(TEST_PROBE_DELAY / 2)
 
-static atomic_t warnings, errors, timeout, async_completed;
+static struct counter_atomic32 warnings, errors, timeout, async_completed;
 
 static int test_probe(struct platform_device *pdev)
 {
@@ -29,9 +30,9 @@ static int test_probe(struct platform_device *pdev)
 	 * have then report it as an error, otherwise we wil sleep for the
 	 * required amount of time and then report completion.
 	 */
-	if (atomic_read(&timeout)) {
+	if (counter_atomic32_read(&timeout)) {
 		dev_err(dev, "async probe took too long\n");
-		atomic_inc(&errors);
+		counter_atomic32_inc(&errors);
 	} else {
 		dev_dbg(&pdev->dev, "sleeping for %d msecs in probe\n",
 			 TEST_PROBE_DELAY);
@@ -48,10 +49,10 @@ static int test_probe(struct platform_device *pdev)
 		    dev_to_node(dev) != numa_node_id()) {
 			dev_warn(dev, "NUMA node mismatch %d != %d\n",
 				 dev_to_node(dev), numa_node_id());
-			atomic_inc(&warnings);
+			counter_atomic32_inc(&warnings);
 		}
 
-		atomic_inc(&async_completed);
+		counter_atomic32_inc(&async_completed);
 	}
 
 	return 0;
@@ -244,11 +245,12 @@ static int __init test_async_probe_init(void)
 	 * Otherwise if they completed without errors or warnings then
 	 * report successful completion.
 	 */
-	if (atomic_read(&async_completed) != async_id) {
+	if (counter_atomic32_read(&async_completed) != async_id) {
 		pr_err("async events still pending, forcing timeout\n");
-		atomic_inc(&timeout);
+		counter_atomic32_inc(&timeout);
 		err = -ETIMEDOUT;
-	} else if (!atomic_read(&errors) && !atomic_read(&warnings)) {
+	} else if (!counter_atomic32_read(&errors) &&
+		   !counter_atomic32_read(&warnings)) {
 		pr_info("completed successfully\n");
 		return 0;
 	}
@@ -271,12 +273,13 @@ static int __init test_async_probe_init(void)
 	 * errors or warnings being reported by the probe routine.
 	 */
 	if (err)
-		atomic_inc(&errors);
+		counter_atomic32_inc(&errors);
 	else
 		err = -EINVAL;
 
 	pr_err("Test failed with %d errors and %d warnings\n",
-	       atomic_read(&errors), atomic_read(&warnings));
+	       counter_atomic32_read(&errors),
+	       counter_atomic32_read(&warnings));
 
 	return err;
 }
-- 
2.25.1

