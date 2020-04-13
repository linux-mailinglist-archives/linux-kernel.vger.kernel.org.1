Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8311A6600
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgDML4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 07:56:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727907AbgDML4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:56:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 473CBDE56527D95F600F;
        Mon, 13 Apr 2020 19:56:43 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:56:34 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH-next] locktorture: use true, false for bool variable
Date:   Mon, 13 Apr 2020 20:02:59 +0800
Message-ID: <1586779379-103799-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

kernel/locking/locktorture.c:689:6-10: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:907:2-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:938:3-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:668:2-19: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:674:2-19: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:634:2-20: WARNING: Assignment of 0/1 to bool variable
kernel/locking/locktorture.c:640:2-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 kernel/locking/locktorture.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5efbfc6..8ff6f50 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -631,13 +631,13 @@ static int lock_torture_writer(void *arg)
 		cxt.cur_ops->writelock();
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
-		lock_is_write_held = 1;
+		lock_is_write_held = true;
 		if (WARN_ON_ONCE(lock_is_read_held))
 			lwsp->n_lock_fail++; /* rare, but... */
 
 		lwsp->n_lock_acquired++;
 		cxt.cur_ops->write_delay(&rand);
-		lock_is_write_held = 0;
+		lock_is_write_held = false;
 		cxt.cur_ops->writeunlock();
 
 		stutter_wait("lock_torture_writer");
@@ -665,13 +665,13 @@ static int lock_torture_reader(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		cxt.cur_ops->readlock();
-		lock_is_read_held = 1;
+		lock_is_read_held = true;
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lrsp->n_lock_fail++; /* rare, but... */
 
 		lrsp->n_lock_acquired++;
 		cxt.cur_ops->read_delay(&rand);
-		lock_is_read_held = 0;
+		lock_is_read_held = false;
 		cxt.cur_ops->readunlock();
 
 		stutter_wait("lock_torture_reader");
@@ -686,7 +686,7 @@ static int lock_torture_reader(void *arg)
 static void __torture_print_stats(char *page,
 				  struct lock_stress_stats *statp, bool write)
 {
-	bool fail = 0;
+	bool fail = false;
 	int i, n_stress;
 	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
 	long long sum = 0;
@@ -904,7 +904,7 @@ static int __init lock_torture_init(void)
 
 	/* Initialize the statistics so that each run gets its own numbers. */
 	if (nwriters_stress) {
-		lock_is_write_held = 0;
+		lock_is_write_held = false;
 		cxt.lwsa = kmalloc_array(cxt.nrealwriters_stress,
 					 sizeof(*cxt.lwsa),
 					 GFP_KERNEL);
@@ -935,7 +935,7 @@ static int __init lock_torture_init(void)
 		}
 
 		if (nreaders_stress) {
-			lock_is_read_held = 0;
+			lock_is_read_held = false;
 			cxt.lrsa = kmalloc_array(cxt.nrealreaders_stress,
 						 sizeof(*cxt.lrsa),
 						 GFP_KERNEL);
-- 
2.6.2

