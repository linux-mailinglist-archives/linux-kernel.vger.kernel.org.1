Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808762A06A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgJ3NnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3Nm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:42:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:42:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604065377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHiwUeVvN9DNLORHA1v1dj1jbmmZaKw58J8ztq848rE=;
        b=GYJxv5ylh9hUbK9u8VDJrokhaaTJeeMMWl5sng52N4nX/klamOAuq/fOm9QuSXU5Ql4pY4
        Nf1CuA1uWpGZDDfVZ2BfsCUkfFMxJDWtMrCVeXetCCCj+3FLpsFQz+Kr1VYMryRwK1VV60
        grxFnQTS+AgdWLiEuyEATuN02+Ui1Ek1X8KBNEixOScBR1q9QXyyXZ8pXDNSYze3v3weDY
        QwPdH3rYtZ24ecRyn8ve0O9W88LvNkuSfWFRxzAxWoIgEPhhzrVIZhDHEIeLNNBEhtpN4P
        UWDZ131kQr+1q8/IlIJS5xtWex+EfWxMEcPWvrm2zV0ojweEuldT1WzmXe1u5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604065377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHiwUeVvN9DNLORHA1v1dj1jbmmZaKw58J8ztq848rE=;
        b=sngCCtSeTixUcNrm5QbiCMbjq77XlHQ06WnLEXlii6T54CNh+uzOBponU3ofZg3aZkXi3S
        wcv8VoKMpsddOSCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [BUG] Stack overflow when running perf and function tracer
In-Reply-To: <874kmcndy5.fsf@nanos.tec.linutronix.de>
References: <20201030002722.766a22df@oasis.local.home> <20201030090037.GZ2628@hirez.programming.kicks-ass.net> <877dr8nh6u.fsf@nanos.tec.linutronix.de> <20201030103220.GH2611@hirez.programming.kicks-ass.net> <874kmcndy5.fsf@nanos.tec.linutronix.de>
Date:   Fri, 30 Oct 2020 14:42:56 +0100
Message-ID: <87v9ern82n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 12:36, Thomas Gleixner wrote:
> On Fri, Oct 30 2020 at 11:32, Peter Zijlstra wrote:
> So the real question is what else is on that stack which blows it up
> close to 4k? Btw, it would be massively helpful for this kind of crash
> to print the actual stack depth per entry in the backtrace.
>
> Here is the partial stack trace:
>                                                 Stack usage
>   ring_buffer_lock_reserve+0x12c/0x380          
>   trace_function+0x27/0x130
>   function_trace_call+0x133/0x180
>   perf_output_begin+0x4d/0x2d0                   64+
>   perf_log_throttle+0x9a/0x120                  470+
>   __perf_event_account_interrupt+0xa9/0x120
>   __perf_event_overflow+0x2b/0xf0               
>   __intel_pmu_pebs_event+0x2ec/0x3e0            760+
>   intel_pmu_drain_pebs_nhm+0x268/0x330          200+
>   handle_pmi_common+0xc2/0x2b0                  

So Steven provided a backtrace with the actual stack depth printed:

ring_buffer_lock_reserve+0x12c/0x380		0030  104
trace_function+0x27/0xf0			0098   56
function_trace_call+0x124/0x190			00d0  224 
__rcu_read_lock+0x5/0x20			01b0    8
perf_output_begin+0x4d/0x2d0			01b8  640
perf_log_throttle+0x9a/0x120			0438  624
__perf_event_account_interrupt+0xa6/0x120	06a8   32
__perf_event_overflow+0x2b/0xf0			06c8   48
__intel_pmu_pebs_event+0x2ec/0x3e0		06f8  960
intel_pmu_drain_pebs_nhm+0x268/0x330		0ab8  256
handle_pmi_common+0xc2/0x2b0			0bb8  584
intel_pmu_handle_irq+0xc8/0x160			0e00   64
perf_event_nmi_handler+0x28/0x50		0e40   32
nmi_handle+0x80/0x190				0e60   64
default_do_nmi+0x6b/0x170			0ea0   40
exc_nmi+0x15d/0x1a0				0ec8   40
end_repeat_nmi+0x16/0x55			0ef0  272

So I missed perf_output_begin and handle_pmi_common ...
