Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD692077F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbgFXPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404618AbgFXPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101FC061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KFkNLGKnCZIPYfDCYZliBUs674rrJ6vlBRa3qnykRNg=; b=kKrkZPHLjpXbkItbSlOOa4pIOY
        OLvFmQmTvTgQVLVYnGbsRFnT8j5F2oHZmN6cRVrHBYEY6Wok25OS70d6tF7SxsZl9l9+OyGcnfzDi
        wRZrNBkLVDSv4QyuLvW06mLTUMoKMTxRAAoW1CIk/s/hopw79c8rstgfkMpfbrPFLs2xmtQlbcr4U
        Ln3k6m+8DDkeFL+3skJKZaMXsha/mz3GR18VT6b9CBK6sTK0GHZeAWZQMq0Wdew9Ba5v8Gx2l85Bi
        rXPIZ+wS0zmFQJvZQiG5g0kFj3n/nHHv2FuMiQquYKNt2NM7AD+VtgapXUE7dMca+nkSGhTSK0hpo
        WqUG9rfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gD-0001do-BU; Wed, 24 Jun 2020 15:51:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90390305CC3;
        Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB5F6236E775A; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154157.027929386@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 05/17] compiler.h: Make __ADDRESSABLE() symbol truly unique
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

The __ADDRESSABLE() macro uses the __LINE__ macro to create a temporary
symbol which has a unique name.  However, if the macro is used multiple
times from within another macro, the line number will always be the
same, resulting in duplicate symbols.

Make the temporary symbols truly unique by using __UNIQUE_ID instead of
__LINE__.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/compiler.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -299,7 +299,7 @@ unsigned long read_word_at_a_time(const
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(.discard.addressable) __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer


