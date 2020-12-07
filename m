Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833722D148B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgLGPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:22:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C2C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:21:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607354481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRjXm06cPumhVJYsv+ceziOtPQIuzZhajfkO5gEjflI=;
        b=NxCTaXbLuPeNw1xhPpDrqaKNSrEWTGqSps2cXZvxKaIXSHJgPH3y0f1Tla22AyKJSInDj8
        fSYLLUFELerF0x/QYSNx0C0y02/f7Y4qWeMHdRA1ePCbb1x6gnCJRlgU7DiJt0EGIa+hZY
        PlpKENrlGGwEpFwHm1yaeiR5jwlA7azOD7ibOoB+5flm44JoYUY2eLvvyo/rgeV0SaUEcG
        oDQkTFgXuRpv5zaMF73+OMV7tGI1+NnhSvy4dkgg1SRg6qP7gyrJ2qWqy/jqaRVPt4II5v
        HGA6UemfB+C36l5RWnrI8I1jIwkVV/Qpa7XzuO4q/pC26KRjvSQpRYBgxGVsGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607354481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRjXm06cPumhVJYsv+ceziOtPQIuzZhajfkO5gEjflI=;
        b=QwxTzMq37c+XBolEGnscs+QcWtHWSN6bRK7JS90bsBnomahEx4CnQAZ094H6oUb+BrayvF
        cA3uhZSUpPs0+ECA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 7/9] softirq: Replace barrier() with cpu_relax() in tasklet_unlock_wait()
In-Reply-To: <20201207113958.GJ3040@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de> <20201204170805.430113367@linutronix.de> <20201207113958.GJ3040@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 16:21:21 +0100
Message-ID: <87wnxt63ri.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 12:39, Peter Zijlstra wrote:
> On Fri, Dec 04, 2020 at 06:01:58PM +0100, Thomas Gleixner wrote:
>>  static inline void tasklet_unlock_wait(struct tasklet_struct *t)
>>  {
>> -	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
>> +	while (test_bit(TASKLET_STATE_RUN, &(t)->state))
>> +		cpu_relax();
>>  }
>
> Wouldn't it be nicer to stick a completion in tasklet_struct ? Or at the
> very least use wait_var_event() or something?

It would be nicer. Just need to audit all possible callers. That would
lose the implicit boosting of the preempted softirq thread, but these
wait pathes should not be in any way relevant for user task
latencies. Emphasis on should.

Lemme stare at the callers including the ones which have it wrapped into
some other inline just because.

Thanks,

        tglx
