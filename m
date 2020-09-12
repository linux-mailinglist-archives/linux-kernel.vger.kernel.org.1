Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808802676F2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgILAsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgILApt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:45:49 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C902C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:45:41 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id s88so296103ilb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vovszmszeTX3/fYMq/yEC/8V2nM1of8JQPOPUdTofb0=;
        b=IkL89XVUEnh3Zuv9T+7VES56Y4g9Nw3dq5ZpAcRuwDOu/KUDNKe4aYXujKA7jTmmAb
         r1jhSlm96K9YZuUq+LQA44kzLSQl7zf1zCQBeGmJpnOOu9IChQFJhOQ6RBqCJybFidzV
         IF0RbfQU5oMXmaLeWqNd1PfqOwIvMUDenKgaCewWeYR2moUqv/Yl6rUq3T/0iUtpxTXn
         rqNeRxgR+B8rZ+tAuxoT+CeWfHqnFi9SEhw/L4aXEMRKFYrweKsYSYfBryWz47M2/8Vj
         wh0GQ5mF9VsQlGWsbom8BgBSQkC08uOcSMSTPvy+dVzrcfhp1d02wJAM53j+F1YxHbpM
         JERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vovszmszeTX3/fYMq/yEC/8V2nM1of8JQPOPUdTofb0=;
        b=iiyGt6bPTkumx8t2A/v542WWTyQezCWnmTkT9O2kTVpUgpaSshJAClU97vn9n2ye6z
         9YJmzmomHDDxgI9eTSJmulgbcGhmr4nVSRnP3xaw7r1UGer9Q4sR2nCVHHGykCg5MTJs
         ZKWQH7J1AYApa+7X6udns2XSxZGr1UZoYvJZ/OK8m4brlppF9i5LW0wV1PyGb5Yf1x/5
         GDWXINV1CpcyNSLpeIOAG8vbZf7GMwMkAIGisIXiLCI2Vo/E22Nueoe42uvtl9tRmmKo
         YvRoYG7QnU17b1HpmspiUA0b5NCb3++Rjk9kbLxarKZzsMRe/XHydqgUWsTbPOSef7N2
         ptIQ==
X-Gm-Message-State: AOAM531nqQhQ9yOHtx7ISu1BVCcwm0NFiHuiIrg+3QCN7z6PAegEQqjM
        37ap/pyGn/v5eqVVgroNAgWimA==
X-Google-Smtp-Source: ABdhPJw7ouPSR52LoQS1AU8cajuYQV2MjwfZf3AcIzs8KTrivKmMvEm4a8klzXrH5kp2ebMg0qDeYQ==
X-Received: by 2002:a92:ba44:: with SMTP id o65mr4105148ili.255.1599871539593;
        Fri, 11 Sep 2020 17:45:39 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z4sm2107807ilh.45.2020.09.11.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 17:45:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/7] net: ipa: manage endpoints separate from clock
Date:   Fri, 11 Sep 2020 19:45:29 -0500
Message-Id: <20200912004532.1386-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200912004532.1386-1-elder@linaro.org>
References: <20200912004532.1386-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when (before) the last IPA clock reference is dropped,
all endpoints are suspended.  And whenever the first IPA clock
reference is taken, all endpoints are resumed (or started).

In most cases there's no need to start endpoints when the clock
starts.  So move the calls to ipa_endpoint_suspend() and
ipa_endpoint_resume() out of ipa_clock_put() and ipa_clock_get(),
respectiely.  Instead, only suspend endpoints when handling a system
suspend, and only resume endpoints when handling a system resume.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 14 ++++----------
 drivers/net/ipa/ipa_main.c  |  8 ++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index b703866f2e20b..a2c0fde058199 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -200,9 +200,8 @@ bool ipa_clock_get_additional(struct ipa *ipa)
 
 /* Get an IPA clock reference.  If the reference count is non-zero, it is
  * incremented and return is immediate.  Otherwise it is checked again
- * under protection of the mutex, and if appropriate the clock (and
- * interconnects) are enabled suspended endpoints (if any) are resumed
- * before returning.
+ * under protection of the mutex, and if appropriate the IPA clock
+ * is enabled.
  *
  * Incrementing the reference count is intentionally deferred until
  * after the clock is running and endpoints are resumed.
@@ -229,17 +228,14 @@ void ipa_clock_get(struct ipa *ipa)
 		goto out_mutex_unlock;
 	}
 
-	ipa_endpoint_resume(ipa);
-
 	refcount_set(&clock->count, 1);
 
 out_mutex_unlock:
 	mutex_unlock(&clock->mutex);
 }
 
-/* Attempt to remove an IPA clock reference.  If this represents the last
- * reference, suspend endpoints and disable the clock (and interconnects)
- * under protection of a mutex.
+/* Attempt to remove an IPA clock reference.  If this represents the
+ * last reference, disable the IPA clock under protection of the mutex.
  */
 void ipa_clock_put(struct ipa *ipa)
 {
@@ -249,8 +245,6 @@ void ipa_clock_put(struct ipa *ipa)
 	if (!refcount_dec_and_mutex_lock(&clock->count, &clock->mutex))
 		return;
 
-	ipa_endpoint_suspend(ipa);
-
 	ipa_clock_disable(ipa);
 
 	mutex_unlock(&clock->mutex);
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index cfdf60ded86ca..3b68b53c99015 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -913,11 +913,15 @@ static int ipa_remove(struct platform_device *pdev)
  * Return:	Always returns zero
  *
  * Called by the PM framework when a system suspend operation is invoked.
+ * Suspends endpoints and releases the clock reference held to keep
+ * the IPA clock running until this point.
  */
 static int ipa_suspend(struct device *dev)
 {
 	struct ipa *ipa = dev_get_drvdata(dev);
 
+	ipa_endpoint_suspend(ipa);
+
 	ipa_clock_put(ipa);
 	if (!test_and_clear_bit(IPA_FLAG_CLOCK_HELD, ipa->flags))
 		dev_err(dev, "suspend: missing suspend clock reference\n");
@@ -932,6 +936,8 @@ static int ipa_suspend(struct device *dev)
  * Return:	Always returns 0
  *
  * Called by the PM framework when a system resume operation is invoked.
+ * Takes an IPA clock reference to keep the clock running until suspend,
+ * and resumes endpoints.
  */
 static int ipa_resume(struct device *dev)
 {
@@ -945,6 +951,8 @@ static int ipa_resume(struct device *dev)
 	else
 		dev_err(dev, "resume: duplicate suspend clock reference\n");
 
+	ipa_endpoint_resume(ipa);
+
 	return 0;
 }
 
-- 
2.20.1

