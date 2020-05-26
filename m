Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE511DCFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgEUObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 10:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgEUObi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:31:38 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37A32072C;
        Thu, 21 May 2020 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590071497;
        bh=sEMqdnK7cQntt7n99N96ofQDUkahXjZaaEEQmq4bc1I=;
        h=From:To:Cc:Subject:Date:From;
        b=Pr4qcLTCzWqvc52YlTUJJ0Uq1Bf2WsiVeUkxA5VstT1/NyRLnC4pswL1Av3Y3GEXL
         fXE+dD6ihdfYaBOvyWb10sxpORyNGgyOElIO/MvFPV9I1+2i7VPie5iIge2kZPkWx+
         rW1tXkCDioQFf8E7eU5RvURlt7N90D+tlcIykJQI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] bitops: Move test_bit() into bitops/atomic.h
Date:   Thu, 21 May 2020 15:31:29 +0100
Message-Id: <20200521143129.7526-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bit() is an atomic operation as documented by atomic_bitops.txt.
Move the function from bitops/non-atomic.h to bitops/atomic.h and adjust
its implementation to align with the other atomic bitops.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/bitops/atomic.h     |  6 ++++++
 include/asm-generic/bitops/non-atomic.h | 10 ----------
 2 files changed, 6 insertions(+), 10 deletions(-)

Just found this kicking around on a branch from last year!

diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index dd90c9792909..5fc4399d8fb4 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -17,6 +17,12 @@ static inline void set_bit(unsigned int nr, volatile unsigned long *p)
 	atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
+static inline int test_bit(unsigned int nr, const volatile unsigned long *p)
+{
+	p += BIT_WORD(nr);
+	return !!(READ_ONCE(*p) & BIT_MASK(nr));
+}
+
 static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 7e10c4b50c5d..8b44da59a9d0 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -96,14 +96,4 @@ static inline int __test_and_change_bit(int nr,
 	return (old & mask) != 0;
 }
 
-/**
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
-{
-	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
-}
-
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
-- 
2.26.2.761.g0e0b3e54be-goog

