Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E122055C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbgFWPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbgFWPZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:25:32 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D0C061573;
        Tue, 23 Jun 2020 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CdyXQj2K/WhL99i44E17m8NIjPfggDEZJpNq1YwlkZk=; b=Q2asf/D+1IaMFnf1i/OVF98de3
        7rs3gVfXshkpsFSSEaP3Y7T3/jTzoRPpqVcpPUtnk9TLPRm/yqsLW5rzqU45RZvshYlmMrH648Bp+
        +VOJgyFc0NC5Vs3bN8mgZAsW1mnElkGwPu5PAeUQupo9bWrU7jFZFfQc7FPoQxcaxz//lpCJDxhJD
        ZuHJZtkrYUFb3n/y9sZEBKLUqfwZkaGs+bglrCumueb5ZG54b/NxCLJJzXQmO9LxeKerFKX+t6AXz
        6X8YpY8hQffzfIE7GoVgFOKPODFGi4aJCr3+VXGUB9CZeB/MY6yUCEz72sg0jKQIZ694RVvWzj7SD
        Plpff4LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnkn7-0003Pr-8v; Tue, 23 Jun 2020 15:24:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 180DE303DA0;
        Tue, 23 Jun 2020 17:24:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F17AC234EBA53; Tue, 23 Jun 2020 17:24:50 +0200 (CEST)
Date:   Tue, 23 Jun 2020 17:24:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623152450.GM4817@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:00:31PM +0200, Ahmed S. Darwish wrote:
> On Tue, Jun 23, 2020 at 10:36:52AM +0200, Peter Zijlstra wrote:
> ...
> > -#define lockdep_assert_irqs_disabled()	do {				\
> > -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> > -			  current->hardirqs_enabled,			\
> > -			  "IRQs not disabled as expected\n");		\
> > -	} while (0)
> > +#define lockdep_assert_irqs_enabled()					\
> > +do {									\
> > +	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
> > +} while (0)
> >
> 
> Can we add a small comment on top of lockdep_off(), stating that lockdep
> IRQ tracking will still be kept after a lockdep_off call?

That would only legitimize lockdep_off(). The only comment I want to put
on that is: "if you use this, you're doing it wrong'.
