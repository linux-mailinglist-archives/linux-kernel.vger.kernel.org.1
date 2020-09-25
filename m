Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49877279441
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgIYWhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIYWhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:37:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F356C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:37:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601073458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DhcPDYsymGRYtFB2dmQY+Zy+IpI+TEEnDEihuujzLt0=;
        b=KWJ+Oxhw3yNSPw6BGgcUmmNNFya46I0LL4TK4TA01jxstORj0LHB6/RVX3d75ud3ne25b0
        lwHtPtJTtTHgkNmY1PU+vfFstpNkDkqTPrGi3mFGfR82KOShmzq9a4/2WFk2vG/zcjdXS2
        6ZD5FRuNRG6fY95xOPC+kmIxZHQA+T2F6li0eLBdgstUyfrkJx2V+gXXCa976kB6gLlP4q
        VW7qF3HUBZkoHpzr/grGalvEBLJ8JKK+nxk82av98XwCOeGe8N3/BvbIiPcjFrtfgA7Ygx
        o8tDoARFrrPb1QltI16KZaxMlOVJqbxE4woozT+jo+4PUh9W6tp4LUS4Z/RGvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601073458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DhcPDYsymGRYtFB2dmQY+Zy+IpI+TEEnDEihuujzLt0=;
        b=lbZW0QdE1qPFRKJ84X3/iPFmINUkK6RRC25re6/DvhIcEKw5iULkeKr1nKb0WDf4JPgXA6
        V21FT6ohHKU8zaAA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
In-Reply-To: <20200924230811.GC19346@lenoir>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-5-qianjun.kernel@gmail.com> <878scz89tl.fsf@nanos.tec.linutronix.de> <20200924230811.GC19346@lenoir>
Date:   Sat, 26 Sep 2020 00:37:37 +0200
Message-ID: <87imc1v5xq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25 2020 at 01:08, Frederic Weisbecker wrote:

> On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
>> Subject: softirq; Prevent starvation of higher softirq vectors
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Thu, 24 Sep 2020 10:40:24 +0200
>> 
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> The early termination of the softirq processing loop can lead to starvation
>> of the higher numbered soft interrupt vectors because each run starts at
>> the lowest bit. If the loop terminates then the already processed bits can
>> be raised again before the next loop starts. If these lower bits run into
>> the termination again, then a re-raise might starve the higher bits forever.
>> 
>> To prevent this, store the leftovers of the previous run in the upper 16
>> bit of the local softirq_pending storage and ensure that these are
>> processed before any newly raised bits are handled.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  kernel/softirq.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 50 insertions(+), 8 deletions(-)
>> 
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -259,11 +259,23 @@ static inline bool __softirq_needs_break
>>  	return need_resched() || __softirq_timeout(tbreak);
>>  }
>>  
>> +/*
>> + * local_softirq_pending() is split into two 16 bit words. The low word
>> + * contains the bits set by raise_softirq(), the high word contains pending
>> + * bits which have not been processed in an early terminated run. This is
>> + * required to prevent starvation of the higher numbered softirqs.
>> + */
>> +#define SIRQ_PREV_SHIFT		16
>
> Note that in the case of x86, irq_start.__softirq_pending is a u16.
>
> The origin is there: 9aee5f8a7e30330d0a8f4c626dc924ca5590aba5
> "x86/irq: Demote irq_cpustat_t::__softirq_pending to u16"

Bah, crap. I knew I that and wanted to fix it up but then forgot.

Thanks for reminding me of my slowly upcoming alzheimer!
