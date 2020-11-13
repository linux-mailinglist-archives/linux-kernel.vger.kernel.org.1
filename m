Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF62B22FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgKMRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKMRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:44 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E2C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:44 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y17so9217934ilg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jfejap+8Du6797JcyNsOi4rRJRb08+4y2GV2+v6nu0s=;
        b=IuV8gkTO5CZpZfLPe00JA/img/sMGD2hPSw5r6J5oeG2t4j2ZLRXP/55DeRC1Qbk1Z
         on3JtCbn61GadUrBOIbZTTc1BiA04aEg+X5SI0vzOSYIIyhcEjgm7V/5e6SQy2INnwHE
         +MSLKTA0n1yS7nzG8fMjk0OKuJISuIqt66KTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jfejap+8Du6797JcyNsOi4rRJRb08+4y2GV2+v6nu0s=;
        b=tvCCEgAOUkEZ8kWDtD3xNNEHPUTPHDf6H/C602zbDFL/v2+wUAk/c+0RWdI4KNBbx/
         ojPDih9n4RmfG+KOo6VAPcHl2Ndbf/fubgui2mEE5tiBzRdesA2YLkORmOrLpVL6EEA9
         uo01tMLSybsD+Lpks7C9C/oBKedtkQEtf6E2E+zJ2vOb8X6HkGt4W0RMNf0jhGYU1eUt
         5TNbA5iBWVzRnSAoR06ATbMVvHXPHvZIEby/Pnk5QN5vZqYiK7bZqamwNEy/ruJziSUj
         Q/GGTrRpiPsf2HPINdsDnuNznB9WIQagja9fIJYg+z+QflWiFWETHWiJAVegWUF1yXJw
         LKKg==
X-Gm-Message-State: AOAM531gEw2VC/RHDexxe62JQIuKsrrF/5DRPGmQPaVPJx3N5yu/waBq
        e96ZTe7nFrYBfR+DENqqYGj+7Q==
X-Google-Smtp-Source: ABdhPJyZ0Z0BjU6Tdj/It/tBdXPQNbxJuI2xLWMLsJ5Sqmf/vaPNlTcbObOVzvqQVNnCHM4gXsZTug==
X-Received: by 2002:a92:c648:: with SMTP id 8mr796543ill.176.1605289598015;
        Fri, 13 Nov 2020 09:46:38 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:37 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] drivers/base/test/test_async_driver_probe: convert to use seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:07 -0700
Message-Id: <633b231ad210279f0a5af0508db016812c8da496.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

atomic_t variables used to count errors, warns, keep track of timeout,
and async completion are counters. Convert them to use seqnum32 and init
counters to 0.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/test/test_async_driver_probe.c | 28 +++++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 3bb7beb127a9..75a3b617dcac 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -14,11 +14,15 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <linux/seqnum_ops.h>
 
 #define TEST_PROBE_DELAY	(5 * 1000)	/* 5 sec */
 #define TEST_PROBE_THRESHOLD	(TEST_PROBE_DELAY / 2)
 
-static atomic_t warnings, errors, timeout, async_completed;
+static struct seqnum32 warnings = SEQNUM_INIT(0);
+static struct seqnum32 errors = SEQNUM_INIT(0);
+static struct seqnum32 timeout = SEQNUM_INIT(0);
+static struct seqnum32 async_completed = SEQNUM_INIT(0);
 
 static int test_probe(struct platform_device *pdev)
 {
@@ -29,9 +33,9 @@ static int test_probe(struct platform_device *pdev)
 	 * have then report it as an error, otherwise we wil sleep for the
 	 * required amount of time and then report completion.
 	 */
-	if (atomic_read(&timeout)) {
+	if (seqnum32_fetch(&timeout)) {
 		dev_err(dev, "async probe took too long\n");
-		atomic_inc(&errors);
+		seqnum32_inc_return(&errors);
 	} else {
 		dev_dbg(&pdev->dev, "sleeping for %d msecs in probe\n",
 			 TEST_PROBE_DELAY);
@@ -48,10 +52,10 @@ static int test_probe(struct platform_device *pdev)
 		    dev_to_node(dev) != numa_node_id()) {
 			dev_warn(dev, "NUMA node mismatch %d != %d\n",
 				 dev_to_node(dev), numa_node_id());
-			atomic_inc(&warnings);
+			seqnum32_inc_return(&warnings);
 		}
 
-		atomic_inc(&async_completed);
+		seqnum32_inc_return(&async_completed);
 	}
 
 	return 0;
@@ -244,11 +248,12 @@ static int __init test_async_probe_init(void)
 	 * Otherwise if they completed without errors or warnings then
 	 * report successful completion.
 	 */
-	if (atomic_read(&async_completed) != async_id) {
+	if (seqnum32_fetch(&async_completed) != async_id) {
 		pr_err("async events still pending, forcing timeout\n");
-		atomic_inc(&timeout);
+		seqnum32_inc_return(&timeout);
 		err = -ETIMEDOUT;
-	} else if (!atomic_read(&errors) && !atomic_read(&warnings)) {
+	} else if (!seqnum32_fetch(&errors) &&
+		   !seqnum32_fetch(&warnings)) {
 		pr_info("completed successfully\n");
 		return 0;
 	}
@@ -271,12 +276,13 @@ static int __init test_async_probe_init(void)
 	 * errors or warnings being reported by the probe routine.
 	 */
 	if (err)
-		atomic_inc(&errors);
+		seqnum32_inc_return(&errors);
 	else
 		err = -EINVAL;
 
-	pr_err("Test failed with %d errors and %d warnings\n",
-	       atomic_read(&errors), atomic_read(&warnings));
+	pr_err("Test failed with %u errors and %u warnings\n",
+	       seqnum32_fetch(&errors),
+	       seqnum32_fetch(&warnings));
 
 	return err;
 }
-- 
2.27.0

