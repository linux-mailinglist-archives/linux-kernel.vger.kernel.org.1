Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4629FB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJ3C15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJ3C15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:27:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:27:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 13so3985682pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B60xVbhPe7rb6EgjNTjb/8plxpCQprGZrIuoqWSL9gY=;
        b=ZwGyii0vEEV7yAtOirV25Mk5Ork0AfFf9W4/77JUJw/QyA70vkLNYpMdO/MFDUUwA9
         JMRskGNLJ0+LuplA0Tu1gia4MqUHewyZCkqGDqNFMxnPTHC1bjChm7Gz9uYsEuCcN1M7
         oVGfaTiffXVwU47KqajHfqT3gr1T8mzROtCGGecI+KQaPxjoIRGBKNYwHg0E+1XeiBNs
         xAwZMgozJvTdj6a2d6CJNN45vMXFXTUn9zjnNiKP5HR15Wg30Eg/JO7qL7aRtBDQX7Up
         qv9ofQpNCPJ4K5AEjdxuLdxvMxtT9cl/bWL5sGAu2a3viaVL8vs2Q67l4Mh2cx1kQ1ul
         I34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B60xVbhPe7rb6EgjNTjb/8plxpCQprGZrIuoqWSL9gY=;
        b=g0aoS1vy0FGXTck3x+g76WH/whAO2S4eKUnKIrXhmaO675g3qzOsvixkV9L0qip12m
         Uw3xWdeTFEd5CKbowGGZ1I/ahyayRekUL+QEXgd7mQFZ0TaX+uysl8nPtOr+4X5uoTKz
         TClFwP+LmL40bEWrwZBxX0+e9uQq4uyTlHL5hYbJ7G1jzp73hAaq2sU2E+pp/ds95GGu
         LO7iCOdMuVQ54Wtm4pH1WY5l10PkJbQyN+CcwZjtrRbX6MC9oBewCAzEK459WHs/bxzI
         XtKcgm7KvO7SAIQANzwOL5F9nsxSZfQqTCUjk7LZIZFZ/90+zEpsarBrcUiM5B+YeYpP
         ETLQ==
X-Gm-Message-State: AOAM53246+1eOQmV0KZKtaqZsOKuuruoYRY0xPJluB991Os6y7smAlv8
        BowZS/Ct7J2Y3Avvw8j+GfQHJw+B2Hk=
X-Google-Smtp-Source: ABdhPJxqEJU7lcRxu0xqThY5dQsPj+rwQXsaHEyD1VedG6oepKlzs6U69vxwmyyFyI/MFbuiR2A9Og==
X-Received: by 2002:a65:4b84:: with SMTP id t4mr237102pgq.138.1604024876259;
        Thu, 29 Oct 2020 19:27:56 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id mp13sm1207967pjb.36.2020.10.29.19.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 19:27:55 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v6 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Fri, 30 Oct 2020 11:27:47 +0900
Message-Id: <20201030022748.332831-1-daeho43@gmail.com>
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

