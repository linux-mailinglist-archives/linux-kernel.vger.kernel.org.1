Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A132AB77B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgKILsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgKILsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:48:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RIJu7kcD4b+q3MwZgmcjcf1X5lgrAFVJnDz085ADJJk=; b=vK0g+08iL8DBsyr1Vy9NcdOu9O
        pxiwGaD4K2S92V4hQ/ReMT7EWi0+LLXee834URfAynkjHEkqtWTcMD3CZd/q/E/aKX3YMLJNicvF6
        H5eZtpQXkCd8XGtkCmoDkcDm+woi0Ly5hI6xC8VXIl7MKcU/RqtATXXTsj4QcP42AKMRBZn1Kp/Uk
        8UvWrStw+Ep6/6XJKfN+sjgoZYw4kTv2ZDN+xqhhwq/3yKhn8ODEfuI2eMEd+gv+vhhbpE/F0XBBA
        YXLzD6TKPtJ1VceOkDefleFmEOJkvMUDWT8FJuQiXC3P9KhS1OiZeikZ+nSlKrE9F1HqvGvqJ9eLB
        P45siwuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc5eg-0007XJ-Nk; Mon, 09 Nov 2020 11:48:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 130AB305C16;
        Mon,  9 Nov 2020 12:48:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE92E203E223F; Mon,  9 Nov 2020 12:48:13 +0100 (CET)
Date:   Mon, 9 Nov 2020 12:48:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 0/4] perf: Fix perf_event_attr::exclusive rotation
Message-ID: <20201109114813.GI2594@hirez.programming.kicks-ass.net>
References: <20201029162719.519685265@infradead.org>
 <20201031234418.GE3380099@krava>
 <20201102035238.GI466880@tassilo.jf.intel.com>
 <20201102141625.GX2594@hirez.programming.kicks-ass.net>
 <20201103024143.GK466880@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103024143.GK466880@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:41:43PM -0800, Andi Kleen wrote:
> On Mon, Nov 02, 2020 at 03:16:25PM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 01, 2020 at 07:52:38PM -0800, Andi Kleen wrote:
> > > The main motivation is actually that the "multiple groups" algorithm
> > > in perf doesn't work all that great: it has quite a few cases where it
> > > starves groups or makes the wrong decisions. That is because it is very
> > > difficult (likely NP complete) problem and the kernel takes a lot
> > > of short cuts to avoid spending too much time on it.
> > 
> > The event scheduling should be starvation free, except in the presence
> > of pinned events.
> > 
> > If you can show starvation without pinned events, it's a bug.
> > 
> > It will also always do equal or better than exclusive mode wrt PMU
> > utilization. Again, if it doesn't it's a bug.
> 
> Simple example (I think we've shown that one before):
> 
> (on skylake)
> $ cat /proc/sys/kernel/nmi_watchdog
> 0
> $ perf stat -e instructions,cycles,frontend_retired.latency_ge_2,frontend_retired.latency_ge_16 -a sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>        654,514,990      instructions              #    0.34  insn per cycle           (50.67%)
>      1,924,297,028      cycles                                                        (74.28%)
>         21,708,935      frontend_retired.latency_ge_2                                     (75.01%)
>          1,769,952      frontend_retired.latency_ge_16                                     (24.99%)
> 
>        2.002426541 seconds time elapsed
> 
> The second frontend_retired should be both getting 50% and the fixed events should be getting
> 100%. So several events are starved.

*should* how? Also, nothing is 0% so nothing is getting starved.

> Another similar example is trying to schedule the topdown events on Icelake in parallel to other
> groups. It works with one extra group, but breaks with two.
> 
> (on icelake)
> $ cat /proc/sys/kernel/nmi_watchdog
> 0
> $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring},{branches,branches,branches,branches,branches,branches,branches,branches},{branches,branches,branches,branches,branches,branches,branches,branches}' -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         71,229,087      slots                                                         (60.65%)
>          5,066,320      topdown-bad-spec          #      7.1% bad speculation         (60.65%)
>         35,080,387      topdown-be-bound          #     49.2% backend bound           (60.65%)
>         22,769,750      topdown-fe-bound          #     32.0% frontend bound          (60.65%)
>          8,336,760      topdown-retiring          #     11.7% retiring                (60.65%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>            424,584      branches                                                      (70.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
>          3,634,075      branches                                                      (30.00%)
> 
>        1.001312511 seconds time elapsed
> 
> A tool using exclusive hopefully will be able to do better than this.

I don't see how, exclusive will always result in equal or worse PMU
utilization, never better.
