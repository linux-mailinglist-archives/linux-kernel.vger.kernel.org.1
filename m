Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4903F29861E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 05:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420719AbgJZERN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 00:17:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33685 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420573AbgJZERM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:17:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id j18so5502199pfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVUY8XDBh1qaAwzm2t2SSRv1K8UOH5wvkyKHMRF+1+Y=;
        b=TLuMwJYk7SPCQIJe4UJEpmO2/coM3XMNWVICgf73Dp+HxMreBd1jpoPovnPFO1pX45
         0Rj2URPXTenNoZ1ZoV56/jI0uBg2yWJoC0oSHn+IadKn41h0hguj2Q/Tpz+qanKng0Xm
         onEYmeKP5KbkbXm3f8P3EmjMOuRe2zF5UNR3qI6gCMb3SGynhxlPlzAP8PiCRL41tXYj
         JMMhVfDcmmM7eieMvSiGwaCnqz/b4WMM3YKEzXX+umxA7+7u3pCi+0dDr3S8D6rmMsaI
         NpMUMKf9/JIxcNDKMpkp6Rkh1kd8n8iqTTDekWnQIdh0CVNCNVJRIjyw0Nua8cl4rvIC
         kwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVUY8XDBh1qaAwzm2t2SSRv1K8UOH5wvkyKHMRF+1+Y=;
        b=o57jrFCH/HE+a/hiB6JTSnSb4d4f177NACzIk1biTgRwL31hLLreenmNdwGQkD8Yd4
         kWRqk0Ywg5O97ChZ8jFGYbHBmXTAb4NBn1WbkCsFu1teqsTQqhm4dZdxKMzThQqlqpkw
         KA6K02e3wOegXHgeURsdEn1Wd5/KsmK9Gd9o++zdp4vjmc4mH/q0XbIMklC3bESSaijj
         EoF8LCSrNDVf3fHS3CpJDJdw9cQSZeop2A30rIis0qcz9WgvNyNCL8s+SQGUD7sKcB5C
         m2Av897b3QbGyI1vk3lvaiaZOgoIV/zbdr0UXmC/pDTdm9BxqpCvq3bHLiTU5PeCjIp+
         RINg==
X-Gm-Message-State: AOAM532K9ej/HwFCyt49zaeQv3d4Xd4+2jb9+3eL06oqA783b7DaeP8G
        MPVX05eRAjQoNfvcXzMDxHsbNCqhKNk2bw==
X-Google-Smtp-Source: ABdhPJwoe7u/X8d3SEBCu15nsVed+k20I9hEGiEl4kN6YU0EnUfzuISndKdhXVPIkRIU+YFye0CfQw==
X-Received: by 2002:a63:354c:: with SMTP id c73mr14761654pga.315.1603685830837;
        Sun, 25 Oct 2020 21:17:10 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id b20sm10030627pft.55.2020.10.25.21.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 21:17:10 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
Date:   Mon, 26 Oct 2020 13:16:56 +0900
Message-Id: <20201026041656.2785980-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026041656.2785980-1-daeho43@gmail.com>
References: <20201026041656.2785980-1-daeho43@gmail.com>
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
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---

v3: changed the error number more specific.
v2: added ioctl description.
---
 fs/f2fs/compress.c |  5 +++++
 fs/f2fs/f2fs.h     |  7 +++++++
 fs/f2fs/file.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

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
index 8922ab191a9d..8048b150e43b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3963,6 +3963,55 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
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
+			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE)
+		return -EINVAL;
+
+	if (!f2fs_is_compress_algorithm_ready(option.algorithm))
+		return -ENOPKG;
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
@@ -4053,6 +4102,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_sec_trim_file(filp, arg);
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 		return f2fs_ioc_get_compress_option(filp, arg);
+	case F2FS_IOC_SET_COMPRESS_OPTION:
+		return f2fs_ioc_set_compress_option(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4224,6 +4275,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 	case F2FS_IOC_SEC_TRIM_FILE:
 	case F2FS_IOC_GET_COMPRESS_OPTION:
+	case F2FS_IOC_SET_COMPRESS_OPTION:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.29.0.rc1.297.gfa9743e501-goog

