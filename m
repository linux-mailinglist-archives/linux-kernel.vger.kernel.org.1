Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049ED287450
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgJHMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:34:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgJHMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:34:40 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mc06b-1kviHD2F9r-00dUgU; Thu, 08 Oct 2020 14:34:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: avoid xchg() warning
Date:   Thu,  8 Oct 2020 14:34:04 +0200
Message-Id: <20201008123429.1133896-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:I+9wR8oh7607EOHEdvNpIMSS6YsdYkrjnvM8U1fKs03vgNed7Sd
 ETQk6e3YUOZqq1DGvZiyk38v/6qe7oF5eD8BkHzo2ie4GRM3ioP1C7mCFsITvD2HwoUyocZ
 e2lVd7u5vP7YHQ6GM04Vmudw91EzW8iJ+UnlxLVDpg5K1QEeqPqYtetRL2r/dRi/tFE/DZW
 u5N5o8K/cFYf2d42h/J+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WIq8Vn22CvA=:R72ll13MwBmZy71UmvPEXk
 /onrvpLxj7arDjjfhgZloR8fqEzN3vHRcSWCsfnUvGlA/+NpTnVUJTzSejQkSOcCc+CzVuT/E
 6X6Z2r+7cDphDDzk997c+uOtlyK1blyem8c+99wkMniSPph0QUhTpUAT6N8HASrDiRQ9XK83/
 TV/Y+wct7d6wXUps+xpdenAEucQrlO+t4phqRl/htKIuUWsCt18TkLZbv+nsX0pn87GmPcUIE
 j7oFQLmjhq7/Y6kvsbfFPUGQN+8djJb9xT23uUApIY56wPtsGD8xm1XiIZE3FNsSR3XXe2pck
 II7PxFLOPE6fFLXZnZRWnUeym6qQ3rKNLq44kqhVfPaEM1Md3ocS3JMIFy03s+wlKy+YJGZRZ
 XjLv/OmenJ7pzNnY0tw8VZGUtC8cXr6RwtOmPR87uX47JbtaNcX7Elp7ZiIw2bLx8sUH0cCWF
 MrpiwzfCBPOubzkh/AY3674R/8ycwZbdHhJsvW8N953F3TTXQVvsW4BZfOxzmZBdiNhFeLjmV
 1RdBN7kJ6fshrZTSFQlW8xtJ/krazKGmcuv5Vslxw24t6C79rrrwkkK2U7vW9kdDRDS9S70a5
 zxHDjRgxrFs+D6xQZjLXtqSVSFCIT4Q1tUDw/egVgw6v0Amry+dUjvcwJNkdlrTuvcSGzLIjp
 1j9u5IBwfS+WZW041tY9dOHEBtbHGYN8JkF6j0/XUQKMsrgcIUpcyJbgrjq7ASTOSh4YMdko3
 Dub+Cc6nJhjutJdUmlG/UoNG5oW90aQwpCxL9EjgfC0PT3h82ZdNovkGbZQ6RHrRgimATaidB
 ft+t13Juj5Qe89g4jcJ/E8u0SutMgeyunTmM5H4xdlXrLAIYNBZmU9ZX1V4XTCjX8ezPhDS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns about the value of xchg()/cmpxchg() being unused
in some cases:

net/core/filter.c: In function 'bpf_clear_redirect_map':
arch/m68k/include/asm/cmpxchg.h:137:3: warning: value computed is not used [-Wunused-value]
  106 | #define cmpxchg(ptr, o, n) cmpxchg_local((ptr), (o), (n))
net/core/filter.c:3595:4: note: in expansion of macro 'cmpxchg'
 3595 |    cmpxchg(&ri->map, map, NULL);

Shut up that warning like we do on other architectures, by
turning the macro into a statement expression.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/cmpxchg.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 3a3bdcfcd375..a4aa82021d3b 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -76,7 +76,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 }
 #endif
 
-#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
 
 #include <asm-generic/cmpxchg-local.h>
 
@@ -119,11 +119,11 @@ static inline unsigned long __cmpxchg(volatile void *p, unsigned long old,
 }
 
 #define cmpxchg(ptr, o, n)						    \
-	((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
-			(unsigned long)(n), sizeof(*(ptr))))
+	({(__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
+			(unsigned long)(n), sizeof(*(ptr)));})
 #define cmpxchg_local(ptr, o, n)					    \
-	((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
-			(unsigned long)(n), sizeof(*(ptr))))
+	({(__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
+			(unsigned long)(n), sizeof(*(ptr)));})
 
 #define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
 
-- 
2.27.0

