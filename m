Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29932A5A97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 00:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgKCXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 18:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgKCXg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 18:36:28 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC17C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 15:36:26 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 133so15711972pfx.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 15:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0+bzA9s7UKxsAZSBmq5cQ30e/XxfLYDpoojIw6IapI=;
        b=GnkgjZ4V8Mpuxwh8634uGhR4JY+mTyktfUh0yGEX+giA0w25biqOVecK0archgURGw
         hGuWsUwxs8FpU6UAZqTmhWRtmDLabujEZm0bk9ZKZkPwKl5oCnXNpF1+SZJCloIitcVJ
         tbLXvsM1at5qYb9MBK9U4fBMXgMWceUXsnRgfJjjAl3o7RowiQpHjpRU5UICiCJ3DEID
         OtCRbhJSQEz0KJMlESnjNv8ThDvs+an9nR4PRHaHiD6r2RBE2qeHJVweGGpT/TAbZNyG
         bTbiHY4p9dGrK44NNeV+sS2Ej2dGhiFbRTcdODHETL9C9pEEkXo71DLNPV0cf4BKp4f8
         EpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0+bzA9s7UKxsAZSBmq5cQ30e/XxfLYDpoojIw6IapI=;
        b=FG6P76NdSp5UNvgOOGd3vZ+Wh8L9Ll+a3+Jk35sXNofQD+B+ZHlOYihb8HeMxg7mC9
         v25dxFNzQQEfVGEufNbHmBzg7UvTr2yQiSoZUjHNRt1EcG1ui//eHF6Xt+HbJrpg20AL
         kyhAQFcOyZtmSRkxZtltqK7VN3nrPlHLNfpC+nz1TKiOmu9K+gpnUPU2M4GgJIqOTXFR
         PNc+PBIAV6ug5iIOgo3h30TnsADxoZbDE78uO87Zcu3ePlHk53+hkqip6eORE16PZ8bd
         VR/q0ZTgqMZXV5GXN0Ge3FJepRk3AmkyjB8q38OzxXwG/zhJ6Cf8sYNrOPIfYcUMR6Gc
         251w==
X-Gm-Message-State: AOAM5310x2h8V+Vbk7C2VAykwLoF1m9pXjHwsmsm3plQD6lx2jKgbsLy
        58+g/8QOHmWn6RloFX21AH4/RtXzeyo=
X-Google-Smtp-Source: ABdhPJwMOnE5FwtsYa0OytLzoxFJWsQq7QuLt7z6A7c10GT9ViKR4VQQfU/TU2qz7t9r4qfNS+RjNA==
X-Received: by 2002:a62:e40b:0:b029:18b:2d21:45cd with SMTP id r11-20020a62e40b0000b029018b2d2145cdmr6231150pfh.36.1604446585723;
        Tue, 03 Nov 2020 15:36:25 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id cm20sm237082pjb.18.2020.11.03.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 15:36:24 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs_io: add get/set compression option
Date:   Wed,  4 Nov 2020 08:36:14 +0900
Message-Id: <20201103233614.2092498-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added new commands, get_coption and set_coption, to support
F2FS_IOC_GET_COMPRESS_OPTION and F2FS_IOC_SET_COMPRESS_OPTION.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---

v2: changed the file open option of set_coption to write only.
---
 tools/f2fs_io/f2fs_io.c | 61 +++++++++++++++++++++++++++++++++++++++++
 tools/f2fs_io/f2fs_io.h |  9 ++++++
 2 files changed, 70 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 5a2d06e..7e6cfd8 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -905,6 +905,65 @@ static void do_reserve_cblocks(int argc, char **argv, const struct cmd_desc *cmd
 	exit(0);
 }
 
+#define get_coption_desc "get compression option of a compressed file"
+#define get_coption_help						\
+"f2fs_io get_coption [file]\n\n"	\
+"  algorithm        : compression algorithm (0:lzo, 1: lz4, 2:zstd, 3:lzorle)\n"	\
+"  log_cluster_size : compression cluster log size (2 <= log_size <= 8)\n"
+
+static void do_get_coption(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct f2fs_comp_option option;
+	int ret, fd;
+
+	if (argc != 2) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	fd = xopen(argv[1], O_RDONLY, 0);
+
+	ret = ioctl(fd, F2FS_IOC_GET_COMPRESS_OPTION, &option);
+	if (ret < 0)
+		die_errno("F2FS_IOC_GET_COMPRESS_OPTION failed");
+
+	printf("compression algorithm:%u\n", option.algorithm);
+	printf("compression cluster log size:%u\n", option.log_cluster_size);
+
+	exit(0);
+}
+
+#define set_coption_desc "set compression option of a compressed file"
+#define set_coption_help						\
+"f2fs_io set_coption [algorithm] [log_cluster_size] [file_path]\n\n"	\
+"  algorithm        : compression algorithm (0:lzo, 1: lz4, 2:zstd, 3:lzorle)\n"	\
+"  log_cluster_size : compression cluster log size (2 <= log_size <= 8)\n"
+
+static void do_set_coption(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct f2fs_comp_option option;
+	int fd, ret;
+
+	if (argc != 4) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	option.algorithm = atoi(argv[1]);
+	option.log_cluster_size = atoi(argv[2]);
+
+	fd = xopen(argv[3], O_WRONLY, 0);
+
+	ret = ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);
+	if (ret < 0)
+		die_errno("F2FS_IOC_SET_COMPRESS_OPTION failed");
+
+	printf("set compression option: algorithm=%u, log_cluster_size=%u\n",
+			option.algorithm, option.log_cluster_size);
+	exit(0);
+}
 
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
@@ -930,6 +989,8 @@ const struct cmd_desc cmd_list[] = {
 	CMD(get_cblocks),
 	CMD(release_cblocks),
 	CMD(reserve_cblocks),
+	CMD(get_coption),
+	CMD(set_coption),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index 05d4cfe..cb56e8c 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -84,6 +84,10 @@ typedef u32	__be32;
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_GET_COMPRESS_OPTION    _IOR(F2FS_IOCTL_MAGIC, 21,      \
+						struct f2fs_comp_option)
+#define F2FS_IOC_SET_COMPRESS_OPTION    _IOW(F2FS_IOCTL_MAGIC, 22,      \
+						struct f2fs_comp_option)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -164,3 +168,8 @@ struct f2fs_flush_device {
 	u32 dev_num;		/* device number to flush */
 	u32 segments;		/* # of segments to flush */
 };
+
+struct f2fs_comp_option {
+	u8 algorithm;
+	u8 log_cluster_size;
+};
-- 
2.29.1.341.ge80a0c044ae-goog

