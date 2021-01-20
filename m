Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4402FD8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392293AbhATTAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbhATRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:37:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4702E207C4;
        Wed, 20 Jan 2021 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164190;
        bh=5GZtx5inBi7paTjDAzc0sxuRXktlFwJSoTEoY/D7ZmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdWQv3xvaA0v2TUZLwjq/QGsJ+90rBiCFsxBIr34LBByEZuIYI4bPMdgX8r2vGxkD
         OaNtl1caOy2s/6Q0kWQ15uL3/Gaoa+ORzSuHZtCsgOpwtnPQyXeNVoAFvfO0qPineM
         BHV5wE1Hi3ON5AppH0sBkknp/dmYcSm1iY2+MGiJd22K/8Fgjq5zArzlo0FsUSpB19
         OOJMqFjNHI+NLfN1sZ3oi2EeaX4R/p/3FtrMAuqEEMbAzXsz2pEF5AnTwruZj6pEs/
         0yssvKFDKB4+AStqrSSBERctINEwvYNiFSiu42ee+DZd4KB6aALo6lSlcKvv3EPeve
         c1jbPXJV153NQ==
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
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: [PATCH v4 3/8] arm64: mm: Implement arch_wants_old_prefaulted_pte()
Date:   Wed, 20 Jan 2021 17:36:07 +0000
Message-Id: <20210120173612.20913-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
References: <20210120173612.20913-1-will@kernel.org>
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

