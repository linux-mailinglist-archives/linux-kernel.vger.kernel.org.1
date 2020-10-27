Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFC729A431
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505926AbgJ0Fi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:38:26 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34114 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441525AbgJ0FiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:38:25 -0400
Received: by mail-pj1-f65.google.com with SMTP id b6so250296pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y88FdVXAgfg5w8PyflknRqNxB6/N6fKsnjWxZd+03NM=;
        b=Ueh7Hse2bmKx46Y6BDGHFuX3F9o4sLgKwhpQ+5wTCBm7sBnNy0MBuNHCo7tIAjrwmC
         f3zFPYMUohNPlD71bm8dQ8sKaSIFHZrXyU6CyyktrId62npDXV/8a9igN+R1sOcinvIS
         F5Y3i2psZFaVJiMbtpCJlPCRkroZdRBjYIo0YTLB5v3qq/8wOncpfd9U2JF5jorYYlMb
         X2zWp2jFTdAzYyuKi5DlSKYUfjm9+S//e1rsrBtFjcAeFgrKQOv6zHgvUTSYk2lRHzRD
         h/ybJKwmLyjws40OiVuk0iVmrLCz004erYmuZV8etUwghc/vJpHsNLPp/oQRsfa+vKSn
         9dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y88FdVXAgfg5w8PyflknRqNxB6/N6fKsnjWxZd+03NM=;
        b=WBUb8MyPQKtDTV16WbsV/mE7Qw8SYEsHpdfrIZ0RS5l9RC8DPdU08B2ocWOzBVjQGp
         syU+ifKmHp4yj0t8JZi/jGLr/advkP2CzeY5nQX9f5FQq2f/IlVzjeqCPHmhs+IN6ZPA
         LseazhKPq6W+B4bGs7RdEcGvc/sg/Q/3pepYvhI2bpaWPxxSh1xD2p9KYg0TBd0Ri3Vg
         edengSD7Zpbrqh61NGvYbTCmaMB4THZfTLPGVF8/WN6feqxFZauHhWnrMekXjzOfAWsO
         nfGu1eow6wt7IW1vNIdam1WSCO4qSHNDe3uUfoDfDb3X9UhSikVaevekAZbeBR8/108i
         5BZQ==
X-Gm-Message-State: AOAM5323JIdtcACNECArpZ9tgwk+n0uYYGvJOSzvkXyEpHBfnQ9dLAPf
        SfQUVuZaJ3JkUlEa6ur/b6rNEDnldwc=
X-Google-Smtp-Source: ABdhPJxkU1FVe/JpOzzQ4tK9icFWX/K30mbP10klXX4Q3uuhlVNI6rXChsh44ijI2FQ7j2cA8M95aw==
X-Received: by 2002:a17:90a:f206:: with SMTP id bs6mr484281pjb.214.1603777104571;
        Mon, 26 Oct 2020 22:38:24 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id z10sm573029pff.218.2020.10.26.22.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 22:38:23 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v4 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Date:   Tue, 27 Oct 2020 14:38:17 +0900
Message-Id: <20201027053818.3291747-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
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
2.29.0.rc2.309.g374f81d7ae-goog

