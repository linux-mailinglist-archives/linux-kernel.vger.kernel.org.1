Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861E02AD3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbgKJKjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:39:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB2CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fktQnF2Ye8FTc+pSwtVrS46H0tV0qfWWmnoMgSrzU6U=; b=n6+gPId/vuLBb46e8ul2kC9M/D
        12isZBomW4xUtsRC6+VGFKLK0XVkiCMb8YlH/vnVEjf9TO3+08BTbqe6Vn5rW5CbG7+GTyA4gHYC3
        CFM8VlsUi3Y//JvuYK41CVnbe/I7z22b9MdI0ZTSu4qShZWVFUgoa88F09K/5Q7PsBZpp+jVgGMr8
        +utkFqrcN6JTok16Jv1DBl1/4x3YAV1KgiBBVMZ9JfzLjuOdqkEgBUB/aRPSaw0iyM4PM5xTMCb6b
        wiMgRAiVlU392QJ34l6fmTfRTfAH30oxfuPXW50E71Yze0tV0NxkdBZVaV0NOhnAKsVU8eHjTnJ9u
        r+nLygAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcR3O-0005Tr-Rs; Tue, 10 Nov 2020 10:39:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B5E9300455;
        Tue, 10 Nov 2020 11:39:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76E4F2C09A81C; Tue, 10 Nov 2020 11:39:09 +0100 (CET)
Date:   Tue, 10 Nov 2020 11:39:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 4/7] preempt/dynamic: Provide cond_resched() and
 might_resched() static calls
Message-ID: <20201110103909.GD2594@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110005609.40989-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:56:06AM +0100, Frederic Weisbecker wrote:

> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_CALL(cond_resched, __static_call_return0);
> +EXPORT_STATIC_CALL(cond_resched);
> +
> +DEFINE_STATIC_CALL(might_resched, __static_call_return0);
> +EXPORT_STATIC_CALL(might_resched);
>  #endif

I suppose we want the below and change the above to use
EXPORT_STATIC_CALL_TRAMP().

---
Subject: static_call: EXPORT_STATIC_CALL_TRAMP()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Nov 10 11:37:48 CET 2020

For when we want to allow modules to call the static_call() but not
change it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/static_call.h |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -160,13 +160,19 @@ extern int static_call_text_reserved(voi
 
 #define static_call_cond(name)	(void)__static_call(name)
 
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+	EXPORT_STATIC_CALL_TRAMP(name)
+
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+	EXPORT_STATIC_CALL_TRAMP_GPL(name)
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
@@ -206,13 +212,19 @@ static inline int static_call_text_reser
 	return 0;
 }
 
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+	EXPORT_STATIC_CALL_TRAMP(name)
+
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+	EXPORT_STATIC_CALL_TRAMP_GPL(name)
 
 #else /* Generic implementation */
 
@@ -269,6 +281,9 @@ static inline int static_call_text_reser
 	return 0;
 }
 
+#define EXPORT_STATIC_CALL_TRAMP(name)
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)
+
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
 
