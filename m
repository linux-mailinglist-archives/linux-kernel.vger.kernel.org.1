Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B311D42FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 03:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEOBf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 21:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgEOBf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:35:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758AC2065F;
        Fri, 15 May 2020 01:35:24 +0000 (UTC)
Date:   Thu, 14 May 2020 21:35:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V5 03/38] nmi, tracing: Provide nmi_enter/exit_notrace()
Message-ID: <20200514213522.59f8de4d@oasis.local.home>
In-Reply-To: <20200514213230.02c13bd2@oasis.local.home>
References: <20200512210059.056244513@linutronix.de>
        <20200512213809.678944067@linutronix.de>
        <20200514213230.02c13bd2@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 21:32:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> It's accounting only. Now it does use a per-cpu variable (which I see
> in other patches can be an issue) and calls time_get().

time_get() being defined as trace_clock_local(). And this in only
called if CONFIG_GENERIC_SCHED_CLOCK is not true, as that isn't NMI
safe.

-- Steve
