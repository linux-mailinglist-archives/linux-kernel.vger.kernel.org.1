Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE98729861D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 05:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420661AbgJZERK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 00:17:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46844 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgJZERJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:17:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id y14so5458270pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgJnVhZ++DLjTZN2JC7MwIDGm1rQwn+cwIsU1CQlwyM=;
        b=UhZECgGbXap75eC+90RNG+ayMieTzqzLAxsgnvjP/BXWrZWPtXHQlqCH8qy4FKnpYP
         9ny4zO2unSSfxqUxwhO5L09yKPMJraJtuMeWRy8DQahJ1htARl0DhsQgmDXtvs/yekQz
         lM7I1J0dMg6kmExe7ugMSASqC/xrD6BqY8oVTB8lAMepHED4MppbwCj7TGYYNOUWpJHr
         7CmSkzvCpovxLCQAUnFqnfXholQtnBWMsWkBBtrbz9wRjKRi0rHl7uE6QrVWAtcq5bXY
         Ez6eKc4NLe+gP2r+5BDbPKsdlXV7ufQKIumLACbfUExrDXq8LJw5noxpbRuZe3lWkhnU
         l5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgJnVhZ++DLjTZN2JC7MwIDGm1rQwn+cwIsU1CQlwyM=;
        b=opImcRZW9MQ3LYkTY/fvs8D9QdrUTU8KYTWNGjg2MFlNicolBuyruMslw2jPI2kUts
         bWIldvR5vaIl5V1kHSgz8oUtYP/jJ3AOBrpAO6/UmMGLjciaWx0KUqRFK7rmwKDv9nbd
         9OevRxkTePLyq629vMM4QHmnoRJ9VpFDuY8XXAFHEdzZTYSSfSG6035loSKKCFl/rIOa
         QpX8jERjyUa5hbdwl/1HE2TiVwd2i6RX8AZMhlVmjcUo4ck0Nd0Z29hOCvSTu9HDBwud
         ZYUlFXmIHlvEkaY3xqdKycpt6CtcTZ3DqpZJRE6FSForexkuETXKyeAAE0u7lAwS1yq3
         w4ww==
X-Gm-Message-State: AOAM531o0Sd9Cb7oPFYoNRNcF+u2+RhTvoRDe5J3D7YMZjsVkkGwjX+7
        TDDXa0S6VKoC5Chq833pVFnN+jtBQyY=
X-Google-Smtp-Source: ABdhPJwI+ywh+mS+mgkh5h/tjgWrBuqpNGniIBdB8tSsk839l0YQL1c30rwkC/PcrkjxSlrvHoLWsQ==
X-Received: by 2002:a63:f40a:: with SMTP id g10mr12532875pgi.66.1603685827217;
        Sun, 25 Oct 2020 21:17:07 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id b20sm10030627pft.55.2020.10.25.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 21:17:06 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Mon, 26 Oct 2020 13:16:55 +0900
Message-Id: <20201026041656.2785980-1-daeho43@gmail.com>
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
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---

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
2.29.0.rc1.297.gfa9743e501-goog

