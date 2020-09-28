Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7033527B7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgI1XTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgI1XSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2AC05BD20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:10:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so2674440qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zHbi8BQw4tLw7R6QaxvOI8q15BGzFHU+jorKQdIZSUY=;
        b=G+4Y7xPK4dlA1Hw07eOYl6dbeCasGTBOPhRrj4neIZsHgmxCaDpXxAqlumo6IsPr9J
         qpIq0HQ9KIeCyMkzn/Q91EKN6apMs7XYG7q90xNY1xnhh0VTiNxfqWlDbAX/TnSGMUC9
         41ujr3THuk0X8vExrz6+dJ+nnx7H8IVhGh6oJmSk6CbsZIvJgt1iJclgiw5KpoeOvGUX
         T+Lx3h/vi3nxnxJhUaw3L03nVvAu1izjGRGePGF+7qF+5kHfHQzOOyzAO0ulnZiyZOAy
         i5yaLn1pW8DVFyQwMo9L7DCwrAeSR6Wy+Dj9RKbuJ0URfKhIQ4+WS0/N+n7dEATMOw0u
         xN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zHbi8BQw4tLw7R6QaxvOI8q15BGzFHU+jorKQdIZSUY=;
        b=W5X+SvLyaaFeQ10QbXXPHGaY+gFGKbau3vcuo4GJ4+GGelNTPqHBv4q8KT19ZLvX8O
         uvluQfnWcGLfX1Kx/qVzeSmweit2F6Z5whzjs8mAKZAfAO4TCsGwcMGnwAAZg0oc3Lsu
         vQq3w0H4FWEj2RXH/K/sEeT+Ly3h5q4gv8OKa2yBk4ORHHFtOVtY8oYveUewn0vzKuyB
         ttywmEa1i5h2r9Z5yzPtnkB66Nq0S6MaNSVwc+SGXRd2ANwkv+3E/h7SV3kh7vZiW148
         hYG+sISwe6NNKQ0Wkfe6EcxXn9R9l1SGdoAZp5o74x6Q4L02yCAKLd7sZZxLzW0dphR2
         4BSg==
X-Gm-Message-State: AOAM5326mITFFfpLDJGxcz7aRAUG5fyIelg3a736Z6Qi4Sk79pOT3qQz
        vVfXKdyP7RIbzwF1aEtZkr8=
X-Google-Smtp-Source: ABdhPJxK87v7x0A2HmBtmc135uXN0DDjfwDuAjSiShXNSbiwkCxWJkUqInn4J14BhtXgtgkHwF9HBg==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr1792884qkk.456.1601334599120;
        Mon, 28 Sep 2020 16:09:59 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id y22sm2848538qka.18.2020.09.28.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:09:58 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] static_call: Fix return type of static_call_init
Date:   Mon, 28 Sep 2020 16:09:39 -0700
Message-Id: <20200928230939.5574-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions that are passed to early_initcall should be of type
initcall_t, which expects a return type of int. This is not currently an
error but a patch in the Clang LTO series could change that in the
future.

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Link: https://lore.kernel.org/lkml/20200904044559.GA507165@ubuntu-n2-xlarge-x86/
Link: https://lore.kernel.org/lkml/20200903203053.3411268-17-samitolvanen@google.com/
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/linux/static_call.h | 6 +++---
 kernel/static_call.c        | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index bfa2ba39be57..695da4c9b338 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -136,7 +136,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
-extern void __init static_call_init(void);
+extern int __init static_call_init(void);
 
 struct static_call_mod {
 	struct static_call_mod *next;
@@ -187,7 +187,7 @@ extern int static_call_text_reserved(void *start, void *end);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
-static inline void static_call_init(void) { }
+static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
 	void *func;
@@ -234,7 +234,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #else /* Generic implementation */
 
-static inline void static_call_init(void) { }
+static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
 	void *func;
diff --git a/kernel/static_call.c b/kernel/static_call.c
index f8362b3f8fd5..84565c2a41b8 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -410,12 +410,12 @@ int static_call_text_reserved(void *start, void *end)
 	return __static_call_mod_text_reserved(start, end);
 }
 
-void __init static_call_init(void)
+int __init static_call_init(void)
 {
 	int ret;
 
 	if (static_call_initialized)
-		return;
+		return 0;
 
 	cpus_read_lock();
 	static_call_lock();
@@ -434,6 +434,7 @@ void __init static_call_init(void)
 #ifdef CONFIG_MODULES
 	register_module_notifier(&static_call_module_nb);
 #endif
+	return 0;
 }
 early_initcall(static_call_init);
 

base-commit: de394e7568ce2cdb4643ed230169f484f25f9442
-- 
2.28.0

