Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35B2F68B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbhANSBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbhANSBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:01:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 637B923B6E;
        Thu, 14 Jan 2021 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647251;
        bh=5GZtx5inBi7paTjDAzc0sxuRXktlFwJSoTEoY/D7ZmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cp9U1V8a4Q+VXkL5G4urrW8p7IY8F8ZhInSzyrprCD0gC8nSDKLyiNUCcnw6uL0rb
         YrBJf9gM887K+4e6re7rxuFuwdhz0GThnrFBYoU+Kz+Ya/IG7myNvRFK7ydrKzGO/C
         i+BAm6JQmDHYYza3SfGr5xJDf3JVURu1a7Sh6L9qPASX5r7na+kXc9HZtBAX/Eb9SX
         JfTDctDb1BwaHVrwoXbSInPEeuaGUUGf0tApmQCc1kM6EWDNEjOgQvX/wA8fWTqUIg
         wsnTmx0ywx6M0vyxCgGFIUWKinJXc4Tr9kjmRvUBNSb9ucDZcXfzBf9WEZkyTe1FNg
         Lv85wTU1RWTsg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [PATCH v3 3/8] arm64: mm: Implement arch_wants_old_prefaulted_pte()
Date:   Thu, 14 Jan 2021 17:59:29 +0000
Message-Id: <20210114175934.13070-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114175934.13070-1-will@kernel.org>
References: <20210114175934.13070-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPUs with hardware AF/DBM, initialising prefaulted PTEs as 'old'
improves vmscan behaviour and does not appear to introduce any overhead
elsewhere.

Implement arch_wants_old_prefaulted_pte() to return 'true' if we detect
hardware access flag support at runtime. This can be extended in future
based on MIDR matching if necessary.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 501562793ce2..e17b96d0e4b5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -980,7 +980,17 @@ static inline bool arch_faults_on_old_pte(void)
 
 	return !cpu_has_hw_af();
 }
-#define arch_faults_on_old_pte arch_faults_on_old_pte
+#define arch_faults_on_old_pte		arch_faults_on_old_pte
+
+/*
+ * Experimentally, it's cheap to set the access flag in hardware and we
+ * benefit from prefaulting mappings as 'old' to start with.
+ */
+static inline bool arch_wants_old_prefaulted_pte(void)
+{
+	return !arch_faults_on_old_pte();
+}
+#define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

