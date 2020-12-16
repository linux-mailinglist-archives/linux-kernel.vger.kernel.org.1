Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7E2DC1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgLPN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:59:48 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45628 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgLPN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:59:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UIqAOne_1608127134;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UIqAOne_1608127134)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Dec 2020 21:59:00 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH] usemem: Add option init-time
Date:   Wed, 16 Dec 2020 21:58:45 +0800
Message-Id: <20201216135845.20327-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawaterz@linux.alibaba.com>

This commit add a new option init-time to remove the initialization time
from the run time and show the initialization time.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 usemem.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/usemem.c b/usemem.c
index 823647e..6d1d575 100644
--- a/usemem.c
+++ b/usemem.c
@@ -96,6 +96,7 @@ int opt_bind_interval = 0;
 unsigned long opt_delay = 0;
 int opt_read_again = 0;
 int opt_punch_holes = 0;
+int opt_init_time = 0;
 int nr_task;
 int nr_thread;
 int nr_cpu;
@@ -155,6 +156,7 @@ void usage(int ok)
 	"    -U|--hugetlb        allocate hugetlbfs page\n"
 	"    -Z|--read-again     read memory again after access the memory\n"
 	"    --punch-holes       free every other page after allocation\n"
+	"    --init-time         remove the initialization time from the run time and show the initialization time\n"
 	"    -h|--help           show this message\n"
 	,		ourname);
 
@@ -193,7 +195,8 @@ static const struct option opts[] = {
 	{ "delay"	, 1, NULL, 'e' },
 	{ "hugetlb"	, 0, NULL, 'U' },
 	{ "read-again"	, 0, NULL, 'Z' },
-	{ "punch-holes" , 0, NULL,   0 },
+	{ "punch-holes"	, 0, NULL,   0 },
+	{ "init-time"	, 0, NULL,   0 },
 	{ "help"	, 0, NULL, 'h' },
 	{ NULL		, 0, NULL, 0 }
 };
@@ -945,6 +948,8 @@ int main(int argc, char *argv[])
 		case 0:
 			if (strcmp(opts[opt_index].name, "punch-holes") == 0) {
 				opt_punch_holes = 1;
+			} else if (strcmp(opts[opt_index].name, "init-time") == 0) { 
+				opt_init_time = 1;
 			} else
 				usage(1);
 			break;
@@ -1128,7 +1133,7 @@ int main(int argc, char *argv[])
 	if (optind != argc - 1)
 		usage(0);
 
-	if (!opt_write_signal_read)
+	if (!opt_write_signal_read || opt_init_time)
 		gettimeofday(&start_time, NULL);
 
 	opt_bytes = memparse(argv[optind], NULL);
@@ -1263,5 +1268,25 @@ int main(int argc, char *argv[])
 	if (!nr_task)
 		nr_task = 1;
 
+	if (opt_init_time) {
+		struct timeval stop;
+		char buf[1024];
+		size_t len;
+		unsigned long delta_us;
+
+		gettimeofday(&stop, NULL);
+		delta_us = (stop.tv_sec - start_time.tv_sec) * 1000000 +
+			(stop.tv_usec - start_time.tv_usec);
+		len = snprintf(buf, sizeof(buf),
+			"the initialization time is %lu secs %lu usecs\n",
+			delta_us / 1000000, delta_us % 1000000);
+		fflush(stdout);
+		if (write(1, buf, len) != len)
+			fprintf(stderr, "WARNING: statistics output may be incomplete.\n");
+
+		if (!opt_write_signal_read)
+			gettimeofday(&start_time, NULL);
+	}
+
 	return do_tasks();
 }
-- 
2.17.1

