Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD62D0AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 07:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLGGoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 01:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:44:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F23C0613D2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 22:43:37 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id f9so8228610pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 22:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otQkiR2Uy8rxb1pUSHnhE2UFpTc3iYNCzbqKsfb2NA4=;
        b=DYtvR1R7Wtnp8S64BLo/0lOTgKaVJO3rSudD5Y7dxHxnvcnlueoBtU7pTJrjoA9JR+
         H3GMBP4nifMBidpjNOyTPToW97WOsqmTGNRMxDZg+OdvVwr5IvLbipg6JwoBd8Seg8XP
         Q71YUCVq/76glb2VBJCxMzuOFe5H086ncAnIsdVW6ir2lr1dDBL4NtuenTnPT57HANpf
         O7Mm4mDZO8ZMDlU9ziZ+gjCeySlvIGQZmTu10fa7aJl2l1jgIredfD5eNMYe/+CuGZXa
         Fbe5aEETbX6flXqIZ0zuX8VUnxMq/yPSdpfP5SuqlmSxAjJu2votKNzWS80QLzmMJJRG
         akPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otQkiR2Uy8rxb1pUSHnhE2UFpTc3iYNCzbqKsfb2NA4=;
        b=af8Un+9lU0vcRrFS45jHk+0CSeO2JzzTs7bGKxH+tQhN+j8+y/K8AJ7bZ9S5npcKRV
         SkG/KEKGIISrlmLKMGAKhGS7Zs8IDqbZae7XmmgAfEBGAypi493KfXtNsoKZfbo5QIT9
         rSCnlm6O/VSUUqW1K0ooq/eVn7t+46d2bgO8chk2w1tBBc7BY1U9aeetP7nl2V4i4fao
         FJGNea2zBpymkyfKN/ROCryQhkRKPrb3s9c4UgQjclWywU3EPOior4GhmD38f+M4qNrX
         b1QHWgrF6PT+ieRKI8NQo/F4gW/jNkCrHDTrZK1e5qypnFzRrWpviprE2+Yx3ZeNAANa
         LMPA==
X-Gm-Message-State: AOAM532CR6mTenpUqJLfBQHY/wwWwe5/eeC10/F5/PoEpMY5JoNOWVnM
        Qt/TXFBvGD86K9VxyDp5rFcuX1oGH3w=
X-Google-Smtp-Source: ABdhPJwPpnqJ3+aM79hweW/me2ydhRM5t0xuGUZv0BphpJ+fO+PgpgfvNgCsdNBb3I3V31eGKEhR9g==
X-Received: by 2002:a17:902:70cc:b029:d7:e8ad:26d4 with SMTP id l12-20020a17090270ccb02900d7e8ad26d4mr14539708plt.33.1607323417021;
        Sun, 06 Dec 2020 22:43:37 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id o9sm9079984pjl.11.2020.12.06.22.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 22:43:36 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v2 1/3] f2fs-tools: Added #ifdef WITH_func
Date:   Mon,  7 Dec 2020 14:42:48 +0800
Message-Id: <20201207064250.272240-2-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201207064250.272240-1-robinh3123@gmail.com>
References: <20201207064250.272240-1-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Add proprocessor defines (options) 'WITH_func',
where func = DUMP, DEFRAG, RESIZE, or SLOAD

Bug: 161486536
Test: n/a (trivial)
Signed-off-by: Robin Hsu <robinhsu@google.com>
Change-Id: I813755548cc71dd8b026abd06893ed0fcf1d8b26
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

