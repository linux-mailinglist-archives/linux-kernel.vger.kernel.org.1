Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C62CB1EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgLBA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLBA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:58:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DBEC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 16:57:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w187so120076pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGoXkB/firHSerlRwS3YRy335L2aZrXOoUmu7edbdqo=;
        b=n8uU7Gm98Aw702pheuqehG0wwI4hLJaOhU2U1RimF498Yi/yb0syqbKQm0huQp2ATO
         tvl09cds3mwP8d6EI5OYi6tdqFRvuc71+IzBC2hNnwkJnB+L9LiCG47GOoebWcaI76sc
         tY+qe9UMNP2K31CeclwgevZvi6PJdab4za7oNjNK+fKuV7sfvZJBrCrlzPRJxePpUYlw
         d5HZ396BrLyE3HWGXTsdiz5iJhVTPSjNGLKKpQEJo8yeiKVz4txfra6gTOfkoj6c/mdJ
         e7n8F1tlt4YR1mUp+fJfUrqUkvLc0jXxRCQkd1gDXOBLjhwyVShgFVKozDmfToBvR6u6
         bHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGoXkB/firHSerlRwS3YRy335L2aZrXOoUmu7edbdqo=;
        b=MintsAg/UOePKeAJ1PdbS+llDp4AaBlWDnippX38KTv+HIxzruChWYodLY3TEGanrq
         0g6Km5P33TAtd14wqVuPE8mvoomKrzlgAwjOx44JueGfEO9mJsOhdnmK5ANOw5puz4sl
         ZkSZZitZaOLYambNMcmIsPqwgRYo+AiXLzZwjcD706mQWsGmVc7cBGypPzhRB7HctvaB
         YiesAfXd83p4GP85zVR4SP6OQKQLlqr8ZdkI9BX62kENTPO/MY4VgLkDtj8hlLeasr+n
         tH+nx+3+XfWUsfh4Fp6V7w1BJTyiEzr7xkfhAjhqyHidzeTYqZ2tAFsn0tAbJsgHP6ZY
         EX0A==
X-Gm-Message-State: AOAM530gQAXTgEBkuwDMeX++QgAXYMianwkR8u3hveBMh1AbJkgEQATx
        h/C8FnVAqtg8oxd3sdXgayY=
X-Google-Smtp-Source: ABdhPJyheiTIWEd+j1RQTi2m/mMn5TLRQxceVMkmfi1PMDTfXt7JHGZmGBZtho9hqE/cVuOhY+5ucg==
X-Received: by 2002:aa7:9429:0:b029:197:f974:c989 with SMTP id y9-20020aa794290000b0290197f974c989mr69046pfo.30.1606870677134;
        Tue, 01 Dec 2020 16:57:57 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id gz2sm116974pjb.2.2020.12.01.16.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 16:57:56 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH 1/3] f2fs-tools: Added #ifdef WITH_func
Date:   Wed,  2 Dec 2020 08:57:22 +0800
Message-Id: <20201202005724.691458-2-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202005724.691458-1-robinh3123@gmail.com>
References: <20201202005724.691458-1-robinh3123@gmail.com>
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
2.29.2.454.gaff20da3a2-goog

