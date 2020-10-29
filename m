Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1039829E579
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgJ2H5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgJ2HYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EFC0613E9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:15:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s22so1277628pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B60xVbhPe7rb6EgjNTjb/8plxpCQprGZrIuoqWSL9gY=;
        b=f/Px0j46Bm05qxw7cB18MS2bHQxp4/FmLSBtVohP4jP0austiXtomIhWHebQw8Hygk
         NhJ1quDw7qQjk0z2FXf48S+8unqv6O9OKjx45363gYges36zO+msJyXEBY7gclKDR6Xq
         MosEfO3bBjv+A1mL3qG7jhXqlY+ICrhxpEv6ZLZqnGdYnFm6IItpsTRc6/mOLhoRXeh7
         fCoc3EtZZ+RYlJWWxKO5Z7kHh9YEWoLVB+f8Mxlrdzc7Aji1eynZiphstxzH/ZxKD2ji
         8nnw4ICOYyWQcUKAiAyztDmhJy2Zun4oJ0qgHLJ3f+g7sse+5pjmQt2Gn5K5StpmVpxN
         kSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B60xVbhPe7rb6EgjNTjb/8plxpCQprGZrIuoqWSL9gY=;
        b=oxeiSjaOdLcqPdMNc/rMc/lzsYJAsy3KlsNsFBvb6ZVyN3hPdpZluvSzj8YGvq1dMR
         QBUor8zU6PuqFnIFWIT6st5MrBWZcn+fH1jkV026HrAXvV8RySrNRRm/vAOp5L9gDH/B
         ZjNBuKoHc3fuiyYtS3KFCPAIPSuPMngXUmDLHqDRz6JDikwgEQJIUzxhp+Bx/CCzOY0f
         0nxGzmqIsl29DDtxC2HNlfg1coyRwLpaGVSwIPoNHVllEtWjzDdgouRbu66kU/54qK61
         /YXWS4ET6Oup38K+Xc1Hn+3t5+mWdOrMdGdHvKSWDDCjMdd0R/XWju2zYCj533MUohpd
         IjYQ==
X-Gm-Message-State: AOAM531lxksArXwQtNF2d5eRYZnCSk4EHuG+79v1UjbJILdYKXcN3xsd
        XQmrT5JO+XCPKpvPdDXWJQheUYSIp6A=
X-Google-Smtp-Source: ABdhPJxQIPoq7afFfyIPPWa0I1llw9HsEzh9QCV0qsZoQo7BFTFJdAWfpTguVwHCactDtFsykiGOqQ==
X-Received: by 2002:a63:e:: with SMTP id 14mr2478562pga.426.1603944950179;
        Wed, 28 Oct 2020 21:15:50 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id d186sm1116261pfa.76.2020.10.28.21.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 21:15:49 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Thu, 29 Oct 2020 13:15:37 +0900
Message-Id: <20201029041538.4165209-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
option of a file.

struct f2fs_comp_option {
    u8 algorithm;         => compression algorithm
                          => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
    u8 log_cluster_size;  => log scale cluster size
                          => 2 ~ 8
};

struct f2fs_comp_option option;

ioctl(fd, F2FS_IOC_GET_COMPRESS_OPTION, &option);

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---

v4: changed commit message.
v3: changed the error number more specific.
v2: added ioctl description.
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
index ef5a844de53f..8922ab191a9d 100644
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
+		return -ENODATA;
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
2.29.1.341.ge80a0c044ae-goog

