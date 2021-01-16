Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9511F2F8A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbhAPA7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPA7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:59:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285AC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:58:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so5562347plh.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LApCWeggNMCh5CgqzvEHxB+p2LaFGe+4VtSGAdUM1Hs=;
        b=f2/Jzgmd9WSr4U2LrXK5JUIowxDg4ce1IKo9scyE31mWT3GTqHjGenB/QXUTCGJFgo
         IM2XDQXF7RmQpUZWN1+gIrk2hVFmgr8u/n238WQZ+jMvf8iguer3uWpN+hXH78fxb0pk
         zCpK1mPbDJbdu7oH32NgKI9SvdK0IdWQN76C/SJa9W1bZm+RizHwrAbqUF2FhvVxIgow
         sYgWQTLX27aijPpNNcEVWB8Wp8c7ITuPMWAITqzFEidlNX+mwz2xSWKrgWkjuX5NDbcf
         1CZxqK1celshWGwjms0GldHZB8K5K/rhzzid5XcG8oFhsWMQ3vyGbrJ/67Box0I7crtG
         FYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LApCWeggNMCh5CgqzvEHxB+p2LaFGe+4VtSGAdUM1Hs=;
        b=dvZmjabeejyzXlBTNbf6VynHJHAbqVwBtmWcFtxXflyQphebfVM7wva+y+ef0STwu4
         rEDrhJLSNR21MtTtn9coWL/vxkX8OJUVIvPvVx9nDOy0hHeUvEz3fiPraYhrC4Qi17sC
         gUuPuXGG5mR834qaxa0cfFcOV+lkaA1BbM3fAga8J2jwn2GspGTC23WhLbv9+E0DgzoW
         SqQZ8S5jiy4mjGev50pxVCyGl8+rZjM0qli57X3MzBer/si3fcimj7ZSSBaEkFViIUz0
         JlcdUzt8auxekQpUKFA9iE13rfdy2a4Pce3buuFM/7f0uZFtjpIlpZ6sLCPRW26HUOlk
         /pTw==
X-Gm-Message-State: AOAM530hrh9Llv9b8KWfIHLeEj/zbNpIDQ6lWyk/mwwoWvDStuZH3eSW
        W9a3b6wioQLCPPoOWq+KemihhVK+rdI=
X-Google-Smtp-Source: ABdhPJyOA3bBu0i/USpbNEnp6RCtY0QLA2rLQKpdoQdb6u4xHSw+5shqiya6uak1H94P4xnP60g5zQ==
X-Received: by 2002:a17:90a:5991:: with SMTP id l17mr2331094pji.187.1610758699574;
        Fri, 15 Jan 2021 16:58:19 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id b22sm9031369pfo.163.2021.01.15.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 16:58:18 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add ckpt_thread_ioprio sysfs node
Date:   Sat, 16 Jan 2021 09:58:12 +0900
Message-Id: <20210116005812.3753714-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added "ckpt_thread_ioprio" sysfs node to give a way to change checkpoint
merge daemon's io priority. Its default value is "be,3", which means
"BE" I/O class and I/O priority "3". We can select the class between "rt"
and "be", and set the I/O priority within valid range of it.
"," delimiter is necessary in between I/O class and priority number.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2:
- adapt to inlining ckpt_req_control of f2fs_sb_info
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
 fs/f2fs/checkpoint.c                    |  2 +-
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         | 51 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3dfee94e0618..0c48b2e7dfd4 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -377,3 +377,11 @@ Description:	This gives a control to limit the bio size in f2fs.
 		Default is zero, which will follow underlying block layer limit,
 		whereas, if it has a certain bytes value, f2fs won't submit a
 		bio larger than that size.
+What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
+Date:		January 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Give a way to change checkpoint merge daemon's io priority.
+		Its default value is "be,3", which means "BE" I/O class and
+		I/O priority "3". We can select the class between "rt" and "be",
+		and set the I/O priority within valid range of it. "," delimiter
+		is necessary in between I/O class and priority number.
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ef6ad3d1957d..30e3fe161bb4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1854,7 +1854,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
 		return PTR_ERR(cprc->f2fs_issue_ckpt);
 	}
 
-	set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO);
+	set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);
 
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f2ae075aa723..517eb0eda638 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -276,6 +276,7 @@ struct ckpt_req {
 
 struct ckpt_req_control {
 	struct task_struct *f2fs_issue_ckpt;	/* checkpoint task */
+	int ckpt_thread_ioprio;			/* checkpoint merge thread ioprio */
 	wait_queue_head_t ckpt_wait_queue;	/* waiting queue for wake-up */
 	atomic_t issued_ckpt;		/* # of actually issued ckpts */
 	atomic_t total_ckpt;		/* # of total ckpts */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 30bae57428d1..ddd70395148d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/f2fs_fs.h>
 #include <linux/seq_file.h>
 #include <linux/unicode.h>
+#include <linux/ioprio.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -34,6 +35,7 @@ enum {
 	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
 #endif
 	RESERVED_BLOCKS,	/* struct f2fs_sb_info */
+	CPRC_INFO,	/* struct ckpt_req_control */
 };
 
 struct f2fs_attr {
@@ -70,6 +72,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 	else if (struct_type == STAT_INFO)
 		return (unsigned char *)F2FS_STAT(sbi);
 #endif
+	else if (struct_type == CPRC_INFO)
+		return (unsigned char *)&sbi->cprc_info;
 	return NULL;
 }
 
@@ -255,6 +259,23 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
+	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
+		struct ckpt_req_control *cprc = &sbi->cprc_info;
+		int len = 0;
+		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
+		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
+
+		if (class == IOPRIO_CLASS_RT)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
+		else if (class == IOPRIO_CLASS_BE)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
+		else
+			return -EINVAL;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
+		return len;
+	}
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -308,6 +329,34 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return ret ? ret : count;
 	}
 
+	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
+		const char *name = strim((char *)buf);
+		struct ckpt_req_control *cprc = &sbi->cprc_info;
+		int class;
+		long data;
+		int ret;
+
+		if (!strncmp(name, "rt,", 3))
+			class = IOPRIO_CLASS_RT;
+		else if (!strncmp(name, "be,", 3))
+			class = IOPRIO_CLASS_BE;
+		else
+			return -EINVAL;
+
+		name += 3;
+		ret = kstrtol(name, 10, &data);
+		if (ret)
+			return ret;
+		if (data >= IOPRIO_BE_NR || data < 0)
+			return -EINVAL;
+
+		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
+		ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
+				cprc->ckpt_thread_ioprio);
+
+		return count;
+	}
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	ret = kstrtoul(skip_spaces(buf), 0, &t);
@@ -567,6 +616,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 #endif
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
+F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
@@ -652,6 +702,7 @@ static struct attribute *f2fs_attrs[] = {
 #endif
 	ATTR_LIST(data_io_flag),
 	ATTR_LIST(node_io_flag),
+	ATTR_LIST(ckpt_thread_ioprio),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
 	ATTR_LIST(unusable),
-- 
2.30.0.296.g2bfb1c46d8-goog

