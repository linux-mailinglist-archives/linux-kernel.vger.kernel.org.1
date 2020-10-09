Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA8288E74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbgJIQPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389757AbgJIQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:14:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31AC0613B3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:14:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r2so9407054yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=q9NeEgeJtjuDXz46HWaR2aTcr7U+m+G2Xtw7ZYj0i80=;
        b=iCTjiWuFQ2uB1i7Yhxg7UUj2mxvVVeGH/uQnN9Bzf/9nrboOJWa+d3Q/NkVPWU7eV3
         voaVDdIBJlbDt7irnbkO3Enn8ewROPL3YQoRlKaSls0cQ+9RQRYvcsTNJBnf2NIAkM51
         gORjOGMGQ3oiPn7datixsfnkDy944221Gg5t1XN7qw2DL3iUmcE5N/74O4L67inJNOic
         jd/+9Vf+mOz0eyNxmM2t6PSHNoBARqJdQUsqd7Qj9Jh11x5gqBHhdlIAuAhFw+tc1/uR
         PZMxXLi0dfoU1sOeVVjUZ+sboRVnrfCV06KoaukunrNToQRq+KoaqhfG+fvp/M+PAKVW
         /EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q9NeEgeJtjuDXz46HWaR2aTcr7U+m+G2Xtw7ZYj0i80=;
        b=Ap3JfA/rSZgmPrvklp4MnTsw8FjeSWL5HKSf6Znh/7g33jp3dnmUmqq+7L3hI2+zB4
         u3oWftTm0IufJH6SX9MuibIw+6QwBxrDB0N8yo5nZx65LBRnAYSuT7C2HwF+WL8659bX
         R8P68/t9FzFX6yn644l/hm920HeivAw7d2PtKPf5VXxThLe3b7LJt5wr/Nelf329RoGJ
         1qSHeovF5ooBJbB4oLGXwcqQtf15XwRyke9MpEGjk+FSOr0Ba8ug9IjPRHboDlFXDfCA
         k0zIPrDeGiaRLubZQEgaIhT3QdFdqk5BNJTOAP7petU6gqCV2bS4h83+YIpPoLxNR+Ob
         P+1Q==
X-Gm-Message-State: AOAM5327RGmdtRTnGl7UMnD/S+ZJNvWVnKjtjXBaWvEmk1O3RPmVvRDG
        ctt105egLLX055bqMSWfjmWqR5psNqlb4gt9xoU=
X-Google-Smtp-Source: ABdhPJxY7pqjr5alUFzXvJASZaY1+9+AH6N5iCrVJlJppZ8GYz1J0DKcDLQiwjunvMUmtHmat2QqY1/pF/tHlD/h+6k=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:c709:: with SMTP id
 w9mr18142859ybe.327.1602260056890; Fri, 09 Oct 2020 09:14:16 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:27 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 18/29] modpost: lto: strip .lto from module names
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LTO, everything is compiled into LLVM bitcode, so we have to link
each module into native code before modpost. Kbuild uses the .lto.o
suffix for these files, which also ends up in module information. This
change strips the unnecessary .lto suffix from the module name.

Suggested-by: Bill Wendling <morbo@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/modpost.c    | 16 +++++++---------
 scripts/mod/modpost.h    |  9 +++++++++
 scripts/mod/sumversion.c |  6 +++++-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 69341b36f271..5a329df55cc3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -17,7 +17,6 @@
 #include <ctype.h>
 #include <string.h>
 #include <limits.h>
-#include <stdbool.h>
 #include <errno.h>
 #include "modpost.h"
 #include "../../include/linux/license.h"
@@ -80,14 +79,6 @@ modpost_log(enum loglevel loglevel, const char *fmt, ...)
 		exit(1);
 }
 
-static inline bool strends(const char *str, const char *postfix)
-{
-	if (strlen(str) < strlen(postfix))
-		return false;
-
-	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
-}
-
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
@@ -1984,6 +1975,10 @@ static char *remove_dot(char *s)
 		size_t m = strspn(s + n + 1, "0123456789");
 		if (m && (s[n + m] == '.' || s[n + m] == 0))
 			s[n] = 0;
+
+		/* strip trailing .lto */
+		if (strends(s, ".lto"))
+			s[strlen(s) - 4] = '\0';
 	}
 	return s;
 }
@@ -2007,6 +2002,9 @@ static void read_symbols(const char *modname)
 		/* strip trailing .o */
 		tmp = NOFAIL(strdup(modname));
 		tmp[strlen(tmp) - 2] = '\0';
+		/* strip trailing .lto */
+		if (strends(tmp, ".lto"))
+			tmp[strlen(tmp) - 4] = '\0';
 		mod = new_module(tmp);
 		free(tmp);
 	}
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 3aa052722233..fab30d201f9e 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -180,6 +181,14 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 	return info->symtab_shndx_start[sym - info->symtab_start];
 }
 
+static inline bool strends(const char *str, const char *postfix)
+{
+	if (strlen(str) < strlen(postfix))
+		return false;
+
+	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
+}
+
 /* file2alias.c */
 extern unsigned int cross_build;
 void handle_moddevtable(struct module *mod, struct elf_info *info,
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index d587f40f1117..760e6baa7eda 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -391,10 +391,14 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 	struct md4_ctx md;
 	char *fname;
 	char filelist[PATH_MAX + 1];
+	int postfix_len = 1;
+
+	if (strends(modname, ".lto.o"))
+		postfix_len = 5;
 
 	/* objects for a module are listed in the first line of *.mod file. */
 	snprintf(filelist, sizeof(filelist), "%.*smod",
-		 (int)strlen(modname) - 1, modname);
+		 (int)strlen(modname) - postfix_len, modname);
 
 	buf = read_text_file(filelist);
 
-- 
2.28.0.1011.ga647a8990f-goog

