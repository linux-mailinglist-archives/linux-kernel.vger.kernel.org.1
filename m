Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799222B988B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgKSQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:10 -0500
Received: from foss.arm.com ([217.140.110.172]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgKSQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1932615DB;
        Thu, 19 Nov 2020 08:46:07 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F33FD3F719;
        Thu, 19 Nov 2020 08:46:05 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 04/25] coresight: tpiu: Prepare for using coresight device access abstraction
Date:   Thu, 19 Nov 2020 16:45:26 +0000
Message-Id: <20201119164547.2982871-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119164547.2982871-1-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the TPIU driver to make use of the CoreSight device access
abstraction layer. The driver touches the device even before the
coresight device is registered. Thus we could be accessing the
devices without a csdev. As we are about to use the abstraction
layer for accessing the device, pass in the access directly
to avoid having to deal with the un-initialised csdev.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 30 +++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index dfa3b91d0281..98c4a029854c 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -60,49 +60,45 @@ struct tpiu_drvdata {
 	struct coresight_device	*csdev;
 };
 
-static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
+static void tpiu_enable_hw(struct csdev_access *csa)
 {
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(csa->base);
 
 	/* TODO: fill this up */
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(csa->base);
 }
 
 static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	tpiu_enable_hw(drvdata);
+	tpiu_enable_hw(&csdev->access);
 	atomic_inc(csdev->refcnt);
 	dev_dbg(&csdev->dev, "TPIU enabled\n");
 	return 0;
 }
 
-static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
+static void tpiu_disable_hw(struct csdev_access *csa)
 {
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(csa->base);
 
 	/* Clear formatter and stop on flush */
-	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
+	csdev_access_relaxed_write32(csa, FFCR_STOP_FI, TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
+	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
+	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(csa->base);
 }
 
 static int tpiu_disable(struct coresight_device *csdev)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
 	if (atomic_dec_return(csdev->refcnt))
 		return -EBUSY;
 
-	tpiu_disable_hw(drvdata);
+	tpiu_disable_hw(&csdev->access);
 
 	dev_dbg(&csdev->dev, "TPIU disabled\n");
 	return 0;
@@ -152,7 +148,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	/* Disable tpiu to support older devices */
-	tpiu_disable_hw(drvdata);
+	tpiu_disable_hw(&desc.access);
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
-- 
2.24.1

