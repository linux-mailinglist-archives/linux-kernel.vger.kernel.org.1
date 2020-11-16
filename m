Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7032B4B21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgKPQaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:30:04 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:20882 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgKPQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:30:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605544202; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=OcOxP9SoB2zIBSz04f/3dy8QWxDpqnS+1Xsbwg8a9Zg=; b=Rs7XGNn6DKeOlEIRBX77QjOUD8b7LVy8SrRvtlt1+vHxulkrxKvONrQUyYtbugWGq9lA3gBt
 Nxq4WJnqxPWSUy7Afb70IjN1o3vTntvH/2JHkOj617f9EKs1usWMS7S1FylYgMfB1JbKBMsz
 uBlHPyQfG2qeR6z9fUSb42xCdNY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fb2a90a07fe4e8a18ca5edc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 16:30:02
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94930C43464; Mon, 16 Nov 2020 16:30:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mojha-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D57B1C433C6;
        Mon, 16 Nov 2020 16:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D57B1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] thermal: Fix NULL pointer dereference issue
Date:   Mon, 16 Nov 2020 21:59:41 +0530
Message-Id: <1605544181-5348-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cooling stats variable inside thermal_cooling_device_stats_update()
can get NULL. We should add a NULL check on stat inside for sanity.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a6f371f..f52708f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -754,6 +754,9 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 {
 	struct cooling_dev_stats *stats = cdev->stats;
 
+	if (!stats)
+		return;
+
 	spin_lock(&stats->lock);
 
 	if (stats->state == new_state)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

