Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160771E54C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 05:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgE1Dn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 23:43:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgE1Dn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:43:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6424043087DF6C431BE4;
        Thu, 28 May 2020 11:43:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 28 May 2020
 11:43:46 +0800
From:   liuchao <liuchao173@huawei.com>
To:     <mingo@kernel.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>, liuchao <liuchao173@huawei.com>
Subject: [RFC] decrease tsk->signal->live before profile_task_exit
Date:   Thu, 28 May 2020 12:09:56 +0800
Message-ID: <20200528040956.30155-1-liuchao173@huawei.com>
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

I want to dermine which thread is the last one to enter
do_exit in profile_task_exit. But when a lot of threads
exit, tsk->signal->live is not correct since it decrease
after profile_task_exit.

Signed-off-by: liuchao <liuchao173@huawei.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index ce2a75bc0ade..1693764bc356 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -708,6 +708,7 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	profile_task_exit(tsk);
 	kcov_task_exit(tsk);
 
@@ -755,7 +756,6 @@ void __noreturn do_exit(long code)
 	if (tsk->mm)
 		sync_mm_rss(tsk->mm);
 	acct_update_integrals(tsk);
-	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
 		/*
 		 * If the last thread of global init has exited, panic
-- 
2.19.1

