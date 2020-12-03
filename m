Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322F2CE1E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgLCWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgLCWhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:37:38 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] selftest/fpu: avoid clang warning
Date:   Thu,  3 Dec 2020 23:36:30 +0100
Message-Id: <20201203223652.1320700-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With extra warnings enabled, clang complains about the redundant
-mhard-float argument:

clang: error: argument unused during compilation: '-mhard-float' [-Werror,-Wunused-command-line-argument]

Move this into the gcc-only part of the Makefile.

Fixes: 4185b3b92792 ("selftests/fpu: Add an FPU selftest")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 985c6a8909e0..dc623561ef9d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
 # get appended last to CFLAGS and thus override those previous compiler options.
 #
-FPU_CFLAGS := -mhard-float -msse -msse2
+FPU_CFLAGS := -msse -msse2
 ifdef CONFIG_CC_IS_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
@@ -120,6 +120,7 @@ ifdef CONFIG_CC_IS_GCC
 #  -mpreferred-stack-boundary=3 is not between 4 and 12
 #
 # can be triggered. Otherwise gcc doesn't complain.
+FPU_CFLAGS += -mhard-float
 FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
 endif
 
-- 
2.27.0

