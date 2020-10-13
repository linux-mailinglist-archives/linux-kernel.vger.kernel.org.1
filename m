Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8455128D311
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgJMRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:22:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F446C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:22:45 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s1so404505qvq.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ljkCIQrwrjsGy0cTJoQSe2caDNaXNxndtQSxnTEHTS4=;
        b=BKuOba0LLtscjZtPuBYP4WXvOyvG/bSv+0NGruQNLLHY71uSi0QBsSJschwv1erfrn
         plbRPvm6XWLdju+9q1V/WNG0LphZYwUqUjHxmLBakesLvmxjn3yQ9ZttJ4RcDt61mYyp
         MPBzOtiQREz9JVR9aFcec2vAV/6/C8gaMpRSnGKMfcQ/pFxsRh+fZYp2skY/i7KkM4cc
         uoTrZBKGpyTaPsyEF+F4qTmnBrUw6e4IxPXoEoSnvSysUJkXhvoaSR4In+UAKc9UePHx
         Z4GbUq36yG6mE10NAS98aNlVTGfrUmUHvHV4Vq2YzRUjymIkyxsezvWVDTPIqmbKlYrJ
         To6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ljkCIQrwrjsGy0cTJoQSe2caDNaXNxndtQSxnTEHTS4=;
        b=DMqOoWuJKGNGQDhhH/K5O1g7/pHTCdNGIkvCKP8NAyTTTXe+8D9raItsab0HWSupvt
         R8XJ9hEJILP5kJYMaKCALmLKk5+Fye8hXzZ7WbkGvkZr1qn5+ypSlOkJ67Iy3WLk+Aaw
         JUuNh6jA+qLm1Ly6V5PkF0qitfhrgU6senrWSerr33s2Eqmyk9dWjPP0jQc7KRpKERID
         sllVhdVLwhISFObU8TcqwGizTOY93MaI4QZabkHoYwlxw+omLi7CJM50uw6qtkUQqQoi
         sKNsPQ6Xnaq690WJeK/rqAZU4IwsDOj4WRr6c5RHfysfYqk7eaXMLIjuS0pNWfrxQI2l
         /OvQ==
X-Gm-Message-State: AOAM531WQN9ckUYaOuSHjGGC1M9E3qd5Qdk/jAdQVVp3PjudW+B9RRm1
        NL4Yvxek7HLA2G9e0Lgo5hEurY/D9ZWYK80=
X-Google-Smtp-Source: ABdhPJwOYz0tBvfJQWBtJ+py1RvlZXpskuwJH022we9jVgVviHz7OnEEQUQ17BRNuoLLBOZH7eG/m1s/P75r2UI=
Sender: "oceanchen via sendgmr" <oceanchen@oceanchen.tao.corp.google.com>
X-Received: from oceanchen.tao.corp.google.com ([2401:fa00:fd:2:3e52:82ff:fe5e:f3ed])
 (user=oceanchen job=sendgmr) by 2002:a0c:8c4c:: with SMTP id
 o12mr671849qvb.46.1602609764207; Tue, 13 Oct 2020 10:22:44 -0700 (PDT)
Date:   Wed, 14 Oct 2020 01:22:40 +0800
Message-Id: <20201013172240.251899-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH] f2fs_io: add erase option
From:   Ocean Chen <oceanchen@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     oceanchen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_io erase [block_device_path]

Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 1ca82f1..cef32b1 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -24,13 +24,13 @@
 #include <getopt.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <linux/fs.h>
 #include <signal.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <string.h>
 #include <sys/mman.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
@@ -432,6 +432,56 @@ static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define erase_desc "erase a block device"
+#define erase_help				\
+"f2fs_io erase [block_device_path]\n\n"		\
+"Send DISCARD | BLKSECDISCARD comamnd to"	\
+"block device in block_device_path\n"		\
+
+static void do_erase(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd, ret;
+	struct stat st;
+	u64 range[2];
+
+	if (argc != 2) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	if (stat(argv[1], &st) != 0) {
+		fputs("stat error\n", stderr);
+		exit(1);
+	}
+
+	if (!S_ISBLK(st.st_mode)) {
+		fputs(argv[1], stderr);
+		fputs(" is not a block device\n", stderr);
+		exit(1);
+	}
+
+	fd = xopen(argv[1], O_WRONLY, 0);
+
+	range[0] = 0;
+	ret = ioctl(fd, BLKGETSIZE64, &range[1]);
+	if (ret < 0) {
+		fputs("get size failed\n", stderr);
+		exit(1);
+	}
+
+	ret = ioctl(fd, BLKSECDISCARD, &range);
+	if (ret < 0) {
+		ret = ioctl(fd, BLKDISCARD, &range);
+		if (ret < 0) {
+			fputs("Discard failed\n", stderr);
+			exit(1);
+		}
+	}
+
+	exit(0);
+}
+
 #define write_desc "write data into file"
 #define write_help					\
 "f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path]\n\n"	\
@@ -951,6 +1001,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(shutdown),
 	CMD(pinfile),
 	CMD(fallocate),
+	CMD(erase),
 	CMD(write),
 	CMD(read),
 	CMD(randread),
-- 
2.28.0.1011.ga647a8990f-goog

