Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686922996B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792941AbgJZTVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773013AbgJZTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:21:24 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE132080A;
        Mon, 26 Oct 2020 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603740084;
        bh=QBomOs1MRD6KBdhaZHDZgZVE4gAqM0ilwheUmiGBh0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=omCvoEY6+CUzGm9PICop4dkdjIM/YPYRckUPX/pbS7XxwLj9elWK5K196K7sL9Knd
         ZKSnxEtiWavmDtFG6+oSsg7RuWMboLugtq8ULVW8CfA7ON/5WwDfGYQE+9DteILWQG
         d/KF0/qglx/fJLUkt1cB+j/oUiTlRmWpQh0byo4Q=
From:   Arnd Bergmann <arnd@kernel.org>
To:     arnd@arndb.de
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v2] ctype.h: remove duplicate isdigit() helper
Date:   Mon, 26 Oct 2020 20:20:58 +0100
Message-Id: <20201026192117.3811525-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns a few thousand times about the isdigit() shadow:

include/linux/ctype.h:26:19: warning: declaration of 'isdigit' shadows a built-in function [-Wshadow]

As there is already a compiler builtin, just use that, and make
it clear we do that by defining a macro.  Unfortunately, clang
does not have the isdigit() builtin, so this has to be conditional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compiler.h |  6 ++++++
 include/linux/ctype.h    | 15 +++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ac45f6d40d39..b75b49f00ffd 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -136,6 +136,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 } while (0)
 #endif
 
+#ifdef __has_builtin
+#define has_builtin(x) __has_builtin(x)
+#else
+#define has_builtin(x) (0)
+#endif
+
 /*
  * KENTRY - kernel entry point
  * This can be used to annotate symbols (functions or data) that are used
diff --git a/include/linux/ctype.h b/include/linux/ctype.h
index 363b004426db..df8233c84b67 100644
--- a/include/linux/ctype.h
+++ b/include/linux/ctype.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_CTYPE_H
 #define _LINUX_CTYPE_H
 
+#include <linux/compiler.h>
+
 /*
  * NOTE! This ctype does not handle EOF like the standard C
  * library is required to.
@@ -23,10 +25,6 @@ extern const unsigned char _ctype[];
 #define isalnum(c)	((__ismask(c)&(_U|_L|_D)) != 0)
 #define isalpha(c)	((__ismask(c)&(_U|_L)) != 0)
 #define iscntrl(c)	((__ismask(c)&(_C)) != 0)
-static inline int isdigit(int c)
-{
-	return '0' <= c && c <= '9';
-}
 #define isgraph(c)	((__ismask(c)&(_P|_U|_L|_D)) != 0)
 #define islower(c)	((__ismask(c)&(_L)) != 0)
 #define isprint(c)	((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
@@ -39,6 +37,15 @@ static inline int isdigit(int c)
 #define isascii(c) (((unsigned char)(c))<=0x7f)
 #define toascii(c) (((unsigned char)(c))&0x7f)
 
+#if has_builtin(__builtin_isdigit)
+#define  isdigit(c) __builtin_isdigit(c)
+#else
+static inline int isdigit(int c)
+{
+	return '0' <= c && c <= '9';
+}
+#endif
+
 static inline unsigned char __tolower(unsigned char c)
 {
 	if (isupper(c))
-- 
2.27.0

