Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18E529924B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785786AbgJZQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785777AbgJZQXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:23:44 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 029C722284;
        Mon, 26 Oct 2020 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603729424;
        bh=yUOfxfS9igt/p3qR0VlqJ21rvyD2S/dpzhyJ173/25k=;
        h=From:To:Cc:Subject:Date:From;
        b=esLzZFZJtsmQeXwsk36H9Qm8iJH5Xt7kCisL900ixIlu1Zizxj0482lrANlS2od0x
         i2cgrIu7Rlac4xLGrrYiOf2cxuPyYJgEEIJI75aThrHDnwwrrfNxO+Vg6JsP1P8442
         2QSItQ+ylghWglsLO/Cz+7liKQJ5+x4Y48QUaF/g=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] ctype.h: remove duplicate isdigit() helper
Date:   Mon, 26 Oct 2020 17:23:29 +0100
Message-Id: <20201026162336.3711040-1-arnd@kernel.org>
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
 include/linux/ctype.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/ctype.h b/include/linux/ctype.h
index 363b004426db..c407acb258c2 100644
--- a/include/linux/ctype.h
+++ b/include/linux/ctype.h
@@ -23,10 +23,6 @@ extern const unsigned char _ctype[];
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
@@ -39,6 +35,18 @@ static inline int isdigit(int c)
 #define isascii(c) (((unsigned char)(c))<=0x7f)
 #define toascii(c) (((unsigned char)(c))&0x7f)
 
+#if defined __has_builtin
+#if __has_builtin(__builtin_isdigit)
+#define isdigit(ch) __builtin_isdigit(ch)
+#endif
+#endif
+#ifndef isdigit
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

