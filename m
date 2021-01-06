Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B352EBFD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbhAFOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbhAFOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:49:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A645C061358
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=USeyIOBG4gtWe+I6lOFfTmZTGrldZP1FUBRZhAnoMYw=; b=mkB5u5GfqPQzuX0ZfU1Q0t9lfK
        rJzR80lyaDnoOEUr6cCJATrjG024GyielP1i9TT8nNO0JU5Xb+e3ArWVEQCA+MJ3WydNCDEI44XK4
        FEPUWwmNUaelpEM3/bfIjj4aQeHo4nqr6Y8sS0RS/XOebDywMG2Kj4hfLq75PPSUqrQBm2dlKUB5O
        sDfpkN8g+lAp3LrofDjNPILG4Ft1MCgocle5mWBC/uObqV/vOMcb4gs0wEjlyVmsiNIC/UgCYD1XA
        J8eSJQ9YlAex6sMKLluQvUhx+oNBBYeCl7/asAxCCYzhGYLesmTHAHXxJdGP6J6QJK27Lgs9tpu8T
        CTBegK2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxA3H-002QUX-Ow; Wed, 06 Jan 2021 14:45:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B75E930785A;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6C602029C72D; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106144017.592595176@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [PATCH 3/6] locking/lockdep: Cure noinstr fail
References: <20210106143619.479313782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the compiler doesn't feel like inlining, it causes a noinstr
fail:

  vmlinux.o: warning: objtool: lock_is_held_type()+0xb: call to lockdep_enabled() leaves .noinstr.text section

Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -79,7 +79,7 @@ module_param(lock_stat, int, 0644);
 DEFINE_PER_CPU(unsigned int, lockdep_recursion);
 EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
 
-static inline bool lockdep_enabled(void)
+static __always_inline bool lockdep_enabled(void)
 {
 	if (!debug_locks)
 		return false;


