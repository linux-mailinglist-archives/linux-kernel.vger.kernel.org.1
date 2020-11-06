Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1FD2A8D37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgKFC4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:56:18 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60911 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgKFC4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:56:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UENt9Vb_1604631373;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UENt9Vb_1604631373)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 10:56:14 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Nick Terrell <terrelln@fb.com>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/zstd: remove unused macro tame compiler
Date:   Fri,  6 Nov 2020 10:56:08 +0800
Message-Id: <1604631368-77927-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some of unused macros cause compiler warning, let's remove them.

lib/zstd/fse_compress.c:82:0: warning: macro "FSE_FUNCTION_NAME" is not used [-Wunused-macros]
lib/zstd/fse_decompress.c:90:0: warning: macro "FSE_FUNCTION_NAME" is not used [-Wunused-macros]
lib/zstd/fse_compress.c:82:0: warning: macro "FSE_FUNCTION_NAME" is not used [-Wunused-macros]
lib/zstd/fse_decompress.c:90:0: warning: macro "FSE_FUNCTION_NAME" is not used [-Wunused-macros]
lib/zstd/fse_compress.c:83:0: warning: macro "FSE_TYPE_NAME" is not used [-Wunused-macros]
lib/zstd/fse_decompress.c:91:0: warning: macro "FSE_TYPE_NAME" is not used [-Wunused-macros]
lib/zstd/fse_compress.c:83:0: warning: macro "FSE_TYPE_NAME" is not used [-Wunused-macros]
lib/zstd/fse_decompress.c:91:0: warning: macro "FSE_TYPE_NAME" is not used [-Wunused-macros]
lib/zstd/fse_compress.c:81:0: warning: macro "FSE_CAT" is not used [-Wunused-macros]
lib/zstd/fse_decompress.c:89:0: warning: macro "FSE_CAT" is not used [-Wunused-macros]
lib/zstd/fse_compress.c:81:0: warning: macro "FSE_CAT" is not used [-Wunused-macros]
lib/zstd/fse_decompress.c:89:0: warning: macro "FSE_CAT" is not used [-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Nick Terrell <terrelln@fb.com> 
Cc: Kees Cook <keescook@chromium.org> 
Cc: Ingo Molnar <mingo@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/zstd/fse_compress.c   | 5 -----
 lib/zstd/fse_decompress.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/lib/zstd/fse_compress.c b/lib/zstd/fse_compress.c
index ef3d1741d532..20367cd2eaa0 100644
--- a/lib/zstd/fse_compress.c
+++ b/lib/zstd/fse_compress.c
@@ -77,11 +77,6 @@
 #error "FSE_FUNCTION_TYPE must be defined"
 #endif
 
-/* Function names */
-#define FSE_CAT(X, Y) X##Y
-#define FSE_FUNCTION_NAME(X, Y) FSE_CAT(X, Y)
-#define FSE_TYPE_NAME(X, Y) FSE_CAT(X, Y)
-
 /* Function templates */
 
 /* FSE_buildCTable_wksp() :
diff --git a/lib/zstd/fse_decompress.c b/lib/zstd/fse_decompress.c
index 0b353530fb3f..86fff64db563 100644
--- a/lib/zstd/fse_decompress.c
+++ b/lib/zstd/fse_decompress.c
@@ -78,11 +78,6 @@
 #error "FSE_FUNCTION_TYPE must be defined"
 #endif
 
-/* Function names */
-#define FSE_CAT(X, Y) X##Y
-#define FSE_FUNCTION_NAME(X, Y) FSE_CAT(X, Y)
-#define FSE_TYPE_NAME(X, Y) FSE_CAT(X, Y)
-
 /* Function templates */
 
 size_t FSE_buildDTable_wksp(FSE_DTable *dt, const short *normalizedCounter, unsigned maxSymbolValue, unsigned tableLog, void *workspace, size_t workspaceSize)
-- 
1.8.3.1

