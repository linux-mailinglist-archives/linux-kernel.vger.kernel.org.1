Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9B1CF0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgELJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 05:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgELJB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:27 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11292207FF;
        Tue, 12 May 2020 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589274087;
        bh=C3guuoMqBfrmKZqycLGf0H3TPGSppBdGMcJv42z9iVw=;
        h=From:To:Cc:Subject:Date:From;
        b=yHWFno2u2Adj+OTBopbDm+rmB0LKoWEKwpFgU4RMqTJ/8KI4tb30C+7NAu9pJdoXb
         7ZC1FbHX5zNlBumOuA0tu55BTTu6Upm8S8XI031/dEvXUzBcoHWNUuKE11glDDiz4e
         sYb+5yLHw/gRuuhq4hEJ4xNhrS6BMKypmfVm6P1c=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH] READ_ONCE: Fix comment describing 2x32-bit atomicity
Date:   Tue, 12 May 2020 10:01:01 +0100
Message-Id: <20200512090101.2497-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

READ_ONCE() permits 64-bit accesses on 32-bit architectures, since this
crops up in a few places and is generally harmless because either the
upper bits are always zero (e.g. for a virtual address or 32-bit time_t)
or the architecture provides 64-bit atomicity anyway.

Update the corresponding comment above compiletime_assert_rwonce_type(),
which incorrectly states that 32-bit x86 provides 64-bit atomicity, and
instead reference 32-bit Armv7 with LPAE.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

Applies on top of the READ_ONCE() pile I sent last night (v5).

 include/linux/compiler.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 741c93c62ecf..e24cc3a2bc3e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -384,9 +384,9 @@ static inline void *offset_to_ptr(const int *off)
 
 /*
  * Yes, this permits 64-bit accesses on 32-bit architectures. These will
- * actually be atomic in many cases (namely x86), but for others we rely on
- * the access being split into 2x32-bit accesses for a 32-bit quantity (e.g.
- * a virtual address) and a strong prevailing wind.
+ * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
+ * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
+ * (e.g. a virtual address) and a strong prevailing wind.
  */
 #define compiletime_assert_rwonce_type(t)					\
 	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
-- 
2.26.2.645.ge9eca65c58-goog

