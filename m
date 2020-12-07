Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C32D17F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLGR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:56:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:56:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607363752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qx8NAjj5faN33tgthRrp3ZisWVrxrdfyIGRgfm2F/Bg=;
        b=xpvR+Bob89Uu5/0GcPLivKxa7r0Jx526tziQ4a6zflIXOaCI3WNEBH55cEpcxwr2Nbw7vX
        rJMvOmXduOwERRmTCuN08YA120FJ+C6ksnLR9szaI285BPkRlXx8beviQM95lCljThEpMM
        sB7V69xQpjddj0XuWei6cjBNlXHswISvzVUJ46vg3fxHlrxvUDCbWQtwc0cxWUV1YswtVd
        gf3L4epcK0CU2LS2J+N1C9X6rGAvgyLomIyjeXBcYwocEikolHaVjyH8isRN7ARGIY1j8T
        Hp16ZoR/FjOqHkLWrAJaB19+oqgtuD9PNcic9BK7wyvJNhXEpiJiMIGnGOXXRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607363752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qx8NAjj5faN33tgthRrp3ZisWVrxrdfyIGRgfm2F/Bg=;
        b=yI1DWurOsvOjz7kbnFk/ijKYf9T0aK2LP7dqFp0lnB4xevtD6ri5qzGjjug7jT/YQZchCp
        J4X4gGIaYP3RCNBA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
In-Reply-To: <20201207142727.GU3021@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de> <20201204170805.627618080@linutronix.de> <20201207114743.GK3040@hirez.programming.kicks-ass.net> <20201207140040.yrxsu4v4xz43szkk@linutronix.de> <20201207142727.GU3021@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 18:55:51 +0100
Message-ID: <87o8j54i1k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 15:27, Peter Zijlstra wrote:

> On Mon, Dec 07, 2020 at 03:00:40PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2020-12-07 12:47:43 [+0100], Peter Zijlstra wrote:
>> > On Fri, Dec 04, 2020 at 06:02:00PM +0100, Thomas Gleixner wrote:
>> > > @@ -825,7 +848,20 @@ void tasklet_kill(struct tasklet_struct
>> > >  
>> > >  	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>> > >  		do {
>> > > -			yield();
>> > >  		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
>> > >  	}
>> > >  	tasklet_unlock_wait(t);
>> > 
>> > 
>> > Egads... should we not start by doing something like this?
>> 
>> So we keep the RT part as-is and replace the non-RT bits with this?
>
> For RT you probably want to wrap the wait_var_event() in that
> local_bh_disable()/enable() pear.

Is that a new species local to the Netherlands? Never heard about
bh-pears before. Are they tasty?

> I just figured those unbounded spin/yield loops suck and we should get
> rid of em.

Ack.
