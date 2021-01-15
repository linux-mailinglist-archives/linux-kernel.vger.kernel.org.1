Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5922F7A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbhAOMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbhAOMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:52:16 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B3C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:59 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id w18so17884776iot.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfRJBAuwxkFe9MRJG/5cSKWNhxAuQvwcEflUN1LY3nE=;
        b=UnfYX33Fna0JZ/2Df+rkQOYbUBXHbLOe8AFwOyVCwgCfPnskCF5080GcDYg5UZqMic
         ppKwX00Z2MdsoiuYJtLOhzQY16GUJTypFje5NeApz+kBNwtIn7Gg349lFfLi+a9pUF/Y
         0OtqPCHdH6S+gO0OojIYHXJWx8JS2jYO0Xv5phbiyhFhUw385Gl482XLLyP8LQbqKQ7T
         sKaQuxgblQwscKM70rwBneOmSF+WPL6FTkxT6d/ZffHk1QSybC9aLbgOopYjEcGxn/+j
         6fAub15nhCmX4Qsenh1QABpwW+NJfe+Lj1x0fjnenIkYKzkYbmJERdIt+LNPJN5biOnR
         elQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfRJBAuwxkFe9MRJG/5cSKWNhxAuQvwcEflUN1LY3nE=;
        b=I2cZrEghuLFBQBMFiQmTvRwDA4RlOevYVtfEroNlnlQCOJVxrYZtvpDZSdiYZQR0Vx
         G/Aqh2L40aORVt1UiH30Nk7rQGzWPbB88eRnR2FL5zlPzbtwCcwZLjqUwef/W0Tz5PA7
         slpxd38fotjQRZn1HUfQSDGV93uvHTjG76bv5V7sx5iTk2VpXiytzTBlKw172gCTvAVc
         GZi3BduH3h+Lo2UAbhly+z6/W9iwv5EFjfLqti7ajyuWobRJuFUMBYXuGsgFi46pYinR
         bKkRwQ02wgK1etL+2vHb8mcXLOGSkRGz6n5j77/B9yue+C8KoggjMYM8Tkg10FHY/m7o
         J7BA==
X-Gm-Message-State: AOAM530I0tPzcIWfkjA71gFLqswCii7RVBaR8M2vqdJ6Lp6MhvEyQQfr
        rBZfamtHyUsDAuffrrc7GjZ3Lg==
X-Google-Smtp-Source: ABdhPJwmvXu2xJbc3vh8OWCqcuGwIKYln30n3CyDkyqZpDfqYIrkReZzvZbd1wGqAqjOxt3bao6Xwg==
X-Received: by 2002:a92:154f:: with SMTP id v76mr10637337ilk.272.1610715058829;
        Fri, 15 Jan 2021 04:50:58 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f13sm3952450iog.18.2021.01.15.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:50:58 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: ipa: add interconnect name to configuration data
Date:   Fri, 15 Jan 2021 06:50:48 -0600
Message-Id: <20210115125050.20555-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115125050.20555-1-elder@linaro.org>
References: <20210115125050.20555-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the name to the configuration data for each interconnect.  Use
this information rather than a constant string during initialization.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c       | 6 +++---
 drivers/net/ipa/ipa_data-sc7180.c | 3 +++
 drivers/net/ipa/ipa_data-sdm845.c | 3 +++
 drivers/net/ipa/ipa_data.h        | 2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 537c72b5267f6..07069dbc6d033 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -76,7 +76,7 @@ static int ipa_interconnect_init(struct ipa_clock *clock, struct device *dev,
 	struct ipa_interconnect *interconnect;
 	struct icc_path *path;
 
-	path = ipa_interconnect_init_one(dev, "memory");
+	path = ipa_interconnect_init_one(dev, data->name);
 	if (IS_ERR(path))
 		goto err_return;
 	interconnect = &clock->interconnect[IPA_INTERCONNECT_MEMORY];
@@ -85,7 +85,7 @@ static int ipa_interconnect_init(struct ipa_clock *clock, struct device *dev,
 	interconnect->peak_bandwidth = data->peak_bandwidth;
 	data++;
 
-	path = ipa_interconnect_init_one(dev, "imem");
+	path = ipa_interconnect_init_one(dev, data->name);
 	if (IS_ERR(path))
 		goto err_memory_path_put;
 	interconnect = &clock->interconnect[IPA_INTERCONNECT_IMEM];
@@ -94,7 +94,7 @@ static int ipa_interconnect_init(struct ipa_clock *clock, struct device *dev,
 	interconnect->peak_bandwidth = data->peak_bandwidth;
 	data++;
 
-	path = ipa_interconnect_init_one(dev, "config");
+	path = ipa_interconnect_init_one(dev, data->name);
 	if (IS_ERR(path))
 		goto err_imem_path_put;
 	interconnect = &clock->interconnect[IPA_INTERCONNECT_CONFIG];
diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index 491572c0a34dc..1936ecb4c1104 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -314,15 +314,18 @@ static struct ipa_clock_data ipa_clock_data = {
 	/* Interconnect bandwidths are in 1000 byte/second units */
 	.interconnect = {
 		[IPA_INTERCONNECT_MEMORY] = {
+			.name			= "memory",
 			.peak_bandwidth		= 465000,	/* 465 MBps */
 			.average_bandwidth	= 80000,	/* 80 MBps */
 		},
 		/* Average bandwidth unused for the next two interconnects */
 		[IPA_INTERCONNECT_IMEM] = {
+			.name			= "imem",
 			.peak_bandwidth		= 68570,	/* 68.57 MBps */
 			.average_bandwidth	= 0,		/* unused */
 		},
 		[IPA_INTERCONNECT_CONFIG] = {
+			.name			= "config",
 			.peak_bandwidth		= 30000,	/* 30 MBps */
 			.average_bandwidth	= 0,		/* unused */
 		},
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index c62b86171b929..3b556b5a63406 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -334,15 +334,18 @@ static struct ipa_clock_data ipa_clock_data = {
 	/* Interconnect bandwidths are in 1000 byte/second units */
 	.interconnect = {
 		[IPA_INTERCONNECT_MEMORY] = {
+			.name			= "memory",
 			.peak_bandwidth		= 600000,	/* 600 MBps */
 			.average_bandwidth	= 80000,	/* 80 MBps */
 		},
 		/* Average bandwidth unused for the next two interconnects */
 		[IPA_INTERCONNECT_IMEM] = {
+			.name			= "imem",
 			.peak_bandwidth		= 350000,	/* 350 MBps */
 			.average_bandwidth	= 0,		/* unused */
 		},
 		[IPA_INTERCONNECT_CONFIG] = {
+			.name			= "config",
 			.peak_bandwidth		= 40000,	/* 40 MBps */
 			.average_bandwidth	= 0,		/* unused */
 		},
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 96a9771a6cc05..d8ea6266dc6a1 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -268,10 +268,12 @@ enum ipa_interconnect_id {
 
 /**
  * struct ipa_interconnect_data - description of IPA interconnect bandwidths
+ * @name:		Interconnect name (matches interconnect-name in DT)
  * @peak_bandwidth:	Peak interconnect bandwidth (in 1000 byte/sec units)
  * @average_bandwidth:	Average interconnect bandwidth (in 1000 byte/sec units)
  */
 struct ipa_interconnect_data {
+	const char *name;
 	u32 peak_bandwidth;
 	u32 average_bandwidth;
 };
-- 
2.20.1

