Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAE2EF659
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbhAHRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbhAHRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:16:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 227E623A1D;
        Fri,  8 Jan 2021 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610126137;
        bh=a8XtFnA7Zvrd0DWLoNyieMx6jPLocftcZJUWhZ6r6ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9nPI7ivwFyQT3P0dzQuu+zFqBTC4v2Wgv7wkX0WyHOzmeOnQYOmKVaQHDreD0RFh
         0UFgmwKyA/o+dHv58kCLc7pdd9DTj6Rfki3fYqQ/ghiZiTQnbRGWExe0tWmjI+ynRr
         uGFzbQdWdameHsCIHXBXqhXL7ZaolzjQYGQXlzPQMHAvnHC0uw+ckErXkOc7s7RQ2D
         NX7Mh2z0TuDNU8YhSfJuB5D5cg+QaeKq7bFU2enyldXU8NtTZW/p/sFmYlSFvgVIek
         onUwKo5nbROA5DW3ShBzanFVGJP+D4+Lv0bBY1R7Yfw9zAQYFs3g+RiGAVy/2nowf8
         ROpcP+z5L6/4w==
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
Subject: [PATCH v2 3/3] arm64: mm: Implement arch_wants_old_prefaulted_pte()
Date:   Fri,  8 Jan 2021 17:15:17 +0000
Message-Id: <20210108171517.5290-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210108171517.5290-1-will@kernel.org>
References: <20210108171517.5290-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPUs with hardware AF/DBM, initialising prefaulted PTEs as 'old'
improves vmscan behaviour and does not appear to introduce any overhead.

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
2.29.2.729.g45daf8777d-goog

