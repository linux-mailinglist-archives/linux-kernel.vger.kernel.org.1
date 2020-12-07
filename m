Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464572D1494
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgLGPWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:22:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:22:49 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607354527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Sw68YI5yuJQcttKYWiDCqBwx4hmz9OpW4+WPZ4DHas=;
        b=O/OA6Ta44pmrYIsEIkgP2jpf+JfYZ/+OPFYc0WVfmPmUIMAMw4fcXrjueTv4y78quk/ZKv
        iIFu5riARS89Cpby1RB5kBtsppAe5Oyn8RqYDKadREfZPrJ/EWW2weGEC4sQrL44CYpRRC
        uxsQKJ7iCk29uJ2aOFJ/S3xsvTGNyw+hs5Te8P9OxC5twgZJ7fkqU6dTkQewwZs996ARou
        Z7cCt8jyugq7OtcLPS+dG/58YT3WWAn/qsxpEw0yy3IOemyspv/0IxvSK5/u8/J2yCd7ck
        O4omPbh4mdvI3ylq0+sYqNXZGhHavv58LIeb4IsG3Qemwqpo2xXrdspkB5lmgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607354527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Sw68YI5yuJQcttKYWiDCqBwx4hmz9OpW4+WPZ4DHas=;
        b=O/zSN0n01/FbQ2n6S0yFam8SFAr0IPGk/Vgiwcg8s4T6YtJzx8qoGhpTvmhYpl3OBiq5GR
        UJN+RnnD3LQC4oCQ==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
In-Reply-To: <20201207140040.yrxsu4v4xz43szkk@linutronix.de>
References: <20201204170151.960336698@linutronix.de> <20201204170805.627618080@linutronix.de> <20201207114743.GK3040@hirez.programming.kicks-ass.net> <20201207140040.yrxsu4v4xz43szkk@linutronix.de>
Date:   Mon, 07 Dec 2020 16:22:07 +0100
Message-ID: <87tusx63q8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 15:00, Sebastian Andrzej Siewior wrote:
> On 2020-12-07 12:47:43 [+0100], Peter Zijlstra wrote:
>> On Fri, Dec 04, 2020 at 06:02:00PM +0100, Thomas Gleixner wrote:
>> > @@ -825,7 +848,20 @@ void tasklet_kill(struct tasklet_struct
>> >  
>> >  	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>> >  		do {
>> > -			yield();
>> >  		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
>> >  	}
>> >  	tasklet_unlock_wait(t);
>> 
>> 
>> Egads... should we not start by doing something like this?
>
> So we keep the RT part as-is and replace the non-RT bits with this?

No. It would work for both.
