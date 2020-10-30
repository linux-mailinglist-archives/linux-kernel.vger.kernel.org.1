Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA4F29FB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgJ3C2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJ3C2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:28:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52430C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:28:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so3951284pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6j0d1liRXtmZgJz/uib04kzQvCzDNmh9oEoxa0otezM=;
        b=FDv6bjtLnEOT5O/NcTH5wV1jVuDd+7yn9o2ukpKpMDQahiSu7djlAbtrulpvYh2G4N
         e90DlJLg5EpQDVwxvftmvCqTJ7ab5qNT9eDDNwps/JGWRSMY/wvY5bZ977EO39PcfOEG
         k+439UJ3NMX9qjEBnu0maECcChJq5ScsffK2drf4R3xVBaOqR2r5QWUqkd9G9l0ryC+U
         Hw4w2DROuTbClfSnSa/iZ/n9bmeZ0MhNjxKCFm+p1M1w41gb3FooV2tglo4kavD6Gz7u
         1Dh9bVT8CtcOzXsNa9ZgvKVEBpjVtWfjNMsOK3B1pGIm4EatJfUu0K+Ks4gJaMtyeFWF
         LVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6j0d1liRXtmZgJz/uib04kzQvCzDNmh9oEoxa0otezM=;
        b=NekukKgwk+hJpKxB+Itc9tA4ePVmLQcBHuzFj0ZfFTNMb79/JWyuCgGoOiJKR4sDoB
         QfRGUIjvzRDXKiTqLVfqIlvL4KFiY1dgpAultq4e3nPAWQodXIsWKAJzY+hOS+Eg7Mil
         7Uty3mToLAPwcTRzSRym8uDP0D7mmsyagwS1pcppuoD/XxK9fRvuu/iZlRCBG5HOMUdV
         No51FMSyG3rX56aNc1ewWQLvtgVLbWscu6/dOktDp5WoVtXYYqf+KfKYpT/jX8NjReWa
         eCRVc01ElF7Tt2g7t+hZ2tf9wr/5UbPoZyDYasR+PmBxoSNiHPzZs6fAG3W6ChMG4/oX
         9DwQ==
X-Gm-Message-State: AOAM531VY6+3tsc5sB4hz3Wf/q93Ah36LKpcE7AReAeDbkkNmKxHSaBT
        USMxCI4pxuLoewwHmfw6ZFDfQahBRok=
X-Google-Smtp-Source: ABdhPJwlSI6t5JHN2/b65h/7qnwcJGwBJx+/0pPaBmCnuF1PDb/HNgjprhaBwAHp6h64BE0hQ1ClmQ==
X-Received: by 2002:a17:90a:a514:: with SMTP id a20mr76054pjq.213.1604024879497;
        Thu, 29 Oct 2020 19:27:59 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id mp13sm1207967pjb.36.2020.10.29.19.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 19:27:58 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v6 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
Date:   Fri, 30 Oct 2020 11:27:48 +0900
Message-Id: <20201030022748.332831-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201030022748.332831-1-daeho43@gmail.com>
References: <20201030022748.332831-1-daeho43@gmail.com>
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

v6: changed the function name of checking compression algorithm validity.
v5: allowed to set algorithm which is not currently enabled by kernel.
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
index 7895186cc765..b0144670d320 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
+bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
+{
+	return f2fs_cops[algorithm] != NULL;
+}
+
 static mempool_t *compress_page_pool;
 static int num_compress_pages = 512;
 module_param(num_compress_pages, uint, 0444);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a33c90cf979b..70a8a2196888 100644
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
+bool f2fs_is_compress_algorithm_valid(unsigned char algorithm);
 int f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity);
@@ -3945,6 +3948,10 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
 	/* not support compression */
 	return false;
 }
+static inline bool f2fs_is_compress_algorithm_valid(unsigned char algorithm)
+{
+	return false;
+}
 static inline struct page *f2fs_compress_control_page(struct page *page)
 {
 	WARN_ON_ONCE(1);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8922ab191a9d..9fbe98a90301 100644
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
+	if (!f2fs_is_compress_algorithm_valid(option.algorithm))
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

