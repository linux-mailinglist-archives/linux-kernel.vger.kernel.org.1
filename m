Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E22D2588
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgLHIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgLHIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:15:24 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7EDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:14:44 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e2so3168886pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1Fz0yq5QOWZGHX6crMbhCYX2GPoKckcY3/RN3rhSp8=;
        b=LYcl97eWcyp36GTTmFA630p01xUrXCDfNOigwz2I/OMi9Yi/XnQ12k2r5aXhgo+AN9
         3ZsxxLEDUjkNhZe4t4GXT7ForPbCasMHNakE1GinbIjV5uzN4I4XXndGh80RsoMd8sIU
         pp79PgS8q4g/U5jnDM+StBZewDvDaW4s/ffbn/LT/w6rcsg1Ojn1dl0pVjw+hO+PNkCF
         FY7I5lF7JmEt2e4DzZie82mYQf6zuItUD4z6gKx2w1j6kjcvUvwWm0tiOePplMF8gMQ8
         ReCaD/kZDZKnKoY1SRcZG4Wm11U5TUa4uZyMLKF9vjb2ali+rGWxsS21o1vT5lyk39E9
         lJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1Fz0yq5QOWZGHX6crMbhCYX2GPoKckcY3/RN3rhSp8=;
        b=lN0U9HNkW39AD3eRz4BrTMXeYS1a2VrZBFeeqzRF9IJN1pclEqqMNOIxsesrKt6Sra
         rbw4DudpDCHMSi2d/YeuMnthIykAvK3FhAr0JiymE94n3kpgpRbk/cJbCOCNdlASEJp6
         JuyevSTF64kzvVj1xzohpx3ja4a0jke8dfKkn9M+tx0FGllWHsmqiWZEkXnRaxQiBQL7
         cblq9qw865LzQkGwfDAqE0fFp5rU69VXauaPSVwmRDf2wYpOtOlt4aJc3cUvpbEEalWD
         3ZYn+gIapCcXpJFq3yf94j5FIiAvr773LfV6b52zF2r2XYkHpav4JNmBIG8I6EjlAVDM
         IfQQ==
X-Gm-Message-State: AOAM532sVwyzve13L3vj5GDBmfWY/+5U7Gsseyjkwb4kt1PuM/NXiYt3
        JrMXF8vEOD+1Lz8t+3Nl4cA=
X-Google-Smtp-Source: ABdhPJxBXk46n3SDMmXeBCsRrmKRkx57VGxxBE11dFj+he8rrDP78jbjlA1yj3fZvOLON/zq+wz/zg==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr3193611pjd.204.1607415284080;
        Tue, 08 Dec 2020 00:14:44 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id 19sm2665387pfu.85.2020.12.08.00.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:14:43 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH 1/3] f2fs-tools: Added #ifdef WITH_func
Date:   Tue,  8 Dec 2020 16:13:42 +0800
Message-Id: <20201208081344.652430-2-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208081344.652430-1-robinh3123@gmail.com>
References: <20201208081344.652430-1-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Add proprocessor defines (options) 'WITH_func',
where func = DUMP, DEFRAG, RESIZE, or SLOAD

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 fsck/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index e70048b..b20498f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -345,6 +345,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
+#ifdef WITH_DUMP
 		const char *option_string = "d:i:n:s:Sa:b:V";
 		static struct dump_option dump_opt = {
 			.nid = 0,	/* default root ino */
@@ -426,7 +427,9 @@ void f2fs_parse_options(int argc, char *argv[])
 		}
 
 		c.private = &dump_opt;
+#endif
 	} else if (!strcmp("defrag.f2fs", prog)) {
+#ifdef WITH_DEFRAG
 		const char *option_string = "d:s:Sl:t:iV";
 
 		c.func = DEFRAG;
@@ -484,7 +487,9 @@ void f2fs_parse_options(int argc, char *argv[])
 			if (err != NOERROR)
 				break;
 		}
+#endif
 	} else if (!strcmp("resize.f2fs", prog)) {
+#ifdef WITH_RESIZE
 		const char *option_string = "d:st:iV";
 
 		c.func = RESIZE;
@@ -526,7 +531,9 @@ void f2fs_parse_options(int argc, char *argv[])
 			if (err != NOERROR)
 				break;
 		}
+#endif
 	} else if (!strcmp("sload.f2fs", prog)) {
+#ifdef WITH_SLOAD
 		const char *option_string = "C:d:f:p:s:St:T:V";
 #ifdef HAVE_LIBSELINUX
 		int max_nr_opt = (int)sizeof(c.seopt_file) /
@@ -595,6 +602,7 @@ void f2fs_parse_options(int argc, char *argv[])
 			if (err != NOERROR)
 				break;
 		}
+#endif /* WITH_SLOAD */
 	}
 
 	if (err == NOERROR) {
@@ -707,6 +715,7 @@ static int do_fsck(struct f2fs_sb_info *sbi)
 	return FSCK_ERRORS_LEFT_UNCORRECTED;
 }
 
+#ifdef WITH_DUMP
 static void do_dump(struct f2fs_sb_info *sbi)
 {
 	struct dump_option *opt = (struct dump_option *)c.private;
@@ -733,7 +742,9 @@ static void do_dump(struct f2fs_sb_info *sbi)
 	print_cp_state(flag);
 
 }
+#endif
 
+#ifdef WITH_DEFRAG
 static int do_defrag(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -782,7 +793,9 @@ out_range:
 				c.defrag_target);
 	return -1;
 }
+#endif
 
+#ifdef WITH_RESIZE
 static int do_resize(struct f2fs_sb_info *sbi)
 {
 	if (!c.target_sectors)
@@ -796,7 +809,9 @@ static int do_resize(struct f2fs_sb_info *sbi)
 
 	return f2fs_resize(sbi);
 }
+#endif
 
+#ifdef WITH_SLOAD
 static int do_sload(struct f2fs_sb_info *sbi)
 {
 	if (!c.from_dir) {
@@ -808,6 +823,7 @@ static int do_sload(struct f2fs_sb_info *sbi)
 
 	return f2fs_sload(sbi);
 }
+#endif
 
 #if defined(__APPLE__)
 static u64 get_boottime_ns()
-- 
2.29.2.576.ga3fc446d84-goog

