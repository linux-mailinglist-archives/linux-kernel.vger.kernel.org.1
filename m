Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACB727F173
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgI3Sj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:39:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54341 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3Sj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:39:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200930183924euoutp025de3b64dc2066735e6718713997158a8~5o7qyK0aQ3098530985euoutp02j
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200930183924euoutp025de3b64dc2066735e6718713997158a8~5o7qyK0aQ3098530985euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601491164;
        bh=bc6vCXY5W/Zq9gSC9dpK4wsgx0OJXc0ePYpMVE+U1/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTnRm+3TyS7WtndLMcRND+QbbS+oU5el8VPrvldyX1h2KfxswGYxPcNUkrXWPCG/u
         evtXoEaMSsGrHIjobHCC8eR51rbcitIC8cdSnxXwIjaMDMyNESeJ8297V5pzhCVImD
         1aSs6CG2Phy5o208eOdNuOGknC4OK/6WpVRszA8A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200930183924eucas1p104c81418b7b3257a0de7cd4c2bd9bc04~5o7qf-aOf1834618346eucas1p15;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 97.10.06318.CD0D47F5; Wed, 30
        Sep 2020 19:39:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200930183923eucas1p2241d3e1b8d4d05a2228448ff8fc4bb74~5o7qB8rJa0060600606eucas1p27;
        Wed, 30 Sep 2020 18:39:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200930183923eusmtrp2a04d19e2723d7361276d8224333460af~5o7qBJVMw3109431094eusmtrp2B;
        Wed, 30 Sep 2020 18:39:23 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-77-5f74d0dca353
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 62.F3.06017.BD0D47F5; Wed, 30
        Sep 2020 19:39:23 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200930183923eusmtip192527e4174f64558a64d624446d17b20~5o7pyTLOZ1501415014eusmtip1Y;
        Wed, 30 Sep 2020 18:39:23 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 1/4] arm: add image header definitions
Date:   Wed, 30 Sep 2020 20:34:10 +0200
Message-Id: <20200930183413.17023-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930183413.17023-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvT6UAsjAXlBIloRSMkgAaXMSwu8WFiDPGB+GBUqDJhbSGd
        FsUXyqIIItRiXQqRxqBgBdGCoOw2BBSkgkuBpASNxgWoEtFEFEHagcjbOff//vOfk1wSk0wI
        fckkhYpVKmSpUsIdb+yeeRFsH1DFbrn52Zt+cK1OSOvudQpozSUNTo9ktwjo5xfkdEvfTwE9
        YqlGtPm9TUi/ai4naIu+DdG1XaMi+t3bYSF9d64X0VPaeQE92zGD0/VmPbaHYl7ZBjGmTDOI
        M39NnzHGaFYzZlMBwdhtrQTz1WoVMfWVWYx2ykEw39rfEExxgwkx0+a1h1YccY+IZ1OTMlhl
        aFSce6L98hCRbvQ77eg1ijQo26cQuZFAbYPXhklBIXInJVQ1gpaOdswpSKgfCKZrd/LCNIKO
        2jm05BgdmMF5oQqBLXcE8c0nBM/uN+NOiqD2Qsmtp0Kn4E29xWBcX+WyYNRtBPPXJoVOyova
        BY7hAZcDpzbCyFivK0NMhYN2rATn8/whv6qJcNZuVAS87O8ieGYlPLv+wcV4UkFQkzPkqrEF
        PvdhGeYMA+oOCdbJgoXzyIVmPzhmIvmZXjDe0yDiaz+Yf1yxiGRBqW4Hby1C0Fj+a3GHcLBb
        fxNOBqMCoa45lH/eCzWVn0S81QOGHSv5DTxA13gV45/FcP6chKcD4F5J6+JAX7g4Xo20SGpY
        doth2f6G/1lGhJmQD6vm5AksF6ZgT4VwMjmnViSEnEyTm9HCF+yb6/n5CLXPnrAgikTSFWKt
        QhUrEcoyuEy5BQGJSb3F+/r7jkvE8bLMM6wyLVapTmU5C1pD4lIfcdjNL8ckVIJMxaawbDqr
        XFIFpJuvBh0u18e82Xll6vCBsYAhw8ctrYH+9iub8t1s6+NgQvfQ2t6ZUlyk6i7rjEqLjCl+
        nTdmzF3nmXIip60+L+O2tEYfcCRn26D6Oxw8enx8e0P0E/ZjYfJASlZecMXu0zdqm5SZiVOe
        YRssyb2Rq3Rd1kN/Nhf/Th4VfYteXdrMXTy764AU5xJlW4MwJSf7B6PjOVx+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7q3L5TEG3y6amixccZ6VotJ6w4w
        WTRMbGCxuNm4m8niTHeuxe7TX5ksbh5awWix6fE1VovLu+awWRyaupfRYu2Ru+wWDx/cYLVY
        /e8Uo8WHCf+ZLP7s/8lisXnTVGYHAY/L1y4ye8xuuMji8XfVC2aPBZtKPTat6mTzuHNtD5vH
        u3Pn2D02L6n3mPDhLZvH+31X2Tz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJC
        z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv486U62wFC2Qq3p5awN7A2CjexcjJISFgInH3
        wk+WLkYuDiGBpYwS02dsZeti5ABKSEmsnJsOUSMs8edaFxtEzVNGiQWndrKBJNgEHCX6l55g
        BUmICLxhlmif+AysillgGaPE4v/9rCBVwgKWEm9vXGABsVkEVCVu3j/FCGLzClhLTLjfzwKx
        Ql6iffl2sKmcAjYSl84eAbOFBHIltk/8xARRLyhxcuYTFpDrmAXUJdbPEwIJ8wtoSaxpug42
        hhloTPPW2cwTGIVmIemYhdAxC0nVAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFRv+3Y
        zy07GLveBR9iFOBgVOLhnZBXEi/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTi
        Q4ymQG9OZJYSTc4HJiSgHkNTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxS
        DYxyvxhmp1wq4ny8J9M68bu+t7T9lg36E9jduBaG/5K0+q9eFqyz4MEa67AD5VPiv03VfHX4
        aO6Tj3Ncclw4JXQlNksEcSf4sk1Rtdnza+qV8NLL1w6flXvd835tK/f8HcZxp+Ispu+t3Wec
        U7pM+c+F5fOm23+Y8txh83mx1i/xj3kuphYFtMkrsRRnJBpqMRcVJwIATmGdbhADAAA=
