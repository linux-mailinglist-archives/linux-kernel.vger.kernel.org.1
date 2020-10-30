Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6282A0439
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJ3LgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3LgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604057762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt26X5MkA+U4JNX02cIhMuWaKRtR15syAcGfxqiATPQ=;
        b=ho6xQHjuoWuljI1zTFFo6aCJM8yb+fyRyKdUSvfpZ/1WnVjhs6ejuF4CDNlHXAHlH2I7x7
        89O7c6EJ7SVFg9n4KAnrkMq7i3EeqUkjbJMHKXP7bBh8L2qkDeSmERaFXFVUG5NzEYBhmD
        XyPJLwpI2CodqxPvgSH4wr0IU68Y6pHTZ7EATYzmAgSs3Uq3fJX/MnaJzSHlKWU1Y5IVOp
        U52jI7MFdpEHYObO8IzCExBYKYsKTJHOEMHKhIDQoA3kC5MGn5wgjnC0R+n3fEZD59ewTn
        4LbkX2S12eO+7PMB1gszk+tgt+yVG2+iehdF5bgbQH2H63/1Rvfu3mvNmmE/2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604057762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt26X5MkA+U4JNX02cIhMuWaKRtR15syAcGfxqiATPQ=;
        b=YIosfFPO3HTIKOYNyoAVO1IurOEP2BVnmA03j7Q1iwLsZ59iV7bY3EwnxF+TGfCAdqsleK
        gf4lsBKPXXWhifBA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [BUG] Stack overflow when running perf and function tracer
In-Reply-To: <20201030103220.GH2611@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home> <20201030090037.GZ2628@hirez.programming.kicks-ass.net> <877dr8nh6u.fsf@nanos.tec.linutronix.de> <20201030103220.GH2611@hirez.programming.kicks-ass.net>
Date:   Fri, 30 Oct 2020 12:36:02 +0100
Message-ID: <874kmcndy5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 11:32, Peter Zijlstra wrote:
> On Fri, Oct 30, 2020 at 11:26:01AM +0100, Thomas Gleixner wrote:
>
>> > The only thing I can come up with in a hurry is that that dummy_iregs
>> > thing really should be static. That's 168 bytes of stack out the window
>> > right there.
>> 
>> What's worse is perf_sample_data which is 384 bytes and is 64 bytes
>> aligned.

And there is also x86_perf_regs which is another 176 bytes ....

> Urgh, that thing just keeps on growing :/
>
> I'll try and have a look if we can both shrink the thing and move it off
> stack.

Even then we still need to worry about the stack depth because that
tracer code was not yet done. Throw some BPF at it and it goes south
again.

So the real question is what else is on that stack which blows it up
close to 4k? Btw, it would be massively helpful for this kind of crash
to print the actual stack depth per entry in the backtrace.

Here is the partial stack trace:
                                                Stack usage
  ring_buffer_lock_reserve+0x12c/0x380          
  trace_function+0x27/0x130
  function_trace_call+0x133/0x180
  perf_output_begin+0x4d/0x2d0                   64+
  perf_log_throttle+0x9a/0x120                  470+
  __perf_event_account_interrupt+0xa9/0x120
  __perf_event_overflow+0x2b/0xf0               
  __intel_pmu_pebs_event+0x2ec/0x3e0            760+
  intel_pmu_drain_pebs_nhm+0x268/0x330          200+
  handle_pmi_common+0xc2/0x2b0                  

The missing call chain is:

 intel_pmu_handle_irq or intel_pmu_handle_irq_v4
 perf_event_nmi_handler
 nmi
 
So the larger offenders accumulate to ~1.5k data on stack, but
where is the rest of the 4k?

It's about 15 calls. So to fill up the stack you'd need about 230 bytes
per call to go up to 4k.

Something is fishy.

Thanks,

        tglx
