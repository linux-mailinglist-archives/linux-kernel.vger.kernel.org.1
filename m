Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753C2F7A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbhAOMvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733285AbhAOMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:51:35 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D8C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:55 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n2so692198iom.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbNcO1PxaEFCNLiObWORAHVRJjozk9n2oBP+T8k1g7Q=;
        b=kHE3h/6fYs9voS8QaFVlcBTH2loV7DSRwxyrPKKa6qHDSqUTx6BQum0C/gIP+aFMCi
         UohHy7QciVDcznmwhsIlqP8YKoKP3JcAGIibl3enA1nM2KhpRcU+FMN3etn8SfocCkbf
         bao+DMqKK33hge7kMKfBYZDQCJ91t60N9eGeGUH08K+i9CvdG+xtAZ8EahT9ea2EihZa
         MBv52Dq6/nbFmvBRKWWuLisM5hhbL8KLypgStfvfuOyFpzlh7MDvF6RBC5FEFJMLcDXZ
         Gc5nqdhGjwmGZfrmQoiP49yQFCBG2/goy6VRiGDQ+Fy5tXeDo2rpXMNGAr8gJl00AqbD
         EhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbNcO1PxaEFCNLiObWORAHVRJjozk9n2oBP+T8k1g7Q=;
        b=B6ZlKqD7JrOByxnO2yRVxUPqbND4iZYgMah6cLupOrv/wR8nlfpzL+qPu/3l7dH+dD
         BdEqAexFpIxxwQN7XCdVvzARuvyTbEheSCcw2daypUru1YX4Jn/tBcBgeN9+cyrJc4mQ
         XzRUbQEPRteWbMu+1Mvgkf8OTD2GbgX4JSYlBKS0McWDczmhc4YxNTVCFNMIRpqmouP/
         5i7P5SlVjDApqpKwmGwz0XIDWnRdK0hUVV22PSbKbPD6L0nCgkGL/5DQ6dVqFZPaR0cl
         xyJJMGhyplQDZXi2L6pTlKFpPj4mWbsS1O2EEhtSz/mTi8kDU9Jw2iH0CxaBW6PS87qg
         LeoQ==
X-Gm-Message-State: AOAM5332w6hHL6DCbPlwplz4he5aSoo/Aa90cqXZTV7UCO0Dz7qWqyMM
        u9EvAd4J5TtDCpboaqOyFEhLNpd4CHLRBA==
X-Google-Smtp-Source: ABdhPJy+u7fmCI/QSaPChjJHvw3zP1P3ZKzdLE7VtD32HfHmMNYT5OYQXkBmmih5xKimlu9JCj6FQQ==
X-Received: by 2002:a6b:8d91:: with SMTP id p139mr8464723iod.96.1610715054774;
        Fri, 15 Jan 2021 04:50:54 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f13sm3952450iog.18.2021.01.15.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:50:54 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net: ipa: rename interconnect settings
Date:   Fri, 15 Jan 2021 06:50:44 -0600
Message-Id: <20210115125050.20555-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115125050.20555-1-elder@linaro.org>
References: <20210115125050.20555-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "bandwidth" rather than "rate" in describing the average and
peak values to use for IPA interconnects.  They should have been
named that way to begin with.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c       | 20 ++++++++++----------
 drivers/net/ipa/ipa_data-sc7180.c | 16 ++++++++--------
 drivers/net/ipa/ipa_data-sdm845.c | 16 ++++++++--------
 drivers/net/ipa/ipa_data.h        | 10 +++++-----
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 135c393437f12..459c357e09678 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -109,20 +109,20 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 	int ret;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_MEMORY];
-	ret = icc_set_bw(clock->memory_path, data->average_rate,
-			 data->peak_rate);
+	ret = icc_set_bw(clock->memory_path, data->average_bandwidth,
+			 data->peak_bandwidth);
 	if (ret)
 		return ret;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_IMEM];
-	ret = icc_set_bw(clock->imem_path, data->average_rate,
-			 data->peak_rate);
+	ret = icc_set_bw(clock->imem_path, data->average_bandwidth,
+			 data->peak_bandwidth);
 	if (ret)
 		goto err_memory_path_disable;
 
 	data = &clock->interconnect_data[IPA_INTERCONNECT_CONFIG];
-	ret = icc_set_bw(clock->config_path, data->average_rate,
-			 data->peak_rate);
+	ret = icc_set_bw(clock->config_path, data->average_bandwidth,
+			 data->peak_bandwidth);
 	if (ret)
 		goto err_imem_path_disable;
 
@@ -159,12 +159,12 @@ static int ipa_interconnect_disable(struct ipa *ipa)
 
 err_imem_path_reenable:
 	data = &clock->interconnect_data[IPA_INTERCONNECT_IMEM];
