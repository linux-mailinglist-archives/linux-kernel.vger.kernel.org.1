Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5865C258DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgIAMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 08:07:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbgIAL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:59:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48FDF56F8CD6021042EF;
        Tue,  1 Sep 2020 19:59:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 19:59:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <christian.brauner@ubuntu.com>, <oleg@redhat.com>,
        <axboe@kernel.dk>, <ebiederm@xmission.com>,
        <madhuparnabhowmik10@gmail.com>, <gustavoars@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] signal: clean up codestyle
Date:   Tue, 1 Sep 2020 07:58:00 -0400
Message-ID: <20200901115800.7916-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a38b3edc6851..10a31fafc35b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1115,8 +1115,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
-		switch ((unsigned long) info) {
-		case (unsigned long) SEND_SIG_NOINFO:
+		switch ((unsigned long)info) {
+		case (unsigned long)SEND_SIG_NOINFO:
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
@@ -1129,7 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 						 current_uid());
 			rcu_read_unlock();
 			break;
-		case (unsigned long) SEND_SIG_PRIV:
+		case (unsigned long)SEND_SIG_PRIV:
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
@@ -1314,7 +1314,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 	int sig = info->si_signo;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	action = &t->sighand->action[sig-1];
+	action = &t->sighand->action[sig - 1];
 	ignored = action->sa.sa_handler == SIG_IGN;
 	blocked = sigismember(&t->blocked, sig);
 	if (blocked || ignored) {
-- 
2.19.1

