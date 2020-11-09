Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AA2AB5C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgKILES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgKILES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:04:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161E5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KwfgTpGW55AenAOm2h2FqHhWzAExUYd5szEjRkPLVjI=; b=XudS7j6hMc58O37G4IzHAZ2hmg
        VQbjmHcUevAlBWZivbSkow4gtQc0WfhgOQ6NJx+LzMa1F4g9EfRrLtWN1sqIUOxKul6oe5v/pJ4Xj
        lk2C0s3cwWu+2CTT1q955jRRbBSe42ghg1asys+pE7EzmG5Mq7gpIJE/RySex/ircBwu9ZBoqSkd+
        U+A2qR87vdUVmcHuYOBn6FZQEUpvIyfeeq7gEXHPu0YX2T3ZO7AUW/f6s5/O/qURp0Fp2Uxat/W0z
        R6IL5YJA0lAMJR2xFF/ORQEoIsLqdxwhH435gwOLmodUCvS/Bk7bnycHyzqflwvHLwnunFdywXwww
        7RyNXmYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc4xz-00049K-Nx; Mon, 09 Nov 2020 11:04:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39886304D58;
        Mon,  9 Nov 2020 12:04:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26B6C2B09AD00; Mon,  9 Nov 2020 12:04:05 +0100 (CET)
Date:   Mon, 9 Nov 2020 12:04:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
Message-ID: <20201109110405.GN2651@hirez.programming.kicks-ass.net>
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109095235.GC2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:52:35AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 06, 2020 at 01:29:33PM -0800, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Sometimes the PMU internal buffers have to be flushed for per-CPU events
> > during a context switch, e.g., large PEBS. Otherwise, the perf tool may
> > report samples in locations that do not belong to the process where the
> > samples are processed in, because PEBS does not tag samples with PID/TID.
> > 
> > The current code only flush the buffers for a per-task event. It doesn't
> > check a per-CPU event.
> > 
> > Add a new event state flag, PERF_ATTACH_SCHED_CB, to indicate that the
> > PMU internal buffers have to be flushed for this event during a context
> > switch.
> > 
> > Add sched_cb_entry and perf_sched_cb_usages back to track the PMU/cpuctx
> > which is required to be flushed.
> > 
> > Only need to invoke the sched_task() for per-CPU events in this patch.
> > The per-task events have been handled in perf_event_context_sched_in/out
> > already.
> > 
> > Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
> 
> Are you sure? In part this patch looks like a revert of:
> 
>   44fae179ce73a26733d9e2d346da4e1a1cb94647
>   556cccad389717d6eb4f5a24b45ff41cad3aaabf

*groan*... I think I might've made a mistake with those two patches. I
assumed the whole cpuctx->task_ctx thing was relevant, it is not.

As per perf_sched_cb_{inc,dec}(struct pmu *), the thing we care about is
that the *PMU* gets a context switch callback, we don't give a crap
about the actual task context. Except that LBR code does, but I'm
thinking that started the whole confusion -- and I'm still not sure it's
actually correct either.

Now,.. how did we end up with the above two patches anyway... /me frobs
around in the inbox... Ah! that daft user RDPMC thing. I wanted to avoid
yet another pmu::method().

Hmm.. and the reason I proposed that change is because we'd end up with
the sched_cb for every context switch now, not just large-pebs and or
lbr crud. And this form avoids the double perf_pmu_disable() and all
that.

Maybe we can frob x86_pmu_enable()...
