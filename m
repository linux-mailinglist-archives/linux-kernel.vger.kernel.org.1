Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE32AD76C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgKJNYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJNYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:24:18 -0500
Received: from localhost (unknown [176.177.120.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93AA20797;
        Tue, 10 Nov 2020 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605014658;
        bh=gcfDuMLqnk+kPa9XW0OypoQjSOdA8fkR3oPqBpY7KeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lp83RlRrI9hmTOfR3UqbmcYxPs0ggPwfSFt5K4naQJLWhHjSbZT2hBxMN5jZ1y7vU
         CKrB4GDkjTw3Aan7apKyBfTJhhN96F4KOvgCvYbcCfymnaJwIKMvkAwvj2coYu0+2D
         F++WyxLPP/ecnswO5m+FCJunmImz3W2wTotnl+/E=
Date:   Tue, 10 Nov 2020 14:24:15 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Message-ID: <20201110132415.GA48886@lothringen>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-2-frederic@kernel.org>
 <20201110095515.GA2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110095515.GA2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:55:15AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 01:56:03AM +0100, Frederic Weisbecker wrote:
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 2400ad62f330..37592f576a10 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1125,6 +1125,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
> >  		int3_emulate_jmp(regs, (long)ip + tp->rel32);
> >  		break;
> >  
> > +	case XOR5RAX_INSN_OPCODE:
> > +		int3_emulate_xor5rax(regs);
> > +		break;
> > +
> >  	default:
> >  		BUG();
> >  	}
> > @@ -1291,6 +1295,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
> >  	switch (tp->opcode) {
> >  	case INT3_INSN_OPCODE:
> >  	case RET_INSN_OPCODE:
> > +	case XOR5RAX_INSN_OPCODE:
> >  		break;
> >  
> >  	case CALL_INSN_OPCODE:
> 
> Why did you add full emulation of this? The patch I send to you used the
> text_poke_bp(.emulate) argument to have it emulate an actual call to the
> out-of-line version of that function.
> 
> That should work fine and is a lot less code.

Perhaps I pushed the cleanup a bit too far indeed. I wanted to standardize
it just like any flavour of text patching. And also I thought that emulate
thing was on the way to be deprecated.

Anyway, I'll restore the old version.

Thanks.
