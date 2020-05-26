Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8B1C763E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEFQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729405AbgEFQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:29:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC5C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fd3UEHcmje3N6DjodZqeqpJ6DqtVWXpYm4oCZPMA85o=; b=CW58LdmuHIwthGYqKK52pcoC6a
        c38F3/pcQrnOHfLd58+UKTjQofsztvYgvL2aEMI2OxbvLdOAYVhnA0ZlbRqTg4UW/xw5XDAlgCXlq
        hmrDc23NU4IIHv3kPU4SWUYw8aUW1311LIHjxTLSmRY15t9tA68GbNQJiwESLEGoAOVeJVa5akiP0
        nVxLCR04y20Wb5pawkBSGwmZ9WcCzTjjyxHOSEwPizwTQ3hR/+RZjPUZc1PwGrdlx/1F5xIe0VcyX
        oUCUhhNkgI5IkIBvHklo+Mz+6YqvMBeH9uKKi35ys+ysTqIir1SdGTZQBJ87oRLebGnzd+wquHz3B
        OTO35FLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWMug-0005pu-Jo; Wed, 06 May 2020 16:28:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6CA5300739;
        Wed,  6 May 2020 18:28:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90E2B29DAC127; Wed,  6 May 2020 18:28:48 +0200 (CEST)
Date:   Wed, 6 May 2020 18:28:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [patch V4 part 1 20/36] vmlinux.lds.h: Create section for
 protection against instrumentation
Message-ID: <20200506162848.GI5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.075416272@linutronix.de>
 <20200506160831.GB3329@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506160831.GB3329@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 09:08:31AM -0700, Sean Christopherson wrote:
> On Tue, May 05, 2020 at 03:16:22PM +0200, Thomas Gleixner wrote:
> > Provide also a set of markers: instr_begin()/end()
> > 
> > These are used to mark code inside a noinstr function which calls
> > into regular instrumentable text section as safe.
> 
> ...
> 
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -120,10 +120,27 @@ void ftrace_likely_update(struct ftrace_
> >  /* Annotate a C jump table to allow objtool to follow the code flow */
> >  #define __annotate_jump_table __section(.rodata..c_jump_table)
> >  
> > +/* Begin/end of an instrumentation safe region */
> > +#define instr_begin() ({						\
> > +	asm volatile("%c0:\n\t"						\
> > +		     ".pushsection .discard.instr_begin\n\t"		\
> > +		     ".long %c0b - .\n\t"				\
> > +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
> > +})
> > +
> > +#define instr_end() ({							\
> > +	asm volatile("%c0:\n\t"						\
> > +		     ".pushsection .discard.instr_end\n\t"		\
> > +		     ".long %c0b - .\n\t"				\
> > +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
> > +})
> 
> Any chance we could spell these out, i.e. instrumentation_begin/end()?  I
> can't help but read these as "instruction_begin/end".  At a glance, the
> long names shouldn't cause any wrap/indentation issues.

The kernel naming convention is insn for instruction, not instr. That
said, you're not the first to be confused by this.
