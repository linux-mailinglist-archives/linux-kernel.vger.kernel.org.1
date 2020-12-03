Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E52CCFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgLCG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgLCG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:57:04 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F390C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:56:24 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so625004plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lc7bOrg/2FPLXC69S/OBOmR0G1J50Q697SgCANI/bBs=;
        b=QQ9ZUZ84N4fy6aMyDjIfHfgqPPGjv53vw1SQLLrNnZb5YU2D+jaaH8GUYCCyGEpPr/
         UDrE0j+T5G4nPfsYN0dDIlIO38AD3xaxobQ2xiR7eK33kfSiQcv5LvKcT8mDaSUZJYAF
         JaYJfdQu0o57sZaSdAgnA0JTBvOTQ640EZOEsVGeS8AZjoLkkOcqRFROi2Qd1vnL7fzg
         9281Blg9eZTDyUH/zxyjY1+ZjYOItGg5bylRrPhbXYw0UNFFmmI2zrgGrRtWKV+G8pZf
         f5a6w8wgMsVtbWr18IujwTH+lm3xoqbxiLdKD45ftLIq+xlX+kkg9ivt39DS/gwjAjcH
         +sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lc7bOrg/2FPLXC69S/OBOmR0G1J50Q697SgCANI/bBs=;
        b=WB7Io6xcp4e/7r15UTivQEYo0ivifGRPQUJk0jfglaOBBVjUemNgLnck7ZWk6q02Sd
         etrGR6+lCgkQzxhqHxfO9l8U1ZUbljS9ojrXYA28YAdnBO0TcEm9mplS6MqT3xBn2Aj3
         SxRC4Rr4JRpYSCXPNbbsAf+0ZbC+20rJngKYvECuBtJS+COgiTfmV8fYVjc6VpPXerCC
         lBJUmXwltDSR8nwZACHkkd6+NgXCJu42Xl0zBSDDwEpjpCV+GY83jcS5ZYOpbwjtX3oo
         DOH72e79K8nGXTAH74zX/1uAB1wZBS3HINL+r12QZHPbVmnTpoj5FPw58ZR/gXO9SXtv
         OwQg==
X-Gm-Message-State: AOAM531GQrZdAc6Qd9xmeH9OXhWYcTM9DAuqnIpt+oKaeyrwhcTIzYi/
        Dhcr2Pg4kaTY7YX4lLGWZPyKMD85/GI=
X-Google-Smtp-Source: ABdhPJzEZ2uZ4dnP4N+fcWX96To1xyNjRf0eSHN3fFkdvGVmHHaFGFHV31Issgu0wU4cctRtTG9rtg==
X-Received: by 2002:a17:902:44e:b029:da:b944:b798 with SMTP id 72-20020a170902044eb02900dab944b798mr1906507ple.6.1606978583225;
        Wed, 02 Dec 2020 22:56:23 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id c66sm637885pfa.0.2020.12.02.22.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:56:22 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
Date:   Thu,  3 Dec 2020 15:56:15 +0900
Message-Id: <20201203065615.402494-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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
v3: changed error condition and use get_dirty_pages for flush routine
v2: reformed codes based on comments and put gradual flush routine
---
 fs/f2fs/file.c            | 185 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/f2fs.h |   2 +
 2 files changed, 187 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be8db06aca27..3678e25ed17a 100644
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
+	unsigned int blk_per_seg = sbi->blocks_per_seg;
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
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (!f2fs_is_compress_backend_ready(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
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
+		if (get_dirty_pages(inode) >= blk_per_seg)
+			filemap_fdatawrite(inode->i_mapping);
+
+		count -= len;
+		page_idx += len;
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
+	unsigned int blk_per_seg = sbi->blocks_per_seg;
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
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (!f2fs_is_compress_backend_ready(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
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
+		if (get_dirty_pages(inode) >= blk_per_seg)
+			filemap_fdatawrite(inode->i_mapping);
+
+		count -= len;
+		page_idx += len;
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
2.29.2.576.ga3fc446d84-goog

