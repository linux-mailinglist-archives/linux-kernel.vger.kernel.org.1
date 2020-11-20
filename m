Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15E2BAA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKTMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgKTMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:52:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF55C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=w8tWVD7LdEH5Iapb8dd0CG6GtxCHUaaVQtuBmEoXo/k=; b=sDWpWMaMlYX96L2HJWxU81bEsx
        WGoBBfaObZ8OxW4Np7wTFfmTIB2pLzTU3BkkUo2tSKv4Berit7C+xkhckULK8mWDCINX2XXw27+0m
        /BJdP8uhAK21HLEbLL5uWy8fb89ZrTukXtZO9XX+LpRRy/Vmg+EH/ODNZBf7xLYPvT+yYbepyseq+
        tE1rrgnLpME9eTbIl9+qPswQnW5SJstbtef0BVIE72nbf8cnnghE7v26y6qLTf+5TEKl4XSDQvQAf
        UnjdwAiBCceSwOgeHlT6anM2K6XIiPWhLN+S/PfmNJYgpqJPa1egLGbZVva2sNUWIs41KSn1IxQcP
        tXf6UYew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg5tM-0000Qq-UJ; Fri, 20 Nov 2020 12:51:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C580304D28;
        Fri, 20 Nov 2020 13:51:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4629F20244762; Fri, 20 Nov 2020 13:51:54 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:51:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        Jakub Jelinek <jakub@redhat.com>, rdunlap@infradead.org
Subject: [PATCH] ilog2: Improve ilog2 for constant arguments
Message-ID: <20201120125154.GB3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From:   Jakub Jelinek <jakub@redhat.com>

As discussed in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97445
the const_ilog2 macro generates a lot of code which interferes badly
with GCC inlining heuristics, until it can be proven that the ilog2
argument can or can't be simplified into a constant.

It can be expressed using __builtin_clzll builtin which is supported
by GCC 3.4 and later and when used only in the __builtin_constant_p guarded
code it ought to always fold back to a constant.
Other compilers support the same builtin for many years too.

Other option would be to change the const_ilog2 macro, though as the
description says it is meant to be used also in C constant expressions,
and while GCC will fold it to constant with constant argument even in
those, perhaps it is better to avoid using extensions in that case.

Signed-off-by: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201021132718.GB2176@tucnak
---
 include/linux/log2.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -156,7 +156,8 @@ unsigned long __rounddown_pow_of_two(uns
 #define ilog2(n) \
 ( \
 	__builtin_constant_p(n) ?	\
-	const_ilog2(n) :		\
+	((n) < 2 ? 0 :			\
+	 63 - __builtin_clzll (n)) :	\
 	(sizeof(n) <= 4) ?		\
 	__ilog2_u32(n) :		\
 	__ilog2_u64(n)			\
