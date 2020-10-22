Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF612956FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895572AbgJVD7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442922AbgJVD7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:59:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6546C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:59:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bh6so253075plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZM3tGZHf4rzxz8mYF7qCc/LLm8RaVsAbyP3sONq6oeY=;
        b=gC48ja+gyQbzVCcvvm4NioF3HTd7qABlD05xYvmm55tm22iKleXbt6dSWH6XfXu6b2
         ruUiC+3ZJO61O5t3S7xtr2uvkvfCxU1rl0LQYmw/gsGx7juPxDGOm/nOhiRslzkSkLVI
         zLy2EEQVZF2dS2Q6OBwi0Uvr1qjIv2azc/pC9VNnLdVN+D2qvmcCpEOvxSJ46R00TTX8
         cU8ET2imKl4MQBEw6IgjggOWpW6AsBwKy8p7LP3ioBy/b9LKgk8UOwhT2IRbLUYYH1W2
         4h6yLRUOxN5VK3N7gAPaTQ2gcd+Zn6eJ7JAAQR+Fw0CAcrjyM+C2zcCCopFtWNz2d4J0
         auog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZM3tGZHf4rzxz8mYF7qCc/LLm8RaVsAbyP3sONq6oeY=;
        b=J45L9EoEAz7xdpiknEBXRYnDBA83IDQPICmQn5uaimJ933cBbM8oTTt+p9mTNZHwE7
         aQyybeqxAPnBrdlEGXVPP1Oqa9aC77Fx4xRTh2aMOzkGD6vLO0SFVcyZotwzg0zkZ7k/
         SA4q2HWqWFDxIY02n2yEIRFDSxcGu26ZP8ONesJoqIAX0LOTjSjHKcYtN8JgsCnNzSEu
         FmNpVBxz79ZzDZpwJHMt3yRePm39ODQGIqplINW43PsRkliUG6taBrZqWPV/0eXF6sN/
         qi3gDRguft+9EVkzOC6NwT90pBAOaEOy3+BTwZvaJZ6CGxFSQsnFTvZET8VoJ9yoSyOC
         eMuw==
X-Gm-Message-State: AOAM533S6+bN6v7IijLAGLTl4efts36sBNRkB1J5/D/BCYwgioPZsS/y
        o9Y+QPUQT/IEIy2SAJJijVE4t5uqUVA=
X-Google-Smtp-Source: ABdhPJwRDSUYZrMc8FZdxt1TvnELv/oyaof4Ao4bOKc6wEWE7Rl1VgU9ZSy57CGmK4gQ2iDu0TYhhA==
X-Received: by 2002:a17:90a:7486:: with SMTP id p6mr589011pjk.162.1603339139561;
        Wed, 21 Oct 2020 20:58:59 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id q81sm276879pfc.36.2020.10.21.20.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:58:58 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Thu, 22 Oct 2020 12:58:47 +0900
Message-Id: <20201022035848.976286-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
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
2.29.0.rc1.297.gfa9743e501-goog

