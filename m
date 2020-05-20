Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018501DBFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgETUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgETUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:15:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52256C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kbaCNgOg/Mx9LKI9XxUZj7vNDJVgTURsBoqYoX0aVXg=; b=at1LbFE7fNJwSF6G9wxT1VeQhv
        WEEty4zULcWfguKs2sjHm8/BwqriOsnQMi0b7ivIj550rkBUt5uwD0hJ2Bw7NxAzJaiXjawRQJdGY
        bptjyrxIkAvXjz87wkvCWXJEro7Q3IRQaS4AzMnT9nZgoC7XZcxdc9jyj+4CTVfVds4CYaJG8hp4b
        u6wdEikqMOAD7ApIuIlo3cN9OGa+Vl2XTWE4sHIRcHvoxAIOgWl+troiH4geeXDf3GfuGN/+NLokF
        yEC1epyXK37ELBLiTUnrpFD3ZP6w+Vn6cKi6vYWvtq4qlDchxrf6jODZndmtyCvAvExcskyFqVJb5
        0GTjwR1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbV7B-0002Xz-HS; Wed, 20 May 2020 20:14:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E7B3303DA0;
        Wed, 20 May 2020 22:14:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2B54212820EE; Wed, 20 May 2020 22:14:53 +0200 (CEST)
Date:   Wed, 20 May 2020 22:14:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 01/37] tracing/hwlat: Use ktime_get_mono_fast_ns()
Message-ID: <20200520201453.GE325280@hirez.programming.kicks-ass.net>
References: <20200515234547.710474468@linutronix.de>
 <20200515235124.466962628@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515235124.466962628@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 01:45:48AM +0200, Thomas Gleixner wrote:
> Timestamping in the hardware latency detector uses sched_clock() underneath
> and depends on CONFIG_GENERIC_SCHED_CLOCK=n because sched clocks from that
> subsystem are not NMI safe.

AFAICT that's not actually true, see commit:

  1809bfa44e10 ("timers, sched/clock: Avoid deadlock during read from NMI")

that said, no objection to switching to ktime, people that run HPET
clocks deserve all the pain and suffering available with those setups.
