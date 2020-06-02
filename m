Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7381EC104
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFBReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFBRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:34:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532FBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4xLbMzeVbeH3u0A7zApTQ56UOcpBzDKP0lu5oB5vj54=; b=m6Don+I+7KFCv5+GxGzZPW3TPM
        7tpfoX5YzzUUF6Xp/Qb+rdslyDqTpJ73T3bjH/yiAe+DIoda8Yg/LlrqA8PxRbqWF85/XDNyLqFLV
        jqkD4v2vQMGniJiZW0DqvD9848kRMxi90fCEq1WZSZDppsM+d/tp9yo5YoNjg3n6oS9fSVsNmtQeG
        uFMdMTykYNykPcJdQsTJo/OBEwSztVxY/8YYQWCwoPcYw8ee3lb3VjpUGKGGC1u4Z8TSWmMFTAfsk
        eBCHuOE7XmaBd7BI0nVHmaVIQU4WDFElyKawOwjSKm1+QIKFMK+EEl0dH+GAWJffpyGceDpGIAMoP
        JT+0OQww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgAoC-0007Aq-7S; Tue, 02 Jun 2020 17:34:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D287302753;
        Tue,  2 Jun 2020 19:34:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 053AD202436F2; Tue,  2 Jun 2020 19:34:37 +0200 (CEST)
Message-ID: <20200602173348.343967487@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Jun 2020 19:31:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 1/3] x86, kcsan: Remove __no_kcsan_or_inline usage
References: <20200602173103.931412766@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that KCSAN relies on -tsan-distinguish-volatile we no longer need
the annotation for constant_test_bit(). Remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bitops.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,12 +201,8 @@ arch_test_and_change_bit(long nr, volati
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
-	/*
-	 * Because this is a plain access, we need to disable KCSAN here to
-	 * avoid double instrumentation via instrumented bitops.
-	 */
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }


