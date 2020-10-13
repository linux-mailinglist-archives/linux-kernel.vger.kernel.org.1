Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AAB28C71A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgJMCYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgJMCYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:24:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364DBC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:24:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x16so16407651pgj.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5asbHEXOVzz3KY0nwEzagtPhdb/NuvhbToUoYEnsfg=;
        b=WkgVHQGOeM7r/o0qnnDRFFZnzNkzTsnpK+MIc3bNt/s2RdULSgIQA74WP6KBoPQlwD
         8hbEiqvcENmWYe51UJqlI4JuDQ/Di4InhZ7+mu6ye6wVuzrvUfJ3esRm5YuW1GdInWua
         XtSyOrCfEuZA6v5IYPhmYzEN+s9PmGcHPa0deTkiu986kHh9Pf7BbXdqG7Bu9N7cxEV0
         epNTn9K9osF9fjOXBRssQdhNxBprsaronaZ3Ddh4+hRtxES6kqjvNefH4mxp98QQGqzu
         mBgCFAZLwbbikuKRAtH4NQJdXJkHv0gGXoOzaKdxADoS9e4M/LBZQDFFi5mEelvf0PH/
         6ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5asbHEXOVzz3KY0nwEzagtPhdb/NuvhbToUoYEnsfg=;
        b=eetVqvyE+pxIELq572T+TbwJY2IJ4xsiT8S/f7z8abrhzDJwikr+C/CfWYiGTvg8EE
         vW1iYQnLP6KzgcgGD1HHOa+Iflb8ojjs6n4hLolMh1Elg24R4hyI9remtfUIUJ/4lNkR
         WBvwEEg/zYSnraw9dd7CsT8ZuCIri+BYnl6fKWbaDtr4V21Uf1UIE8DpvHHLkESJrdq+
         /S9huoPwPQjTxfh/xiUn4rhjcNgsP86eDRciN043tDK6xzR9wh58DoogXKrd36KYn4nn
         H7Oez1laZgPt11oPO8mcjGOPXFYPgGfNNnyZPikOXRJkeE6l3wOE8QLw4bq5MV9jesRc
         sgIg==
X-Gm-Message-State: AOAM531Ls5/3sATrgN8ySHaWEdn3e3kRXSCjYNEgdkKuFoE6HvTu0k7D
        0+IIBaC93NnskZh/bjQg3nRnK8hhnBU=
X-Google-Smtp-Source: ABdhPJx0t8zTOmfObjOqfTTfSf717fNFPX2PMEkJ9ekbnUlvasAMRR4wPqYuUdxrOAMqHwJUISqTXw==
X-Received: by 2002:a62:7cd4:0:b029:154:f9ee:320b with SMTP id x203-20020a627cd40000b0290154f9ee320bmr26690911pfc.26.1602555880156;
        Mon, 12 Oct 2020 19:24:40 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id d194sm10581110pfd.172.2020.10.12.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 19:24:39 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Tue, 13 Oct 2020 11:24:28 +0900
Message-Id: <20201013022429.454161-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
option of a file.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |  7 +++++++
 fs/f2fs/file.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 53fe2853579c..a33c90cf979b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -433,6 +433,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
 #define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
 						struct f2fs_sectrim_range)
+#define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
+						struct f2fs_comp_option)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -481,6 +483,11 @@ struct f2fs_sectrim_range {
 	u64 flags;
 };
 
+struct f2fs_comp_option {
+	u8 algorithm;
+	u8 log_cluster_size;
+};
+
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
 static inline int get_extra_isize(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef5a844de53f..7e64259f6f5e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3936,6 +3936,33 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_comp_option option;
+
+	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+		return -EOPNOTSUPP;
+
+	inode_lock(inode);
+
+	if (!f2fs_compressed_file(inode)) {
+		inode_unlock(inode);
+		return -EINVAL;
+	}
+
+	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
+	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+
+	inode_unlock(inode);
+
+	if (copy_to_user((struct f2fs_comp_option __user *)arg, &option,
+				sizeof(option)))
+		return -EFAULT;
+
+	return 0;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -4024,6 +4051,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_reserve_compress_blocks(filp, arg);
 	case F2FS_IOC_SEC_TRIM_FILE:
 		return f2fs_sec_trim_file(filp, arg);
+	case F2FS_IOC_GET_COMPRESS_OPTION:
+		return f2fs_ioc_get_compress_option(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4194,6 +4223,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 	case F2FS_IOC_SEC_TRIM_FILE:
+	case F2FS_IOC_GET_COMPRESS_OPTION:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.28.0.1011.ga647a8990f-goog

