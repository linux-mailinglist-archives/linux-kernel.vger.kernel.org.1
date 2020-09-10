Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C90263A26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 04:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgIJCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgIJCUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:20:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9FC061796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 19:20:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so2273549pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uZtoOwKYtsNFinbEP17eK0TcjEDx3wgWg9ndpqP7KNU=;
        b=Pnkoe39bqJabvoo0ojb/o9LLCXqc1onnL4qfdvXXN0/K1OsPwsfjivIL5vQDSGnSrO
         P02SnjA3159MaHvxZZyNdFWY7b1mM6uIi36g9edeoXtUuCLd+dgBXfGzsranod+EIBa0
         VxqS4ufxRWaw3081ZcwaJlD3y/1v1FQYUgplOEG32nGnC6Su8JtNasPueRFL04Jb+lj3
         7myYYhWKpL18SADIJBZC7AmqWix9Ra0eHkwop0I4f7GQwzvqdJmvuRVGN20z8yIojo7+
         5kHqFbb/NJDrB0pGfLOHKBrU3vbgmq3fAXpX5U/IQLoAm5m8g+qGnAmLjQzsJ2u1sw3J
         A7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uZtoOwKYtsNFinbEP17eK0TcjEDx3wgWg9ndpqP7KNU=;
        b=d8ILLjGgzhm1KJicr6tFt5s9flwAGIL8lazXiUBaT/yKPQN5zBVsVWrjPzJlhe/zQg
         j//alIHGnIdNDSQ3Rgu/OQ/LgxB70bCY5oG1QeYx/qGAWOBzU5zIXfhbzDb+8ry/QLV8
         6cB3p33MjywIocbeMF7dIukz7OyyrLxpVqWiiL/zMtitICq1W8dMyJmwTicqNJbpJQrL
         gcvf9Oxz8/5jarrFlxIBleo0JFQzFwfqyh123gHB9KbdcHxu8Tdtum6r1pmRj7eyiYZp
         x7ytu80KsHN2e3xeCwaTVURfvUlRXHDSeBS7Q35HpQYZYzwALZe7oxmkSwS4Nj68BQsI
         7mLg==
X-Gm-Message-State: AOAM532TOEQSaNrXRZiXpJws1rZUjDtTD42Jfnn8kBkoMBs6oWoJiqfk
        kmXwB0zjqB1ssEoc3VETNDYvJA==
X-Google-Smtp-Source: ABdhPJw1VwIuxeCYOYqJLuox6GtHjWg3dPNyTtj4gQflfBSTKC8v0l+FkgTB0W5JxGpfQ6GPlMFn6Q==
X-Received: by 2002:a17:902:c253:: with SMTP id 19mr3444489plg.65.1599704433135;
        Wed, 09 Sep 2020 19:20:33 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id o1sm3781664pfg.83.2020.09.09.19.20.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 19:20:32 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     axboe@kernel.dk
Cc:     pizhenwei@bytedance.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: add io_error stat for block device
Date:   Thu, 10 Sep 2020 10:20:26 +0800
Message-Id: <20200910022026.632617-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if hitting block req error, block layer only prints error
log with a rate limitation. Then agent has to parse kernel log to
record what happens.

In this patch, add read/write/discard/flush stat counter to record
io errors.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/blk-core.c          | 14 +++++++++++---
 block/genhd.c             | 19 +++++++++++++++++++
 include/linux/part_stat.h |  1 +
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..8f1424835700 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1558,9 +1558,17 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		req->q->integrity.profile->complete_fn(req, nr_bytes);
 #endif
 
-	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
-		print_req_error(req, error, __func__);
+	if (unlikely(error && !blk_rq_is_passthrough(req))) {
+		if (op_is_flush(req_op(req)))
+			part_stat_inc(&req->rq_disk->part0,
+				io_errors[STAT_FLUSH]);
+		else
+			part_stat_inc(&req->rq_disk->part0,
+				io_errors[op_stat_group(req_op(req))]);
+
+		if (!(req->rq_flags & RQF_QUIET))
+			print_req_error(req, error, __func__);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..852035095485 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -104,6 +104,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 			stat->sectors[group] += ptr->sectors[group];
 			stat->ios[group] += ptr->ios[group];
 			stat->merges[group] += ptr->merges[group];
+			stat->io_errors[group] += ptr->io_errors[group];
 		}
 
 		stat->io_ticks += ptr->io_ticks;
@@ -1374,6 +1375,22 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 	return sprintf(buf, "%d\n", queue_discard_alignment(disk->queue));
 }
 
+static ssize_t io_error_show(struct device *dev,
+		      struct device_attribute *attr, char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+	struct disk_stats stat;
+
+	part_stat_read_all(p, &stat);
+
+	return sprintf(buf,
+		"%8lu %8lu %8lu %8lu\n",
+		stat.io_errors[STAT_READ],
+		stat.io_errors[STAT_WRITE],
+		stat.io_errors[STAT_DISCARD],
+		stat.io_errors[STAT_FLUSH]);
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -1386,6 +1403,7 @@ static DEVICE_ATTR(capability, 0444, disk_capability_show, NULL);
 static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
+static DEVICE_ATTR(io_error, 0444, io_error_show, NULL);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1437,6 +1455,7 @@ static struct attribute *disk_attrs[] = {
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 	&dev_attr_fail_timeout.attr,
 #endif
+	&dev_attr_io_error.attr,
 	NULL
 };
 
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 24125778ef3e..4fe3836d2308 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -9,6 +9,7 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
+	unsigned long io_errors[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	local_t in_flight[2];
 };
-- 
2.11.0

