Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0A26A395
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIOKs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:48:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33262 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgIOKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166631; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FuCSba+psr1HNe/EwoFLOIZxYtq9ZFS3OanE5U3Ee9c=; b=KKqJc1YL9o00/X8B/Y0rnqnn3onHLhuK76nHTiZ/9KWHO3G+eaUU9ujTfKMYqyLoyj71igss
 LB/fYSxY6zTCF/IyKHArO0OxP3Y/f+qJB+T5bY20xHPfWJEkvV330ueSJxsgPFtoUCcf8vwg
 0lLvpLiCTXL7+U02HBC3HaI8VS8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f609ad6238e1efa37db2177 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7336EC4339C; Tue, 15 Sep 2020 10:43:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5F48C433CA;
        Tue, 15 Sep 2020 10:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5F48C433CA
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
Subject: [PATCH v11 20/24] coresight: cti: increase reference count when enabling cti
Date:   Tue, 15 Sep 2020 18:41:12 +0800
Message-Id: <20200915104116.16789-21-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTI device is enabled when associated coresight device is enabled.
Increase the module and device reference count for CTI device
when it's enabled. This can prevent CTI device be removed or
module be unloaded when CTI device is enabled by an active trace
session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 711beb92166a..546c97045afe 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -241,19 +241,30 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
 {
 	int ect_ret = 0;
 	struct coresight_device *ect_csdev = csdev->ect_dev;
+	struct module *mod;
 
 	if (!ect_csdev)
 		return 0;
 	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
 		return 0;
 
+	mod = ect_csdev->dev.parent->driver->owner;
 	if (enable) {
-		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
-		if (!ect_ret)
-			csdev->ect_enabled = true;
+		if (try_module_get(mod)) {
+			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+			if (ect_ret) {
+				module_put(mod);
+			} else {
+				get_device(ect_csdev->dev.parent);
+				csdev->ect_enabled = true;
+			}
+		} else
+			ect_ret = -ENODEV;
 	} else {
 		if (csdev->ect_enabled) {
 			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
+			put_device(ect_csdev->dev.parent);
+			module_put(mod);
 			csdev->ect_enabled = false;
 		}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

