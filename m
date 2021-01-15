Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4192F7AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbhAOMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbhAOMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:52:15 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF241C061799
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:57 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q2so16180581iow.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQTzRspM7VOhdUIB2fwWrTYFwF0pu0m+N8Hr60ecngE=;
        b=Sxp5q9+tUNocZDVR4IqjOqJl4SlFzviVO/ta9XLDo5muhYQjwAYGKs6k/H7hsBHiPE
         4ePYTEmvbATf65HrnVhuUygPsKz8PBROu+J2ihbq2isU+nBoY5c5gVs60xCQqR4kLj/L
         DSVd+zcUSzRENq2/ZdGS4tzTGw+g6MTGtdEZpG0bY/7gV5EjVskYvrI0+/+oa4myKMBW
         b5QeBfZQveo3uNdiW6Phnhj8REONXbs9BPJWm4sYVqvICR8FP0dlv+NQnbzhdsivgJJM
         1Qcm0//A5rVuJ79Aju7yfJ2UXZ5JgA0bIPIR5P2mCEdd4Luqp6KjlhqIed6lPCM+UelB
         iY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQTzRspM7VOhdUIB2fwWrTYFwF0pu0m+N8Hr60ecngE=;
        b=joKoP97zEcdLwamMTzqZ5poEkr3VjuVeYlMGirtoKoZ42NAV9K12fmspyjYeJJwzO5
         5H3rdg3+MvtJY6o69UyihQPL29/5Gtcp9vMX+xUm70MnfQpQFIQ03sVtv8lQfZefOYpe
         sA6K5FvmkIgOFtvI9UzN4U9ixOZDmSTBgS6NT7DlXFd+uMyozu5CJfd/XBQrCQ1H2zni
         JOLUdBc1ulylB+HODrYkW3QZhOWE9wlxe6vCPlp3kafHV336PcKU3xqrHNV6fDFmgYtw
         qdwH4rLvc5flG1iLtZc6MaeRCiM7LsOJIjJ5rvQWT1UqShhhAzlj/gVLEaaIxwrz3xNA
         d/YA==
X-Gm-Message-State: AOAM532q0XzgsxKHlWsFaX6M7WC+Olpv/vUMpmKc4MwUFTDmHWGYfadU
        F27Zu0xqyERfF9sFar4R7uDH5A==
X-Google-Smtp-Source: ABdhPJzSFWy24nk1ZQwQbQLbJazmN++tIF1Yc5MSswRqeotsaK8b3A043Hl7i3keKRQb7H6ofJvmpQ==
X-Received: by 2002:a02:23ce:: with SMTP id u197mr10176639jau.113.1610715056857;
        Fri, 15 Jan 2021 04:50:56 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f13sm3952450iog.18.2021.01.15.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:50:56 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: ipa: introduce an IPA interconnect structure
Date:   Fri, 15 Jan 2021 06:50:46 -0600
Message-Id: <20210115125050.20555-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115125050.20555-1-elder@linaro.org>
References: <20210115125050.20555-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having separate pointers for the memory, imem, and
config interconnect paths, maintain an array of ipa_interconnect
structures each of which contains a pointer to a path.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 59 +++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index baedb481fe824..2bf5af6823d8c 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -30,23 +30,27 @@
  * An IPA clock reference must be held for any access to IPA hardware.
  */
 
+/**
+ * struct ipa_interconnect - IPA interconnect information
+ * @path:		Interconnect path
+ */
+struct ipa_interconnect {
+	struct icc_path *path;
+};
+
 /**
  * struct ipa_clock - IPA clocking information
  * @count:		Clocking reference count
  * @mutex:		Protects clock enable/disable
  * @core:		IPA core clock
- * @memory_path:	Memory interconnect
- * @imem_path:		Internal memory interconnect
- * @config_path:	Configuration space interconnect
+ * @interconnect:	Interconnect array
  * @interconnect_data:	Interconnect configuration data
  */
 struct ipa_clock {
 	refcount_t count;
 	struct mutex mutex; /* protects clock enable/disable */
 	struct clk *core;
-	struct icc_path *memory_path;
-	struct icc_path *imem_path;
-	struct icc_path *config_path;
+	struct ipa_interconnect *interconnect[IPA_INTERCONNECT_COUNT];
 	const struct ipa_interconnect_data *interconnect_data;
 };
 
@@ -71,24 +75,24 @@ static int ipa_interconnect_init(struct ipa_clock *clock, struct device *dev)
 	path = ipa_interconnect_init_one(dev, "memory");
 	if (IS_ERR(path))
 		goto err_return;
