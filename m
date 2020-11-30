Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370792C8225
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgK3K25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:28:57 -0500
Received: from foss.arm.com ([217.140.110.172]:51938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3K24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:28:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA2030E;
        Mon, 30 Nov 2020 02:28:10 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 495743F23F;
        Mon, 30 Nov 2020 02:28:10 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] mailbox: arm_mhu_db: Fix mhu_db_shutdown by replacing kfree with devm_kfree
Date:   Mon, 30 Nov 2020 10:28:04 +0000
Message-Id: <20201130102804.2345083-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mhu_db_channel info is allocated per channel using devm_kzalloc from
mhu_db_mbox_xlate which gets called from mbox_request_channel. However
we are releasing the allocated mhu_db_channel info using plain kfree from
mhu_db_shutdown which is called from mbox_free_channel.

This leads to random crashes when the channel is freed like below one:

  Unable to handle kernel paging request at virtual address 0080000400000008
  [0080000400000008] address between user and kernel address ranges
  Internal error: Oops: 96000044 [#1] PREEMPT SMP
  Modules linked in: scmi_module(-)
  CPU: 1 PID: 2212 Comm: rmmod Not tainted 5.10.0-rc5 #31
  Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno
  	Development Platform, BIOS EDK II Nov 19 2020
  pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
  pc : release_nodes+0x74/0x230
  lr : devres_release_all+0x40/0x68
  Call trace:
   release_nodes+0x74/0x230
   devres_release_all+0x40/0x68
   device_release_driver_internal+0x12c/0x1f8
   driver_detach+0x58/0xe8
   bus_remove_driver+0x64/0xe0
   driver_unregister+0x38/0x68
   platform_driver_unregister+0x1c/0x28
   scmi_driver_exit+0x38/0x44 [scmi_module]
   __arm64_sys_delete_module+0x188/0x260
   el0_svc_common.constprop.0+0x80/0x1a8
   do_el0_svc+0x2c/0x98
   el0_sync_handler+0x160/0x168
   el0_sync+0x174/0x180
  Code: 1400000d eb07009f 54000460 f9400486 (f90004a6)
  ---[ end trace c55ffd306c140233 ]---

Fix it by replacing kfree with devm_kfree as required.

Fixes: 7002ca237b21 ("mailbox: arm_mhu: Add ARM MHU doorbell driver")
Reported-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/arm_mhu_db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhu_db.c b/drivers/mailbox/arm_mhu_db.c
index 275efe4cca0c..8eb66c4ecf5b 100644
--- a/drivers/mailbox/arm_mhu_db.c
+++ b/drivers/mailbox/arm_mhu_db.c
@@ -180,7 +180,7 @@ static void mhu_db_shutdown(struct mbox_chan *chan)
 
 	/* Reset channel */
 	mhu_db_mbox_clear_irq(chan);
-	kfree(chan->con_priv);
+	devm_kfree(mbox->dev, chan->con_priv);
 	chan->con_priv = NULL;
 }
 
-- 
2.25.1

