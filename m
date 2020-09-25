Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45282277FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgIYFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:08:20 -0400
Received: from mail1.windriver.com ([147.11.146.13]:48677 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgIYFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:08:20 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 08P5877L011172
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 24 Sep 2020 22:08:07 -0700 (PDT)
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 22:08:01 -0700
From:   <qiang.zhang@windriver.com>
To:     <tj@kernel.org>, <pmladek@suse.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] kernel/kthread.c: kthread_worker: add work status check in timer_fn
Date:   Fri, 25 Sep 2020 13:07:59 +0800
Message-ID: <20200925050759.20805-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When queue delayed work to worker, at some point after that the timer_fn
will be call, add work to worker's work_list, at this time, the work may
be cancel, so add "work->canceling" check current work status.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Change description information.

 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..85a2c9b32049 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -897,7 +897,8 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
 	list_del_init(&work->node);
-	kthread_insert_work(worker, work, &worker->work_list);
+	if (!work->canceling)
+		kthread_insert_work(worker, work, &worker->work_list);
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
 }
-- 
2.17.1

