Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB032B98BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgKSQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:57:19 -0500
Received: from devianza.investici.org ([198.167.222.108]:31113 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgKSQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:57:10 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CcQdB2d4mz6vNv;
        Thu, 19 Nov 2020 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605804574;
        bh=d3Gb/r8juyYmXty1Zs6cAP1wvNQs32vfeMBtqK0HsG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qehUZ7TGsAKobK8/EliqiGv/5zCIAPUWA3g9pJXEjVLNVc3Q4NYO/IqmijFTC4KUQ
         9XDR8Js4OvGcen/U5wK37vTZPA52gPMo/q/ow7g0vsoAbNJ/C8ryS63uvkJNZNmOz7
         oN2nYLeZLthkrWtEzpfkeFjwQEnw3tshxuZd9HPY=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CcQd96cpRz6vNC;
        Thu, 19 Nov 2020 16:49:33 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v6 3/5] string.h: Add FORTIFY coverage for strscpy()
Date:   Thu, 19 Nov 2020 17:49:13 +0100
Message-Id: <20201119164915.10618-4-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The fortified version of strscpy ensures the following before vanilla strscpy
is called:
1. There is no read overflow because we either size is smaller than src length
or we shrink size to src length by calling fortified strnlen.
2. There is no write overflow because we either failed during compilation or at
runtime by checking that size is smaller than dest size.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 46e91d684c47..1cd63a8a23ab 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/errno.h>	/* for E2BIG */
 #include <stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -357,6 +358,53 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 	return ret;
 }
 
+/* defined after fortified strnlen to reuse it */
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+{
+	size_t len;
+	/* Use string size rather than possible enclosing struct size. */
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+
+	/* If we cannot get size of p and q default to call strscpy. */
+	if (p_size == (size_t) -1 && q_size == (size_t) -1)
+		return __real_strscpy(p, q, size);
+
+	/*
+	 * If size can be known at compile time and is greater than
+	 * p_size, generate a compile time write overflow error.
+	 */
+	if (__builtin_constant_p(size) && size > p_size)
+		__write_overflow();
+
+	/*
+	 * This call protects from read overflow, because len will default to q
+	 * length if it smaller than size.
+	 */
+	len = strnlen(q, size);
+	/*
+	 * If len equals size, we will copy only size bytes which leads to
+	 * -E2BIG being returned.
+	 * Otherwise we will copy len + 1 because of the final '\O'.
+	 */
+	len = len == size ? size : len + 1;
+
+	/*
+	 * Generate a runtime write overflow error if len is greater than
+	 * p_size.
+	 */
+	if (len > p_size)
+		fortify_panic(__func__);
+
+	/*
+	 * We can now safely call vanilla strscpy because we are protected from:
+	 * 1. Read overflow thanks to call to strnlen().
+	 * 2. Write overflow thanks to above ifs.
+	 */
+	return __real_strscpy(p, q, len);
+}
+
 /* defined after fortified strlen and strnlen to reuse them */
 __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 {
-- 
2.20.1

