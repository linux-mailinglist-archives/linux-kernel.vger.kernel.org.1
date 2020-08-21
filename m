Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4F24D0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgHUI4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 04:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgHUI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42068C061387
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Stz6oN4kWWeLz+WC/vRYlNC6yipTRTCyCMx/4rhSEsk=; b=vDc1QW3ozluS/DPYI/FTX/orp+
        dhQOrXwwwa3gDip0Q+4R4QIwz0uhLNEBT93BmTZYJm4sr86AemRbhbWviEBcaA27Zdoi4qmJtII67
        7EuPJaKkzKZLm7TFoiLOk5abbqUuwwutfsKu1OwXuDMDwwmr5Sh93Whsx3uxFaThsQpS8ORn9tTSJ
        /jursKd4g/OACAevCRVM5I7xR6MdYVmPEXo5guNuvp18zsYT+QVTBPR5VMR5uGaslzU2OICr6KQQQ
        QAWZ/23DarVhG8SoNV/ACB4AoSS/1n7GBuUwbG0ZK/KK/QvQFDBNOOt7NKo7nRrQxfjFnc/2JF7j9
        ErJ0eH/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92pJ-0007S1-5G; Fri, 21 Aug 2020 08:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80185305B23;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBC882B649919; Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Message-ID: <20200821085348.487040689@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 06/11] x86/entry: Remove unused THUNKs
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused remnants

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
---
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,11 +29,6 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace


