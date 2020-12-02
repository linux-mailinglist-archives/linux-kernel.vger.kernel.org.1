Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709692CBDAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgLBNDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:03:08 -0500
Received: from m42-5.mailgun.net ([69.72.42.5]:60584 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgLBNDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:03:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606914166; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=qjAu4ARaDSHofzOeaPU7lbpS6oa/GFM40mmufUDX6Cw=; b=UfPfWwuKuD8Cw426JWWRJ5DByUe7F1DnWPSd6GWu1LqdjdH1M/NSgu1Vbfr+ClR7BUqMxCZY
 PnNRirBKWwCICZ2R8/vIjlO2f7lh0ULZRp+DKCWpXH5l3ZES1GKXh37VY0vdj8A2JXccZcdk
 BkApT4ULNow9m1b3Ff1tHXTrYWM=
X-Mailgun-Sending-Ip: 69.72.42.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fc79076e8c9bf49ade1ccab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 13:02:46
 GMT
Sender: sallenki=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C81EFC433C6; Wed,  2 Dec 2020 13:02:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from sallenki-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sallenki)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B405FC43460;
        Wed,  2 Dec 2020 13:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B405FC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sallenki@codeaurora.org
From:   Sriharsha Allenki <sallenki@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, mgautam@codeaurora.org,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v2] usb: gadget: Fix spinlock lockup on usb_function_deactivate
Date:   Wed,  2 Dec 2020 18:32:20 +0530
Message-Id: <20201202130220.24926-1-sallenki@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spinlock lockup as part of composite_disconnect
when it tries to acquire cdev->lock as part of usb_gadget_deactivate.
This is because the usb_gadget_deactivate is called from
usb_function_deactivate with the same spinlock held.

This would result in the below call stack and leads to stall.

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     3-...0: (1 GPs behind) idle=162/1/0x4000000000000000
softirq=10819/10819 fqs=2356
 (detected by 2, t=5252 jiffies, g=20129, q=3770)
 Task dump for CPU 3:
 task:uvc-gadget_wlhe state:R  running task     stack:    0 pid:  674 ppid:
 636 flags:0x00000202
 Call trace:
  __switch_to+0xc0/0x170
  _raw_spin_lock_irqsave+0x84/0xb0
  composite_disconnect+0x28/0x78
  configfs_composite_disconnect+0x68/0x70
  usb_gadget_disconnect+0x10c/0x128
  usb_gadget_deactivate+0xd4/0x108
  usb_function_deactivate+0x6c/0x80
  uvc_function_disconnect+0x20/0x58
  uvc_v4l2_release+0x30/0x88
  v4l2_release+0xbc/0xf0
  __fput+0x7c/0x230
  ____fput+0x14/0x20
  task_work_run+0x88/0x140
  do_notify_resume+0x240/0x6f0
  work_pending+0x8/0x200

Fix this by doing an unlock on cdev->lock before the usb_gadget_deactivate
call from usb_function_deactivate.

The same lockup can happen in the usb_gadget_activate path. Fix that path
as well.

Reported-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/linux-usb/20201102094936.GA29581@b29397-desktop/
Tested-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
---
Changes since v1:
- Updated commit text to reflect fix in usb_gadget_activate as well

 drivers/usb/gadget/composite.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index c6d455f2bb92..1a556a628971 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -392,8 +392,11 @@ int usb_function_deactivate(struct usb_function *function)
 
 	spin_lock_irqsave(&cdev->lock, flags);
 
-	if (cdev->deactivations == 0)
+	if (cdev->deactivations == 0) {
+		spin_unlock_irqrestore(&cdev->lock, flags);
 		status = usb_gadget_deactivate(cdev->gadget);
+		spin_lock_irqsave(&cdev->lock, flags);
+	}
 	if (status == 0)
 		cdev->deactivations++;
 
@@ -424,8 +427,11 @@ int usb_function_activate(struct usb_function *function)
 		status = -EINVAL;
 	else {
 		cdev->deactivations--;
-		if (cdev->deactivations == 0)
+		if (cdev->deactivations == 0) {
+			spin_unlock_irqrestore(&cdev->lock, flags);
 			status = usb_gadget_activate(cdev->gadget);
+			spin_lock_irqsave(&cdev->lock, flags);
+		}
 	}
 
 	spin_unlock_irqrestore(&cdev->lock, flags);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

