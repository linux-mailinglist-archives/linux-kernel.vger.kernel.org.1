Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509E3291055
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437369AbgJQHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437360AbgJQHHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:07:08 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0EE82074A;
        Sat, 17 Oct 2020 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602918428;
        bh=xA284iII8ZRmJJo0eUa2yxNmhAWRCMgnzZvf5SdcrYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzAG7FVunUHB2umA5syQVcafMHCwBPvMDzgvzxMn/sJ6XjQBUalPSMl3ojdAfid4E
         0x6XY/zyyPP6UBe2Gupm9G6cwNU4IbJPKsgg519HzOwFMJjnmus4EXaGF/yj5GXdbx
         lk8uXiLOMWZRgRuK/yeOXZ49jOzS8xSILcZPBlbQ=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v4 3/9] riscv: Fixup wrong ftrace remove cflag
Date:   Sat, 17 Oct 2020 07:06:11 +0000
Message-Id: <1602918377-23573-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602918377-23573-1-git-send-email-guoren@kernel.org>
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
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
index dc93710..f14aed2 100644
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

