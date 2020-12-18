Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375F2DE6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgLRPqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgLRPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:46:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810EDC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3fY7rhu2byKIO7aNp+C95hSj1ur1oOgkG2xd3B6qarA=; b=tmi60KirVLb5y5nDcudkoAhfcW
        Mzm1qJsWe+9h7+11TU8ik31EWpT1hW0/asEZaqAYBWt90gLF0YW9kjmla8Lm0NJAQOBIYo9o6FJgr
        //n9Z666tOPakask96dEyQTAKH0Vjk4i2/wju3Rse+VFFnG7lIYlzXM32BKlXNQhpS3TgYNmVuDjb
        nCzUQuyZck9SlzySEJ91TcAhtBQcBeJSw603E3asu0hl2XB8jE7KAOsdJOuq3i0XqNXIPacjxGtNH
        iqDnQ+bfSG/bvhbrW/WnkwMZtccu4iTabui7nzeoz4JsJKj4ChtfuR/ozVrZwBRfm9HoukiAxaqyL
        YTOsLYxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqHwW-0002Bq-EP; Fri, 18 Dec 2020 15:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D28BC30018A;
        Fri, 18 Dec 2020 16:45:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AB0220122356; Fri, 18 Dec 2020 16:45:19 +0100 (CET)
Date:   Fri, 18 Dec 2020 16:45:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: __local_bh_enable_ip() vs lockdep
Message-ID: <20201218154519.GW3092@hirez.programming.kicks-ass.net>
References: <20201215190152.GA22285@osiris>
 <20201215144724.40ab7612@gandalf.local.home>
 <20201216175259.GP3040@hirez.programming.kicks-ass.net>
 <20201218153356.GA7932@osiris>
 <20201218153716.GI3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218153716.GI3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 04:37:16PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 18, 2020 at 04:33:56PM +0100, Heiko Carstens wrote:
> 
> > Peter, will you make proper patch out of this?
> 
> Yes, let me go do that now, and stick it in the quilt series before I go
> off and don't think for 2 weeks.

As below, I'll try and push it out to tip/locking/urgent before I really
dissapear.

---

Subject: softirq: Avoid bad tracing / lockdep interaction
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Dec 18 16:39:14 CET 2020

Similar to commit:

  1a63dcd8765b ("softirq: Reorder trace_softirqs_on to prevent lockdep splat")

__local_bh_enable_ip() can also call into tracing with inconsistent
state. Unlike that commit we don't need to bother about the tracepoint
because 'cnt-1' never matches preempt_count() (by construction).

Reported-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
---
 kernel/softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -186,7 +186,7 @@ void __local_bh_enable_ip(unsigned long
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
 	 */
-	preempt_count_sub(cnt - 1);
+	__preempt_count_sub(cnt - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
 		/*
