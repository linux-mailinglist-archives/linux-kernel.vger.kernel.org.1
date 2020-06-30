Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D982B20F374
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgF3LOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgF3LOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:14:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E02C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ipThrZuiPi2FnyWwe4ZHiuTtrytxyEAxUYdjGjPsi+4=; b=oELOMxZ6Xt01zk+jrRA0m8WYE0
        zl4jHU6xoTKX5L1hs8NPtGsw0n6VzVmN97YJQftmz8fknsRyMJDpws4W2kWuz8jzdNyzQBeHeOhZU
        YU/YyIhSmloPFXqHUsGHQ45AGS3vE4M/oGaA7EfkPLrQf09eLvIg3NIS5AeiZmLy2cksEo1UmLq5q
        vPY0Wby9p5oKd1ePgFHt0wwl7TjNvGzTQtbc2rGoRCwpokYGNkG8o1/EJC8Hr6KNNpJObj3RG9XoY
        zVft1H2FTxbkiWXWsZoA3sXFRW3J0LtscNFZMwkbGprPUz2B0lfdCf5YkJn7x0MKNLbw9tZ1bNw4d
        qGxP5/OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqEDe-0000dZ-Vn; Tue, 30 Jun 2020 11:14:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B63230066E;
        Tue, 30 Jun 2020 13:14:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 531352140512D; Tue, 30 Jun 2020 13:14:30 +0200 (CEST)
Date:   Tue, 30 Jun 2020 13:14:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/entry: Remove `regs' parameter from
 idtentry_exit_cond_resched()
Message-ID: <20200630111430.GN4800@hirez.programming.kicks-ass.net>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
 <20200630102209.1143072-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630102209.1143072-3-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:22:09PM +0200, Sebastian Andrzej Siewior wrote:
> The `regs' parameter is not used in idtentry_exit_cond_resched() and can
> be removed.
> 
> Remove the `regs' parameter.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/entry/common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 212382f61b8e4..652dce37643b4 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -610,7 +610,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
>  	return false;
>  }
>  
> -static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
> +static void idtentry_exit_cond_resched(bool may_sched)

This is a style question; so far all idtentry_*() functions have regs
passed. In the lockdep-vs-nmi series I introduce
idtentry_{enter,exit}_nmi() both having an unused regs argument.

Not sure which way around I feel on this.
