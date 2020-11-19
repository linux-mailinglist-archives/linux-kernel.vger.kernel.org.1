Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788392B95FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgKSPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:20:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34284 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKSPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:20:10 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605799208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHHR7EQSPMXOlS0WEz2TOc8zDTaBySj/f2uZ+CqbfAQ=;
        b=gM0YFGmoxZrSMkVDhkksjt6mjfiSh+sOAe4EE2TJL5sl2wSipd9RA+x7Dw0Zp4pOWTn9yC
        VOe8Ktml5nQ1BfzS2V7mM30XzCiGaXd98A7DGznABnkIQuoRqKHLKvVHzfj1m4UAagdX4q
        RQUPXEBmZqDmMFXeokmnMJykQbR1o7MB/SBl2QY5QfqQl/Be42N3PUaeMbxiejans0jhfp
        TU6cWHoJzDYA2gtqWmM2VAeK7vfnLdDjOUTihDS3mNn0PeIAhu4LNtHqIDRFyYNNcQ/I1B
        8zhtQMeyV2im7uOdgd+zwVoxIZWvKxKLJJjcIOJS6fEF83RFsD8rtFtXYdx24w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605799208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHHR7EQSPMXOlS0WEz2TOc8zDTaBySj/f2uZ+CqbfAQ=;
        b=uKnohQUAu1/lkEz9WPkYMoEA4dwt4JGObLARzWmKo3L4zT+jWfgWg/lKCssvA+cHsknpgS
        WSpBEBoNpK3/CzDA==
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Deadlock cpuctx_mutex / pmus_lock / &mm->mmap_lock#2
In-Reply-To: <160579231162.30679.12645532537616868812@build.alporthouse.com>
References: <1185a97a-3780-3bce-d97d-ff9c2830e35d@gmail.com> <20201119130244.GN3121392@hirez.programming.kicks-ass.net> <160579231162.30679.12645532537616868812@build.alporthouse.com>
Date:   Thu, 19 Nov 2020 16:20:08 +0100
Message-ID: <87o8jtpe53.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 13:25, Chris Wilson wrote:
> Quoting Peter Zijlstra (2020-11-19 13:02:44)
>> 
>> Chris, I suspect this is due to i915 calling stop machine with all sorts
>> of locks held. Is there anything to be done about this? stop_machine()
>> is really nasty to begin with.
>> 
>> What problem is it typing to solve?
>
> If there is any concurrent access through a PCI bar (that is exported to
> userspace via mmap) as the GTT is updated, results in undefined HW
> behaviour (where that is not limited to users writing to other system
> pages).
>
> stop_machine() is the most foolproof method we know that works.

It's also the biggest hammer and is going to cause latencies just
because even on CPUs which are not involved at all. We have already
enough trouble vs. WBINVD latency wise, so no need to add yet another
way to hurt everyone.

As the gfx muck knows which processes have stuff mapped, there are
certainly ways to make them and only them rendevouz and do so while
staying preemptible otherwise. It might take an RESCHED_IPI to all CPUs
to achieve that, but that's a cheap operation compared to what you want
to do.

Thanks,

        tglx


