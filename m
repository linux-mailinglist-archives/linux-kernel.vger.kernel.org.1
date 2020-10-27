Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1A29C898
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829633AbgJ0TTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:19:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829605AbgJ0TTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:19:22 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603826359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0CmGDDPRiNeoZmas3WC/BuGgJ2L+HXBpzjZ1xtym5Y=;
        b=CJT35Ob+9BEk+pzK1G7vADh+AXYUOI8dtu3AGqSy9ZsGLcD2f5cOqxQJFNoOUnUjECe2gl
        htxY0g/9FXlzESqidLgtrXkLsbnH6TNLr8JIj14QVKb+wUu1FnCjGEC5bBiUUVv5JVBK5d
        ZoNqh/Wk66DPC3dGS+DmYjj3EtbbiAEQpxqjAJEVt92nItu2yGYMivm1fhY02ZgMUNIVHt
        KpivOpCLzQvhXeUnEz80jvkuEcWElefx/AwEvI4wPZZLRiYYr5ll+dCMEne4HZ/SN9X+8p
        kxLBGEYTIDcTNR+3xmE2stq8iLaaK8wpg5ot74EE2QmsR+IiMp2i3lJNu4yB6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603826359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0CmGDDPRiNeoZmas3WC/BuGgJ2L+HXBpzjZ1xtym5Y=;
        b=wGSJTne4di+ga8Wi8QvPkEJ2X0GUE7zBPXVCZRhU81Ff7SeNCoGnI0oEcsqf0KuxFxASCy
        Ri/lIxZ/Eol2J2BA==
To:     Petr Mladek <pmladek@suse.com>, qiang.zhang@windriver.com
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kthread_worker: re-set CPU affinities if CPU come online
In-Reply-To: <20201027163925.GE31882@alley>
References: <20201026065213.30477-1-qiang.zhang@windriver.com> <20201027163925.GE31882@alley>
Date:   Tue, 27 Oct 2020 20:19:19 +0100
Message-ID: <87a6w71npk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

On Tue, Oct 27 2020 at 17:39, Petr Mladek wrote:
> On Mon 2020-10-26 14:52:13, qiang.zhang@windriver.com wrote:
>> From: Zqiang <qiang.zhang@windriver.com>
>> 
>> When someone CPU offlined, the 'kthread_worker' which bind this CPU,
>> will run anywhere, if this CPU online, recovery of 'kthread_worker'
>> affinity by cpuhp notifiers.
>
> I am not familiar with CPU hotplug notifiers. I rather add Thomas and
> Peter into Cc.

Thanks!

>> +static int kworker_cpu_online(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct kthread_worker *worker = hlist_entry(node, struct kthread_worker, cpuhp_node);
>
> The code here looks correct.
>
> JFYI, I was curious why many cpuhp callbacks used hlist_entry_safe().
> But they did not check for NULL. Hence the _safe() variant did
> not really prevented any crash.
>
> I seems that it was a cargo-cult programming. cpuhp_invoke_callback() calls
> simple hlist_for_each(). If I get it correctly, the operations are
> synchronized by cpus_read_lock()/cpus_write_lock() and _safe variant
> really is not needed.

Correct.

>> +static __init int kthread_worker_hotplug_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "kthread-worker/online",
>> +					kworker_cpu_online, NULL);

The dynamic hotplug states run late. What's preventing work to be queued
on such a worker before it is bound to the CPU again?

Nothing at all.

Moving the hotplug state early does not help either because this cannot
happen _before_ the CPUHP_AP_ONLINE state. After that it's already too
late because that's after interrupts have been reenabled on the upcoming
CPU. Depending on the interrupt routing an interrupt hitting the
upcoming CPU might queue work before the state is reached. Work might
also be queued via a timer before rebind happens.

The only current user (powerclamp) has it's own hotplug handling and
stops the thread and creates a new one when the CPU comes online. So
that's not a problem.

But in general this _is_ a problem. There is also no mechanism to ensure
that work on a CPU bound worker has been drained before the CPU goes
offline and that work on the outgoing CPU cannot be queued after a
certain point in the hotplug state machine.

CPU bound kernel threads have special properties. You can access per CPU
variables without further protection. This blows up in your face once
the worker thread is unbound after a hotplug operation.

So the proposed patch is duct tape and papers over the underlying design
problem.

Either this is fixed in a way which ensures operation on the bound CPU
under all circumstances or it needs to be documented that users have to
have their own hotplug handling similar to what powerclamp does.

Thanks,

        tglx
