Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9526A39D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIOKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:49:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53733 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgIOKnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166630; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2Jmzvt9lu8hZREOsIFVtSCuLMl7jwroAT0dgfeCejFc=; b=QgjTJzolccc+Adpm7EqtS1ITLxnuZKioilAUwuK6Dymv4KBU0x231FP5yijWGCphnS82oa8P
 NMhBNnJkpiwLJ1zCsF2UeDd9p2x3itJpc4Ah2Y7dYmcc0sNnc/hFM8dRK6+kByt4zeTV25iW
 axhrp/oU2Nnfsd92z29nY6vD2IM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f609ad0238e1efa37db1bbf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE283C433FE; Tue, 15 Sep 2020 10:43:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24C51C43385;
        Tue, 15 Sep 2020 10:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24C51C43385
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 19/24] coresight: cti: don't disable ect device if it's not enabled
Date:   Tue, 15 Sep 2020 18:41:11 +0800
Message-Id: <20200915104116.16789-20-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If associated ect device is not enabled at first place, disable
routine should not be called. Add ect_enabled flag to check whether
ect device is enabled. Fix the issue in below case.  Ect device is
not available when associated coresight device enabled and the
association is established after coresight device is enabled.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 11 ++++++++---
 include/linux/coresight.h               |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index b8b0a20e93c9..711beb92166a 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -244,13 +244,18 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
 
 	if (!ect_csdev)
 		return 0;
+	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
+		return 0;
 
 	if (enable) {
-		if (ect_ops(ect_csdev)->enable)
-			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+		if (!ect_ret)
+			csdev->ect_enabled = true;
 	} else {
-		if (ect_ops(ect_csdev)->disable)
+		if (csdev->ect_enabled) {
 			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
+			csdev->ect_enabled = false;
+		}
 	}
 
 	/* output warning if ECT enable is preventing trace operation */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 3bb738f9a326..7d3c87e5b97c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -208,6 +208,7 @@ struct coresight_device {
 	/* sysfs links between components */
 	int nr_links;
 	bool has_conns_grp;
+	bool ect_enabled; /* true only if associated ect device is enabled */
 };
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

