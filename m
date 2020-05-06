Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619B21C798D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgEFSho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgEFShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:37:43 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0941C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ecKITwvkyDkNKn9u2BusQHHoxShGXH+9vqmdM5Woe18=; b=Go/JeZr+oeZAXggliMUwX0LMis
        Cyz+HB3eo+65ZwW8Jhf54OTUg4Ch2Yg4UTwg9wz0onAcXgZVTAK1/L1nep+htuOiwGVjWuLLXtdfL
        9XOFNAg7JeBXlD/aUsIJOf6BixJA/XBo3dDcK75mvPVnVEk8hVscsSnbUJeFWGpaXN21fGFG+v65U
        aFeT1fci/AzgVzOOAK+Z9Bo42v23wIir4lvEnB2rPDf+/dherhnXvO6fwmIztyyS04I+MEYXsPsRz
        DjW4ZF14pApQDXdFTCU4CApHYybp2cNvEzG4HhdpdLLROIwpzkl+WewV1j4mtFCXYXtwQBt38GcBa
        cl/WLetw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWOuo-0001dP-0k; Wed, 06 May 2020 18:37:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03598301DFD;
        Wed,  6 May 2020 20:37:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFDEC2B87C19A; Wed,  6 May 2020 20:37:03 +0200 (CEST)
Date:   Wed, 6 May 2020 20:37:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
Message-ID: <20200506183703.GJ5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.361859938@linutronix.de>
 <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
 <20200506153300.GB5281@hirez.programming.kicks-ass.net>
 <20200506182856.GD2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506182856.GD2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:28:56AM -0700, Paul E. McKenney wrote:
> I still see warnings of the form "leave instruction with modified stack
> frame" from older complilers and of the form "undefined stack state"
> from newer compilers.  I am running stock objtool versions, so I am
> guessing that this is at least one reason for these warnings.

Part 5, patch 2, might be responsible. I still have to look at curing
that.
