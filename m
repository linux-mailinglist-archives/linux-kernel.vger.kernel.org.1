Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9772A02C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3K0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgJ3K0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:26:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76292C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:26:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604053562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8pf3sYX6uhqreYow0JUobm7dh3ohRmmP578ZgXGTClM=;
        b=mQHbguNd2TNiV46kH4gt0A99mYtiVPvlUKjtQHlh8ci9VP3KQqENlxOBatwM9CUJzwmDa1
        cQ5WgcOK2CawViJqCUGDhpMBRlQ1LhiX74vIA6oAzgMBQ3yy2PMKLC7w8V5eERnrV0wZ5W
        0tr7QtWJz2ZOR+6nTfZj4++H9vBRtyHQZolbzD+0onnz52jh3M+Q/K4Sr8b+tAJfP4INkk
        dMGTiOmzWF2v/pnnmC1q7cpSw0AN2t6IwQiGB2Ezlfi/eoa1uhYD5t+HNDtPrM56KMM9NK
        vWbTllLao1KDPxQ9Yq6eaks4BM5RsXMVdVhXXiCAIMujRSbhHOHzl2/z1/nPkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604053562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8pf3sYX6uhqreYow0JUobm7dh3ohRmmP578ZgXGTClM=;
        b=/OkGvxo86gHtpZ6YX58n2IGYRruDM3rEp4RTcUmtBSVrTQjT/ckI9hAalglaiidO9Ak6kl
        tKeTjBB4loEhL2Aw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [BUG] Stack overflow when running perf and function tracer
In-Reply-To: <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home> <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
Date:   Fri, 30 Oct 2020 11:26:01 +0100
Message-ID: <877dr8nh6u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 10:00, Peter Zijlstra wrote:
> On Fri, Oct 30, 2020 at 12:27:22AM -0400, Steven Rostedt wrote:
>> I found a bug in the recursion protection that prevented function
>> tracing from running in NMI context. Applying this fix to 5.9 worked
>> fine (tested by running perf record and function tracing at the same
>> time). But when I applied the patch to 5.10-rc1, it blew up with a
>> stack overflow:
>
> So we just blew away our NMI stack, right?

Looks like that:

>>  RSP: 0018:fffffe000003c000 EFLAGS: 00010046

Clearly a page boundary.

>>  RAX: 000000000000001c RBX: ffff928ada27b400 RCX: 0000000000000000
>>  RDX: ffff928ada07b200 RSI: fffffe000003c028 RDI: ffff928ada27b400
>>  RBP: ffff928ada27b4f0 R08: 0000000000000001 R09: 0000000000000000
>>  R10: fffffe000003c440 R11: ffff928a7383cc60 R12: fffffe000003c028
>>  R13: 00000000000003e8 R14: 0000000000000046 R15: 0000000000110001
>>  FS:  00007f25d43cf780(0000) GS:ffff928adaa40000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: fffffe000003bff8 CR3: 00000000b52a8005 CR4: 00000000001707e0

and CR2 says it tried below.

>> I bisected it down to:
>> 
>> 35d1ce6bec133679ff16325d335217f108b84871 ("perf/x86/intel/ds: Fix
>> x86_pmu_stop warning for large PEBS")
>> 
>> Which looks to be storing an awful lot on the stack:
>> 
>> static void __intel_pmu_pebs_event(struct perf_event *event,
>> 				   struct pt_regs *iregs,
>> 				   void *base, void *top,
>> 				   int bit, int count,
>> 				   void (*setup_sample)(struct perf_event *,
>> 						struct pt_regs *,
>> 						void *,
>> 						struct perf_sample_data *,
>> 						struct pt_regs *))
>> {
>> 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> 	struct hw_perf_event *hwc = &event->hw;
>> 	struct perf_sample_data data;
>> 	struct x86_perf_regs perf_regs;
>> 	struct pt_regs *regs = &perf_regs.regs;
>> 	void *at = get_next_pebs_record_by_bit(base, top, bit);
>> 	struct pt_regs dummy_iregs;
>
> The only thing I can come up with in a hurry is that that dummy_iregs
> thing really should be static. That's 168 bytes of stack out the window
> right there.

What's worse is perf_sample_data which is 384 bytes and is 64 bytes aligned.

> Still, this seems to suggest (barring some actual issue hidding in those
> 135 lost lines, we're very close to the limit on the NMI stack, which is
> a single 4k page IIRC.

Yes, unless KASAN is enabled

Thanks,

        tglx




