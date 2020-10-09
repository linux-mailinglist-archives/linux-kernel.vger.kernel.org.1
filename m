Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E053288D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbgJIP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbgJIP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:56:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C217C0613E0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:56:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l4so9409976ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsijR83BOtB3z3hYiSoZUcuW4ksRnbxmTB+AVU77Gr0=;
        b=OT80Um1tgaD4/CbB6fRjJSeqEDPAx6viDvoLmrb8GboH4diPesAlFTxHMGtRk3Tuhb
         +Jc938Zco7PU3pOuwtVBC9MRs8ZqTUiL9eC2OiJRMyzQpC1NTyqPQhGEchh0vJBmnZdY
         bkghn5Lsl6dVR5inXnOZqD1VPb0Ud+QGGfO10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsijR83BOtB3z3hYiSoZUcuW4ksRnbxmTB+AVU77Gr0=;
        b=br2cOfe1DnZZdcGuFKMF8VCC/dbbsLcsUtYIUblmokIRMPwd7mzQDDLuv5F+yH7EFa
         x9zISjsgJ4GmKIpYsbQPvToTv5/3lml2nFvyKO9WyGFBruCr5NFRD2DfzcBPotj+GNOT
         8a9msbNAHurcnSwYHntPfG6//oOEIRf75KaWMmGlXfG17q1qoH3OOlKWU16FO8OfiUta
         7HZabuVZu31btpMAgV+fiLsCNWy8YzTaj9f1+3UelnbGffSkqqSPYzhlQFTseo700UPx
         a0TgiYjPmLU3dnP61ahZZSNOrdkxRvWN/eQ5NxCdBjpVgn6/AqB+JUtbzjosZurrVi8i
         MZCQ==
X-Gm-Message-State: AOAM53088yvpnF9TMwmrCzbcLsW+R9J6ooAIZbf1lXHaL1Sij0lvHdhV
        xCnJkjjL+iceCLqobMU0JMFXbg==
X-Google-Smtp-Source: ABdhPJzD4xm2KgDXLH6udWO9aTv5b4kesb/VjCDBQrFYNhvTdqn/QV2VnN0uyg64XXA3DT2oXnGDDA==
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr8778413ota.263.1602258979675;
        Fri, 09 Oct 2020 08:56:19 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:19 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] drivers/base/test/test_async_driver_probe: convert to use counter_atomic32
Date:   Fri,  9 Oct 2020 09:56:03 -0600
Message-Id: <f28994a12bff628ee0327b51f5bc75e3ec70e32e.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and open
counts that control state changes, and pm states.

atomic_t variables used to count errors, warns, keep track of timeout,
and async completion are counters.

Unsure overflow is a concern for timeout and async completion, and there
are no checks for overflow to hold them to upper bounds. Overflow and
wrap around doesn't impact errors, and warns.

Convert them to use counter_atomic32 and init counters to 0.

This conversion doesn't change the overflow wrap around behavior.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/test/test_async_driver_probe.c | 26 +++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 3bb7beb127a9..ccd65afb259d 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -14,11 +14,15 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <linux/counters.h>
 
 #define TEST_PROBE_DELAY	(5 * 1000)	/* 5 sec */
 #define TEST_PROBE_THRESHOLD	(TEST_PROBE_DELAY / 2)
 
-static atomic_t warnings, errors, timeout, async_completed;
+static struct counter_atomic32 warnings = COUNTER_ATOMIC_INIT(0);
+static struct counter_atomic32 errors = COUNTER_ATOMIC_INIT(0);
+static struct counter_atomic32 timeout = COUNTER_ATOMIC_INIT(0);
+static struct counter_atomic32 async_completed = COUNTER_ATOMIC_INIT(0);
 
 static int test_probe(struct platform_device *pdev)
 {
@@ -29,9 +33,9 @@ static int test_probe(struct platform_device *pdev)
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
@@ -48,10 +52,10 @@ static int test_probe(struct platform_device *pdev)
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
@@ -244,11 +248,12 @@ static int __init test_async_probe_init(void)
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
@@ -271,12 +276,13 @@ static int __init test_async_probe_init(void)
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

