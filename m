Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81C2C9645
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLAEI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgLAEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:08:57 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B33C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:08:17 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id s2so369646plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jE3125qtgCcvfVOdGXVIuHLlo/pTilZkAQEoLFhiTKM=;
        b=N6qJdLZ4Dz+2EsFvQkQDmi1GrVzzyaeh39kULeLQNm0Ei1He+/0dtXTdfmpo+F2ukE
         NxSrUKHYWxOzT5o8NTbOs3zErwXo3/VlNSYe+yb1uFiMTHziMAJbNWRHZj439Om7h1Ur
         QBTB3Gy7IZsUNOAuwKDhWPYuVnaIlPYXGh9eebxRNElg1lSujDhl20kGyfmuI1+8ecAD
         JoGBmYwIzaqCAXSQJUQw8d8cp55HDSAmtSbGnv5TOSzrHLlVzEJnFctSFRrAmP+82kiL
         SHeN1904fSc471ZbI0xQBMp8XYSkxiHeuTFdDnrOxqrRnx7lzkrcN6xxxo1YKaugieJD
         XfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jE3125qtgCcvfVOdGXVIuHLlo/pTilZkAQEoLFhiTKM=;
        b=XnFcVOt8mYy1VFu8CZakNFqQ653cFzjBdTBwtl0zd9s0f6P2I/H+6RfnVcAuUIebq+
         PWJT2XtM2G39JE0inHWjg1DTI10ttisBELFeJzworhXkKoXPxtKYeVMHweaYOm99Tn4y
         AYTe/QmmjXh10famNmaQl5bB5+s9za9IIbS0lHRTuZYTFnZmSJHXUIFQ9a4Thw4YnYrd
         Nh+TlK4XatbM4EsL3GlD3g3COb597TePq5b6QCYBnNZ1o2QuEDILwLjUrJqyV7jD8mkY
         c0Vi4lyXAjuakxEmaHG6wQQ7TtS34q8syWtdwL+p4BwAUntxVn9gCDz6tFQ20u5aOdV9
         MJzg==
X-Gm-Message-State: AOAM530PRaz55zLsTbi2kyQfkugjiqbY5y4kS/6HDJFpgcw0I1aaJU8o
        2huA53eG4Rx60jRqIWbBkHXmkndukyU=
X-Google-Smtp-Source: ABdhPJxKsPkzn1jDGlos/QDoM/r+L2oOMBRZvvK8F5cwudmMgnRq6B3YvUitwJC4vKfeNpYPcpJl4w==
X-Received: by 2002:a17:90a:7c44:: with SMTP id e4mr786807pjl.138.1606795696138;
        Mon, 30 Nov 2020 20:08:16 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id e141sm606733pfh.13.2020.11.30.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 20:08:15 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
Date:   Tue,  1 Dec 2020 13:08:03 +0900
Message-Id: <20201201040803.3590442-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201201040803.3590442-1-daeho43@gmail.com>
References: <20201201040803.3590442-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added two ioctl to decompress/compress explicitly the compression
enabled file in "compress_mode=user" mount option.

Using these two ioctls, the users can make a control of compression
and decompression of their files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: reformed codes based on comments and put gradual flush routine
---
 fs/f2fs/file.c            | 185 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/f2fs.h |   2 +
 2 files changed, 187 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be8db06aca27..300355fe25f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4026,6 +4026,185 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
+{
+	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	pgoff_t redirty_idx = page_idx;
+	int i, page_len = 0, ret = 0;
+
+	page_cache_ra_unbounded(&ractl, len, 0);
+
+	for (i = 0; i < len; i++, page_idx++) {
+		page = read_cache_page(mapping, page_idx, NULL, NULL);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
+			break;
+		}
+		page_len++;
+	}
+
+	for (i = 0; i < page_len; i++, redirty_idx++) {
+		page = find_lock_page(mapping, redirty_idx);
+		if (!page)
+			ret = -ENOENT;
+		set_page_dirty(page);
+		f2fs_put_page(page, 1);
+		f2fs_put_page(page, 0);
+	}
+
+	return ret;
+}
+
+static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	pgoff_t page_idx = 0, last_idx;
+	unsigned int blk_per_seg = sbi->blocks_per_seg, dirtied = 0;
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, ret;
+
+	if (!f2fs_sb_has_compression(sbi) ||
+			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (!f2fs_is_compress_backend_ready(inode))
+		return -ENOPKG;
+
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_mmap_file(inode)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
+	if (ret)
+		goto out;
+
+	if (!atomic_read(&fi->i_compr_blocks))
+		goto out;
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	count = last_idx - page_idx;
+	while (count) {
+		int len = min(cluster_size, count);
+
+		ret = redirty_blocks(inode, page_idx, len);
+		if (ret < 0)
+			break;
+
+		count -= len;
+		page_idx += len;
+		dirtied += len;
+		if (dirtied >= blk_per_seg) {
+			filemap_fdatawrite(inode->i_mapping);
+			dirtied = 0;
+		}
+	}
+
+	if (!ret)
+		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+							LLONG_MAX);
+
+	if (ret)
+		f2fs_warn(sbi, "%s: The file might be partially decompressed "
+				"(errno=%d). Please delete the file.\n",
+				__func__, ret);
+out:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
+static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t page_idx = 0, last_idx;
+	unsigned int blk_per_seg = sbi->blocks_per_seg, dirtied = 0;
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, ret;
+
+	if (!f2fs_sb_has_compression(sbi) ||
+			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (!f2fs_is_compress_backend_ready(inode))
+		return -ENOPKG;
+
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_mmap_file(inode)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
+	if (ret)
+		goto out;
+
+	set_inode_flag(inode, FI_ENABLE_COMPRESS);
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	count = last_idx - page_idx;
+	while (count) {
+		int len = min(cluster_size, count);
+
+		ret = redirty_blocks(inode, page_idx, len);
+		if (ret < 0)
+			break;
+
+		count -= len;
+		page_idx += len;
+		dirtied += len;
+		if (dirtied >= blk_per_seg) {
+			filemap_fdatawrite(inode->i_mapping);
+			dirtied = 0;
+		}
+	}
+
+	if (!ret)
+		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+							LLONG_MAX);
+
+	clear_inode_flag(inode, FI_ENABLE_COMPRESS);
+
+	if (ret)
+		f2fs_warn(sbi, "%s: The file might be partially compressed "
+				"(errno=%d). Please delete the file.\n",
+				__func__, ret);
+out:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
 static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -4113,6 +4292,10 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_compress_option(filp, arg);
 	case F2FS_IOC_SET_COMPRESS_OPTION:
 		return f2fs_ioc_set_compress_option(filp, arg);
+	case F2FS_IOC_DECOMPRESS_FILE:
+		return f2fs_ioc_decompress_file(filp, arg);
+	case F2FS_IOC_COMPRESS_FILE:
+		return f2fs_ioc_compress_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4352,6 +4535,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_SEC_TRIM_FILE:
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 	case F2FS_IOC_SET_COMPRESS_OPTION:
+	case F2FS_IOC_DECOMPRESS_FILE:
+	case F2FS_IOC_COMPRESS_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index f00199a2e38b..352a822d4370 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -40,6 +40,8 @@
 						struct f2fs_comp_option)
 #define F2FS_IOC_SET_COMPRESS_OPTION	_IOW(F2FS_IOCTL_MAGIC, 22,	\
 						struct f2fs_comp_option)
+#define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
+#define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.29.2.454.gaff20da3a2-goog

