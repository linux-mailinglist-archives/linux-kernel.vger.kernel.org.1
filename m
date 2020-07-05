Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93226215155
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGFDTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 23:19:53 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53030 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbgGFDTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 23:19:53 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0663GhXp022250
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 5 Jul 2020 20:16:54 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Sun, 5 Jul 2020 20:16:32 -0700
From:   <qiang.zhang@windriver.com>
To:     <ben.dooks@codethink.co.uk>, <bfields@redhat.com>,
        <cl@rock-chips.com>, <peterz@infradead.org>, <pmladek@suse.com>,
        <tj@kernel.org>
CC:     <akpm@linux-foundation.org>, <mm-commits@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] kthread: Work could not be queued when worker being destroyed
Date:   Sun, 5 Jul 2020 09:30:18 +0800
Message-ID: <20200705013018.7375-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Before the work is put into the queue of the worker thread,
the state of the worker thread needs to be detected,because
the worker thread may be in the destruction state at this time.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 v1->v2:
 Add warning information for condition "!worker->task".
 v2->v3:
 Modify submission information and add "Reviewed-by" tags. 

 kernel/kthread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..cac5184ffd86 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -791,6 +791,9 @@ static inline bool queuing_blocked(struct kthread_worker *worker,
 {
 	lockdep_assert_held(&worker->lock);
 
+	if (WARN_ON(!worker->task))
+		return true;
+
 	return !list_empty(&work->node) || work->canceling;
 }
 
-- 
2.24.1

