Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55AC1A8DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 23:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634023AbgDNVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 17:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633973AbgDNVk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:40:28 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEC32076C;
        Tue, 14 Apr 2020 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586900428;
        bh=ve7sv4les00ZVqpVE/yt4gMPSgxJivLn9fk5bQ5+EmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/mx/JlWob8BANxK2lx+xGXhxtrKDIUO0pqls7LKmCmybl82tcTprQERGRPUWLSIc
         DmG7aHkm7XMTtbRcj/NBtwJiX/PKbTAe3lnBx7EAI8rslN8+KIhBqqfzO1KTC9of9r
         msqoqsOIgoa9iD4JgszOzQUlC0ngAeDee2y9vQjU=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        sparclinux@vger.kernel.org, kernel-team@android.com
Subject: [RESEND PATCH 4/4] sparc32: mm: Reduce allocation size for PMD and PTE tables
Date:   Tue, 14 Apr 2020 22:40:11 +0100
Message-Id: <20200414214011.2699-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414214011.2699-1-will@kernel.org>
References: <20200414214011.2699-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the page table allocator can free page table allocations
smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
to avoid needlessly wasting memory.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/include/asm/pgtsrmmu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 58ea8e8c6ee7..7708d015712b 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -17,8 +17,8 @@
 /* Number of contexts is implementation-dependent; 64k is the most we support */
 #define SRMMU_MAX_CONTEXTS	65536
 
-#define SRMMU_PTE_TABLE_SIZE		(PAGE_SIZE)
-#define SRMMU_PMD_TABLE_SIZE		(PAGE_SIZE)
+#define SRMMU_PTE_TABLE_SIZE		(PTRS_PER_PTE*4)
+#define SRMMU_PMD_TABLE_SIZE		(PTRS_PER_PMD*4)
 #define SRMMU_PGD_TABLE_SIZE		(PTRS_PER_PGD*4)
 
 /* Definition of the values in the ET field of PTD's and PTE's */
-- 
2.26.0.110.g2183baf09c-goog

