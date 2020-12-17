Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3F2DD4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgLQQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgLQQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:04:32 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org,
        bjorn.topel@intel.com, pdp7pdp7@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v5 3/9] riscv: Fixup wrong ftrace remove cflag
Date:   Thu, 17 Dec 2020 16:01:39 +0000
Message-Id: <1608220905-1962-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608220905-1962-1-git-send-email-guoren@kernel.org>
References: <1608220905-1962-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We must use $(CC_FLAGS_FTRACE) instead of directly using -pg. It
will cause -fpatchable-function-entry error.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/Makefile | 4 ++--
 arch/riscv/mm/Makefile     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fa896c5..27f10eb 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -4,8 +4,8 @@
 #
 
 ifdef CONFIG_FTRACE
-CFLAGS_REMOVE_ftrace.o	= -pg
-CFLAGS_REMOVE_patch.o	= -pg
+CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 endif
 
 extra-y += head.o
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index c0185e5..6b4b7ec 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -2,7 +2,7 @@
 
 CFLAGS_init.o := -mcmodel=medany
 ifdef CONFIG_FTRACE
-CFLAGS_REMOVE_init.o = -pg
+CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
 endif
 
 KCOV_INSTRUMENT_init.o := n
-- 
2.7.4

