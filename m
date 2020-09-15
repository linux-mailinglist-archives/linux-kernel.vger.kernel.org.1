Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41512269FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIOHfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:35:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:35469 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgIOHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:34:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600155295; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=zO7YxpF1G5S5zr+mYWbXoKnIjONI35AREKEkXVlkqO0=; b=oAycvt20sE5XViiF7UZ4bRUlkCF8K6uuY3/ZCMz8EGbr8fGiXh5dHPdwclEe9O8OypJgKJ4g
 sFMfRZ7BRJmyXVYfvBBlNUiJZ0wtgsInW3wqe5k0eVZuWCL0w3pFVa8pIzvpWb4h9ENHxywM
 SLqe5iVbVtKh/MrDH+11eiQb5xM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f606e8432925f96e13f2b19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 07:34:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79FC5C433FE; Tue, 15 Sep 2020 07:34:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2166DC433CA;
        Tue, 15 Sep 2020 07:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2166DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, rishabhb@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] remoteproc: Fixup coredump debugfs disable request
Date:   Tue, 15 Sep 2020 13:04:16 +0530
Message-Id: <20200915073416.20864-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the coredump debugfs entry takes in "disable" to set the
coredump state to "disabled". Let's just accept the expected state
instead.

Fixes: 3afdc59e43904 ("remoteproc: Add coredump debugfs entry")
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/remoteproc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 2e3b3e22e1d01..7ca823f6aa638 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -94,7 +94,7 @@ static ssize_t rproc_coredump_write(struct file *filp,
 		goto out;
 	}
 
-	if (!strncmp(buf, "disable", count)) {
+	if (!strncmp(buf, "disabled", count)) {
 		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
 	} else if (!strncmp(buf, "inline", count)) {
 		rproc->dump_conf = RPROC_COREDUMP_INLINE;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

