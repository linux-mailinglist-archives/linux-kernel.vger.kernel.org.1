Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487802D2595
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgLHIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLHIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:17:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B436C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:16:28 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o5so11507763pgm.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1Fz0yq5QOWZGHX6crMbhCYX2GPoKckcY3/RN3rhSp8=;
        b=QgzesVVgLRoxtIPEdfa7MoIIptAhBhUS4cyG3wez7TlsoJA7zbfBiJW82Gs9Zkpqox
         KmQ9dt8i+qtLjijsGk4ZpbzBaFHb4iG0Br1SRVtfUUOw2AsOzrNdaCtNIxbdHKUvzin7
         gbCijlejT14NcCJTscaajh3GwhL/cWU3jua6pDgCHR4fiYTH+aMmlZ442/AEByFqduMN
         OZQSU1YBizL4NHRxcQe9lIp7UCWVGvqcceAUS+TEsg+Qp9D9dDwbKEFmjBcHjd8d+zko
         NV18hPbdYdvjYFemqA1dYVt5UYbn1XDpGikGbPLtxVlHci7xw1U6I3PiDQvymgKZwcYv
         AUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1Fz0yq5QOWZGHX6crMbhCYX2GPoKckcY3/RN3rhSp8=;
        b=NgnrLWAqwftMQmBBt+ncPwKhKGlGbUcEv98X7oItGEcfl06/11DhCzffsTjcBfJuqp
         MmLJcwcCAEb7na7sy8pUA09w6q1w1W3MtqnhCcJPvHW8P2xEQZMu8sF5MJAV8oy/194A
         hcyp6bR+j1WoL/GOX73e/l/UGiiazt2s2LDUXf07JAQy4DSZYlyU9+DtcIqBOTLuWpc1
         NGln82hRkW1DlSWXxYoBqHcmBZymv8FaHlcVsu66vuMOaZKWfrDQRwXq1AkNKO2muTCh
         U4fKc7PDRkBUwZ9Dj0GLrx/G2t63wde4SkoRQX6Gyzto1POdJ6ED1Md97u/tJeMU307Y
         9jPw==
X-Gm-Message-State: AOAM531rbekRiZpSD+ro6qUCJAQ6pYj+S0eQpwWXeyA48G0zse4pwGmn
        Z3yMQIataSeugX6n7O1xe2c=
X-Google-Smtp-Source: ABdhPJzg+jvi7ZBMS7cFN5eQkDnRgtkCeWo6pcxuTnod6UD2gSK1CnJQ1o0o/qDuDhkMYlXjztprPQ==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr21740474pgj.96.1607415388140;
        Tue, 08 Dec 2020 00:16:28 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id d4sm2093574pjz.28.2020.12.08.00.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:16:27 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v3 1/3] f2fs-tools: Added #ifdef WITH_func
Date:   Tue,  8 Dec 2020 16:15:53 +0800
Message-Id: <20201208081555.652932-2-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208081555.652932-1-robinh3123@gmail.com>
References: <20201208081555.652932-1-robinh3123@gmail.com>
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

