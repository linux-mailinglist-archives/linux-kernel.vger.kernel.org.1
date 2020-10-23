Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F52296B04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375662AbgJWIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374553AbgJWIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:16:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C839AC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 01:16:35 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id i39so347766qtb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bCm9g8jcXgNZHZSC/xIRr4kSLYBexCpDEsc6joeepFo=;
        b=nDzHHzuuY4+Qn8h9VBK+hQKJ2M5ExitXX5DXSUJQc61LT6/uljyOCVj5N7Vkr66Rl+
         8QFZ5uVzSHpv2CfZWQtlc21toPyvl5r/0ondqAvctKOqxUpozCBkvB1Dsa0aexVky8XA
         yDJe7lmCeIRKvc8AGGGZJ8MyYdks5CWn87vBHm9N0MDLnDsTbaaC6Lpg/D+doGJCIja9
         24hus9xuLEkIi7Czbps0GubYleM2wSauB5cxdWAgT85L2roWZ+vEJC0WcczUJnaypQ97
         OhRec1t0pyuoTgdwIedzNvJoTLn2JZlGj1W32cyRetkzCUAEaFnj6kLGCU5NUnUVrRdb
         8hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bCm9g8jcXgNZHZSC/xIRr4kSLYBexCpDEsc6joeepFo=;
        b=N3fmIJpFaWcvYTmJdB8YwDnDsn0x7XVV1DwGy83D4X0OSf3wZH5SCLuQKM/wckTMjI
         XGBANn5oKgph01W8bHAoB6mh6poLryXuyxXe4wXx/kolPEWi9pw5EdYmMxKGnEzhgM83
         vh8DaUd8RZkcNwbZ5Okq+88quEvqUguSEm11KHuKZMdVj1aVXt39DIgjvJCNX/cghsv6
         ZhZ7zA8duWe+vqGllcwlfAIVQ9UO60Cs3kPTxjIe88uaafv3nIwhX3BioRafRWtWCHsq
         3lOeHvuUdWqLW3RJ7T/EaK5koyC3/axhJIN0QbvVkpcrpoKAkqFJ+yANEKLee5zmQrSC
         pzAA==
X-Gm-Message-State: AOAM530ZAw/V4mDsrXyILwdDwPeR418x8HQpCgVnnggCa4RC4gLnsObZ
        B3tLJEopA8x1ijY3doJ70K++HxCh/O0=
X-Google-Smtp-Source: ABdhPJy1fBXppRJkGFYZcpfRxOJ0Xx8LJjMo83rvtkGnO8uefQZOXktiGylDqXceHIJzaL1OXkuInOrPPRw=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a0c:a304:: with SMTP id u4mr1004964qvu.58.1603440994760;
 Fri, 23 Oct 2020 01:16:34 -0700 (PDT)
Date:   Fri, 23 Oct 2020 10:16:28 +0200
Message-Id: <20201023081628.1296884-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v4] x86: add failure injection to get/put/clear_user
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

To test fault-tolerance of user memory acceses in x86, add support for
fault injection.

Make both put_user() and get_user() fail with -EFAULT, and clear_user()
fail by not clearing any bytes.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Albert van der Linde <alinde@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 - no significant changes

v3:
 - no changes

v4:
 - instrument the new out-of-line implementations of get_user()/put_user()
 - fix a minor checkpatch warning in the inline assembly

---
---
 arch/x86/include/asm/uaccess.h | 36 ++++++++++++++++++++++------------
 arch/x86/lib/usercopy_64.c     |  3 +++
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f13659523108..7041ebc48b75 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -5,6 +5,7 @@
  * User space memory access functions
  */
 #include <linux/compiler.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
 #include <asm/asm.h>
@@ -126,11 +127,16 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	asm volatile("call __" #fn "_%P4"				\
-		     : "=a" (__ret_gu), "=r" (__val_gu),		\
-			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
-	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
+	if (should_fail_usercopy()) {					\
+		(x) = 0;						\
+		__ret_gu = -EFAULT;					\
+	} else {							\
+		asm volatile("call __" #fn "_%P4"			\
+			     : "=a" (__ret_gu), "=r" (__val_gu),	\
+				ASM_CALL_CONSTRAINT			\
+			     : "0" (ptr), "i" (sizeof(*(ptr))));	\
+		(x) = (__force __typeof__(*(ptr))) __val_gu;		\
+	}								\
 	__builtin_expect(__ret_gu, 0);					\
 })
 
@@ -213,14 +219,18 @@ extern void __put_user_nocheck_8(void);
 	int __ret_pu;							\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
 	__chk_user_ptr(ptr);						\
-	__val_pu = (x);							\
-	asm volatile("call __" #fn "_%P[size]"				\
-		     : "=c" (__ret_pu),					\
-			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr),					\
-		       "r" (__val_pu),					\
-		       [size] "i" (sizeof(*(ptr)))			\
-		     :"ebx");						\
+	if (unlikely(should_fail_usercopy())) {				\
+		__ret_pu = -EFAULT;					\
+	} else {							\
+		__val_pu = (x);						\
+		asm volatile("call __" #fn "_%P[size]"			\
+			     : "=c" (__ret_pu),				\
+				ASM_CALL_CONSTRAINT			\
+			     : "0" (ptr),				\
+			       "r" (__val_pu),				\
+			       [size] "i" (sizeof(*(ptr)))		\
+			     : "ebx");					\
+	}								\
 	__builtin_expect(__ret_pu, 0);					\
 })
 
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 508c81e97ab1..5617b3864586 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -7,6 +7,7 @@
  * Copyright 2002 Andi Kleen <ak@suse.de>
  */
 #include <linux/export.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 
@@ -50,6 +51,8 @@ EXPORT_SYMBOL(__clear_user);
 
 unsigned long clear_user(void __user *to, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	if (access_ok(to, n))
 		return __clear_user(to, n);
 	return n;
-- 
2.29.0.rc2.309.g374f81d7ae-goog

