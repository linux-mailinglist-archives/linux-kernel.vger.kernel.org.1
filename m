Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77E2EC25A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbhAFRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbhAFRed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:34:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 914F02312F;
        Wed,  6 Jan 2021 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954432;
        bh=uCyrTySTOecUcjr22U1nEfXeLczGcpalxZJbqBxUHRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnawW+P9fXBrLscxZuBGVG5ZJ95Y7wnd5cjZbvuYWcLwF9vVm1mfczFssOuyqF7fD
         mkMLtimVtVNPcrnhg9bkaWCnuGnuf0Xt9pR4UglzQx2ZLbxHxrkP9TaPG2ZRmkYMiO
         iogmV7053lK5ApYzWM+ygc4tRymdnFg/hhDAGpuBFLIwTi2cXpGy4Ttv1VQSSgwRXd
         /jhKnjJ4O87h3NOCRCHPl6RInK41Y7Wrym3s+QQmAnhoWaRFEVnn1dqgN6/rq31B+N
         l/VoSn1uhoHnN/MvrClgW53f3pZbbK8OrppU+mNm1ZQeybJteVjoUDTR+mXaeD0Ant
         17iS+Nxo00KmQ==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] random32: Re-enable KCSAN instrumentation
Date:   Wed,  6 Jan 2021 09:33:51 -0800
Message-Id: <20210106173351.23377-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173323.GA23292@paulmck-ThinkPad-P72>
References: <20210106173323.GA23292@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Re-enable KCSAN instrumentation, now that KCSAN no longer relies on code
in lib/random32.c.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index afeff05..dc09208 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -27,9 +27,6 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
-# Used by KCSAN while enabled, avoid recursion.
-KCSAN_SANITIZE_random32.o := n
-
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
-- 
2.9.5

