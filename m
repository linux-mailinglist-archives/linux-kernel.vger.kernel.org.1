Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E221C257
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 07:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGKFKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 01:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgGKFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 01:10:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE07C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 22:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qmi48nP1RLoX90PR888sc/dCvFKTBy0XzGPK7WGd41E=; b=iRPZKqA0Oov5wn+4BFlI86Bfmi
        lW6z5knTwgngSU83AaLdNJEp7FnEKIpvO2ZmrLQsV6Pr0HZzL0itFGffkJGUZeSMSwDRwLjoyZBY9
        3P9oZKLR5rffNTZ4JL+EKuis+pfBuN1t0dV7TDksUBuAuupx/JyFz/IqaiyoH5EA+ljrMs0GbZffU
        I8fQja+hc1uHU7nGrlbMJ0bDXn5hBLbX8ijC7Xt9qrPyJWonzmPi0WRD185OJNXrbFj/0mdV8DtWM
        vr+V/xVv7cAVA+DqRshvH3CduXUDJOG3rtr8Wc3/4Ide/R3hUEbZkCDDfIQsOAZw/ut1sOF1jjuUT
        7om+elug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ju7lq-0005sR-D8; Sat, 11 Jul 2020 05:09:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFD97304E03;
        Sat, 11 Jul 2020 07:09:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D21792B85DD2B; Sat, 11 Jul 2020 07:09:53 +0200 (CEST)
Date:   Sat, 11 Jul 2020 07:09:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 13/17] static_call: Add static_call_cond()
Message-ID: <20200711050953.GZ597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.918547865@infradead.org>
 <20200710190825.02c75c04@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710190825.02c75c04@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:08:25PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:44 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +static void __static_call_transform(void *insn, enum insn_type type, void *func)
> >  {
> > -	const void *code = text_gen_insn(opcode, insn, func);
> > +	int size = CALL_INSN_SIZE;
> > +	const void *code;
> >  
> > -	if (WARN_ONCE(*(u8 *)insn != opcode,
> > -		      "unexpected static call insn opcode 0x%x at %pS\n",
> > -		      opcode, insn))
> 
> I would still feel better if we did some sort of sanity check before
> just writing to the text. Confirm this is a jmp, call, ret or nop?

I'll see if I can come up with something, but I'm not sure we keep
enough state to be able to reconstruct what should be there.
