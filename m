Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C485C2AA436
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgKGJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:19:25 -0500
Received: from mail.loongson.cn ([114.242.206.163]:53260 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbgKGJTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:19:25 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9OSZqZfszcIAA--.19255S2;
        Sat, 07 Nov 2020 17:19:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] locking/lock_events: no need to check return value of debugfs_create functions
Date:   Sat,  7 Nov 2020 17:19:13 +0800
Message-Id: <1604740753-17662-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxL9OSZqZfszcIAA--.19255S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fGFyUuF1kWr48Aw4UCFg_yoW8Ar4Upa
        nxCr9xtr40v3ySqF98Ww1vvryfua4vyFs7CF9F9ryIywn5tr4ava1kKF1xJrySqrWfXr90
        q3W5KF4j9FyjyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUPl13UUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/locking/lock_events.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index fa2c2f9..bac77a1 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -146,9 +146,6 @@ static int __init init_lockevent_counts(void)
 	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
 	int i;
 
-	if (!d_counts)
-		goto out;
-
 	/*
 	 * Create the debugfs files
 	 *
@@ -159,21 +156,13 @@ static int __init init_lockevent_counts(void)
 	for (i = 0; i < lockevent_num; i++) {
 		if (skip_lockevent(lockevent_names[i]))
 			continue;
-		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
-					 (void *)(long)i, &fops_lockevent))
-			goto fail_undo;
+		debugfs_create_file(lockevent_names[i], 0400, d_counts,
+				    (void *)(long)i, &fops_lockevent);
 	}
 
-	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
-				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
-				 &fops_lockevent))
-		goto fail_undo;
+	debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200, d_counts,
+			    (void *)(long)LOCKEVENT_reset_cnts, &fops_lockevent);
 
 	return 0;
-fail_undo:
-	debugfs_remove_recursive(d_counts);
-out:
-	pr_warn("Could not create '%s' debugfs entries\n", LOCK_EVENTS_DIR);
-	return -ENOMEM;
 }
 fs_initcall(init_lockevent_counts);
-- 
2.1.0

