Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DA72AE041
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgKJTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgKJTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:40 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E36C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:39 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id p10so13353924ile.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WgRvfWZtIIbrhN4z2kTeTI9w1lTyQBygp9mXnGSOPw=;
        b=fQcnAiHqDU4asvdCyGxe/c74Z+/7MqBn2bxanHqg4iEeEvgh91DSuLSL7iR0T0lEba
         r69nOhJpmYaOuxEsryAiy4xjqRStmJSG2mQFKVCiUxfNAB2HptWnfzfSA+l+/ATzVUZ2
         fDP7kFu/WXK3uGhsWlL5EKMLTJs5z/fqbyMio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WgRvfWZtIIbrhN4z2kTeTI9w1lTyQBygp9mXnGSOPw=;
        b=ApFzmsjRhQfmFgb460IfYveISsaUS2WZuReJcaNv2PdQkahtyljSJCOYq9kOPYVsph
         cGtZb56HrdiURNqYa/fZ9VLpQhlRPdsEc8yE2Y9NlhG0WEu8AQukKjgLJQh3GvFMSt+y
         6vApwOo0Oe4uZVopr/6+DB4A9qELbaG4lnbcY0f9UZIxJBk99SmUBCu6agvEO3/LeVx6
         zGI7qM0GNVs0sqfJ5zCiJlDqNRLTL/m74QN/iPIwk5SLxMziFEHqDFMoczwgKp9ljWmR
         yKogEkgSdqKk2RQ8jT2F4J17rwIzQ3XIeqzToblqOQTpVXC1MksjwJwEAWt1bapQrqr8
         LiFg==
X-Gm-Message-State: AOAM533hN2U5G3KmC2PTlfC9Fh/yEHspOioX2MTJ+gbnxYmXwG3wn4e7
        gqPy2FgFG+XmE3oEU5Md9H2xqg==
X-Google-Smtp-Source: ABdhPJw5QuHvqaFsf7o+OfJ/3Ulft+Hl7LLa5nNr5JuhZCQpbh/LI3JCNeA6xtgYeUkb8UR9mXgfQA==
X-Received: by 2002:a92:dc07:: with SMTP id t7mr8015890iln.189.1605038079086;
        Tue, 10 Nov 2020 11:54:39 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:38 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] drivers/base/test/test_async_driver_probe: convert to use seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:31 -0700
Message-Id: <afefc59cff147c1e85196447d349df5a8b3000b0.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used to count errors, warns, keep track of timeout,
and async completion are counters.

Unsure overflow is a concern for timeout and async completion, and there
are no checks for overflow to hold them to upper bounds. Overflow and
wrap around doesn't impact errors, and warns.

Convert them to use seqnum32 and init counters to 0. This conversion
doesn't change the overflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/test/test_async_driver_probe.c | 26 +++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 3bb7beb127a9..1886f79ec252 100644
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
+	if (seqnum32_read(&timeout)) {
 		dev_err(dev, "async probe took too long\n");
-		atomic_inc(&errors);
+		seqnum32_inc(&errors);
 	} else {
 		dev_dbg(&pdev->dev, "sleeping for %d msecs in probe\n",
 			 TEST_PROBE_DELAY);
@@ -48,10 +52,10 @@ static int test_probe(struct platform_device *pdev)
 		    dev_to_node(dev) != numa_node_id()) {
 			dev_warn(dev, "NUMA node mismatch %d != %d\n",
 				 dev_to_node(dev), numa_node_id());
-			atomic_inc(&warnings);
+			seqnum32_inc(&warnings);
 		}
 
-		atomic_inc(&async_completed);
+		seqnum32_inc(&async_completed);
 	}
 
 	return 0;
@@ -244,11 +248,12 @@ static int __init test_async_probe_init(void)
 	 * Otherwise if they completed without errors or warnings then
 	 * report successful completion.
 	 */
-	if (atomic_read(&async_completed) != async_id) {
+	if (seqnum32_read(&async_completed) != async_id) {
 		pr_err("async events still pending, forcing timeout\n");
-		atomic_inc(&timeout);
+		seqnum32_inc(&timeout);
 		err = -ETIMEDOUT;
-	} else if (!atomic_read(&errors) && !atomic_read(&warnings)) {
+	} else if (!seqnum32_read(&errors) &&
+		   !seqnum32_read(&warnings)) {
 		pr_info("completed successfully\n");
 		return 0;
 	}
@@ -271,12 +276,13 @@ static int __init test_async_probe_init(void)
 	 * errors or warnings being reported by the probe routine.
 	 */
 	if (err)
-		atomic_inc(&errors);
+		seqnum32_inc(&errors);
 	else
 		err = -EINVAL;
 
 	pr_err("Test failed with %d errors and %d warnings\n",
-	       atomic_read(&errors), atomic_read(&warnings));
+	       seqnum32_read(&errors),
+	       seqnum32_read(&warnings));
 
 	return err;
 }
-- 
2.27.0

