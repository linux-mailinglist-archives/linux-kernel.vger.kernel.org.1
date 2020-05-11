Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35001CD84C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgEKLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:25:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46759 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgEKLZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJWr0X5Xz9ty3p;
        Mon, 11 May 2020 13:25:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6IzsmW3rgw_U; Mon, 11 May 2020 13:25:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJWq6smjz9ty3g;
        Mon, 11 May 2020 13:25:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A4BCA8B7B1;
        Mon, 11 May 2020 13:25:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q-UWe4hNu2U6; Mon, 11 May 2020 13:25:34 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 602518B7AD;
        Mon, 11 May 2020 13:25:34 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EF19865A09; Mon, 11 May 2020 11:25:33 +0000 (UTC)
Message-Id: <55e07412794112aadb3f4b91027bfd17e1aa1421.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 08/45] powerpc/ptdump: Reorder flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder flags in a more logical way:
- Page size (huge) first
- User
- RWX
- Present
- WIMG
- Special
- Dirty and Accessed

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/8xx.c    | 30 +++++++++++++++---------------
 arch/powerpc/mm/ptdump/shared.c | 30 +++++++++++++++---------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index ca9ce94672f5..a3169677dced 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -11,11 +11,6 @@
 
 static const struct flag_info flag_array[] = {
 	{
-		.mask	= _PAGE_SH,
-		.val	= _PAGE_SH,
-		.set	= "sh",
-		.clear	= "  ",
-	}, {
 		.mask	= _PAGE_RO | _PAGE_NA,
 		.val	= 0,
 		.set	= "rw",
@@ -37,11 +32,26 @@ static const struct flag_info flag_array[] = {
 		.val	= _PAGE_PRESENT,
 		.set	= "p",
 		.clear	= " ",
+	}, {
+		.mask	= _PAGE_NO_CACHE,
+		.val	= _PAGE_NO_CACHE,
+		.set	= "i",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_GUARDED,
 		.val	= _PAGE_GUARDED,
 		.set	= "g",
 		.clear	= " ",
+	}, {
+		.mask	= _PAGE_SH,
+		.val	= _PAGE_SH,
+		.set	= "sh",
+		.clear	= "  ",
+	}, {
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "s",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_DIRTY,
 		.val	= _PAGE_DIRTY,
@@ -52,16 +62,6 @@ static const struct flag_info flag_array[] = {
 		.val	= _PAGE_ACCESSED,
 		.set	= "a",
 		.clear	= " ",
-	}, {
-		.mask	= _PAGE_NO_CACHE,
-		.val	= _PAGE_NO_CACHE,
-		.set	= "i",
-		.clear	= " ",
-	}, {
-		.mask	= _PAGE_SPECIAL,
-		.val	= _PAGE_SPECIAL,
-		.set	= "s",
-		.clear	= " ",
 	}
 };
 
diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index 44a8a64a664f..dab5d8028a9b 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -30,21 +30,6 @@ static const struct flag_info flag_array[] = {
 		.val	= _PAGE_PRESENT,
 		.set	= "p",
 		.clear	= " ",
-	}, {
-		.mask	= _PAGE_GUARDED,
-		.val	= _PAGE_GUARDED,
-		.set	= "g",
-		.clear	= " ",
-	}, {
-		.mask	= _PAGE_DIRTY,
-		.val	= _PAGE_DIRTY,
-		.set	= "d",
-		.clear	= " ",
-	}, {
-		.mask	= _PAGE_ACCESSED,
-		.val	= _PAGE_ACCESSED,
-		.set	= "a",
-		.clear	= " ",
 	}, {
 		.mask	= _PAGE_WRITETHRU,
 		.val	= _PAGE_WRITETHRU,
@@ -55,11 +40,26 @@ static const struct flag_info flag_array[] = {
 		.val	= _PAGE_NO_CACHE,
 		.set	= "i",
 		.clear	= " ",
+	}, {
+		.mask	= _PAGE_GUARDED,
+		.val	= _PAGE_GUARDED,
+		.set	= "g",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
 		.set	= "s",
 		.clear	= " ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "d",
+		.clear	= " ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "a",
+		.clear	= " ",
 	}
 };
 
-- 
2.25.0

