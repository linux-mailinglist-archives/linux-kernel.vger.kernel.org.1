Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A282A44F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgKCMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbgKCMRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:17:34 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFC92240C;
        Tue,  3 Nov 2020 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405853;
        bh=BCgiu9K0Vqk44ZIzAPpCiD5ozFp8P1v2e6umqroeIWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kw3wHPhXk4rskprK8mBpamdvL2GCzA8ksI4tAq5mCcBT1gkO5UV5Nr+73FKJpd4Bv
         Uu9H8Eq2lWNvAmd1aQvkQPz9JK+6yhGFCzb/p8V4y3ZTvq9fslGrG0Uhpw1b9Jxyra
         I6cSgsNvF/t5+WY9+OuSNvGDTja250yeCyedtKr0=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] arm64: alternatives: Remove READ_ONCE() usage during patch operation
Date:   Tue,  3 Nov 2020 12:17:20 +0000
Message-Id: <20201103121721.5166-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103121721.5166-1-will@kernel.org>
References: <20201103121721.5166-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for patching the internals of READ_ONCE() itself, replace
its usage on the alternatives patching patch with a volatile variable
instead.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/alternative.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 73039949b5ce..a57cffb752e8 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -21,7 +21,8 @@
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-static int all_alternatives_applied;
+/* Volatile, as we may be patching the guts of READ_ONCE() */
+static volatile int all_alternatives_applied;
 
 static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
 
@@ -205,7 +206,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-		while (!READ_ONCE(all_alternatives_applied))
+		while (!all_alternatives_applied)
 			cpu_relax();
 		isb();
 	} else {
@@ -217,7 +218,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		BUG_ON(all_alternatives_applied);
 		__apply_alternatives(&region, false, remaining_capabilities);
 		/* Barriers provided by the cache flushing */
-		WRITE_ONCE(all_alternatives_applied, 1);
+		all_alternatives_applied = 1;
 	}
 
 	return 0;
-- 
2.29.1.341.ge80a0c044ae-goog

