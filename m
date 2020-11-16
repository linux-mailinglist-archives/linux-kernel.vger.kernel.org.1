Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DFE2B4B97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgKPQqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgKPQqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:46:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA7D20776;
        Mon, 16 Nov 2020 16:46:30 +0000 (UTC)
Date:   Mon, 16 Nov 2020 11:46:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>, eupm90@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: #PF from NMI
Message-ID: <20201116114629.1e1894be@gandalf.local.home>
In-Reply-To: <87ima8luix.fsf@nanos.tec.linutronix.de>
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
        <87ima8luix.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 00:13:58 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> nmi:
>   ...
>   trace_hardirqs_off_finish() {
>     if (!this_cpu_read(tracing_irq_cpu)) {
>            this_cpu_write(tracing_irq_cpu, 1);
>            ...
>   }
>   ...
>   perf()
> 
> #PF
>   save_cr2()
>   
>   irqentry_enter()
>      trace_hardirqs_off_finish()
>         if (!this_cpu_read(tracing_irq_cpu)) {
> 
> So yes, it is recursion protected unless I'm missing something.

That should work.

-- Steve

