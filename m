Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D82F0BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAKElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:41:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbhAKElk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:41:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C661AD7A;
        Mon, 11 Jan 2021 04:40:58 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jacmet@sunsite.dk
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] usb/c67x00: Replace tasklet with work
Date:   Sun, 10 Jan 2021 20:40:50 -0800
Message-Id: <20210111044050.86763-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

c67x00_do_work() will now run in process context and have further
concurrency (tasklets being serialized among themselves), but this
is done holding the c67x00->lock, so it should be fine. Furthermore,
this patch fixes the usage of the lock in the callback as otherwise
it would need to be irq-safe.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/usb/c67x00/c67x00-hcd.h   |  2 +-
 drivers/usb/c67x00/c67x00-sched.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
index 6b6b04a3fe0f..6332a6b5dce6 100644
--- a/drivers/usb/c67x00/c67x00-hcd.h
+++ b/drivers/usb/c67x00/c67x00-hcd.h
@@ -76,7 +76,7 @@ struct c67x00_hcd {
 	u16 next_td_addr;
 	u16 next_buf_addr;
 
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 
 	struct completion endpoint_disable;
 
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index e65f1a0ae80b..af60f4fdd340 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -1123,24 +1123,26 @@ static void c67x00_do_work(struct c67x00_hcd *c67x00)
 
 /* -------------------------------------------------------------------------- */
 
-static void c67x00_sched_tasklet(struct tasklet_struct *t)
+static void c67x00_sched_work(struct work_struct *work)
 {
-	struct c67x00_hcd *c67x00 = from_tasklet(c67x00, t, tasklet);
+	struct c67x00_hcd *c67x00;
+
+	c67x00 = container_of(work, struct c67x00_hcd, work);
 	c67x00_do_work(c67x00);
 }
 
 void c67x00_sched_kick(struct c67x00_hcd *c67x00)
 {
-	tasklet_hi_schedule(&c67x00->tasklet);
+        queue_work(system_highpri_wq, &c67x00->work);
 }
 
 int c67x00_sched_start_scheduler(struct c67x00_hcd *c67x00)
 {
-	tasklet_setup(&c67x00->tasklet, c67x00_sched_tasklet);
+        INIT_WORK(&c67x00->work, c67x00_sched_work);
 	return 0;
 }
 
 void c67x00_sched_stop_scheduler(struct c67x00_hcd *c67x00)
 {
-	tasklet_kill(&c67x00->tasklet);
+        cancel_work_sync(&c67x00->work);
 }
-- 
2.26.2

