Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446AF29FC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgJ3EKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3EKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:10:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D80C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:10:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so2334851plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgmumI7ZIdl/4zrrr5Jig1yUiHUmTmfn26+X9c6IFVs=;
        b=qNM4RhVb1q48eUupDZKli/1pY7yqujmJCWgLpbCOvX6JanI3X+CsbJ5WDB+Sc91J35
         pvAkRhyEYunBiBmChUoP3gmpBpWJRfuygVwsuu34BiRp+t48MMUUbZv6WySe6r9r6xDf
         jfiHuIi1He7vLOVuHNZpqESp2BXG2XrVKVj1CMAk1k4l+ofG5qe2NxoODZN2PuBTZDXP
         b60xENMOIeCTyrZCdcCrQ79iZ30vkau0VEMHMsSuL3PYCh7Oub6UPvvFKrPG4zkUNgOQ
         0oipxy5xa7533q/hyXUFf31UROmDpOR3ZQ1DTJmCP3t+WFqEGUv3/3hFkKhurftOoBKW
         vLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgmumI7ZIdl/4zrrr5Jig1yUiHUmTmfn26+X9c6IFVs=;
        b=q2LPLCoVP0DLgk3vfjLjy5csNqtpRJyuhqLSWC+MDeyZVIqfyT5fZslHwIjzQoEYTz
         4TNVe1PuqBmjV5FclNhC3jPXF/hidB0diwN7rQRtKc5v+GcEz3ER4ZLndey6QKP5HuWi
         Y1tAwUGlMa7ikKhz8FBkrlOCiHsQRXddv+MhUcEP/9Kji6P+GeNcj+7wqGpqXuLv3Yt5
         CUpBzv0cT3guhZrv0eCukA/DqgPCrRwMBo3VbYeteAInBpLdrHC4t+JhJlf9YYF/4IQi
         0+gAavpfDrpU9zbHpqJyRUvAyor+hPoX3NIRDIa3+bP1OnSn1Nns96+dnMez8nl8WAAh
         SQeg==
X-Gm-Message-State: AOAM533f0rWiBG/ir+ls73a/6T8YmlykTnpsA0iQxA+ZTcEHt0Lt9uAw
        Bw2G1zP2Q/igOEpsHfh2R8eM6NSVm/Y=
X-Google-Smtp-Source: ABdhPJw9P3o5FdZSz4JHibDPr44lFl3PH28cn8aoMLjnKpkFK+oSDgPmhnQTCNjRs8XtejbNGhUKEQ==
X-Received: by 2002:a17:902:b903:b029:d6:631e:c99e with SMTP id bf3-20020a170902b903b02900d6631ec99emr7476075plb.14.1604031041414;
        Thu, 29 Oct 2020 21:10:41 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id k9sm4374326pfi.188.2020.10.29.21.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 21:10:40 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v7 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Fri, 30 Oct 2020 13:10:34 +0900
Message-Id: <20201030041035.394565-1-daeho43@gmail.com>
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

v7: changed inode_lock() to inode_lock_shared().
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
index ef5a844de53f..bd52df84219d 100644
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
+	inode_lock_shared(inode);
+
+	if (!f2fs_compressed_file(inode)) {
+		inode_unlock_shared(inode);
+		return -ENODATA;
+	}
+
+	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
+	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+
+	inode_unlock_shared(inode);
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

