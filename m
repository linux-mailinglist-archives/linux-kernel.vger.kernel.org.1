Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF22F6AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbhANTRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:17:41 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:62254 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbhANTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:17:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610651835; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2CS72TCnxt3Fqc0caK4ll84m6yjTGbSgg54c4Wku140=; b=JRW20ab7R3JnI44AmOkZa5l4BxdJzZciDPVidPXGeZw15adzDHjIO/R8U5mok3iuRH2J7vOx
 v8nsSk1sbuzFqpiyEs0oDKuwy+/hpSVZ+KPEcM4cP4O8aAh02J72wJUvvS0QOB5W1+AjAqhT
 wEdw29tYhb4Xdnm6iduquB9OphQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 6000989e9dddba11a6cce4bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 19:16:46
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0DBFCC43461; Thu, 14 Jan 2021 19:16:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F24A6C433C6;
        Thu, 14 Jan 2021 19:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F24A6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 3/3] bus: mhi: core: Process execution environment changes serially
Date:   Thu, 14 Jan 2021 11:16:35 -0800
Message-Id: <1610651795-31287-4-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610651795-31287-1-git-send-email-bbhatt@codeaurora.org>
References: <1610651795-31287-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current design, whenever the BHI interrupt is fired, the execution
environment is updated. This can cause race conditions and impede any
ongoing power up/down processing. For example, if a power down is in
progress and the host has updated the execution environment to a
local "disabled" state, any BHI interrupt firing later could replace
it with the value from the BHI EE register. Another example would be
that the device can enter mission mode while device creation for SBL
is still going on, leading to multiple attempts at opening the same
channel.

Ensure that EE changes are handled only from appropriate places and
occur one after another and handle only PBL or RDDM EE changes as
critical events directly from the interrupt handler. This also makes
sure that we use the correct execution environment to notify the
controller driver when the device resets to one of the PBL execution
environments.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 14 ++++++++------
 drivers/bus/mhi/core/pm.c   |  5 +++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 1a7192e..2929e9f 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -411,7 +411,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	enum mhi_state state = MHI_STATE_MAX;
 	enum mhi_pm_state pm_state = 0;
-	enum mhi_ee_type ee = 0;
+	enum mhi_ee_type ee = MHI_EE_MAX;
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
@@ -420,8 +420,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	}
 
 	state = mhi_get_mhi_state(mhi_cntrl);
-	ee = mhi_cntrl->ee;
-	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+	ee = mhi_get_exec_env(mhi_cntrl);
 	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
 		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
 		TO_MHI_STATE_STR(state));
@@ -439,8 +438,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 		if (!mhi_is_active(mhi_cntrl))
 			goto exit_intvec;
 
-		if (mhi_cntrl->ee == MHI_EE_RDDM && mhi_cntrl->ee != ee) {
+		if (ee == MHI_EE_RDDM && mhi_cntrl->ee != MHI_EE_RDDM) {
 			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
+			mhi_cntrl->ee = ee;
 			wake_up_all(&mhi_cntrl->state_event);
 		}
 		goto exit_intvec;
@@ -450,10 +450,12 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 		wake_up_all(&mhi_cntrl->state_event);
 
 		/* For fatal errors, we let controller decide next step */
-		if (MHI_IN_PBL(ee))
+		if (MHI_IN_PBL(ee)) {
 			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
-		else
+			mhi_cntrl->ee = ee;
+		} else {
 			mhi_pm_sys_err_handler(mhi_cntrl);
+		}
 	}
 
 exit_intvec:
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 44aa7eb..c870fa8 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -384,14 +384,15 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+		ee = mhi_get_exec_env(mhi_cntrl);
 
-	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee)) {
+	if (!MHI_IN_MISSION_MODE(ee)) {
 		mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
 		write_unlock_irq(&mhi_cntrl->pm_lock);
 		wake_up_all(&mhi_cntrl->state_event);
 		return -EIO;
 	}
+	mhi_cntrl->ee = ee;
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 
 	wake_up_all(&mhi_cntrl->state_event);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

