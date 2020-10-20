Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9472941D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408905AbgJTSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408895AbgJTSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:02:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E9C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:02:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603216975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHWnZp9onNDQQJBMppgiNoKoxPFz++Fc7isAPxJlOgk=;
        b=M24BnZLCcq2XMSUMOTIaZo5dqimyGZ9jPlTO/iUML5oiD2ANH3y7kXFK9nFWtOCn7/IO4/
        /rZbB5E2C/pJMWtszFuaCkBNrYYcdfcCuAwKczzBn30zT8H18ZIGRtObaIYq7A9UWyRMKb
        2GByPhpFzRuwZU9y8JVq+152bMUX5vnPrRiLzcTMZQ/fE5cBvbNd4ssEKMnFU5V7q2SOwD
        mQIRJ9iUhLEz+cjtw+BYIfkoat7reSXIjXcgpZxmkHA9fJBIwFzqeCZg8fb7L17+E5X9v+
        +vNlN1DJPA1S4g/N3HiqeZoy6Ne2DP1IjfCQ8/qQCpX13u/IZP3mxINc/GtfPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603216975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHWnZp9onNDQQJBMppgiNoKoxPFz++Fc7isAPxJlOgk=;
        b=xjt0qK3Ru4KPj1vfIQGOllkhh6FuBClIsWcQdrHbZ2mQh51NremuSI8rfO6lFQvgGhUXW6
        20v3AMWZ56P3R1CA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: sched: Reenable interrupts in do sched_yield()
In-Reply-To: <20201020113830.378b4a4c@gandalf.local.home>
References: <87r1pt7y5c.fsf@nanos.tec.linutronix.de> <20201020113830.378b4a4c@gandalf.local.home>
Date:   Tue, 20 Oct 2020 20:02:55 +0200
Message-ID: <87o8kw93n4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20 2020 at 11:38, Steven Rostedt wrote:
> On Tue, 20 Oct 2020 16:46:55 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> -	/*
>> -	 * Since we are going to call schedule() anyway, there's
>> -	 * no need to preempt or enable interrupts:
>
> I think the above comment still makes sense, just needs to be tweeked:
>
> 	/*
> 	 * Since we are going to call schedule() anyway, there's
> 	 * no need to allow preemption after releasing the rq lock.
>> -	 */
>
> Especially, since we are now enabling interrupts, which is likely to
> trigger a preemption.

sched_preempt_enable_no_resched() still enables preemption. It just
avoids the check. And it still allows preemption when an interrupt
triggering preemption happens between sched_preempt_enable_no_resched()
and __schedule() disabling preemption/interrupts.

So no, your new variant is just differently bogus and misleading.

Thanks,

        tglx
