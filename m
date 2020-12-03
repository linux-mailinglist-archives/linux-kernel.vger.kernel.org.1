Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E19E2CE270
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbgLCXNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgLCXNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:13:19 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] coresight: remove broken __exit annotations
Date:   Fri,  4 Dec 2020 00:11:40 +0100
Message-Id: <20201203231232.1482792-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
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
2.27.0

