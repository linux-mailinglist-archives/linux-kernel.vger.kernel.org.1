Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160BD2F0C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbhAKFQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbhAKFQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:16:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34AEC061794
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:15:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l23so9808576pjg.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBtUOVT7XIHXC50aBpXH6yYDCw6kssIDZPJEhJCkygw=;
        b=Q1To7wDptu+qdvd7GH0n24sfqrDvlv71Mk/TT7KJ24PojEpEQaSq8zNY6d7Y7a4/kv
         OJo0D0W7UxP6kCKDtALX/blNZYpVubis6Jcxsv7KrC2NezLnoeI6VzB5EhZ+FPSNi4wk
         NeQrP1KE0dL2upPZltAh370niakY25UTmb3Q/JHwBs2F8abP999KeM8sUjLdVUHjg6PT
         YBwE/oLZ0mM3FNJIbbUKU57xHcwqB6y4p3xW8Z34zNJ6B6Oi8RvwnTRRWvxSWCqoHFTH
         ZmsxVjdlVXARy0c7Z1Ne6V0Z/lWMMVuNA4+Jd1GoWmiSctz81ppFR0SQNiVQ3QeLkdej
         M9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBtUOVT7XIHXC50aBpXH6yYDCw6kssIDZPJEhJCkygw=;
        b=AmJ+rpzSnNZ2LbFIaxAVx2NPt2x53Jr22gXrssfTQrBTS2S+wkvrtbJskpP+hrwVWf
         hH9GgNfJJHSyHXa6rneE+cVZFwIyFoa+KaNBloYXVFrRgtZRZ8XoGaI66r65VnbNelBd
         zi9MTfhttIJnPuS8aW2r4EhEKeyQn1i7T0jzXomYd5+Kx+jVodvguhNqSAoO9xP+oYHB
         lTkRxrR9QBXD1voFSGbJxz+8W0iOi3AQzqTKJWfdliw9kVPzqKNBoyiz0LP1tuePHWL7
         K/SGF6WkRtrNrMAJbmuI5h1sgUWOeEmlu7ZXWPQ72BZVRF6sSr7E3EknxnqETcGUhGT5
         BDZw==
X-Gm-Message-State: AOAM533TtWATXYa/LGQRiHbecfuhKJ8n2qDwKQU6Gir2/W3p4J4OycwA
        jajoGRqyivw1co26zPY0sICa01hdYgA=
X-Google-Smtp-Source: ABdhPJxMuI6KC3YkcmZe2ekD2CEio7umcZB6eLKxGuxVWgDAG2W4+1XcZdat4XeEyMMOmd77PZY/GQ==
X-Received: by 2002:a17:902:b7cb:b029:db:c0d6:96ee with SMTP id v11-20020a170902b7cbb02900dbc0d696eemr14902201plz.21.1610342156046;
        Sun, 10 Jan 2021 21:15:56 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id i25sm17729224pgb.33.2021.01.10.21.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:15:55 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: add ckpt_thread_ioprio sysfs node
Date:   Mon, 11 Jan 2021 14:15:43 +0900
Message-Id: <20210111051543.243387-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111051543.243387-1-daeho43@gmail.com>
References: <20210111051543.243387-1-daeho43@gmail.com>
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
index 11288f435dbe..37a393f97d5d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1839,6 +1839,7 @@ int f2fs_create_ckpt_req_control(struct f2fs_sb_info *sbi)
 	atomic_set(&cprc->issued_ckpt, 0);
 	atomic_set(&cprc->total_ckpt, 0);
 	atomic_set(&cprc->queued_ckpt, 0);
+	cprc->ckpt_thread_ioprio = DEFAULT_CHECKPOINT_IOPRIO;
 	init_waitqueue_head(&cprc->ckpt_wait_queue);
 	init_llist_head(&cprc->issue_list);
 	sbi->cprc_info = cprc;
@@ -1859,7 +1860,7 @@ int f2fs_create_ckpt_req_control(struct f2fs_sb_info *sbi)
 		return err;
 	}
 
-	set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO);
+	set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);
 
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4de5285df17d..957bf4c42d40 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -278,6 +278,7 @@ struct ckpt_req {
 
 struct ckpt_req_control {
 	struct task_struct *f2fs_issue_ckpt;	/* checkpoint task */
+	int ckpt_thread_ioprio;			/* checkpoint merge thread ioprio */
 	wait_queue_head_t ckpt_wait_queue;	/* waiting queue for wake-up */
 	atomic_t issued_ckpt;			/* # of actually issued ckpts */
 	atomic_t total_ckpt;			/* # of total ckpts */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 30bae57428d1..295ebd84986b 100644
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
+		return (unsigned char *)sbi->cprc_info;
 	return NULL;
 }
 
@@ -255,6 +259,23 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
+	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
+		struct ckpt_req_control *cprc = sbi->cprc_info;
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
+		struct ckpt_req_control *cprc = sbi->cprc_info;
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
2.30.0.284.gd98b1dd5eaa7-goog

