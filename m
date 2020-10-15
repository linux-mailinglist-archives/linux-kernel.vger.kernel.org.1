Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A990128F83B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbgJOSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:13:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34260 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgJOSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:13:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id x20so3107469qkn.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cJuATedXYgpSJ1YqRltFNQY8ajjuWuhu8ViNrBTmls=;
        b=WGRQ49gmvCN+ZcGnXrjAJpp3MX6JEarYrIN98zNlhXYzgyVrcFs3z9iP9M5/ak6Rlg
         wuagfdzRBpXIUCJxeMuzpzbaa5yMkXNEVmVoiegyBVOlhdZT/u5P0FxrCScIwbMc/G+m
         gY2CHkAb51OqNCmEPtSnmScI/87Ig/2CUUG28TmXJ4+t3vUhRiH7wTs7IjriNVtwKpRD
         mZ6EStFCMWEuGr4b5M+XvvzUgyqiWK1JhiMc6inGLZnANwONf2tQAvumaFxNnNLW59jH
         mbFubqvjdyRltQTqfMuhKzD4cetu+P7RKZJgkc4AGu+BgIZvDW3RnO1c4Fd3+SooXodx
         55PA==
X-Gm-Message-State: AOAM5329PawQLV/AmXXUM3NZyQYYT3JyzbRye64i+OcNbAy7KGwnCqEd
        XkrN6YNY0GggvpEKD2624Q4=
X-Google-Smtp-Source: ABdhPJzmMvF22V0TBegvDXP8CI01u1DEVK6lkGD0GLvCvhs/QL55NEckInPWyLF9eroTny6mMWrCrw==
X-Received: by 2002:a37:2d06:: with SMTP id t6mr42492qkh.308.1602785621933;
        Thu, 15 Oct 2020 11:13:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t13sm26319qtw.23.2020.10.15.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:13:41 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] compiler.h: Clarify comment about the need for barrier_data()
Date:   Thu, 15 Oct 2020 14:13:40 -0400
Message-Id: <20201015181340.653004-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
References: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be clear about @ptr vs the variable that @ptr points to, and add some
more details as to why the special barrier_data() macro is required.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/compiler.h | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 93035d7fee0d..d8cee7c8968d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -86,17 +86,28 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #ifndef barrier_data
 /*
- * This version is i.e. to prevent dead stores elimination on @ptr
- * where gcc and llvm may behave differently when otherwise using
- * normal barrier(): while gcc behavior gets along with a normal
- * barrier(), llvm needs an explicit input variable to be assumed
- * clobbered. The issue is as follows: while the inline asm might
- * access any memory it wants, the compiler could have fit all of
- * @ptr into memory registers instead, and since @ptr never escaped
- * from that, it proved that the inline asm wasn't touching any of
- * it. This version works well with both compilers, i.e. we're telling
- * the compiler that the inline asm absolutely may see the contents
- * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
+ * This version is to prevent dead stores elimination on @ptr where gcc and
+ * llvm may behave differently when otherwise using normal barrier(): while gcc
+ * behavior gets along with a normal barrier(), llvm needs an explicit input
+ * variable to be assumed clobbered.
+ *
+ * Its primary use is in implementing memzero_explicit(), which is used for
+ * clearing temporary data that may contain secrets.
+ *
+ * The issue is as follows: while the inline asm might access any memory it
+ * wants, the compiler could have fit all of the variable that @ptr points to
+ * into registers instead, and if @ptr never escaped from the function, it
+ * proved that the inline asm wasn't touching any of it. gcc only eliminates
+ * dead stores if the variable was actually allocated in registers, but llvm
+ * reasons that the variable _could_ have been in registers, so the inline asm
+ * can't reliably access it anyway, and eliminates dead stores even if the
+ * variable is actually in memory.
+ *
+ * This version works well with both compilers, i.e. we're telling the compiler
+ * that the inline asm absolutely may see the contents of the variable pointed
+ * to by @ptr.
+ *
+ * See also: https://llvm.org/bugs/show_bug.cgi?id=15495#c5
  */
 # define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
 #endif
-- 
2.26.2