-	(void)icc_set_bw(clock->imem_path, data->average_rate,
-			 data->peak_rate);
+	(void)icc_set_bw(clock->imem_path, data->average_bandwidth,
+			 data->peak_bandwidth);
 err_memory_path_reenable:
 	data = &clock->interconnect_data[IPA_INTERCONNECT_MEMORY];
-	(void)icc_set_bw(clock->memory_path, data->average_rate,
-			 data->peak_rate);
+	(void)icc_set_bw(clock->memory_path, data->average_bandwidth,
+			 data->peak_bandwidth);
 
 	return ret;
 }
diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index 5cc0ed77edb9c..491572c0a34dc 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -311,20 +311,20 @@ static struct ipa_mem_data ipa_mem_data = {
 
 static struct ipa_clock_data ipa_clock_data = {
 	.core_clock_rate	= 100 * 1000 * 1000,	/* Hz */
-	/* Interconnect rates are in 1000 byte/second units */
+	/* Interconnect bandwidths are in 1000 byte/second units */
 	.interconnect = {
 		[IPA_INTERCONNECT_MEMORY] = {
-			.peak_rate	= 465000,	/* 465 MBps */
-			.average_rate	= 80000,	/* 80 MBps */
+			.peak_bandwidth		= 465000,	/* 465 MBps */
+			.average_bandwidth	= 80000,	/* 80 MBps */
 		},
-		/* Average rate is unused for the next two interconnects */
+		/* Average bandwidth unused for the next two interconnects */
 		[IPA_INTERCONNECT_IMEM] = {
-			.peak_rate	= 68570,	/* 68.570 MBps */
-			.average_rate	= 0,		/* unused */
+			.peak_bandwidth		= 68570,	/* 68.57 MBps */
+			.average_bandwidth	= 0,		/* unused */
 		},
 		[IPA_INTERCONNECT_CONFIG] = {
-			.peak_rate	= 30000,	/* 30 MBps */
-			.average_rate	= 0,		/* unused */
+			.peak_bandwidth		= 30000,	/* 30 MBps */
+			.average_bandwidth	= 0,		/* unused */
 		},
 	},
 };
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index f8fee8d3ca42a..c62b86171b929 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -331,20 +331,20 @@ static struct ipa_mem_data ipa_mem_data = {
 
 static struct ipa_clock_data ipa_clock_data = {
 	.core_clock_rate	= 75 * 1000 * 1000,	/* Hz */
-	/* Interconnect rates are in 1000 byte/second units */
+	/* Interconnect bandwidths are in 1000 byte/second units */
 	.interconnect = {
 		[IPA_INTERCONNECT_MEMORY] = {
-			.peak_rate	= 600000,	/* 600 MBps */
-			.average_rate	= 80000,	/* 80 MBps */
+			.peak_bandwidth		= 600000,	/* 600 MBps */
+			.average_bandwidth	= 80000,	/* 80 MBps */
 		},
-		/* Average rate is unused for the next two interconnects */
+		/* Average bandwidth unused for the next two interconnects */
 		[IPA_INTERCONNECT_IMEM] = {
-			.peak_rate	= 350000,	/* 350 MBps */
-			.average_rate	= 0,		/* unused */
+			.peak_bandwidth		= 350000,	/* 350 MBps */
+			.average_bandwidth	= 0,		/* unused */
 		},
 		[IPA_INTERCONNECT_CONFIG] = {
-			.peak_rate	= 40000,	/* 40 MBps */
-			.average_rate	= 0,		/* unused */
+			.peak_bandwidth		= 40000,	/* 40 MBps */
+			.average_bandwidth	= 0,		/* unused */
 		},
 	},
 };
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 0ed5ffe2b8da0..96a9771a6cc05 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -267,13 +267,13 @@ enum ipa_interconnect_id {
 };
 
 /**
- * struct ipa_interconnect_data - description of IPA interconnect rates
- * @peak_rate:		Peak interconnect bandwidth (in 1000 byte/sec units)
- * @average_rate:	Average interconnect bandwidth (in 1000 byte/sec units)
+ * struct ipa_interconnect_data - description of IPA interconnect bandwidths
+ * @peak_bandwidth:	Peak interconnect bandwidth (in 1000 byte/sec units)
+ * @average_bandwidth:	Average interconnect bandwidth (in 1000 byte/sec units)
  */
 struct ipa_interconnect_data {
-	u32 peak_rate;
-	u32 average_rate;
+	u32 peak_bandwidth;
+	u32 average_bandwidth;
 };
 
 /**
-- 
2.20.1

