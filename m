Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F42AB7F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgKIMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgKIMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:12:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C5FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LZZ5i/6lsHhrSq1a7BLyavIkV429FK1NVFaCtbZ63gE=; b=oVnsuV66OMztfsPmZ4t3QPze4v
        LZgmQyGW1lg5xVVOkCEv33ySxeaYeX3XJk8vNfTt8k5WZ1mVP4aKQ8TbNsq/hvmx6MQjnFh/0+KAN
        2LoTMpW8HzBxpjsIe7yaARItIjc/IYD2NS5j78Uu78kWZPDbQEppGVP2ZtOGwpm3nJm9G82enjjPb
        ct54dFSJ7feYmEgJeVw2veppCsUM7CSBbqIrzuSP5RWdZe7APJ7oRezq5WIWD335fgnzZSONWdpIs
        HGWAsNAiSAk2QhtTY1uqKKgRo61zk7U/R9EAuSrgCRTZDXNE7LRznMmaoqazegEpy97TYzBtsMf2P
        HxaUg7PA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc62M-0007J0-4r; Mon, 09 Nov 2020 12:12:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E6F6305C16;
        Mon,  9 Nov 2020 13:12:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B7752BD3DF73; Mon,  9 Nov 2020 13:12:37 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:12:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "eranian@google.com" <eranian@google.com>
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
Message-ID: <20201109121237.GJ2594@hirez.programming.kicks-ass.net>
References: <20201030151345.540479897@infradead.org>
 <20201030151955.187580298@infradead.org>
 <20201030181138.215b2b6a@carbon>
 <20201030162248.58e388f0@oasis.local.home>
 <20201030230152.GT2594@hirez.programming.kicks-ass.net>
 <6371740df7704217926315e97294a894@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6371740df7704217926315e97294a894@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 12:11:42PM +0000, David Laight wrote:
> The gcc 7.5.0 I have handy probably generates the best code for:
> 
> unsigned char q_2(unsigned int pc)
> {
>         unsigned char rctx = 0;
> 
>         rctx += !!(pc & (NMI_MASK));
>         rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
>         rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
> 
>         return rctx;
> }
> 
> 0000000000000000 <q_2>:
>    0:   f7 c7 00 00 f0 00       test   $0xf00000,%edi     # clock 0
>    6:   0f 95 c0                setne  %al                # clock 1
>    9:   f7 c7 00 00 ff 00       test   $0xff0000,%edi     # clock 0
>    f:   0f 95 c2                setne  %dl                # clock 1
>   12:   01 c2                   add    %eax,%edx          # clock 2
>   14:   81 e7 00 01 ff 00       and    $0xff0100,%edi
>   1a:   0f 95 c0                setne  %al
>   1d:   01 d0                   add    %edx,%eax          # clock 3
>   1f:   c3                      retq
> 
> I doubt that is beatable.
> 
> I've annotated the register dependency chain.
> Likely to be 3 (or maybe 4) clocks.
> The other versions are a lot worse (7 or 8) without allowing
> for 'sbb' taking 2 clocks on a lot of Intel cpus.

https://godbolt.org/z/EfnG8E

Recent GCC just doesn't want to do that. Still, using u8 makes sense, so
I've kept that.
