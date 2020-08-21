Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBA24D0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHUI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgHUI4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE424C061388
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nO3hfxUMWOif6mGKcbiJTNQNHWgwXTgjZLQJGqmnWhw=; b=DPr3tO+0p2sAaTRRAtLHqCDFfO
        gneWpT4Gz6sO4Ec1GTUrqJY/GCBtp+aTiwWSC6lPniBWhmozxzVMuFIkp3tBUzQVsfulR9XUANCQK
        m1Oz3QzQSe1m5Xb2ZTMubKW9M+LLGzAanTzI9DADsYP3nwWFRApwebYsJ54acYpWndpKEGdfgU1Gs
        l5ksbM+XdxPRPh6Yo7CaFzzLKfZVJG06FTk/mVJGjpTOKRXg0r3YiBdgnIU0oozYzmP9DOMCLf+Fe
        80ASaPafKa7fpevvwQdZsXAln8b7+ALiEVjXJFJ8e4c/AbrT6wvnCbu5RT955xC+7Xw9zur6b/84R
        BmbPl3dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92pJ-0007Rf-4Z; Fri, 21 Aug 2020 08:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0609303271;
        Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB4C02B649914; Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Message-ID: <20200821085348.251340558@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 02/11] cpuidle: Fixup IRQ state
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the pattern elsewhere in this file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
---
 drivers/cpuidle/cpuidle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -153,7 +153,8 @@ static void enter_s2idle_proper(struct c
 	 */
 	stop_critical_timings();
 	drv->states[index].enter_s2idle(dev, drv, index);
-	WARN_ON(!irqs_disabled());
+	if (WARN_ON_ONCE(!irqs_disabled()))
+		local_irq_disable();
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
 	 * first CPU executing it calls functions containing RCU read-side


