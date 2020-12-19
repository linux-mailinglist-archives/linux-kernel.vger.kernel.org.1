Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4C52DED53
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 06:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgLSF0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 00:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgLSF0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 00:26:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0EC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 21:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7NOCJf6gSJieeeFiTAn8QMejK/YJVRySx4FEmsssJ68=; b=XKQR8ilZN8FePpiFjh3StysKK5
        fScFP8g1v6IZzFxSKo19SjXdWBSt0JpmR8qJW9pvfldM/LTkJW/wwDtHbzg756Wy82tIUeMwZ/MBv
        NCgcLUbdC0xK16HuG0foMasYvHZz9tcy0hGs55WRuSiOpIjV0bz6wGQTf9zdcP3Za1u4bGmSvhioy
        fQUNTg1+JYMzmKF1PaBxhtbo9GDKChFuaQM+/sMlD5RrMj60KYs5lf/PYdGHilLjUCwVjINrENK9l
        O3/hMGLyPly+zGDF9DwotcllvkNFRWvynKvRPIG6OAV34dh12mercmzkojVJRl/Nitl+BSpzgpQeL
        wX3AWmtw==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqUkK-0000Y1-DP; Sat, 19 Dec 2020 05:25:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Acked-by : Ilya Leoshkevich" <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] zlib: move EXPORT_SYMBOL() and MODULE_LICENSE() out of dfltcc_syms.c
Date:   Fri, 18 Dec 2020 21:25:30 -0800
Message-Id: <20201219052530.28461-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 11fb479ff5d9 ("zlib: export S390 symbols for zlib modules"), I added
EXPORT_SYMBOL()s to dfltcc_inflate.c but then Mikhail said that these
should probably be in dfltcc_syms.c with the other EXPORT_SYMBOL()s.

However, that is contrary to the current kernel style, which places
EXPORT_SYMBOL() immediately after the function that it applies to,
so move all EXPORT_SYMBOL()s to their respective function locations
and drop the dfltcc_syms.c file. Also move MODULE_LICENSE() from the
deleted file to dfltcc.c.

Fixes: 11fb479ff5d9 ("zlib: export S390 symbols for zlib modules")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/zlib_dfltcc/dfltcc.c         |    6 +++++-
 lib/zlib_dfltcc/dfltcc_deflate.c |    3 +++
 lib/zlib_dfltcc/dfltcc_syms.c    |   17 -----------------
 3 files changed, 8 insertions(+), 18 deletions(-)

--- linux-next-20201218.orig/lib/zlib_dfltcc/dfltcc.c
+++ linux-next-20201218/lib/zlib_dfltcc/dfltcc.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: Zlib
 /* dfltcc.c - SystemZ DEFLATE CONVERSION CALL support. */
 
-#include <linux/zutil.h>
+#include <linux/export.h>
+#include <linux/module.h>
 #include "dfltcc_util.h"
 #include "dfltcc.h"
 
@@ -53,3 +54,6 @@ void dfltcc_reset(
     dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
     dfltcc_state->param.ribm = DFLTCC_RIBM;
 }
+EXPORT_SYMBOL(dfltcc_reset);
+
+MODULE_LICENSE("GPL");
--- linux-next-20201218.orig/lib/zlib_dfltcc/dfltcc_deflate.c
+++ linux-next-20201218/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -4,6 +4,7 @@
 #include "dfltcc_util.h"
 #include "dfltcc.h"
 #include <asm/setup.h>
+#include <linux/export.h>
 #include <linux/zutil.h>
 
 /*
@@ -34,6 +35,7 @@ int dfltcc_can_deflate(
 
     return 1;
 }
+EXPORT_SYMBOL(dfltcc_can_deflate);
 
 static void dfltcc_gdht(
     z_streamp strm
@@ -277,3 +279,4 @@ again:
         goto again; /* deflate() must use all input or all output */
     return 1;
 }
+EXPORT_SYMBOL(dfltcc_deflate);
--- linux-next-20201218.orig/lib/zlib_dfltcc/dfltcc_syms.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/lib/zlib_dfltcc/dfltcc_syms.c
- *
- * Exported symbols for the s390 zlib dfltcc support.
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/zlib.h>
-#include "dfltcc.h"
-
-EXPORT_SYMBOL(dfltcc_can_deflate);
-EXPORT_SYMBOL(dfltcc_deflate);
-EXPORT_SYMBOL(dfltcc_reset);
-MODULE_LICENSE("GPL");
