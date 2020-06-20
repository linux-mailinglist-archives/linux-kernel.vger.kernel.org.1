Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7A20209F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 05:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgFTDbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 23:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733218AbgFTDbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:31:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10061C0604DE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k2so4994666pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QE7doATfVKyRNIS6o4GV46rwBSEL831INB+q/+9Rmh4=;
        b=ASP8ZYf5F8e3CyJ7PlH33MV/i7ui6qpJA/mDIbM14iTBLSGrg0GdC9kyTZr/lfh7CG
         GXzC9dz7nRwrAYeG29S+Q/THEeaVI5eUgF5DSRnMeurjTMSJnbVmhuDSeU19AKii4S2r
         YKBS0Qn5aMH95xmZNn8/myVX4U8ajBfLEQ9mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QE7doATfVKyRNIS6o4GV46rwBSEL831INB+q/+9Rmh4=;
        b=JBRqoUDyGelN3xvVOzguCxe9d0gu8Sn6rnxkhg23Jgc1xBa4cVebz8NER2zY1tdGkg
         dHhvPRPm5MFAEGIYqSkzIYQ4E7nM8f7yT6jGtc3kOh+YU0h9QPtMSg7QOa704d2KhZ5d
         lXQjs6QRj7bRm2nvYDTdkoD7E7N5YNObclSUCkaQZ5KvFTcKWgnSRjKgw87PlUGFJLqN
         EJF8t9JixiHvwIP+DxKwklbwhyxMGzabz/H2iSGx8XkeGEADdhf5x3gFRaeH/9glAIjA
         JEqxU/kJH9TeEQu83oPN9EOy9A12vSLueEPUko09XmUOtk2Hu5KL6Ff6H3Rk2crdFUzy
         PgvQ==
X-Gm-Message-State: AOAM532B6WtZzMkq/B4msUcLXTMxcHdhMMhJMlQEuWfaihTM4VwQCqq4
        uBE+pwgyiQqej8RU6lJmkT1lcQ==
X-Google-Smtp-Source: ABdhPJwXvH55Kn4Xp+SPGU8vAiaQb11ixD/33bxeYcW2UOZTzvT5qr6VlXigT0w5zzrZdxmh+dRSYw==
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr6886989pje.129.1592623829622;
        Fri, 19 Jun 2020 20:30:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm2178138pfc.183.2020.06.19.20.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bart van Assche <bvanassche@acm.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 16/16] compiler: Remove uninitialized_var() macro
Date:   Fri, 19 Jun 2020 20:30:06 -0700
Message-Id: <20200620033007.1444705-16-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings
(e.g. "unused variable"). If the compiler thinks it is uninitialized,
either simply initialize the variable or make compiler changes.

As recommended[2] by[3] Linus[4], remove the macro. With the recent
change to disable -Wmaybe-uninitialized in v5.7 in commit 78a5255ffb6a
("Stop the ad-hoc games with -Wno-maybe-initialized"), this is likely
the best time to make this treewide change.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Bart van Assche <bvanassche@acm.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler-clang.h | 2 --
 include/linux/compiler-gcc.h   | 6 ------
 tools/include/linux/compiler.h | 2 --
 tools/virtio/linux/kernel.h    | 2 --
 4 files changed, 12 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index ee37256ec8bd..f2371b83aaf2 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -5,8 +5,6 @@
 
 /* Compiler specific definitions for Clang compiler */
 
-#define uninitialized_var(x) x = *(&(x))
-
 /* same as gcc, this was present in clang-2.6 so we can assume it works
  * with any version that can compile the kernel
  */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7dd4e0349ef3..84e099a87383 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -59,12 +59,6 @@
 	(typeof(ptr)) (__ptr + (off));					\
 })
 
-/*
- * A trick to suppress uninitialized variable warning without generating any
- * code
- */
-#define uninitialized_var(x) x = x
-
 #ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 9f9002734e19..2f2f4082225e 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -111,8 +111,6 @@
 # define noinline
 #endif
 
-#define uninitialized_var(x) x = *(&(x))
-
 #include <linux/types.h>
 
 /*
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6683b4a70b05..1e14ab967c11 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -109,8 +109,6 @@ static inline void free_page(unsigned long addr)
 	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
 	(type *)( (char *)__mptr - offsetof(type,member) );})
 
-#define uninitialized_var(x) x = x
-
 # ifndef likely
 #  define likely(x)	(__builtin_expect(!!(x), 1))
 # endif
-- 
2.25.1

