Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E32D3225
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgLHS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:27:36 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD49C06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:26:55 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o4so12944906pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZ10jKt/VU4P+WkRFcr8BiC2hZqEj7kmS/7EIjji4+c=;
        b=vghb4gHFmjVXDo7WKWIoVXnZek/TQHSDSGRrfyWHnOJjvgVMy6HpMbbb9cgrO/nMMb
         gakFnEwhn6y39z96srWASisiLFUay/rdrNgzFjpA8K+ObGvSe/1X06x7udnGq7FHLV/V
         5rafYlf9RIU5kUoPxlZGq389z4CSQ5SNVsV/u6pDEJzZZvl082uc0boHVLwyhAPjo1Aq
         0Gpt/IHlHjojeGphARrB/N6zIqL5Wsxzsu5mt0k5ZL2xQdETU+C0wEiz56gpya1++EoQ
         PNNgNS8PZ/cWVh6zAkjDh41Xc8q7Sy4/XxlefIlUJL2F/hb6dqa/eSZiDd0w4foaiw8I
         2rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ10jKt/VU4P+WkRFcr8BiC2hZqEj7kmS/7EIjji4+c=;
        b=tvRdqwwSRE5qs8f1Ll2ql63pfeyDHcRjOyyfnzsXYJpMbsoZigmXwTxcw5uxQvX6+9
         5zS54v1PGANm1TnabSuVUM10OkC6HeSQHloqgM/TL9DEZF5v+JWm8g8fmiAjG1epV98e
         PlkD7cRVaAx38TtbxRds6ClbrJ1AQjb3dH/uxk6W9PITeXF5yTefcwf6f7QvYXrwO0mz
         Tn9JKWZw5VCa+QybkbRdI43KkPdBsPwld1SxHPVK5PMeb0UqgYIK//QEGHtHQY3H4pGt
         kpc+cyd4Mh6SSoXnq1TP7tG9PqtxP9jyGunXaQXZ+/MrMzRFmFyEOa7JnA4/Yl1jSRnW
         1NQQ==
X-Gm-Message-State: AOAM532cv5+/RW3LEijS9t7uMxdbUp902+ieHEoo1bd09lse6F540aMM
        oVgDSFYqyPGhnTibkyKLl7KviA==
X-Google-Smtp-Source: ABdhPJy3YFI6d0OJ9jpvrWbkSwCzMxiXdxpiixmFbfzbRslVda83xFK/b91lJg5q3RXVKII/FhJrjQ==
X-Received: by 2002:a63:170f:: with SMTP id x15mr8950248pgl.157.1607452015396;
        Tue, 08 Dec 2020 10:26:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id nm6sm3966801pjb.25.2020.12.08.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:26:54 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] coresight: remove broken __exit annotations
Date:   Tue,  8 Dec 2020 11:26:50 -0700
Message-Id: <20201208182651.1597945-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
References: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Functions that are annotated __exit are discarded for built-in drivers,
but the .remove callback in a device driver must still be kept around
to allow bind/unbind operations.

There is now a linker warning for the discarded symbol references:

`tmc_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tmc-core.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tmc-core.o
`tpiu_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tpiu.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tpiu.o
`etb_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-etb10.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-etb10.o
`static_funnel_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-funnel.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-funnel.o
`dynamic_funnel_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-funnel.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-funnel.o
`static_replicator_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-replicator.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-replicator.o
`dynamic_replicator_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-replicator.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-replicator.o
`catu_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-catu.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-catu.o

Remove all those annotations.

Fixes: 8b0cf82677d1 ("coresight: stm: Allow to build coresight-stm as a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-etb10.c      | 2 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 ++--
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
 drivers/hwtracing/coresight/coresight-funnel.c     | 6 +++---
 drivers/hwtracing/coresight/coresight-replicator.c | 6 +++---
 drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 99430f6cf5a5..a61313f320bd 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -567,7 +567,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int __exit catu_remove(struct amba_device *adev)
+static int catu_remove(struct amba_device *adev)
 {
 	struct catu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index d28eae93e55c..61dbc1afd8da 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -836,7 +836,7 @@ static void cti_device_release(struct device *dev)
 	if (drvdata->csdev_release)
 		drvdata->csdev_release(dev);
 }
-static int __exit cti_remove(struct amba_device *adev)
+static int cti_remove(struct amba_device *adev)
 {
 	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 1b320ab581ca..0cf6f0b947b6 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -803,7 +803,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int __exit etb_remove(struct amba_device *adev)
+static int etb_remove(struct amba_device *adev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 47f610b1c2b1..5bf5a5a4ce6d 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -902,14 +902,14 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static void __exit clear_etmdrvdata(void *info)
+static void clear_etmdrvdata(void *info)
 {
 	int cpu = *(int *)info;
 
 	etmdrvdata[cpu] = NULL;
 }
 
-static int __exit etm_remove(struct amba_device *adev)
+static int etm_remove(struct amba_device *adev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d78a37b6592c..3ad5c2a01033 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1575,14 +1575,14 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 	}
 };
 
-static void __exit clear_etmdrvdata(void *info)
+static void clear_etmdrvdata(void *info)
 {
 	int cpu = *(int *)info;
 
 	etmdrvdata[cpu] = NULL;
 }
 
-static int __exit etm4_remove(struct amba_device *adev)
+static int etm4_remove(struct amba_device *adev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 39be46b74dfe..071c723227db 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -274,7 +274,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	return ret;
 }
 
-static int __exit funnel_remove(struct device *dev)
+static int funnel_remove(struct device *dev)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
 
@@ -328,7 +328,7 @@ static int static_funnel_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit static_funnel_remove(struct platform_device *pdev)
+static int static_funnel_remove(struct platform_device *pdev)
 {
 	funnel_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -370,7 +370,7 @@ static int dynamic_funnel_probe(struct amba_device *adev,
 	return funnel_probe(&adev->dev, &adev->res);
 }
 
-static int __exit dynamic_funnel_remove(struct amba_device *adev)
+static int dynamic_funnel_remove(struct amba_device *adev)
 {
 	return funnel_remove(&adev->dev);
 }
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 6772f23e5c4b..7e2a2b7f503f 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -291,7 +291,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	return ret;
 }
 
-static int __exit replicator_remove(struct device *dev)
+static int replicator_remove(struct device *dev)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
 
@@ -318,7 +318,7 @@ static int static_replicator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit static_replicator_remove(struct platform_device *pdev)
+static int static_replicator_remove(struct platform_device *pdev)
 {
 	replicator_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -388,7 +388,7 @@ static int dynamic_replicator_probe(struct amba_device *adev,
 	return replicator_probe(&adev->dev, &adev->res);
 }
 
-static int __exit dynamic_replicator_remove(struct amba_device *adev)
+static int dynamic_replicator_remove(struct amba_device *adev)
 {
 	return replicator_remove(&adev->dev);
 }
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 32d29704206b..99791773f682 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -951,7 +951,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int __exit stm_remove(struct amba_device *adev)
+static int stm_remove(struct amba_device *adev)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 5653e0945c74..8169dff5a9f6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -559,7 +559,7 @@ static void tmc_shutdown(struct amba_device *adev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
-static int __exit tmc_remove(struct amba_device *adev)
+static int tmc_remove(struct amba_device *adev)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 010762a46087..d5dfee9ee556 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -173,7 +173,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR(drvdata->csdev);
 }
 
-static int __exit tpiu_remove(struct amba_device *adev)
+static int tpiu_remove(struct amba_device *adev)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
-- 
2.25.1

