Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9D2A1163
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgJ3XCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgJ3XC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:02:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B65C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WZUWoGAH6M0vOc7felvtoYqBxBRmN7X/BhItNhFZdvY=; b=sguMJ/0cYARAs5QSQab7j5MJ3T
        IDOhDVRUtFm9/+yJoKf2hcLDDPV2b7mw253Vdt0OZLrIuP8/8mhj7ZA6SD6pYKVRSno9wyo61VN/0
        g1Uyy9SJun8TojUoQ5bkr1m+7Eq59pZqdyGjdz5Ed64VdpKW0w3KYs8+/und0cSQJAsBiE4W4cj1z
        mJ3I9jjR+n0o8bMocetNICMqyXSoOaKmut98Pk32UnD3MAhCC6pYpWVGa5cpNe3wROCcdHOeYzSNw
        cGatizLkbLFZ2m+n6zFtVvbSPnKWWKNOEyESZkNSGG6Ipmw0faPGLetSakQcFZuJZzF69y9ByIZW/
        NRPxiycA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYdPA-0002jI-5x; Fri, 30 Oct 2020 23:01:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E5DA300446;
        Sat, 31 Oct 2020 00:01:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9A8C286B0708; Sat, 31 Oct 2020 00:01:52 +0100 (CET)
Date:   Sat, 31 Oct 2020 00:01:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
Message-ID: <20201030230152.GT2594@hirez.programming.kicks-ass.net>
References: <20201030151345.540479897@infradead.org>
 <20201030151955.187580298@infradead.org>
 <20201030181138.215b2b6a@carbon>
 <20201030162248.58e388f0@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030162248.58e388f0@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 04:22:48PM -0400, Steven Rostedt wrote:
> As this is something that ftrace recursion also does, perhaps we should
> move this into interrupt.h so that anyone that needs a counter can get
> it quickly, and not keep re-implementing it.

Works for me, however:

> /*
>  * Quickly find what context you are in.
>  * 0 - normal
>  * 1 - softirq
>  * 2 - hard interrupt
>  * 3 - NMI
>  */
> static inline int irq_context()
> {
> 	unsigned int pc = preempt_count();
> 	int rctx = 0;

unsigned

> 
> 	if (pc & (NMI_MASK))
> 		rctx++;
> 	if (pc & (NMI_MASK | HARDIRQ_MASK))
> 		rctx++;
> 	if (pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET))
> 		rctx++;
> 
> 	return rctx;
> }

otherwise you'll get an extra instruction to sign extend it, which is
daft (yes, i've been staring at GCC output far too much).

Also, gcc-9 does worse (like 1 byte iirc) with:

	rctx += !!(pc & (NMI_MASK));
	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));

but gcc-10 doesn't seem to care.
