Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3685026A36A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIOKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:44:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:62164 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgIOKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166603; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2JXlwjdxdFhqJ8uMYrIqAHwY4Q8bKWRYk+e6/k2DJ54=; b=HRdUZcMxJdTblqsGss8AghhMwIYFqScoCJkj2R+uvtTDgYct0Pd5/yqakNTezf9Uzi4BFBC0
 /TgV/fLm81v4mKlQndc+5uj5dOS9dqaa0XiJzzzUcSh7PlRyFYEZrjlbaeDonX8hDkLMuSA7
 oVcAgNKHlg5+o/Iz0z5sE+3ffI8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f609acbd7b4e2691390eac5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F40C4C4339C; Tue, 15 Sep 2020 10:43:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8749FC433FE;
        Tue, 15 Sep 2020 10:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8749FC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingwei@codeaurora.org
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
Subject: [PATCH v11 18/24] coresight: cti: Fix bug clearing sysfs links on callback
Date:   Tue, 15 Sep 2020 18:41:10 +0800
Message-Id: <20200915104116.16789-19-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

During module unload, a coresight driver module will call back into
the CTI driver to remove any links between the two devices.

The current code has 2 issues:-
1) in the CTI driver the matching code is matching to the wrong device
so misses all the links.
2) The callback is called too late in the unload process resulting in a
crash.

This fixes both the issues.

Fixes: 177af8285b59 ("coresight: cti: Enable CTI associated with devices")
Reported-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 2 +-
 drivers/hwtracing/coresight/coresight.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index abc8b32e79b3..38e785d913b0 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -591,7 +591,7 @@ static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 		ctidrv = csdev_to_cti_drvdata(csdev->ect_dev);
 		ctidev = &ctidrv->ctidev;
 		list_for_each_entry(tc, &ctidev->trig_cons, node) {
-			if (tc->con_dev == csdev->ect_dev) {
+			if (tc->con_dev == csdev) {
 				cti_remove_sysfs_link(ctidrv, tc);
 				tc->con_dev = NULL;
 				break;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4f4485b17458..b8b0a20e93c9 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1246,8 +1246,6 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	if (cti_assoc_ops && cti_assoc_ops->remove)
-		cti_assoc_ops->remove(csdev);
 	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev->refcnt);
 	kfree(csdev);
@@ -1582,6 +1580,8 @@ void coresight_unregister(struct coresight_device *csdev)
 {
 	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
+	if (cti_assoc_ops && cti_assoc_ops->remove)
+		cti_assoc_ops->remove(csdev);
 	coresight_remove_conns(csdev);
 	coresight_clear_default_sink(csdev);
 	coresight_release_platform_data(csdev, csdev->pdata);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

