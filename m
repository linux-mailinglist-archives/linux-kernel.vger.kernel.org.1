Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB84A26C9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgIPTkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCA4C061351
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so4483418pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMJpZJO+2jiFbj8wcLuUaO2zDrxZ7Y0vpl9oHvf3HWM=;
        b=GTGP5UbUl6DVcepsjEQDw63YIXpk6nBZ7o3Wei+3/VinKwNlvopmyWceSpRvUe513y
         wH11+u1eI7b7L37gaxadfb91MFPg4Sc6utEOff4kYaOIPde0MaDeNYgRqY8uvRf8r0rx
         PDfpcKzE4qWU3RDGFuvM+Y+TzfE+vu4ZngZ7G2KlSqrnwEUR4XSa+asd7pFJZji9aspX
         nsOtizA1EhA5ACB2S03hUAJB9AmUGzRuVfcShA9eAWAyWs0pTk1sd5lQtba8rOQIUMwb
         IQeHKFWje2GpFB7mYRT05BjXRNwDbzkLAp50VDqyycSMYuR3ZXdk7K7e/ImWhS3/nUEj
         qkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMJpZJO+2jiFbj8wcLuUaO2zDrxZ7Y0vpl9oHvf3HWM=;
        b=KOWydfR058/Ayjcqm9XuZnnE9eWFN5mKELXCoQLzzfCywAF/0XE/5DPmqb6HvbFh+e
         SBxgmn8qGwZv429TzeCgk0O7M9vOj0LGFpBqaMNcypDu02wo0qIEt9riIuART4d2NJ12
         U1FVSSA25uj9OVRl8ADuV55okuvTSQcDMle75c1fUBCSGTDa9QgcOIADOop5fI5fIwmF
         tkY2heryng9YG8cxqK7xrkxrwFJyl7Zzhay1zjYVLc/KIxBMBNu/h10OvtRvPegHRlDb
         Cvh6CEpNNoqWqq4TelUXS0bec5s/akYwVGL9NDRIM+FceKQ0rQm7baIM85E3V3/fhFkY
         OziA==
X-Gm-Message-State: AOAM533UV42IaQZvQQVUxt2phPwt2pphvb9TmPpXr2i8F6jE369r7eyr
        qPe2f/DiV2geZrgLXUfpJ8lFUA==
X-Google-Smtp-Source: ABdhPJzWt/qy7GvIwMAy8Zb248zpCpwAEUbHaVHNwAuqZd34yzLd+Cg/+m/JJ7VA+j9Hav+2Y7ZQcg==
X-Received: by 2002:a62:7f13:0:b029:13e:d13d:a087 with SMTP id a19-20020a627f130000b029013ed13da087mr23721856pfd.30.1600283867426;
        Wed, 16 Sep 2020 12:17:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] coresight: etm4x: Ensure default perf settings filter user/kernel
Date:   Wed, 16 Sep 2020 13:17:28 -0600
Message-Id: <20200916191737.4001561-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Moving from using an address filter to trace the default "all addresses"
range to no filtering to acheive the same result, has caused the perf
filtering of kernel/user address spaces from not working unless an
explicit address filter was used.

This is due to the original code using a side-effect of the address
filtering rather than setting the global TRCVICTLR exception level
filtering.

The use of the mode sysfs file is also similarly affected.

A helper function is added to fix both instances.

Fixes: ae2041510d5d ("coresight: etmv4: Update default filter and initialisation")
Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 32 +++++++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index f027ceed9793..63cb1e0d5953 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -52,6 +52,7 @@ static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
 static void etm4_set_default_config(struct etmv4_config *config);
 static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 				  struct perf_event *event);
+static u64 etm4_get_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
@@ -783,6 +784,22 @@ static void etm4_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
+/* Set ELx trace filter access in the TRCVICTLR register */
+static void etm4_set_victlr_access(struct etmv4_config *config)
+{
+	u64 access_type;
+
+	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK | ETM_EXLEVEL_NS_VICTLR_MASK);
+
+	/*
+	 * TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering
+	 * bits in vinst_ctrl, same bit pattern as TRCACATRn values returned by
+	 * etm4_get_access_type() but with a relative shift in this register.
+	 */
+	access_type = etm4_get_access_type(config) << ETM_EXLEVEL_LSHIFT_TRCVICTLR;
+	config->vinst_ctrl |= (u32)access_type;
+}
+
 static void etm4_set_default_config(struct etmv4_config *config)
 {
 	/* disable all events tracing */
@@ -800,6 +817,9 @@ static void etm4_set_default_config(struct etmv4_config *config)
 
 	/* TRCVICTLR::EVENT = 0x01, select the always on logic */
 	config->vinst_ctrl = BIT(0);
+
+	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
+	etm4_set_victlr_access(config);
 }
 
 static u64 etm4_get_ns_access_type(struct etmv4_config *config)
@@ -1064,7 +1084,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 
 void etm4_config_trace_mode(struct etmv4_config *config)
 {
-	u32 addr_acc, mode;
+	u32 mode;
 
 	mode = config->mode;
 	mode &= (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER);
@@ -1076,15 +1096,7 @@ void etm4_config_trace_mode(struct etmv4_config *config)
 	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
 		return;
 
-	addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
-	/* clear default config */
-	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS |
-		      ETM_EXLEVEL_NS_HYP);
-
-	addr_acc |= etm4_get_ns_access_type(config);
-
-	config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
-	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
+	etm4_set_victlr_access(config);
 }
 
 static int etm4_online_cpu(unsigned int cpu)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b8283e1d6d88..5259f96fd28a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -192,6 +192,9 @@
 #define ETM_EXLEVEL_NS_HYP		BIT(14)
 #define ETM_EXLEVEL_NS_NA		BIT(15)
 
+/* access level control in TRCVICTLR - same bits as TRCACATRn but shifted */
+#define ETM_EXLEVEL_LSHIFT_TRCVICTLR	8
+
 /* secure / non secure masks - TRCVICTLR, IDR3 */
 #define ETM_EXLEVEL_S_VICTLR_MASK	GENMASK(19, 16)
 /* NS MON (EL3) mode never implemented */
-- 
2.25.1