-	clock->memory_path = path;
+	clock->interconnect[IPA_INTERCONNECT_MEMORY]->path = path;
 
 	path = ipa_interconnect_init_one(dev, "imem");
 	if (IS_ERR(path))
 		goto err_memory_path_put;
-	clock->imem_path = path;
+	clock->interconnect[IPA_INTERCONNECT_IMEM]->path = path;
 
 	path = ipa_interconnect_init_one(dev, "config");
 	if (IS_ERR(path))
 		goto err_imem_path_put;
-	clock->config_path = path;
+	clock->interconnect[IPA_INTERCONNECT_CONFIG]->path = path;
 
 	return 0;
 
 err_imem_path_put:
-	icc_put(clock->imem_path);
+	icc_put(clock->interconnect[IPA_INTERCONNECT_IMEM]->path);
 err_memory_path_put:
-	icc_put(clock->memory_path);
+	icc_put(clock->interconnect[IPA_INTERCONNECT_MEMORY]->path);
 err_return:
 	return PTR_ERR(path);
 }
@@ -96,9 +100,9 @@ static int ipa_interconnect_init(struct ipa_clock *clock, struct device *dev)
 /* Inverse of ipa_interconnect_init() */
 static void ipa_interconnect_exit(struct ipa_clock *clock)
 {
-	icc_put(clock->config_path);
-	icc_put(clock->imem_path);
-	icc_put(clock->memory_path);
+	icc_put(clock->interconnect[IPA_INTERCONNECT_CONFIG]->path);
+	icc_put(clock->interconnect[IPA_INTERCONNECT_IMEM]->path);
+	icc_put(clock->interconnect[IPA_INTERCONNECT_MEMORY]->path);
 }
 
 /* Currently we only use one bandwidth level, so just "enable" interconnects */
@@ -109,29 +113,31 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 	int ret;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_MEMORY];
-	ret = icc_set_bw(clock->memory_path, data->average_bandwidth,
-			 data->peak_bandwidth);
+	ret = icc_set_bw(clock->interconnect[IPA_INTERCONNECT_MEMORY]->path,
+			 data->average_bandwidth, data->peak_bandwidth);
 	if (ret)
 		return ret;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_IMEM];
-	ret = icc_set_bw(clock->imem_path, data->average_bandwidth,
-			 data->peak_bandwidth);
+	ret = icc_set_bw(clock->interconnect[IPA_INTERCONNECT_IMEM]->path,
+			 data->average_bandwidth, data->peak_bandwidth);
 	if (ret)
 		goto err_memory_path_disable;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_CONFIG];
-	ret = icc_set_bw(clock->config_path, data->average_bandwidth,
-			 data->peak_bandwidth);
+	ret = icc_set_bw(clock->interconnect[IPA_INTERCONNECT_CONFIG]->path,
+			 data->average_bandwidth, data->peak_bandwidth);
 	if (ret)
 		goto err_imem_path_disable;
 
 	return 0;
 
 err_imem_path_disable:
-	(void)icc_set_bw(clock->imem_path, 0, 0);
+	(void)icc_set_bw(clock->interconnect[IPA_INTERCONNECT_IMEM]->path,
+			 0, 0);
 err_memory_path_disable:
-	(void)icc_set_bw(clock->memory_path, 0, 0);
+	(void)icc_set_bw(clock->interconnect[IPA_INTERCONNECT_MEMORY]->path,
+			 0, 0);
 
 	return ret;
 }
@@ -143,15 +149,18 @@ static void ipa_interconnect_disable(struct ipa *ipa)
 	int result = 0;
 	int ret;
 
-	ret = icc_set_bw(clock->memory_path, 0, 0);
+	ret = icc_set_bw(clock->interconnect[IPA_INTERCONNECT_MEMORY]->path,
+			 0, 0);
 	if (ret)
 		result = ret;
 
-	ret = icc_set_bw(clock->imem_path, 0, 0);
+	ret = icc_set_bw(clock->interconnect[IPA_INTERCONNECT_IMEM]->path,
+			 0, 0);
 	if (ret && !result)
 		result = ret;
 
-	ret = icc_set_bw(clock->config_path, 0, 0);
+	ret = icc_set_bw(clock->interconnect[IPA_INTERCONNECT_CONFIG]->path,
+			 0, 0);
 	if (ret && !result)
 		result = ret;
 
-- 
2.20.1

