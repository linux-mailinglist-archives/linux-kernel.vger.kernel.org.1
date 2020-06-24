Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACF207BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406162AbgFXTDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 15:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404767AbgFXTDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:03:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F415020B80;
        Wed, 24 Jun 2020 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593025390;
        bh=YYqTV8Zr8/5F9AirsUFsM2FCNcZA3ZF1sVGi1jazgBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swkiOYkWbnYu+iQvYlbCgoiUAFg2MxYMRA0gzJqz7twzMDdSbtNMJ3vPivvMG5Csm
         Bbgo88tno+yEuJGh2gwpTfgUiAuo8aIcXyQq/S3rGGYIoDgn/D6uCIzMO4ViB7cDnw
         EhVthcjDSaX8B3eWuOufIcNpcv+S8/ca25/f0KD4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/3] kcsan: Disable branch tracing in core runtime
Date:   Wed, 24 Jun 2020 12:03:07 -0700
Message-Id: <20200624190307.15191-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624190236.GA6603@paulmck-ThinkPad-P72>
References: <20200624190236.GA6603@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Disable branch tracing in core KCSAN runtime if branches are being
traced (TRACE_BRANCH_PROFILING). This it to avoid its performance
impact, but also avoid recursion in case KCSAN is enabled for the branch
tracing runtime.

The latter had already been a problem for KASAN:
https://lore.kernel.org/lkml/CANpmjNOeXmD5E3O50Z3MjkiuCYaYOPyi+1rq=GZvEKwBvLR0Ug@mail.gmail.com/

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index fea064a..65ca553 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -8,7 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
-	-fno-stack-protector
+	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
-- 
2.9.5

