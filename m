Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483B3293A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393199AbgJTLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbgJTLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:30:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB9C061755;
        Tue, 20 Oct 2020 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PMYAhIIQV4IvlK4zWSGt1nHdCOf2mO+8d7HFw8vOhA8=; b=HYMCqrOpOk0al4EFIZFy2yCjOl
        SjCWYkRZv/5xlkDAzcDyCtMRDVZJHm9OFfN8SuCSBqHlchXxc2BzgEaXQ/9nLMTEX307KVin4GFAG
        sAQKKW2+wXLrq4UjI8pbFkvoEfqmtB2jbbR6MmdJfbgwpim+UFi4Os7xQ5lPGf3W9u9ai+gs/ZnKC
        jvyRis4zNvn2/ROIBaAn7h8wx2rK847+RZEfhACkhp9NZ6nJVpNVuvWuSak+rd2zn8027zDQ9+DU4
        0xsaNS0h1xVQNRM0AasUXxINGxwiaVZ3BTGdnbIf2nI4VS+X1/KCj4uVYV526tEdXU5IeZHMD1CIT
        AlefCE3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUpqH-0001fR-SQ; Tue, 20 Oct 2020 11:30:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E7AD3011FE;
        Tue, 20 Oct 2020 13:30:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC872235C0B05; Tue, 20 Oct 2020 13:30:09 +0200 (CEST)
Date:   Tue, 20 Oct 2020 13:30:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christian Eggers <ceggers@arri.de>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sched: system doesn't boot since  "sched: Add new
 migrate_disable() implementation"
Message-ID: <20201020113009.GR2628@hirez.programming.kicks-ass.net>
References: <1654655.1jrfHnk7pZ@n95hx1g2>
 <20201019150935.koqbk57dmahhomdc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201019150935.koqbk57dmahhomdc@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 05:09:35PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-19 12:21:06 [+0200], Christian Eggers wrote:
> > I have problems with the latest 5.9-rt releases on i.MX6ULL (!CONFIG_SMP):
> > 
> …
> > Any hints?
> 
> Thank you for the report. The reason is the migrate_disable()
> implementation for !SMP.

This should fix things I suppose. I'll fold it in.

---
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -378,7 +378,12 @@ static inline void preempt_notifier_init
 extern void migrate_disable(void);
 extern void migrate_enable(void);
 
-#else /* !(CONFIG_SMP && CONFIG_PREEMPT_RT) */
+#elif defined(CONFIG_PREEMPT_RT)
+
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void { }
+
+#else /* !CONFIG_PREEMPT_RT */
 
 /**
  * migrate_disable - Prevent migration of the current task
