Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CFA19FFEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDFVFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:05:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18186 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbgDFVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:05:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586207153; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ffx5EV2Q8Tn2RVpOX/tVF4K3DHDlYVftRrtuWmnjmPo=; b=EuecmqN+iYYlfCqASBwfjEBNHXUaj+VeqwtASLOcCEswCV4yzuX5f+9wXlIMzclPeBokUcef
 ftsGN6yDP/b6gEYuvMNND1pfJ/dDvvXvF1XrTvSdFTnRitE/Mf596P7e1WMRptM0bmGt3448
 EnkvI1RpWaXR2yU+DOQkTt68rME=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b99ac.7fc1dadfe0d8-smtp-out-n01;
 Mon, 06 Apr 2020 21:05:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A13BFC43637; Mon,  6 Apr 2020 21:05:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C347DC43636;
        Mon,  6 Apr 2020 21:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C347DC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH 3/3] bus: mhi: core: Remove link_status() callback
Date:   Mon,  6 Apr 2020 15:04:37 -0600
Message-Id: <1586207077-22361-4-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
References: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the MHI core detects invalid data due to a PCI read, it calls into
the controller via link_status() to double check that the link is infact
down.  All in all, this is pretty pointless, and racy.  There are no good
reasons for this, and only drawbacks.

Its pointless because chances are, the controller is going to do the same
thing to determine if the link is down - attempt a PCI access and compare
the result.  This does not make the link status decision any smarter.

Its racy because its possible that the link was down at the time of the
MHI core access, but then recovered before the controller access.  In this
case, the controller will indicate the link is not down, and the MHI core
will precede to use a bad value as the MHI core does not attempt to retry
the access.

Retrying the access in the MHI core is a bad idea because again, it is
racy - what if the link is down again?  Furthermore, there may be some
higher level state associated with the link status, that is now invalid
because the link went down.

The only reason why the MHI core could see "invalid" data when doing a PCI
access, that is actually valid, is if the register actually contained the
PCI spec defined sentinel for an invalid access.  In this case, it is
arguable that the MHI implementation broken, and should be fixed, not
worked around.

Therefore, remove the link_status() callback before anyone attempts to
implement it.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 6 ++----
 drivers/bus/mhi/core/main.c | 5 ++---
 include/linux/mhi.h         | 2 --
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index b38359c..2af08d57 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -812,10 +812,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (!mhi_cntrl)
 		return -EINVAL;
 
-	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put)
-		return -EINVAL;
-
-	if (!mhi_cntrl->status_cb || !mhi_cntrl->link_status)
+	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
+	    !mhi_cntrl->status_cb)
 		return -EINVAL;
 
 	ret = parse_config(mhi_cntrl, config);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index eb4256b..473278b8 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -20,9 +20,8 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
 {
 	u32 tmp = readl(base + offset);
 
-	/* If there is any unexpected value, query the link status */
-	if (PCI_INVALID_READ(tmp) &&
-	    mhi_cntrl->link_status(mhi_cntrl))
+	/* If the value is invalid, the link is down */
+	if (PCI_INVALID_READ(tmp))
 		return -EIO;
 
 	*out = tmp;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index ad19960..be704a4 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -335,7 +335,6 @@ struct mhi_controller_config {
  * @syserr_worker: System error worker
  * @state_event: State change event
  * @status_cb: CB function to notify power states of the device (required)
- * @link_status: CB function to query link status of the device (required)
  * @wake_get: CB function to assert device wake (optional)
  * @wake_put: CB function to de-assert device wake (optional)
  * @wake_toggle: CB function to assert and de-assert device wake (optional)
@@ -417,7 +416,6 @@ struct mhi_controller {
 
 	void (*status_cb)(struct mhi_controller *mhi_cntrl,
 			  enum mhi_callback cb);
-	int (*link_status)(struct mhi_controller *mhi_cntrl);
 	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_toggle)(struct mhi_controller *mhi_cntrl);
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
