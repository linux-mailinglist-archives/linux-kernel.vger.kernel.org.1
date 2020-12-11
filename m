Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4B2D7EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436917AbgLKStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406368AbgLKSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:48:49 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260FCC0619DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:46:52 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id z43so7169619qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9TLfWaf58UYL7wICLMCVVnhaOCpYf+H5DpQSRdiy6Cc=;
        b=HYjrQ1sMOOn7ObkUbybc+wvc4I5EDo2ggFgwIjqmySqyqvcxKUz9U7SM7Iku6XAD3L
         MaZfkgEgX8bO5VzFU2gtMQNWgcu/wOnkSTwXPIFeVvlEzpMkLiHIbHpRj8g4yDu1jHZA
         3CxXJVzpzKe4SOfBmr81hNI0UbqvcB2S9srss5KkoPp6DWrNCN9YKq4L3D8K0njH4hkb
         YiZREXyM6H7MRSRk5aoMuIbQJAGK7qyIC/Vh6N5H5PAnKudPsvjj6Xkm2vgSii8TALn6
         7lDbS9j6fQNA0FCLEENh5zRwh0RcunHnF5d9mlF3zyS30HlqX3tlEMim0v00ijfjLPOW
         Ri5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9TLfWaf58UYL7wICLMCVVnhaOCpYf+H5DpQSRdiy6Cc=;
        b=Wzt1LcP2LNTIsSPzZoOqqljiPtVooAgWQeK/dUWaN4hY5TZF7lKoTebo+7ZMrfnede
         9ju+wbMeguxXTiAbVguuz9cYKa9+tSG5ixf6IfAj1AwRYbK02RpoCCxE4Uq/46hi+RXO
         FiZL8wqeyNAU4g+EefEyXVvg5Fhl0qKCkQFHPPxIwRn1qqZdNJphKkzrbXJrQrl9/B0s
         IIMUq2J9w8W8/v77sgWN+dxmte0SEnUi4tucv7XuLsgkE8lIBiFtB1rFZ3rWOfa2TSir
         OV+l8mDzP4PIR3goT9w4z4bcf1qHMERwpW5aoSJQgL98icH+FTXCBjJVG5QgEKMD3VgG
         wGWQ==
X-Gm-Message-State: AOAM532d4jxorzFlSQOdR48x/a51lrce/z2xJbDXXKALBTZo6+8ul4Dz
        wyMiVEGYCzJgDm/pkPh6ReAbqK1WBIJFdGYkpd4=
X-Google-Smtp-Source: ABdhPJxOTg1pZ6kKhg4/TLTiKW5mUxnxwTfGU0xF4tIiotwCBx+K30YxUBmIUhBVi6sN8mztOiZkcgmhCe/rnpjaMvs=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:302:: with SMTP id
 i2mr1391507qvu.14.1607712411329; Fri, 11 Dec 2020 10:46:51 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:25 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 08/16] init: lto: fix PREL32 relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LTO, the compiler can rename static functions to avoid global
naming collisions. As initcall functions are typically static,
renaming can break references to them in inline assembly. This
change adds a global stub with a stable name for each initcall to
fix the issue when PREL32 relocations are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/init.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index d466bea7ecba..27b9478dcdef 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -209,26 +209,49 @@ extern bool initcall_debug;
  */
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init.." #__iid
+
+/*
+ * With LTO, the compiler can rename static functions to avoid
+ * global naming collisions. We use a global stub function for
+ * initcalls to create a stable symbol name whose address can be
+ * taken in inline assembly when PREL32 relocations are used.
+ */
+#define __initcall_stub(fn, __iid, id)				\
+	__initcall_name(initstub, __iid, id)
+
+#define __define_initcall_stub(__stub, fn)			\
+	int __init __stub(void);				\
+	int __init __stub(void)					\
+	{ 							\
+		return fn();					\
+	}							\
+	__ADDRESSABLE(__stub)
 #else
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init"
+
+#define __initcall_stub(fn, __iid, id)	fn
+
+#define __define_initcall_stub(__stub, fn)			\
+	__ADDRESSABLE(fn)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define ____define_initcall(fn, __name, __sec)			\
-	__ADDRESSABLE(fn)					\
+#define ____define_initcall(fn, __stub, __name, __sec)		\
+	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
-	    ".long	" #fn " - .			\n"	\
+	    ".long	" __stringify(__stub) " - .	\n"	\
 	    ".previous					\n");
 #else
-#define ____define_initcall(fn, __name, __sec)			\
+#define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
 #endif
 
 #define __unique_initcall(fn, id, __sec, __iid)			\
 	____define_initcall(fn,					\
+		__initcall_stub(fn, __iid, id),			\
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-- 
2.29.2.576.ga3fc446d84-goog

