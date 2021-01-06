Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB112EBFD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAFOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAFOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:49:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7DC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZL8AQj205ZGp6BaiD9kMybv1sAMwMlJhMDyqSk2jlWc=; b=hnZogLRkM+oWyIw5sIIN9YRe+A
        y1zpR5vYaUD5BW44pGM0QU8lTyUjTP0O2DDZX5n+deDxlnKh7HVZm4G76KBGIm1hprHKbEWgX90Ro
        ORyMUVUz78zqTwkzv1/v61DwTaP7PwikQd6ufyrHFevWdtJ6aI/m4xzUbWVY3K9XtRzANgWk2weNT
        BE/Q5UBf4GKQE26Hl7H7S8mXrenoUZ5EExIZh9PUcl9hM3Sj4oCpsCd/FU2nslmfBz9UxcPcCDowo
        X341SU8ODztT16mWZl5b7VY4hgb2w/yf3SVF4LC0XuVsBk8SRNufgQmJGaBRdgCOdh7p6iY1WzB+Y
        Rcu+EWWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxA3H-002QUY-On; Wed, 06 Jan 2021 14:45:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB64D307890;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A99842029C723; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106144017.652218215@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [PATCH 4/6] locking/lockdep: Avoid noinstr warning for DEBUG_LOCKDEP
References: <20210106143619.479313782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  vmlinux.o: warning: objtool: lock_is_held_type()+0x60: call to check_flags.part.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5271,12 +5271,15 @@ static void __lock_unpin_lock(struct loc
 /*
  * Check whether we follow the irq-flags state precisely:
  */
-static void check_flags(unsigned long flags)
+static noinstr void check_flags(unsigned long flags)
 {
 #if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
 	if (!debug_locks)
 		return;
 
+	/* Get the warning out..  */
+	instrumentation_begin();
+
 	if (irqs_disabled_flags(flags)) {
 		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())) {
 			printk("possible reason: unannotated irqs-off.\n");
@@ -5304,6 +5307,8 @@ static void check_flags(unsigned long fl
 
 	if (!debug_locks)
 		print_irqtrace_events(current);
+
+	instrumentation_end();
 #endif
 }
 


