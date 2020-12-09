Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544F82D423A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgLIMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:37:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgLIMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:37:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607517415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KE0CoQtTfxBKnfmuWsFA8hcEhKndzapNZ3Gj1knHNi8=;
        b=s/1rIaA1bu3/rAUt09P4xjsIyc7YraXkPYhwxK1QXN96nii/HfYJbA35k80QMO1r1KLDJf
        BLhUt3QazlTqooRdHAjOArzeEHoe+6YmKAPnXorqntaKdu80MKAsAMBVAB1NBmWnF7k1eD
        Qwy9fQCEuPQYTjXpNSspXTMEWn4O1ys4QhC7b4WUL4rXzz31iO47eXGCVMlBROWGmwSYee
        l/keL7NgbCotcz/lAfhpEalSRebzYnNw8XGPbBN8OxRO6rPVpZQWfIdR4RsG8tRMzNIBVB
        ODj3Z7bK7JT5Y//Cgpns1RXJa8JPZcg1f2HZBAiyEpgZ7UlSM859gwi3F/tYzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607517415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KE0CoQtTfxBKnfmuWsFA8hcEhKndzapNZ3Gj1knHNi8=;
        b=s4B2cf2fcAfjRDqgKwUFvx0eCV4VpyD9ufDyRIeqVPBLQj8d2ZPuRB4aPwzCbjQwdv8+8F
        nNgsiD75qDzdPmBw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT aware
In-Reply-To: <20201209101102.GJ2414@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de> <20201204170805.114951971@linutronix.de> <20201209101102.GJ2414@hirez.programming.kicks-ass.net>
Date:   Wed, 09 Dec 2020 13:36:54 +0100
Message-ID: <878sa717h5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09 2020 at 11:11, Peter Zijlstra wrote:
> On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> +	/* First entry of a task into a BH disabled section? */
>> +	if (!current->softirq_disable_cnt) {
>> +		if (preemptible()) {
>> +			local_lock(&softirq_ctrl.lock);
>
> AFAICT this significantly changes the locking rules.
>
> Where previously we could do:
>
> 	spin_lock(&ponies)
> 	spin_lock_bh(&foo);
>
> vs
>
> 	spin_lock_bh(&bar);
> 	spin_lock(&ponies)
>
> provided the rest of the code observed: bar -> ponies -> foo
> and never takes ponies from in-softirq.
>
> This is now a genuine deadlock on RT.

I know, but making this work is trying to square the circle.

Any approach we tried before going this way had worse problems than
this particular limitation.

> Also see:
>
>   https://lkml.kernel.org/r/X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net

I'm aware of that and it's fortunately not that many instances of this.

Thanks,

        tglx
