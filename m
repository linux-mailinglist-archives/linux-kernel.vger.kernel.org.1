Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D21E7AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgE2KwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 06:52:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:59920 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgE2KwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:52:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590749529; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=co8nl7CTEETIN2B25/tGKTRUwOtkos2z7eE3iS24BaQ=; b=JFwJ9bBrpBMxbBaCh6ild9PhnDLljZ0u28e7dOsRra+KAW0X9+AgMKZiFG4Dz17V/w4KL9DF
 eSxbv8j5HRuF7ZUwqoGwplrdY2cWXQaT0m7nOuVJ1ugLqYpGjNB9eIqVEXuxfNzkZT1iPYyV
 hsjPg/xYQlth0Rm09FsX0Nr/5nY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ed0e958c28b2cdd983704cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 10:52:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD13DC433CA; Fri, 29 May 2020 10:52:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB353C433C9;
        Fri, 29 May 2020 10:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB353C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, ilina@codeaurora.org, lsrao@codeaurora.org
Subject: [PATCH] soc: qcom: rpmh: Remove serialization of TCS commands
Date:   Fri, 29 May 2020 16:21:47 +0530
Message-Id: <1590749507-1440-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Requests sent to RPMH can be sent as fire-n-forget or response required,
with the latter ensuring the command has been completed by the hardware
accelerator. Commands in a request with tcs_cmd::wait set, would ensure
that those select commands are sent as response required, even though
the actual TCS request may be fire-n-forget.

Also, commands with .wait flag were also guaranteed to be complete
before the following command in the TCS is sent. This means that the
next command of the same request blocked until the current request is
completed. This could mean waiting for a voltage to settle or series of
NOCs be configured before the next command is sent. But drivers using
this feature have never cared about the serialization aspect. By not
enforcing the serialization we can allow the hardware to run in parallel
improving the performance.

Let's clarify the usage of this member in the tcs_cmd structure to mean
only completion and not serialization. This should also improve the
performance of bus requests where changes could happen in parallel.
Also, CPU resume from deep idle may see benefits from certain wake
requests.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 19 ++++++++-----------
 include/soc/qcom/tcs.h      |  5 +++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 076fd27..d99e639 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -413,8 +413,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			cmd = &req->cmds[j];
 			sts = read_tcs_cmd(drv, RSC_DRV_CMD_STATUS, i, j);
 			if (!(sts & CMD_STATUS_ISSUED) ||
-			   ((req->wait_for_compl || cmd->wait) &&
-			   !(sts & CMD_STATUS_COMPL))) {
+			   (cmd->wait && !(sts & CMD_STATUS_COMPL))) {
 				pr_err("Incomplete request: %s: addr=%#x data=%#x",
 				       drv->name, cmd->addr, cmd->data);
 				err = -EIO;
@@ -433,7 +432,6 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
-		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
 		writel_relaxed(BIT(i), drv->tcs_base + RSC_DRV_IRQ_CLEAR);
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
@@ -465,23 +463,23 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 			       const struct tcs_request *msg)
 {
-	u32 msgid, cmd_msgid;
+	u32 msgid;
+	u32 cmd_msgid = CMD_MSGID_LEN | CMD_MSGID_WRITE;
 	u32 cmd_enable = 0;
-	u32 cmd_complete;
 	struct tcs_cmd *cmd;
 	int i, j;
 
-	cmd_msgid = CMD_MSGID_LEN;
+	/* Convert all commands to RR when the request has wait_for_compl set */
 	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
-	cmd_msgid |= CMD_MSGID_WRITE;
-
-	cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id);
 
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
 		cmd_enable |= BIT(j);
-		cmd_complete |= cmd->wait << j;
 		msgid = cmd_msgid;
+		/*
+		 * Additionally, if the cmd->wait is set, make the command
+		 * response reqd even if the overall request was fire-n-forget.
+		 */
 		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
 
 		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
@@ -490,7 +488,6 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
 	}
 
-	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
 	cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id);
 	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, cmd_enable);
 }
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 7a2a055..d1c87fd 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2016-2020, The Linux Foundation. All rights reserved.
  */
 
 #ifndef __SOC_QCOM_TCS_H__
@@ -30,7 +30,7 @@ enum rpmh_state {
  *
  * @addr: the address of the resource slv_id:18:16 | offset:0:15
  * @data: the resource state request
- * @wait: wait for this request to be complete before sending the next
+ * @wait: Ensure that this command is complete before returning
  */
 struct tcs_cmd {
 	u32 addr;
@@ -43,6 +43,7 @@ struct tcs_cmd {
  *
  * @state:          state for the request.
  * @wait_for_compl: wait until we get a response from the h/w accelerator
+ *                  (sets the cmd->wait for all commmands in the request)
  * @num_cmds:       the number of @cmds in this request
  * @cmds:           an array of tcs_cmds
  */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

