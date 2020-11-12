Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340A2B02BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKLKbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:31:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A69C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MgRT6CsMu9bYFYS1gOoiUISoENuUsB0VN6BWb/SRcQM=; b=bvp4CviD/1HxEC0vzgf4UbdL+L
        V7qRn8ZIFNbPAIbHq19ybMoFOi9hZ/Irc/VIHS2f38fJrgEsf/claBSXAb/iFmBweGsc9npg5Ii4b
        aqj2SMzXW6tK7yNrLQ9y/cbtdk9O4t+RIUNVbNOZSR29SJBwc1TUzcwo6sjhvTiH3CR3j1I4HWyu1
        Vbi5vx86LrzYzy3DItpUgJRRnnPMGM6PbSDNDJKiybHDkmUE6hGcrLrsk4PDl3/CZN90/icQbEPjQ
        tDGbMQca9vlD1gtjxTlx/vD39w6MEiqKOGn+AvKs8Ni8Ib5UXGoeG7M2r3PORnQnVx0jVMdtAZwb1
        BMob4sTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kd9t2-00034d-LZ; Thu, 12 Nov 2020 10:31:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D57FE306099;
        Thu, 12 Nov 2020 11:31:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A58202C71BAB5; Thu, 12 Nov 2020 11:31:25 +0100 (CET)
Date:   Thu, 12 Nov 2020 11:31:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <20201112103125.GV2628@hirez.programming.kicks-ass.net>
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 08:46:23AM +0100, Dmitry Vyukov wrote:

> for sampling race detection),
> number of threads in the process can be up to, say, ~~10K and the
> watchpoint is intended to be set for a very brief period of time
> (~~few ms).

Performance is a consideration here, doing lots of IPIs in such a short
window, on potentially large machines is a DoS risk.

> This can be done today with both perf_event_open and ptrace.
> However, the problem is that both APIs work on a single thread level
> (? perf_event_open can be inherited by children, but not for existing
> siblings). So doing this would require iterating over, say, 10K

One way would be to create the event before the process starts spawning
threads and keeping it disabled. Then every thread will inherit it, but
it'll be inactive.

> I see at least one potential problem: what do we do if some sibling
> thread already has all 4 watchpoints consumed?

That would be immediately avoided by this, since it will have the
watchpoint reserved per inheriting the event.

Then you can do ioctl(PERF_EVENT_IOC_{MODIFY_ATTRIBUTES,ENABLE,DISABLE})
to update the watch location and enable/disable it. This _will_ indeed
result in a shitload of IPIs if the threads are active, but it should
work.
