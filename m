Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039F02B51C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgKPUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgKPUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:00:05 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05513208C7;
        Mon, 16 Nov 2020 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605556805;
        bh=yrjw14o5asHTeWaBifST22KQ0VTjN4jtabHNixcSZg8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xvJayIxUQqCdvK00oNaDZUoCwldmZpK9t+nF/q8zXZ/vJoo6GtsSDVb0rKmS0ZKWo
         1ppPCmwd6pMm2rCW3fXARbNWyc3N5dDRaspywlG/dMdRXU+fJsPNiSFaIUVb6AFx95
         +qRtSTNX8aKdC9mLtG8zJ4kjL6XsB9MVqsWqT+gY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 96C973522684; Mon, 16 Nov 2020 12:00:04 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:00:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, eupm90@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu: Allow rcu_irq_enter_check_tick() from NMI
Message-ID: <20201116200004.GD1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
 <87ima8luix.fsf@nanos.tec.linutronix.de>
 <20201114010526.GK3249@paulmck-ThinkPad-P72>
 <20201116121012.GC3121378@hirez.programming.kicks-ass.net>
 <87a6vhz034.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6vhz034.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 06:24:31PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 16 2020 at 13:10, Peter Zijlstra wrote:
> 
> > Any which way around; here's a proper patch...
> >
> > ---
> >
> > Subject: rcu: Allow rcu_irq_enter_check_tick() from NMI
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Mon Nov 16 12:54:56 CET 2020
> >
> > Eugenio managed to tickle #PF from NMI context which resulted in
> > hitting a WARN in RCU through irqentry_enter() ->
> > __rcu_irq_enter_check_tick().
> >
> > However, this situation is perfectly sane and does not warrant an
> > WARN. The #PF will (necessarily) be atomic and not require messing
> > with the tick state, so early return is correct.
> >
> > Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
> > Reported-by: "Eugenio Pérez" <eupm90@gmail.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Andy Lutomirski <luto@kernel.org>
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Queued, thank you all!

							Thanx, Paul
