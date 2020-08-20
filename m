Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523B424AEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 07:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgHTFur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 01:50:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13055 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbgHTFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:50:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902644; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cM2CUt+Ix5Vo9VXXeSNvMQ4DVnL0W11AEQs3/zcDqG0=; b=GX/pPwLw0Q6bLtbjOQbz4Jk8J29RbARpk1xr2H3hD8wTBof52VDC1mM9r7iO2QWJcgeaPwG6
 0kTflm1CpoDR/ckKYgxL7mX8nYmBBrYvJDEtEMbkc/wCBUDo69eG8Bcagf0CfMWw0FiCp/dC
 BUp6JO7y6+QbiG4PZ2ZM6gY0HwU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3e0f334db56de6f0156c84 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:50:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92578C433CA; Thu, 20 Aug 2020 05:50:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0FDBC433B7;
        Thu, 20 Aug 2020 05:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0FDBC433B7
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v9 17/24] coresight: cti: Fix remove sysfs link error
Date:   Thu, 20 Aug 2020 13:47:11 +0800
Message-Id: <20200820054718.20115-18-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

CTI code to remove sysfs link to other devices on shutdown, incorrectly
tries to remove a single ended link when these are all double ended. This
implementation leaves elements in the link info structure undefined which
results in a crash in recent tests for driver module unload.

This patch corrects the link removal code.

Fixes: 73274abb6557 ("coresight: cti: Add in sysfs links to other coresight devices")
Reported-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 1f470c47ba70..1c34db7d1b1b 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -511,12 +511,15 @@ static bool cti_add_sysfs_link(struct cti_drvdata *drvdata,
 	return !link_err;
 }
 
-static void cti_remove_sysfs_link(struct cti_trig_con *tc)
+static void cti_remove_sysfs_link(struct cti_drvdata *drvdata,
+				  struct cti_trig_con *tc)
 {
 	struct coresight_sysfs_link link_info;
 
+	link_info.orig = drvdata->csdev;
 	link_info.orig_name = tc->con_dev_name;
 	link_info.target = tc->con_dev;
+	link_info.target_name = dev_name(&drvdata->csdev->dev);
 	coresight_remove_sysfs_link(&link_info);
 }
 
@@ -606,7 +609,7 @@ void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 		ctidev = &ctidrv->ctidev;
 		list_for_each_entry(tc, &ctidev->trig_cons, node) {
 			if (tc->con_dev == csdev->ect_dev) {
-				cti_remove_sysfs_link(tc);
+				cti_remove_sysfs_link(ctidrv, tc);
 				tc->con_dev = NULL;
 				break;
 			}
@@ -658,7 +661,7 @@ static void cti_remove_conn_xrefs(struct cti_drvdata *drvdata)
 		if (tc->con_dev) {
 			coresight_set_assoc_ectdev_mutex(tc->con_dev,
 							 NULL);
-			cti_remove_sysfs_link(tc);
+			cti_remove_sysfs_link(drvdata, tc);
 			tc->con_dev = NULL;
 		}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

