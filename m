Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2881274EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIWBoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIWBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB19C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u126so23242898oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0pylmEC6MXIvZeg8ADGisWHL/FDreH9lM3+Sceu6mE=;
        b=iLNgW0OjMblZbksvidQncv6u6Tvj78vOgDqdkEDT97wg3gVlhtf4SfR31IX/IM0qcc
         yXuuCwPnC7k4EZwM4HVidJr6Gq1MTURxGr3EiI9JSBDvITbCjAAzW3CamVRe0M+eJXy6
         wWGhSVyDBZBqnVxVHwu0DWHIAZlXcynImIhBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0pylmEC6MXIvZeg8ADGisWHL/FDreH9lM3+Sceu6mE=;
        b=SHRrQhbGkocCQWc80jea9OP/KOoMHuoY2l+loANpWt6ul9cow5Utkv21f1faDy9PBn
         p2jtokXC/qGFcQDwKLEIspo7YzhYsWWfrQt4m++HOzb8GOKs5NhVIJYSH5UoTwbYVN9m
         ++Iv3ZWuAczZWQ+lu5Gf9jRiagORyigdwQ8WEAhEGZTmCYMr99TBpDDfcdi8r2WfyfxT
         QukZSAEI1SfRE7AeJhyvqQ5YWJV66GzcGvSRdF4xoqowSFLhQa8i29pWxK+LWDCkp9NT
         r76jKTFYtzf4SLAQSVKFG50bV2Hj7ECrz2S4sDUDdUo87/esspsEs3+k7yUtmJmgi705
         QKVQ==
X-Gm-Message-State: AOAM531yYXtiWL244yjBWnXpxzOeHUZ4Exns6yVfURCQ7nWU+kkOCii2
        dRNYrQVqyy3OmEoTVFshsoRDyg==
X-Google-Smtp-Source: ABdhPJy5rqihSo810wiEYNe+nFiplu85NO09JV9IuWSoLtnTrHWcks4rwd1IqHgRp2sRnnjmmh1c6Q==
X-Received: by 2002:aca:1e08:: with SMTP id m8mr4170436oic.168.1600825463706;
        Tue, 22 Sep 2020 18:44:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/11] drivers/base/test/test_async_driver_probe: convert to use counter_atomic
Date:   Tue, 22 Sep 2020 19:43:37 -0600
Message-Id: <19fcc4c395c022e07ae7ce7c48fec2b09188f391.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600816121.git.skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used to count errors, warns, keep track of timeout,
and async completion are counters.

Unsure overflow is a concern for timeout and async completion, and there
are no checks for overflow to hold them to upper bounds. Overflow and
wrap around doesn't impact errors, and warns.

Convert them to use counter_atomic.

This conversion doesn't change the oveflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/test/test_async_driver_probe.c | 23 ++++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 3bb7beb127a9..def08cd03eb5 100644
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
+static struct counter_atomic warnings, errors, timeout, async_completed;
 
 static int test_probe(struct platform_device *pdev)
 {
@@ -29,9 +30,9 @@ static int test_probe(struct platform_device *pdev)
 	 * have then report it as an error, otherwise we wil sleep for the
 	 * required amount of time and then report completion.
 	 */
-	if (atomic_read(&timeout)) {
+	if (counter_atomic_read(&timeout)) {
 		dev_err(dev, "async probe took too long\n");
-		atomic_inc(&errors);
+		counter_atomic_inc(&errors);
 	} else {
 		dev_dbg(&pdev->dev, "sleeping for %d msecs in probe\n",
 			 TEST_PROBE_DELAY);
@@ -48,10 +49,10 @@ static int test_probe(struct platform_device *pdev)
 		    dev_to_node(dev) != numa_node_id()) {
 			dev_warn(dev, "NUMA node mismatch %d != %d\n",
 				 dev_to_node(dev), numa_node_id());
-			atomic_inc(&warnings);
+			counter_atomic_inc(&warnings);
 		}
 
-		atomic_inc(&async_completed);
+		counter_atomic_inc(&async_completed);
 	}
 
 	return 0;
@@ -244,11 +245,12 @@ static int __init test_async_probe_init(void)
 	 * Otherwise if they completed without errors or warnings then
 	 * report successful completion.
 	 */
-	if (atomic_read(&async_completed) != async_id) {
+	if (counter_atomic_read(&async_completed) != async_id) {
 		pr_err("async events still pending, forcing timeout\n");
-		atomic_inc(&timeout);
+		counter_atomic_inc(&timeout);
 		err = -ETIMEDOUT;
-	} else if (!atomic_read(&errors) && !atomic_read(&warnings)) {
+	} else if (!counter_atomic_read(&errors) &&
+		   !counter_atomic_read(&warnings)) {
 		pr_info("completed successfully\n");
 		return 0;
 	}
@@ -271,12 +273,13 @@ static int __init test_async_probe_init(void)
 	 * errors or warnings being reported by the probe routine.
 	 */
 	if (err)
-		atomic_inc(&errors);
+		counter_atomic_inc(&errors);
 	else
 		err = -EINVAL;
 
 	pr_err("Test failed with %d errors and %d warnings\n",
-	       atomic_read(&errors), atomic_read(&warnings));
+	       counter_atomic_read(&errors),
+	       counter_atomic_read(&warnings));
 
 	return err;
 }
-- 
2.25.1

