Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8592F2253B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgGSTdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 15:33:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:33:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595187182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqSIv/rL+04FTHYHVriiAJ+C3up0OK9z0lS+UY4+8mQ=;
        b=uG54rzVlSRT5nPeDzxAeMJyw3JJxEWKfDD/1YXjBDjhn4A3FMbNuJ/t7tIHhIcGCzkN+f5
        +CoVdGLo/HEHMi2eQ/LY9E22ZUlbQUHRDcrXoEjLMJJaSi4fH+RYe+t4nUwmcnTbN5FcRK
        XbTfsBFfyPyjhAybpVkMzshQbZRshVJe9VI4lWceu2at181RJ4uO7WqISEdBC+ZGV3Sl13
        CL6eRw5taiEGpyI6nnFRIs906qCI17IE82D0c1uiJm66wwqwaQ5vc8eUW1ifY7TyasfjHx
        SkWTnYUfC+k014RZxkVhp8cfb/2KTzCRPkVIHOiIaS4/w8EEMuRXAM06AbK8OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595187182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqSIv/rL+04FTHYHVriiAJ+C3up0OK9z0lS+UY4+8mQ=;
        b=X6B96ADnw9mWyzSoBWeGjcr4nH/ytk9ETsMl8Yu51fSA3G0r8vhQvBMOV/p5pjqEERMSC5
        NXPlca5ddr6QJgAA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
In-Reply-To: <87tuy6q965.fsf@nanos.tec.linutronix.de>
References: <20200716201923.228696399@linutronix.de> <20200716202044.734067877@linutronix.de> <20200716225458.GL5523@worktop.programming.kicks-ass.net> <87tuy6q965.fsf@nanos.tec.linutronix.de>
Date:   Sun, 19 Jul 2020 21:33:01 +0200
Message-ID: <87eep7nvv6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
>>> +static void __run_posix_cpu_timers(struct task_struct *tsk)
>>> +{
>>> +	struct posix_cputimers *pct = &tsk->posix_cputimers;
>>> +
>>> +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
>>> +		task_work_add(tsk, &pct->task_work, true);
>>
>> s/true/TWA_RESUME/g
>>
>> see: e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")
>
> Duh, yes.

Bah, that creates a dependency on sched/core ...
