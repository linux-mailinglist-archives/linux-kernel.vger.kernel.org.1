Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A491CE5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgEKUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731896AbgEKUnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:43:00 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63BC320A8B;
        Mon, 11 May 2020 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229779;
        bh=+CCI+6XYW4jv1KuUrAbjuCuJOFWZCYBS4Rh74IvMaIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pz19izpQ+98KiaT366Vmxvq72eia2cLiZRWxUSDMW99mQDAAlY+HHC1VarpNKfylO
         qurYlWz4bul5382PKI+fH/BfllETbIDkQDYEvFBK3vNN+bfI9SdAQMNsLGc5FLgZDF
         MIUYmvdiHhLhmFs7burG0C0tbc6yEaa9KODCSZr4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 16/18] kcsan: Rework data_race() so that it can be used by READ_ONCE()
Date:   Mon, 11 May 2020 21:41:48 +0100
Message-Id: <20200511204150.27858-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the data_race() macro so that it:

  - Accepts expressions which evaluate to a 'const' type
  - Attempts to discard volatile qualifiers from scalar types, avoiding
    pointless stack spills
  - Uses __kcsan_{disable,enable}_current(), allowing its use from code
    that is built independently from the kernel, such as the vDSO

This will allow for its use by {READ,WRITE}_ONCE() in a subsequent patch.
At the same time, fix-up some weird whitespace issues.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0caced170a8a..f2a64195ee8e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -314,14 +314,15 @@ unsigned long read_word_at_a_time(const void *addr)
  * This macro *does not* affect normal code generation, but is a hint
  * to tooling that data races here are to be ignored.
  */
-#define data_race(expr)                                                        \
-	({                                                                     \
-		typeof(({ expr; })) __val;                                     \
-		kcsan_disable_current();                                       \
-		__val = ({ expr; });                                           \
-		kcsan_enable_current();                                        \
-		__val;                                                         \
-	})
+#define data_race(expr)							\
+({									\
+	__kcsan_disable_current();					\
+	({								\
+		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
+		__kcsan_enable_current();				\
+		__v;							\
+	});								\
+})
 #else
 
 #endif /* __KERNEL__ */
-- 
2.26.2.645.ge9eca65c58-goog