X-CMS-MailID: 20200930183923eucas1p2241d3e1b8d4d05a2228448ff8fc4bb74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200930183923eucas1p2241d3e1b8d4d05a2228448ff8fc4bb74
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200930183923eucas1p2241d3e1b8d4d05a2228448ff8fc4bb74
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200930183413.17023-1-l.stelmach@samsung.com>
        <CGME20200930183923eucas1p2241d3e1b8d4d05a2228448ff8fc4bb74@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This structure will be used later by kexec_file loader.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/head.S        |  3 +-
 arch/arm/boot/compressed/vmlinux.lds.S | 13 ++-----
 arch/arm/include/asm/image.h           | 50 ++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/include/asm/image.h

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 2e04ec5b5446..3099002ad13a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -7,6 +7,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/image.h>
 #include <asm/v7m.h>
 
 #include "efi-header.S"
@@ -206,7 +207,7 @@ start:
 		.word	_magic_start	@ absolute load/run zImage address
 		.word	_magic_end	@ zImage end address
 		.word	0x04030201	@ endianness flag
-		.word	0x45454545	@ another magic number to indicate
+		.word	ARM_ZIMAGE_MAGIC2 @ another magic number to indicate
 		.word	_magic_table	@ additional data table
 
 		__EFI_HEADER
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 1bcb68ac4b01..a6b151112ac5 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -4,14 +4,7 @@
  */
 #include <asm/vmlinux.lds.h>
 
-#ifdef CONFIG_CPU_ENDIAN_BE8
-#define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
-			  (((x) >>  8) & 0x0000ff00) | \
-			  (((x) <<  8) & 0x00ff0000) | \
-			  (((x) << 24) & 0xff000000) )
-#else
-#define ZIMAGE_MAGIC(x) (x)
-#endif
+#include <asm/image.h>
 
 OUTPUT_ARCH(arm)
 ENTRY(_start)
@@ -45,7 +38,7 @@ SECTIONS
   .table : ALIGN(4) {
     _table_start = .;
     LONG(ZIMAGE_MAGIC(6))
-    LONG(ZIMAGE_MAGIC(0x5a534c4b))
+    LONG(ARM_ZIMAGE_MAGIC3)
     LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
     LONG(ZIMAGE_MAGIC(TEXT_OFFSET))
@@ -116,7 +109,7 @@ SECTIONS
     _edata_real = .;
   }
 
-  _magic_sig = ZIMAGE_MAGIC(0x016f2818);
+  _magic_sig = ARM_ZIMAGE_MAGIC1;
   _magic_start = ZIMAGE_MAGIC(_start);
   _magic_end = ZIMAGE_MAGIC(_edata);
   _magic_table = ZIMAGE_MAGIC(_table_start - _start);
diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
new file mode 100644
index 000000000000..8150b9490e86
--- /dev/null
+++ b/arch/arm/include/asm/image.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define ZIMAGE_MAGIC(x) ((((x) >> 24) & 0x000000ff) | \
+			 (((x) >>  8) & 0x0000ff00) |  \
+			 (((x) <<  8) & 0x00ff0000) |  \
+			 (((x) << 24) & 0xff000000))
+#else
+#define ZIMAGE_MAGIC(x) (x)
+#endif
+
+#define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
+#define ARM_ZIMAGE_MAGIC2 (0x45454545)
+#define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <asm/setup.h>
+
+/* ARM zImage header format */
+struct arm_zimage_header {
+	__le32 code[9];
+	__le32 magic;
+	__le32 start;
+	__le32 end;
+	__le32 endian;
+	__le32 magic2;
+	__le32 extension_tag_offset;
+};
+
+struct arm_zimage_tag {
+	struct tag_header hdr;
+	union {
+#define ZIMAGE_TAG_KRNL_SIZE ARM_ZIMAGE_MAGIC3
+		struct zimage_krnl_size {
+			__le32 size_ptr;
+			__le32 bss_size;
+			__le32 text_offset;
+			__le32 malloc_size;
+		} krnl_size;
+	} u;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_IMAGE_H */
-- 
2.26.2

