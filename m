Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63CF2DCCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgLQH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:27:34 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36724 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgLQH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:27:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UItlrWK_1608189998;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UItlrWK_1608189998)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 15:26:42 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH] usemem: Add option touch-alloc
Date:   Thu, 17 Dec 2020 15:26:31 +0800
Message-Id: <20201217072631.6440-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some environment will not fault in memory even if MAP_POPULATE is set.
This commit add option touch-alloc to read memory after allocate it to
make sure the pages is fault in.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 usemem.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/usemem.c b/usemem.c
index 6d1d575..d93691b 100644
--- a/usemem.c
+++ b/usemem.c
@@ -97,6 +97,7 @@ unsigned long opt_delay = 0;
 int opt_read_again = 0;
 int opt_punch_holes = 0;
 int opt_init_time = 0;
+int opt_touch_alloc = 0;
 int nr_task;
 int nr_thread;
 int nr_cpu;
@@ -157,6 +158,7 @@ void usage(int ok)
 	"    -Z|--read-again     read memory again after access the memory\n"
 	"    --punch-holes       free every other page after allocation\n"
 	"    --init-time         remove the initialization time from the run time and show the initialization time\n"
+	"    --touch-alloc       read memory after allocate it\n"
 	"    -h|--help           show this message\n"
 	,		ourname);
 
@@ -197,6 +199,7 @@ static const struct option opts[] = {
 	{ "read-again"	, 0, NULL, 'Z' },
 	{ "punch-holes"	, 0, NULL,   0 },
 	{ "init-time"	, 0, NULL,   0 },
+	{ "touch-alloc"	, 0, NULL,   0 },
 	{ "help"	, 0, NULL, 'h' },
 	{ NULL		, 0, NULL, 0 }
 };
@@ -326,6 +329,18 @@ void detach(void)
 	}
 }
 
+unsigned long do_access(unsigned long *p, unsigned long idx, int read)
+{
+	volatile unsigned long *vp = p;
+
+	if (read)
+		return vp[idx];	/* read data */
+	else {
+		vp[idx] = idx;	/* write data */
+		return 0;
+	}
+}
+
 unsigned long * allocate(unsigned long bytes)
 {
 	unsigned long *p;
@@ -352,6 +367,14 @@ unsigned long * allocate(unsigned long bytes)
 		p = (unsigned long *)ALIGN((unsigned long)p, pagesize - 1);
 	}
 
+	if (opt_touch_alloc) {
+		unsigned long i;
+		unsigned long m = bytes / sizeof(*p);
+
+		for (i = 0; i < m; i += 1)
+			do_access(p, i, 1);
+	}
+
 	return p;
 }
 
@@ -433,18 +456,6 @@ void shm_unlock(int seg_id)
 	shmctl(seg_id, SHM_UNLOCK, NULL);
 }
 
-unsigned long do_access(unsigned long *p, unsigned long idx, int read)
-{
-	volatile unsigned long *vp = p;
-
-	if (read)
-		return vp[idx];	/* read data */
-	else {
-		vp[idx] = idx;	/* write data */
-		return 0;
-	}
-}
-
 #define NSEC_PER_SEC  (1UL * 1000 * 1000 * 1000)
 
 long nsec_sub(long nsec1, long nsec2)
@@ -950,6 +961,8 @@ int main(int argc, char *argv[])
 				opt_punch_holes = 1;
 			} else if (strcmp(opts[opt_index].name, "init-time") == 0) { 
 				opt_init_time = 1;
+			} else if (strcmp(opts[opt_index].name, "touch-alloc") == 0) { 
+				opt_touch_alloc = 1;
 			} else
 				usage(1);
 			break;
-- 
2.17.1

