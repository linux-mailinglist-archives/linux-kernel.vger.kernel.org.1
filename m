Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856392CA781
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391978AbgLAPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:53:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391637AbgLAPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:53:44 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606837982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsxtRFt5Vt85N1IEVKaCtx3dKv4LW3u85sTuoh7AKyQ=;
        b=bEdlC1NsyNMA7+KodwXZ4378AJQ/BKfNcI/en5dRIOilrwS/dqeERRtuAiVONT56mpqVPl
        v50SrFw1OLiljsMyavCd4lxCb1Q7cD09RApLqN1bNNO+iwpaNfBmhpX4w6jarXGmLP0ppC
        InX/P/hQHKOThYZzCh4sOT4p4XAabQms5NsA9p/5LG+QPcy29/dQMgfOJGpbLwnKKAx6F8
        4GGnGmKq9Q4K3AmU5oyodp6euXuSwCI+Llb3J8LtzajBFnt5+cP3kceqe6YUC/lgeh2wDh
        yTer03aqT2SISl+NKTanTozZQLnfe5im8Urd31yN4YzRum3WBmBoAP5h0iSMQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606837982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsxtRFt5Vt85N1IEVKaCtx3dKv4LW3u85sTuoh7AKyQ=;
        b=kCyv9eOVsow31OjbJ2J0/IRCHKheMYvnNQAiQT1UhXQZ8hhU7MuKh41k5CL33lh4X+t5co
        8RrmzTc6CNqMLKAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq offset incrementation
In-Reply-To: <20201201150114.GZ2414@hirez.programming.kicks-ass.net>
References: <20201201001226.65107-1-frederic@kernel.org> <20201201001226.65107-5-frederic@kernel.org> <20201201092011.GS2414@hirez.programming.kicks-ass.net> <87im9lhibd.fsf@nanos.tec.linutronix.de> <20201201114026.GB72897@lothringen> <87blfdhcp2.fsf@nanos.tec.linutronix.de> <20201201143545.GC72897@lothringen> <20201201150114.GZ2414@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Dec 2020 16:53:02 +0100
Message-ID: <87sg8pfrq9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 16:01, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 03:35:45PM +0100, Frederic Weisbecker wrote:
>> And that one too makes things simple. But note that
>> 
>>     account_hardirq_enter_time()
>> 
>> will still need some preempt count checks to see if
>> this is a nested hardirq, a hardirq interrupting a softirq
>> or a hardirq interrupting a task.
>
> So the current tests get that all correct in a single function.
> Splitting it out will just result in more lines to get wrong.
>
> That is, I don't think you can do it saner than:
>
>   account_softirq_enter() := irqtime_account_irq(curr, SOFTIRQ_OFFSET);
>   account_softirq_exit()  := irqtime_account_irq(curr, 0);
>   account_hardirq_enter() := irqtime_account_irq(curr, HARDIRQ_OFFSET);
>   account_hardirq_exit()  := irqtime_account_irq(curr, 0);
>
> Fundamentally you have to determine the previous context to determine
> where to account the delta to. Note that when the previous context is
> task context we throw away the delta.

Fair enough.
