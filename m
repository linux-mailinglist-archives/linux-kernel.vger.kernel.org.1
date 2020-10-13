Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708E228C71B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgJMCYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgJMCYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:24:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171CC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:24:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so2952162pgt.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEV/cWEF/JYPft5qQa3SDqcnDv+itkYtghzo7XBgFNs=;
        b=GWOTVtAdo8DKLCg2sfVY/T+Lny64tP5ZynNSLR/cL67sSFaJyP6GD/dKjlhcsAyceo
         d3hNAVF5U5SwXvV5b4XPZG4+8CZRqeP4RUjKqRW1Y7Dk+Mq3BgVTfRi/FrP7w/A+pAHV
         0oW60V5PPlUMK8I6VxYREn5YzJHO9LTug1tiwOfNO6/YiNTFJAe8QbrGbUF1VhXLBA1v
         LTd56ImOOqEBn+OdQsG9FVG93lh9DJPSeReGva2hrAPQlqnq9dFKqcnKHe3DzCCb0Urw
         VmV/MnJM9QgEgrqjJ0ZhNGeNaHQcTQWrIxgUBfbEaq9iPp7K7a+YW455cueLbEaxufv6
         fF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEV/cWEF/JYPft5qQa3SDqcnDv+itkYtghzo7XBgFNs=;
        b=nwGA/F/n/vBu2QJ65+oOH0tZMU1pI74CfwQj73k/prAS3fNM6NV80QqO9y9dAyXg+v
         MhfnROnGOu+DeIW1KKZ5Uk0u6r0oLp9DhS0DLgFq5oql2DdzsOcgehFRpAOE9d9cNKA3
         QRPEBFhCqXYH+mghODBLKk3WzEJUOV6OBwGy/K266UI/bdVXTO53uNgcCUrbTnWx/nZl
         gQbMeK0h3g0uWMEiDtWjRt88Ov5l2X3GDTMyMv8NghvEyy1F2v4/pvMfoGTpV86IO20T
         tSi7hzSaHjLN7ZNDej/5HY3J7ZNHxdwR0ALnFiUdj31og1yiMaLHSQTLIUgkMzkHEohB
         mxQA==
X-Gm-Message-State: AOAM531IZesFH9QvyztFsvp7MTywu6kiGpvd+HUFD54f7gVFrlB+H4zY
        GoUF1ZicK4Kio+Z6PEkILgceOrXJGMU=
X-Google-Smtp-Source: ABdhPJyZCW3khH+xOjDpor/Y+i/yJb2TjIDKDk0jJX4xd86Ae/x4Beb8doS1Lj5v6QMZNu/PcQ34lw==
X-Received: by 2002:a05:6a00:8c5:b029:142:2501:39e6 with SMTP id s5-20020a056a0008c5b0290142250139e6mr26902826pfu.53.1602555885313;
        Mon, 12 Oct 2020 19:24:45 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id d194sm10581110pfd.172.2020.10.12.19.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 19:24:44 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
Date:   Tue, 13 Oct 2020 11:24:29 +0900
Message-Id: <20201013022429.454161-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201013022429.454161-1-daeho43@gmail.com>
References: <20201013022429.454161-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new F2FS_IOC_SET_COMPRESS_OPTION ioctl to change file
compression option of a file.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/file.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a33c90cf979b..5ee8a4859b62 100644
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
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7e64259f6f5e..6c265c66ddd4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3963,6 +3963,59 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_comp_option option;
+	int ret;
+	int writecount;
+
+	if (!f2fs_sb_has_compression(sbi))
+		return -EOPNOTSUPP;
+
+	if (!f2fs_compressed_file(inode) || IS_IMMUTABLE(inode))
+		return -EINVAL;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
+				sizeof(option)))
+		return -EFAULT;
+
+	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
+			option.algorithm >= COMPRESS_MAX)
+		return -EINVAL;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+
+	writecount = atomic_read(&inode->i_writecount);
+	if ((filp->f_mode & FMODE_WRITE && writecount != 1) ||
+			(!(filp->f_mode & FMODE_WRITE) && writecount)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (get_dirty_pages(inode) || inode->i_size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
+	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
+	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
+	f2fs_mark_inode_dirty_sync(inode, true);
+out:
+	inode_unlock(inode);
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -4053,6 +4106,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_sec_trim_file(filp, arg);
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 		return f2fs_ioc_get_compress_option(filp, arg);
+	case F2FS_IOC_SET_COMPRESS_OPTION:
+		return f2fs_ioc_set_compress_option(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4224,6 +4279,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 	case F2FS_IOC_SEC_TRIM_FILE:
 	case F2FS_IOC_GET_COMPRESS_OPTION:
+	case F2FS_IOC_SET_COMPRESS_OPTION:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.28.0.1011.ga647a8990f-goog

