Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF92709DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgISCDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:03:05 -0400
Received: from m42-11.mailgun.net ([69.72.42.11]:55682 "EHLO
        m42-11.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgISCCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:02:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600480973; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ZdfA1vgYrXj47yJw43/hc550AS1dLK/hDR1YnTZowuI=; b=qLApG/VhcUkj3Yyz1tNspcWtEk5ynlTIbnc4L3HuGduM8U+cpWcKVRqB5y9Lz9u+KU7EUVu8
 FdzWHDFyBlFHq+pi/degDebeq59zv7l0TLHz5n2CV5vHCJ8/84T1hMN3aluPvifBO/REL6Am
 2rq8r0Av/jOrHqSCDkybbKbz7Jo=
X-Mailgun-Sending-Ip: 69.72.42.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f6566c86ace44cacceed692 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Sep 2020 02:02:48
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 968E5C433CB; Sat, 19 Sep 2020 02:02:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AF15C433F1;
        Sat, 19 Sep 2020 02:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AF15C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 06/10] bus: mhi: core: Improve shutdown handling after link down detection
Date:   Fri, 18 Sep 2020 19:02:31 -0700
Message-Id: <1600480955-16827-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600480955-16827-1-git-send-email-bbhatt@codeaurora.org>
References: <1600480955-16827-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MHI were to attempt a device shutdown following an assumption
that the device is inaccessible, the host currently moves to a state
where device register accesses are allowed when they should not be.
This would end up allowing accesses to the device register space when
the link is inaccessible and can result in bus errors observed on the
host. Improve shutdown handling to prevent these outcomes and do not
move the MHI PM state to a register accessible state after device is
assumed to be inaccessible.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/init.c     |  1 +
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/pm.c       | 18 +++++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 9ae4c19..fa33dde 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -37,6 +37,7 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
 	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
 	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
 	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
+	[DEV_ST_TRANSITION_FATAL] = "FATAL SHUTDOWN",
 };
 
 const char * const mhi_state_str[MHI_STATE_MAX] = {
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 7989269..f3b9e5a 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -388,6 +388,7 @@ enum dev_st_transition {
 	DEV_ST_TRANSITION_MISSION_MODE,
 	DEV_ST_TRANSITION_SYS_ERR,
 	DEV_ST_TRANSITION_DISABLE,
+	DEV_ST_TRANSITION_FATAL,
 	DEV_ST_TRANSITION_MAX,
 };
 
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 3462d82..bce1f62 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -37,9 +37,10 @@
  *     M0 -> FW_DL_ERR
  *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
  * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
- * L2: SHUTDOWN_PROCESS -> DISABLE
+ * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
+ *     SHUTDOWN_PROCESS -> DISABLE
  * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
- *     LD_ERR_FATAL_DETECT -> SHUTDOWN_PROCESS
+ *     LD_ERR_FATAL_DETECT -> DISABLE
  */
 static struct mhi_pm_transitions const dev_state_transitions[] = {
 	/* L0 States */
@@ -72,7 +73,7 @@ static struct mhi_pm_transitions const dev_state_transitions[] = {
 	{
 		MHI_PM_M3,
 		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+		MHI_PM_LD_ERR_FATAL_DETECT
 	},
 	{
 		MHI_PM_M3_EXIT,
@@ -103,7 +104,7 @@ static struct mhi_pm_transitions const dev_state_transitions[] = {
 	/* L3 States */
 	{
 		MHI_PM_LD_ERR_FATAL_DETECT,
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_SHUTDOWN_PROCESS
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_DISABLE
 	},
 };
 
@@ -670,6 +671,10 @@ void mhi_pm_st_worker(struct work_struct *work)
 			mhi_pm_disable_transition
 				(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
 			break;
+		case DEV_ST_TRANSITION_FATAL:
+			mhi_pm_disable_transition
+				(mhi_cntrl, MHI_PM_LD_ERR_FATAL_DETECT);
+			break;
 		default:
 			break;
 		}
@@ -1039,6 +1044,7 @@ EXPORT_SYMBOL_GPL(mhi_async_power_up);
 void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 {
 	enum mhi_pm_state cur_state;
+	enum dev_st_transition next_state = DEV_ST_TRANSITION_DISABLE;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 
 	/* If it's not a graceful shutdown, force MHI to linkdown state */
@@ -1053,9 +1059,11 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 			dev_dbg(dev, "Failed to move to state: %s from: %s\n",
 				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
 				to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		else
+			next_state = DEV_ST_TRANSITION_FATAL;
 	}
 
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+	mhi_queue_state_transition(mhi_cntrl, next_state);
 
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

