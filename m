Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47261CE011
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgEKQH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 12:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbgEKQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:07:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BFD3206E6;
        Mon, 11 May 2020 16:07:54 +0000 (UTC)
Date:   Mon, 11 May 2020 12:07:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>, dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200511120753.74d0a785@gandalf.local.home>
In-Reply-To: <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
        <20200312181702.8443-9-paulmck@kernel.org>
        <20200316194754.GA172196@google.com>
        <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
        <20200316203241.GB3199@paulmck-ThinkPad-P72>
        <20200316173219.1f8b7443@gandalf.local.home>
        <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
        <20200316180352.4816cb99@gandalf.local.home>
        <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 17:59:27 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> I think adding a small number of instructions to preempt_schedule_irq()
> is sufficient to create the needed protected region between the start
> of a function and the trampoline body.
> 
> preempt_schedule_irq() {
> +  if (unlikely(is_trampoline_page(page_of(interrupted_ip)))) {
> +      return; // don't do preempt schedule
> +
> +  }
>   preempt_schedule_irq() original body
> }

First, this would never be accepted due to the overhead it would cause,
next, the interrupt instruction pointer could be the call to the
trampoline itself. It would be hard to guarantee that we are not on the way
to the trampoline in question.

-- Steve
