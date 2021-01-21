Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12232FEC42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbhAUNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbhAUNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:48:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2BC06179B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:45:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p15so1688724pjv.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+cAKQ+EbfZbCGBT5NQTPPSVG3VMZwAzb6PXC21HENg=;
        b=LN9YU/w4vC3z2fK6Co+zq7IxcNce2QyC4QyFI8uXGpKrTvdMM6bDA9S20xZiVyXEnH
         HdeeltTjL8o8hPTxPKWL3hs/E5c/QTXYsRFk2ALLEjtWFFLWiBJUy09+1kGO/x4JiynD
         EzIgSCjJ45pfs1xnjEJdAkteMRNQ63PQoNoxCoKcaALh1LAypn/LeVX4fGa9BvI9iSDq
         dnxIAmqC+wTBtULlG7nruwDzq8NFETXvH0bRRzBB0JOwH2ahTwM0zwulsBAj/Sp8Tm8F
         gyph3/fY0ZRUCPra2duuBMNNv076GSvsIHCXFTb3/BRe8ykmfarj7UPC/qFgA8ah4buN
         r2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+cAKQ+EbfZbCGBT5NQTPPSVG3VMZwAzb6PXC21HENg=;
        b=I9yCUEhMcTp9viNmUUzFEwpp7PzhdQ2Zt2qI/fOg3HmsQiB3DF/YJsc+mL26zfktv7
         IBizCeUhHgeAe1o/YbMoK9ZFZEb9x8BiM5g+D69gChhdcPOGA86MXxsXq3SNOHwaNy2H
         09iGew0crIVNQ8+GeEW+ilwOAhSMeM0Dt2H0OeMh6OoZKFDy9fs/3krKb/6SoXhMxH//
         FvzUrA4oReup0DaqoMaz/YItdJFvzQa9lBAS1dINHsSJhvVynMp04vwZNfpFku1s5BjS
         uIsOXIbYFBlfCuKL+thAms45o52C0KSV6BHEklTkFH6290uuU9jDHLpw7KdsZayxxdkr
         B+Ag==
X-Gm-Message-State: AOAM533nBpyxMfF1XGCipsksB9FdGXhfpib1/UuHb/VzWoTePPOmptQ5
        OYZL61wdsKdu2naKvh+vRL5xha02uNY=
X-Google-Smtp-Source: ABdhPJwEa1HnYUHRmvdPV+XvtLGiBL8yspI7TCj4Bdg/6ZtFVrfHkDZ1XoTg44p5tnkls8rV9StPzA==
X-Received: by 2002:a17:90a:1c09:: with SMTP id s9mr12057456pjs.83.1611236743713;
        Thu, 21 Jan 2021 05:45:43 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id e3sm5451618pgs.60.2021.01.21.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 05:45:42 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5 2/2] f2fs: add ckpt_thread_ioprio sysfs node
Date:   Thu, 21 Jan 2021 22:45:29 +0900
Message-Id: <20210121134529.1201249-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
In-Reply-To: <20210121134529.1201249-1-daeho43@gmail.com>
References: <20210121134529.1201249-1-daeho43@gmail.com>
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
v5:
- initialized cprc->ckpt_thread_ioprio
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
 fs/f2fs/checkpoint.c                    |  3 +-
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         | 51 +++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

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
index ef6ad3d1957d..a3549923762d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1854,7 +1854,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
 		return PTR_ERR(cprc->f2fs_issue_ckpt);
 	}
 
-	set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO);
+	set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);
 
 	return 0;
 }
@@ -1880,6 +1880,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi)
 	atomic_set(&cprc->issued_ckpt, 0);
 	atomic_set(&cprc->total_ckpt, 0);
 	atomic_set(&cprc->queued_ckpt, 0);
+	cprc->ckpt_thread_ioprio = DEFAULT_CHECKPOINT_IOPRIO;
 	init_waitqueue_head(&cprc->ckpt_wait_queue);
 	init_llist_head(&cprc->issue_list);
 	spin_lock_init(&cprc->stat_lock);
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

