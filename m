Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4629E459
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgJ2Hh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgJ2HYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF8C0613EE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:15:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r186so1309462pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OS3kiFj7hguFNZ5QHdoV/+kAclT8nIay1b5YHWIjNmQ=;
        b=hUzJ7O8yv79mHDP41mSpHL/IfyDtvtF3wy4mxB94JX2XvwBtDsktIzlUmIedsnkYoe
         lQo/mvM9l71gp5WyrI9jKOQ7ymgJLOCSko5n18VttQpP9+P6hzYT9KyFkcEs5/Kull3f
         C+Ur5utEU73t4hr6AjrEiK51A1Ga9TF/2+LQ3b3qDsG8EhCI8fuZMKKIabas7D56JhAH
         CVqr+gNI1NzpgsycsI8PWbeRml9YWi7KiCgEdIGjXzQvE3Ku0gxUmP1s8MzF6Wlie/W+
         D+3WZnzIhnA0vVycGMbIGWvrugB/lPimmW+sEO85yUhXUEZFkvFY+fWSe6SmtxRaOfE1
         Kk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OS3kiFj7hguFNZ5QHdoV/+kAclT8nIay1b5YHWIjNmQ=;
        b=Mv3Ku9ol97Rx5FSAYcZkm3v7D2rwxjCJ+aBuU2jQdMfCfBpYYCYWKAsdXPs/A4HA3Z
         Ae4+/Epey/l34rsFH7Xc5IFhgLTcVPiM7GGL2YaVr3dErVpSvUyEVrFjmSr0YY+tLFY1
         UU6RprPG2IwDxwp9eg98oSPECnbcBT27xK2xlFKdtP9CoNJa75eRM5uQY1caimtYxwg4
         VJTvBk+wwB6ihmrL65JPyWFPEbmpTlVhysp5W93XzvlPHzAep649wkWFgDGDbpSn0U0S
         L1bb+9AN707BFMdtXFzI4EuLOOHTFvomJ4YXWcFIUWNSqDkk6tk84hBwJb/OCeg20NyL
         tQhQ==
X-Gm-Message-State: AOAM533Vk2z97tUPHSjchP0UkUPCLIKjURuFtq/0RROzfF16vYZ8cPI1
        V4mFtoDVq1wmiwaWYovXFKcDkvHbqNI=
X-Google-Smtp-Source: ABdhPJxU1JklH4uGyIG80yvHBF7BDi3MgXP0+8x1yAWvZjz2pPPsa9wutUAnauMxMPwT0R6ka13LUw==
X-Received: by 2002:a63:490e:: with SMTP id w14mr2364677pga.275.1603944953524;
        Wed, 28 Oct 2020 21:15:53 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id d186sm1116261pfa.76.2020.10.28.21.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 21:15:52 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
Date:   Thu, 29 Oct 2020 13:15:38 +0900
Message-Id: <20201029041538.4165209-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029041538.4165209-1-daeho43@gmail.com>
References: <20201029041538.4165209-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new F2FS_IOC_SET_COMPRESS_OPTION ioctl to change file
compression option of a file.

struct f2fs_comp_option {
    u8 algorithm;         => compression algorithm
                          => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
    u8 log_cluster_size;  => log scale cluster size
                          => 2 ~ 8
};

struct f2fs_comp_option option;

option.algorithm = 1;
option.log_cluster_size = 7;

ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---

v5: allowed to set algorithm which is not currently enabled by kernel
v4: changed commit message.
v3: changed the error number more specific.
    folded in fix for build breakage reported by kernel test robot
    <lkp@intel.com> and Dan Carpenter <dan.carpenter@oracle.com>.
v2: added ioctl description.
---
 fs/f2fs/compress.c |  5 +++++
 fs/f2fs/f2fs.h     |  7 ++++++
 fs/f2fs/file.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7895186cc765..816d7adc914c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
+bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
+{
+	return algorithm < COMPRESS_MAX && f2fs_cops[algorithm] != NULL;
+}
+
 static mempool_t *compress_page_pool;
 static int num_compress_pages = 512;
 module_param(num_compress_pages, uint, 0444);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a33c90cf979b..cc38afde6c04 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -435,6 +435,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 						struct f2fs_sectrim_range)
 #define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
 						struct f2fs_comp_option)
+#define F2FS_IOC_SET_COMPRESS_OPTION	_IOW(F2FS_IOCTL_MAGIC, 22,	\
+						struct f2fs_comp_option)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -3915,6 +3917,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
 void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
+bool f2fs_is_compress_algorithm_ready(unsigned char algorithm);
 int f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity);
@@ -3945,6 +3948,10 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
 	/* not support compression */
 	return false;
 }
+static inline bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
+{
+	return false;
+}
 static inline struct page *f2fs_compress_control_page(struct page *page)
 {
 	WARN_ON_ONCE(1);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8922ab191a9d..a0f31d8ebcfd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3963,6 +3963,57 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_comp_option option;
+	int ret = 0;
+
+	if (!f2fs_sb_has_compression(sbi))
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
+				sizeof(option)))
+		return -EFAULT;
+
+	if (!f2fs_compressed_file(inode) ||
+			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
+			option.algorithm >= COMPRESS_MAX)
+		return -EINVAL;
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (inode->i_size != 0) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
+	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
+	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
+	f2fs_mark_inode_dirty_sync(inode, true);
+
+	if (!f2fs_is_compress_algorithm_ready(option.algorithm))
+		f2fs_warn(sbi, "compression algorithm is successfully set, "
+			"but current kernel doesn't support this algorithm.");
+out:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -4053,6 +4104,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_sec_trim_file(filp, arg);
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 		return f2fs_ioc_get_compress_option(filp, arg);
+	case F2FS_IOC_SET_COMPRESS_OPTION:
+		return f2fs_ioc_set_compress_option(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4224,6 +4277,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 	case F2FS_IOC_SEC_TRIM_FILE:
 	case F2FS_IOC_GET_COMPRESS_OPTION:
+	case F2FS_IOC_SET_COMPRESS_OPTION:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.29.1.341.ge80a0c044ae-goog

